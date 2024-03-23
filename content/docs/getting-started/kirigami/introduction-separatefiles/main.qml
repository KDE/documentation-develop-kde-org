import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root

    title: i18nc("@title:window", "Day Kountdown")

    globalDrawer: Kirigami.GlobalDrawer {
        isMenu: true
        actions: [
            Kirigami.Action {
                text: i18n("Quit")
                icon.name: "gtk-quit"
                shortcut: StandardKey.Quit
                onTriggered: Qt.quit()
            }
        ]
    }

    ListModel {
        id: kountdownModel
    }

    // Fetches item from addEditSheet.qml and does action on signal
    AddEditSheet {
        id: addEditSheet
        onAdded: kountdownModel.append({
            "name": name,
            "description": description,
            "date": Date.parse(kdate)
        });
        onEdited: kountdownModel.set(index, {
            "name": name,
            "description": description,
            "date": Date.parse(kdate)
        });
        onRemoved: kountdownModel.remove(index, 1)
    }

    // Function called by 'edit' button on card and by 'add'-Action
    function openPopulatedSheet(mode, index = -1, listName = "", listDesc = "", listDate = "") {
        addEditSheet.mode = mode
        addEditSheet.index = index;
        addEditSheet.name = listName
        addEditSheet.description = listDesc
        addEditSheet.kdate = listDate

        addEditSheet.open()
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: i18nc("@title", "Kountdown")

        // Kirigami.Action encapsulates a UI action. Inherits from Controls.Action
        actions: [
            Kirigami.Action {
                id: addAction
                // Name of icon associated with the action
                icon.name: "list-add"
                // Action text, i18n function returns translated string
                text: i18nc("@action:button", "Add kountdown")
                // What to do when triggering the action
                onTriggered: openPopulatedSheet("add")
            }
        ]

        Kirigami.CardsListView {
            id: layout
            model: kountdownModel
            delegate: KountdownDelegate {}
        }
    }
}
