import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root

    width: 600
    height: 400

    title: i18nc("@title:window", "Day Kountdown")

    globalDrawer: Kirigami.GlobalDrawer {
        isMenu: true
        actions: [
            Kirigami.Action {
                text: i18n("Quit")
                icon.name: "application-exit-symbolic"
                shortcut: StandardKey.Quit
                onTriggered: Qt.quit()
            }
        ]
    }

    ListModel {
        id: kountdownModel
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
                        level: 1
                        text: i18n("%1 days", Math.round((date-Date.now())/86400000))
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
                    }
                }
            }
        }
    }

    Kirigami.Dialog {
        id: addDialog
        title: i18nc("@title:window", "Add kountdown")
        standardButtons: Kirigami.Dialog.Ok | Kirigami.Dialog.Cancel
        padding: Kirigami.Units.largeSpacing
        preferredWidth: Kirigami.Units.gridUnit * 20

        // Form layouts help align and structure a layout with several inputs
        Kirigami.FormLayout {
            // Textfields let you input text in a thin textbox
            Controls.TextField {
                id: nameField
                // Provides a label attached to the textfield
                Kirigami.FormData.label: i18nc("@label:textbox", "Name*:")
                // What to do after input is accepted (i.e. pressed Enter)
                // In this case, it moves the focus to the next field
                onAccepted: descriptionField.forceActiveFocus()
            }
            Controls.TextField {
                id: descriptionField
                Kirigami.FormData.label: i18nc("@label:textbox", "Description:")
                placeholderText: i18n("Optional")
                // Again, it moves the focus to the next field
                onAccepted: dateField.forceActiveFocus()
            }
            Controls.TextField {
                id: dateField
                Kirigami.FormData.label: i18nc("@label:textbox", "ISO Date*:")
                // D means a required number between 1-9,
                // 9 means a required number between 0-9
                inputMask: "D999-99-99"
                // Here we confirm the operation just like
                // clicking the OK button
                onAccepted: addDialog.onAccepted()
            }
            Controls.Label {
                text: "* = required fields"
            }
        }
        // Once the Kirigami.Dialog is initialized,
        // we want to create a custom binding to only
        // make the Ok button visible if the required
        // text fields are filled.
        // For this we use Kirigami.Dialog.standardButton(button):
        Component.onCompleted: {
            const button = standardButton(Kirigami.Dialog.Ok);
            // () => is a JavaScript arrow function
            button.enabled = Qt.binding( () => requiredFieldsFilled() );
        }
        onAccepted: {
            // The binding is created, but we still need to make it
            // unclickable unless the fields are filled
            if (!addDialog.requiredFieldsFilled()) return;
            appendDataToModel();
            clearFieldsAndClose();
        }
        // We check that the nameField is not empty and that the
        // dateField (which has an inputMask) is completely filled
        function requiredFieldsFilled() {
            return (nameField.text !== "" && dateField.acceptableInput);
        }
        function appendDataToModel() {
            kountdownModel.append({
                name: nameField.text,
                description: descriptionField.text,
                date: new Date(dateField.text)
            });
        }
        function clearFieldsAndClose() {
            nameField.text = ""
            descriptionField.text = ""
            dateField.text = ""
            addDialog.close();
        }
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: i18nc("@title", "Kountdown")

        // Kirigami.Action encapsulates a UI action. Inherits from Controls.Action
        actions: [
            Kirigami.Action {
                id: addAction
                // Name of icon associated with the action
                icon.name: "list-add-symbolic"
                // Action text, i18n function returns translated string
                text: i18nc("@action:button", "Add kountdown")
                // What to do when triggering the action
                onTriggered: addDialog.open()
            }
        ]

        Kirigami.CardsListView {
            id: cardsView
            model: kountdownModel
            delegate: kountdownDelegate
        }
    }
}
