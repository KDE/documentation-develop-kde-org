...
import org.kde kirigami 2.9 as Kirigami
...

Kirigami.ApplicationWindow {
    ...
    pageStack.initialPage: Kirigami.ScrollablePage {
        ...
        actions {
            ...
            contextualActions: [
                Kirigami.Action {
                    iconName: "favorite"
                    text: i18n("&Select as favorite")
                },
                Kirigami.Action {
                    iconName: "document-share"
                    text: i18n("&Share")
                },
                Kirigami.Action {
                    iconName: "document-edit"
                    text: i18n("&Edit")
                },
                Kirigami.Action {
                    iconName: "edit-image-face-add"
                    text: i18n("&Choose photo")
                },
                Kirigami.Action {
                    iconName: "im-kick-user"
                    text: i18n("&Block number")
                },
                Kirigami.Action {
                    iconName: "delete"
                    text: i18n("&Delete contact")
                },
                Kirigami.Action {
                    iconName: "edit-clear-history"
                    text: i18n("&Delete history")
                }
            ]
            ...
        }
    }
    ...
    contextDrawer: Kirigami.ContextDrawer {
    }
    ...
}
