/**
 * Setups a copy button per each .highlight block
 */
window.addEventListener('load', (event) => {
    // Check if clipboard is even supported
    if (!window.navigator || !window.navigator.clipboard) {
      return;
    }

    const copyPopovers = new Map();

    const highlights = document.getElementsByClassName('highlight');
    for (const node of highlights) {
        const button = document.getElementById('copy-btn-template').cloneNode(true).content;
        // Add the button
        node.prepend(button);

        const btn = node.querySelector('.copy-code-btn');
        copyPopovers.set(btn, new bootstrap.Popover(btn));
        btn.addEventListener('click', async (event) => {
            // Icon classes, COPY is the default, and OK shows for a little while after successfully copying
            const ICON_COPY = 'icon_edit-copy';
            const ICON_OK = 'icon_dialog-ok-apply';

            const copyBtn = event.target;
            const copyIcon = copyBtn.querySelector('.icon');
            const copyBtnClickedContent = copyBtn.dataset.clickedContent;
            const copyBtnOriginalContent = copyBtn.dataset.bsContent;

            const popover = copyPopovers.get(copyBtn);

            // Find the code block with the text we want
            const codeBlock = node.querySelector('pre > code[data-lang]');

            // Code block wasn't found then can't continue
            if (!codeBlock || !popover) {
                console.warn("Could not find code-block or popover for ", node, copyBtn);
                return;
            }

            // Copy it to clipboard
            await window.navigator.clipboard.writeText(codeBlock.innerText);

            // Change the icon to OK to indicate success
            copyIcon.classList.replace(ICON_COPY, ICON_OK);

            // "Update" the popover to show the new text
            popover.setContent({'.popover-body': copyBtnClickedContent});

            // Flip the icon back to COPY after a short time
            setTimeout(() => {
                copyIcon.classList.replace(ICON_OK, ICON_COPY);
                // Reset the original copy
                popover.setContent({'.popover-body': copyBtnOriginalContent});
                // Hide the popover as well
                popover.hide();
            }, 3000);
        });
    }
});