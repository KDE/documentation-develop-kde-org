// Adapted from code by Matt Walters https://www.mattwalters.net/posts/hugo-and-lunr/

window.addEventListener('load', async () => {
    const searchInput = document.getElementById('search-input');
    if (!searchInput) {
        return;
    }
    const searchForm = searchInput.closest('form');
    if (!searchForm) {
        return;
    }

    const searchResultsTemplate = document.getElementById('search-results-template');
    const searchResultsCardTemplate = document.getElementById('search-results-card-template')
    const offlineSearchSrc = searchInput.dataset.offlineSearchIndexJsonSrc;
    const offlineSearchBase = searchInput.dataset.offlineSearchBaseHref;

    if (!searchResultsCardTemplate || !searchResultsTemplate) {
        return;
    }

    // Start disabled
    searchInput.setAttribute('disabled', 'true');

    let popover = null;

    // Lunr Data
    let lunrIdx = 0;
    let resultDetails = new Map(); // Will hold the data for the search results (titles and summaries)

    searchInput.addEventListener('change', async (event) => {
        await render(event.target);
        searchInput.blur();
    });

    searchForm.addEventListener('submit', (event) => {
        event.preventDefault();
    });

    const init = async () => {
        const response = await fetch(offlineSearchSrc);
        if (!response.ok) {
            console.warn('Could not fetch offline search data!');
            return;
        }

        const data = await response.json();

        try {
          const lunrWorker = new Worker(window._site.webWorker);

          lunrWorker.onmessage = (event) => {
            const { evt, data } = event.data;
            if (evt === 'index') {
              lunrIdx = lunr.Index.load(data[0]);
              resultDetails = data[1];

              searchInput.removeAttribute('disabled');
              searchInput.dispatchEvent(new SubmitEvent('change', {submitter: searchInput}));
            }
          };

          lunrWorker.postMessage({'evt': 'init', 'data': data});
        } catch {
          lunrIdx = lunr(function () {
              this.ref('ref');
              this.field('title', { boost: 2 });
              this.field('body');

              data.forEach((doc) => {
                  this.add(doc);

                  resultDetails.set(doc.ref, {
                      title: doc.title,
                      excerpt: doc.excerpt,
                  });
              });
          });
          searchInput.removeAttribute('disabled');
          searchInput.dispatchEvent(new SubmitEvent('change', {submitter: searchInput}));
        }

    }

    const render = async (element) => {
        if (popover) {
            popover.dispose();
            popover = null;
        }

        const searchQuery = element.value;

        if (lunrIdx === null || searchQuery === '') {
            return;
        }

        const results = lunrIdx
            .query((q) => {
                const tokens = lunr.tokenizer(searchQuery.toLowerCase());
                tokens.forEach((token) => {
                    const queryString = token.toString();
                    q.term(queryString, {
                        boost: 100,
                    });
                    q.term(queryString, {
                        wildcard:
                            lunr.Query.wildcard.LEADING |
                            lunr.Query.wildcard.TRAILING,
                        boost: 10,
                    });
                    q.term(queryString, {
                        editDistance: 2,
                    });
                });
            })
            .slice(0, 10);

        const html = document.createElement('div');
        const searchResultFragment = searchResultsTemplate.content.cloneNode(true);
        html.appendChild(searchResultFragment);

        const searchResultBody = html.querySelector('.search-results-body');
        const searchNoResults = html.querySelector('.search-no-results');

        searchResultBody.style.maxHeight = `calc(100vh - ${
            element.offsetHeight -
            window.screenTop +
            180
        }px)`;

        // Show the no results text and
        if (results.length === 0) {
            searchNoResults.style.display = 'block';
        } else {
            // Hide the no results text
            searchNoResults.style.display = 'none';

            results.forEach((r) => {
               const cardFragment = searchResultsCardTemplate.content.cloneNode(true);
               const doc = resultDetails.get(r.ref);

               const link = cardFragment.querySelector('.card-link');
               link.href = offlineSearchBase + r.ref.replace(/^\//, '');
               link.innerText = doc.title;

               const body = cardFragment.querySelector('.card-body');
               body.innerText = doc.excerpt;

               searchResultBody.appendChild(cardFragment);
            });
        }

        // Set the data-bs-content with our html
        element.dataset.bsContent = html.innerHTML;

        // Set the close button event
        element.addEventListener('shown.bs.popover', () => {
            document.querySelector('.search-result-close-button').addEventListener('click', () => {
               searchInput.value = '';
               searchInput.dispatchEvent(new SubmitEvent('change', {submitter: searchInput}));
            });
        })

        // Allow the use of style attribute on some of these elements
        const allowList = bootstrap.Tooltip.Default.allowList;
        allowList.div.push('style');
        allowList.p.push('style');
        allowList.i.push('style');

        popover = new bootstrap.Popover(element, {
            html: true,
            template: '<div class="popover offline-search-result" role="tooltip"><div class="popover-arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>',
            placement: 'bottom',
            allowList: allowList,
        });
        popover.show();

    };


    await init();
});