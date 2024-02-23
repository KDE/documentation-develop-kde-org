import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import CustomModel 1.0

Kirigami.ApplicationWindow {
    id: root
    title: "Tutorial"

    CustomModel {
        id: customModel
    }

    Kirigami.OverlaySheet {
        id: editPrompt

        property var model
        property alias text: editPromptText.text

        title: "Edit Characters"

        Controls.TextField {
            id: editPromptText
        }

        footer: Controls.DialogButtonBox {
            standardButtons: Controls.DialogButtonBox.Ok
            onAccepted: {
                const model = editPrompt.model;
                model.characters = editPromptText.text;
                editPrompt.close();
            }
        }
    }

    Kirigami.OverlaySheet {
        id: addPrompt

        title: "Add New Species"

        Controls.TextField {
            id: addPromptText
        }

        footer: Controls.DialogButtonBox {
            standardButtons: Controls.DialogButtonBox.Ok
            onAccepted: {
                customModel.addSpecies(addPromptText.text);
                addPromptText.text = ""; // Clear TextField every time it's done
                addPrompt.close();
            }
        }
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        actions.main: Kirigami.Action {
            icon.name: "add"
            text: "Add New Species"
            onTriggered: {
                addPrompt.open();
            }
        }

        ColumnLayout {
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
    }
}
