/**
 * Setups a copy button per each .highlight block
 */
window.addEventListener('load', (event) => {
    // Check if clipboard is even supported
    if (!window.navigator || !window.navigator.clipboard) {
      return;
    }

    const highlights = document.getElementsByClassName('highlight');
    for (const node of highlights) {
        const button = document.getElementById('copy-btn-template').cloneNode(true).content;
        // Add the button
        node.prepend(button);
        node.querySelector('.copy-code-btn').addEventListener('click', async (event) => {
            // Icon classes, COPY is the default, and OK shows for a little while after successfully copying
            const ICON_COPY = 'icon_edit-copy';
            const ICON_OK = 'icon_dialog-ok-apply';

            const copyBtn = event.target;
            const copyIcon = copyBtn.querySelector('.icon');
            const copyBtnOriginalContent = copyBtn.dataset.content;

            // Find the code block with the text we want
            const codeBlock = node.querySelector('pre > code[data-lang]');

            // Code block wasn't found then can't continue
            if (!codeBlock) {
                console.warn("Could not find code-block for ", node);
                return;
            }

            // Copy it to clipboard
            await window.navigator.clipboard.writeText(codeBlock.innerText);

            // Change the icon to OK to indicate success
            copyIcon.classList.replace(ICON_COPY, ICON_OK);
            copyBtn.dataset.content = copyBtn.dataset.clickedContent;

            // "Update" the popover to show the new text
            $(copyBtn).popover('hide');
            $(copyBtn).popover('show');

            // Flip the icon back to COPY after a short time
            setTimeout(() => {
                copyIcon.classList.replace(ICON_OK, ICON_COPY);
                // Reset the original copy
                copyBtn.dataset.content = copyBtnOriginalContent;
                // Hide the popover as well
                $(copyBtn).popover('hide');
            }, 3000);
        });
    }
});