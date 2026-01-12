import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import org.kde.tutorial.components

Kirigami.ScrollablePage {
    title: "C++ models in QML"
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
                        Controls.Button {
                            text: "Edit"
                            onClicked: {
                                editPrompt.text = model.characters;
                                editPrompt.model = model;
                                editPrompt.open();
                            }
                        }
                    }
                }
            }
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
