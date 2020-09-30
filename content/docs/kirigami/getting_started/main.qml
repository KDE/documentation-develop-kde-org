import QtQuick 2.1
import org.kde.kirigami 2.4 as Kirigami
import QtQuick.Controls 2.0 as Controls

Kirigami.ApplicationWindow {
    id: root

    title: i18n("testes")

    globalDrawer: Kirigami.GlobalDrawer {
        title: i18n("testes")
        titleIcon: "applications-graphics"
        actions: [
            ...
        ]
    }

    contextDrawer: Kirigami.ContextDrawer {
        id: contextDrawer
    }

    pageStack.initialPage: mainPageComponent

    Component {
        id: mainPageComponent

        Kirigami.Page {
            title: i18n("testes")

            actions {
                ...
            }
        }
    }
}
