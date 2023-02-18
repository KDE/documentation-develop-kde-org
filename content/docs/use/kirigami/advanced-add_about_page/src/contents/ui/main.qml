import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami

import org.kde.example 1.0

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
            },

            Kirigami.Action { // <==== Action to open About page
                text: i18n("About")
                icon.name: "help-about"
                onTriggered: pageStack.layers.push(aboutPage)
            }
        ]
    }

    Component { // <==== Component that instantiates the Kirigami.AboutPage
        id: aboutPage

        Kirigami.AboutPage {
            aboutData: About
        }
    }

    ListModel {
        id: kountdownModel
    }

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

        actions.main: Kirigami.Action {
            id: addAction
            icon.name: "list-add"
            text: i18nc("@action:button", "Add kountdown")
            onTriggered: openPopulatedSheet("add")
        }

        Kirigami.CardsListView {
            id: layout
            model: kountdownModel
            delegate: KountdownDelegate {}
        }
    }
}
