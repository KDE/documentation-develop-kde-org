import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami

Kirigami.ApplicationWindow {
    id: root

    title: i18nc("@title:window", "Day Kountdown")

    // Global drawer element with app-wide actions
    globalDrawer: Kirigami.GlobalDrawer {
        // Makes drawer a small menu rather than sliding pane
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
        ListElement {
            name: "Dog birthday!!"
            description: "Big doggo birthday blowout."
            date: 100
        }
    }

    Component {
        id: kountdownDelegate
        Kirigami.AbstractCard {
            contentItem: Item {
                implicitWidth: delegateLayout.implicitWidth
                implicitHeight: delegateLayout.implicitHeight
                GridLayout {
                    id: delegateLayout
                    anchors {
                        left: parent.left
                        top: parent.top
                        right: parent.right
                    }
                    rowSpacing: Kirigami.Units.largeSpacing
                    columnSpacing: Kirigami.Units.largeSpacing
                    columns: root.wideScreen ? 4 : 2

                    Kirigami.Heading {
                        Layout.fillHeight: true
                        level: 1
                        text: date
                    }

                    ColumnLayout {
                        Kirigami.Heading {
                            Layout.fillWidth: true
                            level: 2
                            text: name
                        }
                        Kirigami.Separator {
                            Layout.fillWidth: true
                            visible: description.length > 0
                        }
                        Controls.Label {
                            Layout.fillWidth: true
                            wrapMode: Text.WordWrap
                            text: description
                            visible: description.length > 0
                        }
                    }
                    Controls.Button {
                        Layout.alignment: Qt.AlignRight
                        Layout.columnSpan: 2
                        text: i18n("Edit")
                        //onClicked: to be done... soon!
                    }
                }
            }
        }
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
            onTriggered: kountdownModel.append({
                name: "Kirigami Action added card!",
                description: "Congratulations, your Kirigami Action works!",
                date: 1000
            })
        }

        Kirigami.CardsListView {
            id: layout
            model: kountdownModel
            delegate: kountdownDelegate
        }
    }
}
