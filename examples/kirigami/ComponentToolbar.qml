...
import QtQuick.Controls 2.2 as Controls
import org.kde.kirigami 2.4 as Kirigami
...
    Kirigami.ActionToolBar {
        ...
        actions: [
            Kirigami.Action {
                iconName: "favorite"
                text: i18n("&Select as favorite")
            },
            Kirigami.Action {
                iconName: "document-share"
                text: i18n("&Share")
            }
        ]
        ...
    }
...
