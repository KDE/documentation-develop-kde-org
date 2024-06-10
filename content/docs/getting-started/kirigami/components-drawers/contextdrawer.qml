import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Drawers App"
    height: 600
    width: 1200
    minimumWidth: 500

    globalDrawer: Kirigami.GlobalDrawer {}
    contextDrawer: Kirigami.ContextDrawer {}

    pageStack.initialPage: [ emptyPage, contextDrawerPage ]

    Kirigami.Page {
        title: "Empty page"
        id: emptyPage
    }

    Kirigami.Page {
        id: contextDrawerPage
        title: "Context Drawer page"

        actions: [
            Kirigami.Action {
                icon.name: "media-record"
            },
            Kirigami.Action {
                icon.name: "arrow-left"
            },
            Kirigami.Action {
                icon.name: "arrow-right"
            },
            Kirigami.Action {
                text: "Contextual Action 1"
                icon.name: "media-playback-start"
            },
            Kirigami.Action {
                text: "Contextual Action 2"
                icon.name: "media-playback-stop"
            }
        ]
    }
}
