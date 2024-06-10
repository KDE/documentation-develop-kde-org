import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Actions Demo"
    width: 600
    height: 600

    globalDrawer: Kirigami.GlobalDrawer {}
    contextDrawer: Kirigami.ContextDrawer {}

    pageStack.initialPage: Kirigami.Page {
        title: "Demo"

        actions: [
            Kirigami.Action {
                icon.name: "go-home"
                onTriggered: showPassiveNotification("Main action triggered")
            },
            Kirigami.Action {
                icon.name: "go-previous"
                onTriggered: showPassiveNotification("Left action triggered")
            },
            Kirigami.Action {
                icon.name: "go-next"
                onTriggered: showPassiveNotification("Right action triggered")
            },
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
