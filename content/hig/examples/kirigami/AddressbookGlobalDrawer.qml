...
import org.kde.kirigami 2.9 as Kirigami
...

Kirigami.ApplicationWindow {
    ...
    globalDrawer: Kirigami.GlobalDrawer {
        title: "..."
        titleIcon: "..."
        
        topContent: [
            ...
        ]
        
        actions: [
            Kirigami.Action {
                iconName: "list-import-user"
                text: i18n("&Import")
            },
            Kirigami.Action {
                iconName: "list-export-user"
                text: i18n("&Export")
            },
            Kirigami.Action {
                iconName: "user-group-delete"
                text: i18n("&Merge contacts")
            },
            Kirigami.Action {
                iconName: "user-group-new"
                text: i18n("&Search duplicate contacts")
            },
            Kirigami.Action {
                iconName: "configure"
                text: i18n("&Settings")
            }
        ]
    }
    ...
}
