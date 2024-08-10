/**
 * Lunr Index Worker
 * This is called on page load to handle a very slow index process then sends it back to the offline-search.js
 */
onmessage = (event) => {
    const { evt, data } = event.data;
    const resultDetails = new Map();

    if (evt === 'init') {
        lunrIdx = lunr(function () {
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

        });

        // Send the lunrIdx and result details map back to offline-search.js
        postMessage({evt: 'index', data: [lunrIdx.toJSON(), resultDetails]});
    }
};