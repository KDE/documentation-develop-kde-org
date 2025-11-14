import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import org.kde.tutorial.components

Kirigami.ScrollablePage {
    title: "C++ models in QML"
    actions: [
        Kirigami.Action {
            icon.name: "list-add-symbolic"
            text: "Add New Species"
            onTriggered: {
                addPrompt.open();
            }
        }
    ]
    Model {
        id: customModel
    }
    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        Repeater {
            model: customModel
            delegate: Kirigami.AbstractCard {
                Layout.fillHeight: true
                header: Kirigami.Heading {
                    text: model.species
                    level: 2
                }
                contentItem: Item {
                    implicitWidth: delegateLayout.implicitWidth
                    implicitHeight: delegateLayout.implicitHeight
                    ColumnLayout {
                        id: delegateLayout
                        Controls.Label {
                            text: model.characters
                        }
                        RowLayout {
                            Layout.fillWidth: true
                            Controls.Button {
                                text: "Edit"
                                onClicked: {
                                    editPrompt.text = model.characters;
                                    editPrompt.model = model;
                                    editPrompt.open();
                                }
                            }
                            Controls.Button {
                                text: "Delete"
                                onClicked: {
                                    customModel.deleteSpecies(model.species, index);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    Kirigami.PromptDialog {
        id: addPrompt
        title: "Add New Species"
        standardButtons: Kirigami.Dialog.Ok
        onAccepted: {
            customModel.addSpecies(addPromptText.text);
            addPromptText.text = ""; // Clear TextField every time it's done
            addPrompt.close();
        }
        Controls.TextField {
            id: addPromptText
            Layout.fillWidth: true
            onAccepted: addPrompt.accept()
        }
    }

    Kirigami.PromptDialog {
        id: editPrompt
        property var model
        property alias text: editPromptText.text
        title: "Edit Characters"
        standardButtons: Kirigami.Dialog.Ok | Kirigami.Dialog.Cancel
        onAccepted: {
            const model = editPrompt.model;
            model.characters = editPromptText.text;
            editPrompt.close();
        }
        Controls.TextField {
            id: editPromptText
            onAccepted: editPrompt.accept()
        }
    }
}
