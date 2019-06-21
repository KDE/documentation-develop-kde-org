...
import org.kde kirigami 2.9 as Kirigami
...

Kirigami.InlineMessage {
    visible: true
    text: i18n("&Remember password?")
    type: Kirigami.MessageType.Positive
    showCloseButton: true
    ...
    
    actions: [
        Kirigami.Action {
            text: i18n("&Remember")
            icon.name: "dialog-ok-apply"
        },
        Kirigami.Action {
            text: i18n("&Do not remember")
            icon.name: "dialog-cancel"
        }
    ]
}
