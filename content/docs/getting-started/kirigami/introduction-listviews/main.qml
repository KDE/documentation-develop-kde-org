import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami

Kirigami.ApplicationWindow {
    id: root

    title: i18nc("@title:window", "Day Kountdown")

    // ListModel needed for ListView, contains elements to be displayed
    ListModel {
        id: kountdownModel
        // Each ListElement is an element on the list, containing information
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
                        // Heading will be as tall as possible while respecting constraints
                        Layout.fillHeight: true
                        // Level determines the size of the heading
                        level: 1
                        text: date
                    }

                    // Layout for positioning elements vertically
                    ColumnLayout {
                        Kirigami.Heading {
                            Layout.fillWidth: true
                            level: 2
                            text: name
                        }
                        // Horizontal rule
                        Kirigami.Separator {
                            Layout.fillWidth: true
                            visible: description.length > 0
                        }
                        // Labels contain text
                        Controls.Label {
                            Layout.fillWidth: true
                            // Word wrap makes text stay within box and shift with size
                            wrapMode: Text.WordWrap
                            text: description
                            visible: description.length > 0
                        }
                    }
                    Controls.Button {
                        Layout.alignment: Qt.AlignRight
                        // Column spanning within grid layout (vertically in this case)
                        Layout.columnSpan: 2
                        text: i18n("Edit")
                        //onClicked: to be done...
                    }
                }
            }
        }
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: i18nc("@title", "Kountdown")

        // List view for card elements
        Kirigami.CardsListView {
            id: cardsView
            // Model contains info to be displayed
            model: kountdownModel
            // Delegate is how the information will be presented in the ListView
            delegate: kountdownDelegate
        }
    }
}
