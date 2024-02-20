import QtQuick 2.15
import QtQuick.Controls 2.15
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

        title: "Edit Waifus"

        TextField {
            id: editPromptText
        }

        footer: DialogButtonBox {
            standardButtons: DialogButtonBox.Ok
            onAccepted: {
                const model = editPrompt.model;
                model.waifus = editPromptText.text;
                editPrompt.close();
            }
        }
    }

    Kirigami.OverlaySheet {
        id: addPrompt

        title: "Add New Type"

        TextField {
            id: addPromptText
        }

        footer: DialogButtonBox {
            standardButtons: DialogButtonBox.Ok
            onAccepted: {
                customModel.addType(addPromptText.text);
                addPromptText.text = ""; // Clear TextField every time it's done
                addPrompt.close();
            }
        }
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        actions.main: Kirigami.Action {
            icon.name: "add"
            text: "Add New Type"
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
                        text: model.type
                        level: 2
                    }
                    contentItem: Item {
                        implicitWidth: delegateLayout.implicitWidth
                        implicitHeight: delegateLayout.implicitHeight
                        ColumnLayout {
                            id: delegateLayout
                            Label {
                                text: model.waifus
                            }
                            RowLayout {
                                Button {
                                    text: "Edit"
                                    onClicked: {
                                        editPrompt.text = model.waifus;
                                        editPrompt.model = model;
                                        editPrompt.open();
                                    }
                                }
                                Button {
                                    text: "Delete"
                                    onClicked: {
                                        customModel.deleteType(model.type, index);
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
