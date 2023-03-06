import org.kde.kirigami 2.20 as Kirigami

Kirigami.ApplicationWindow {
    globalDrawer: Kirigami.GlobalDrawer {}
    contextDrawer: Kirigami.ContextDrawer {}

    pageStack.initialPage: Kirigami.Page {
        title: "Demo"

        actions {
            main: Kirigami.Action {
                icon.name: "go-home"
                onTriggered: showPassiveNotification("Main action triggered")
            }
            left: Kirigami.Action {
                icon.name: "go-previous"
                onTriggered: showPassiveNotification("Left action triggered")
            }
            right: Kirigami.Action {
                icon.name: "go-next"
                onTriggered: showPassiveNotification("Right action triggered")
            }
            contextualActions: [
                Kirigami.Action {
                    text: "Contextual Action 1"
                    icon.name: "bookmarks"
                    onTriggered: showPassiveNotification("Contextual action 1 clicked")
                },
                Kirigami.Action {
                    text: "Contextual Action 2"
                    icon.name: "folder"
                    enabled: false
                }
            ]
        }
    }
}
