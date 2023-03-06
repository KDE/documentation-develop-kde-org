import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami

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
        actions.main: Kirigami.Action {
            id: addAction
            // Name of icon associated with the action
            icon.name: "list-add"
            // Action text, i18n function returns translated string
            text: i18nc("@action:button", "Add kountdown")
            // What to do when triggering the action
            onTriggered: openPopulatedSheet("add")
        }

        Kirigami.CardsListView {
            id: layout
            model: kountdownModel
            delegate: KountdownDelegate {}
        }
    }
}
