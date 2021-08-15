function fallbackCopyTextToClipboard(text) {
    var textArea = document.createElement("textarea")
    textArea.value = text

    textArea.style.top = "0"
    textArea.style.left = "0"
    textArea.style.position = "fixed"

    document.body.appendChild(textArea)
    textArea.focus()
    textArea.select()

    try {
        document.execCommand('copy')
    } catch (err) {
    }

    document.body.removeChild(textArea)
}
function copyTextToClipboard(text) {
    if (!navigator.clipboard) {
        fallbackCopyTextToClipboard(text)
        return
    }
    navigator.clipboard.writeText(text)
}
let app = Elm.Main.init({
    node: document.getElementById('palette-app')
})
document.querySelectorAll("*[data-copy]").forEach((elm) => {
    elm.addEventListener("click", () => {
        copyTextToClipboard(elm.dataset.copy)
    })
})