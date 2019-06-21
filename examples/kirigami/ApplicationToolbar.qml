...
import org.kde.kirigami 2.9 as Kirigami
...

Kirigami.ApplicationWindow {
    ...
    pageStack.initialPage: Kirigami.ScrollablePage {
        ...
        actions {
            left: Kirigami.Action {
                iconName: "mail-message"
                text: i18n("&Write mail")
            }
            main: Kirigami.Action {
                iconName: "call-start"
                text: i18n("&Make call")
            }
            right: Kirigami.Action {
                iconName: "kmouth-phrase-new"
                text: i18n("&Write SMS")
            }
        }
    }
    ...
}
