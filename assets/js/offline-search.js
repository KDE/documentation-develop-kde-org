// Adapted from code by Matt Walters https://www.mattwalters.net/posts/hugo-and-lunr/

(function ($) {
    'use strict';

    $(document).ready(function () {
        const $searchInput = $('.td-search-input');

        //
        // Options for popover
        //

        $searchInput.data('html', true);
        $searchInput.data('placement', 'bottom');
        $searchInput.data(
            'template',
            '<div class="popover offline-search-result" role="tooltip"><div class="arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>'
        );
        // Disable the search input until we have the index
        $searchInput.prop('disabled', true);

        //
        // Register handler
        //

        $searchInput.on('change', (event) => {
            render($(event.target));

            // Hide keyboard on mobile browser
            $searchInput.blur();
        });

        // Prevent reloading page by enter key on sidebar search.
        $searchInput.closest('form').on('submit', () => {
            return false;
        });

        //
        // Lunr
        //

        let idx = null; // Lunr index
        let resultDetails = new Map(); // Will hold the data for the search results (titles and summaries)

        /**
         * Init the lunr index object, either runs a web worker to do it, or does it locally if that fails.
         * @returns {Promise<void>}
         */
        const init = async () => {
            const response = await fetch($searchInput.data('offline-search-index-json-src'));
            if (!response.ok) {
                console.warn('Could not fetch offline search data!');
                return;
            }
            const data = await response.json();

            // Try to run the web worker, if that fails run it normally.
            try {
                const lunrWorker = new Worker(window._site.webWorker);

                lunrWorker.onmessage = (event) => {
                    const { evt, data } = event.data;
                    if (evt === 'index') {
                        idx = lunr.Index.load(data[0]);
                        resultDetails = data[1];

                        $searchInput.prop('disabled', false);
                        $searchInput.trigger('change');
                    }
                };

                lunrWorker.postMessage({'evt': 'init', 'data': data});
            } catch {
                console.warn("Web worker was unable to run. Running indexing the slow way!")
                idx = lunr(function () {
                    this.ref('ref');
                    this.field('title', { boost: 2 });
                    this.field('body');

                    data.forEach( (doc) => {
                        this.add(doc);

                        resultDetails.set(doc.ref, {
                            title: doc.title,
                            excerpt: doc.excerpt,
                        });
                    });


                    $searchInput.prop('disabled', false);
                    $searchInput.trigger('change');
                });
            }
        }

        init();

        const render = ($targetSearchInput) => {
            // Dispose the previous result
            $targetSearchInput.popover('dispose');

            //
            // Search
            //

            if (idx === null) {
                return;
            }

            const searchQuery = $targetSearchInput.val();
            if (searchQuery === '') {
                return;
            }

            const results = idx
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

            //
            // Make result html
            //

            const $html = $('<div>');

            $html.append(
                $('<div>')
                    .css({
                        display: 'flex',
                        justifyContent: 'space-between',
                        marginBottom: '1em',
                    })
                    .append(
                        $('<span>')
                            .text('Search results')
                            .css({ fontWeight: 'bold' })
                    )
                    .append(
                        $('<i>')
                            .addClass('icon icon_paint-none search-result-close-button p-1')
                            .css({
                                cursor: 'pointer',
                            })
                    )
            );

            const $searchResultBody = $('<div>').css({
                maxHeight: `calc(100vh - ${
                    $targetSearchInput.offset().top -
                    $(window).scrollTop() +
                    180
                }px)`,
                overflowY: 'auto',
            });
            $html.append($searchResultBody);

            if (results.length === 0) {
                $searchResultBody.append(
                    $('<p>').text(`No results found for query "${searchQuery}"`)
                );
            } else {
                results.forEach((r) => {
                    const $cardHeader = $('<div>').addClass('card-header');
                    const doc = resultDetails.get(r.ref);
                    const href =
                        $searchInput.data('offline-search-base-href') +
                        r.ref.replace(/^\//, '');

                    $cardHeader.append(
                        $('<a>').attr('href', href).text(doc.title)
                    );

                    const $cardBody = $('<div>').addClass('card-body');
                    $cardBody.append(
                        $('<p>')
                            .addClass('card-text text-muted')
                            .text(doc.excerpt)
                    );

                    const $card = $('<div>').addClass('card');
                    $card.append($cardHeader).append($cardBody);

                    $searchResultBody.append($card);
                });
            }

            $targetSearchInput.on('shown.bs.popover', () => {
                $('.search-result-close-button').on('click', () => {
                    $targetSearchInput.val('');
                    $targetSearchInput.trigger('change');
                });
            });

            $targetSearchInput
                .data('content', $html[0])
                .popover('show');
        };
    });
})(jQuery);
