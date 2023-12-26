import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: "Chips"

    ListModel {
        id: chips

        ListElement { text: "Chip 1" }
        ListElement { text: "Chip 2" }
        ListElement { text: "Chip 3" }
    }

    pageStack.initialPage: Kirigami.Page {
        title: "Chips"

        Kirigami.OverlaySheet {
            id: editChipPrompt

            property var chip;
            property var index;

            header: Kirigami.Heading {
                text: "Edit Chip"
            }

            footer: DialogButtonBox {
                standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
                onAccepted: {
                    // Both the data from the Repeater and ListModel must be
                    // edited in order to update both.
                    editChipPrompt.chip.text = editTextField.text;
                    chips.setProperty(editChipPrompt.index, "text", editTextField.text);
                    editChipPrompt.close();
                }
                onRejected: {
                    editChipPrompt.close();
                }
            }

            TextField {
                id: editTextField
            }
        }

        ColumnLayout {
            anchors.fill: parent
            Kirigami.FormLayout {
                TextField {
                    id: insertTextField
                    Kirigami.FormData.label: "Item:"
                    onAccepted: chips.append({ text: insertTextField.text })
                }
                // Wrapped in ColumnLayout to prevent binding loops.
                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    Repeater {
                        model: chips

                        Kirigami.Chip {
                            id: chip
                            text: modelData
                            onClicked: {
                                editTextField.text = modelData;
                                editChipPrompt.chip = chip;
                                editChipPrompt.index = index;
                                editChipPrompt.open();
                            }
                            onRemoved: chips.remove(index)
                        }
                    }
                }
            }
        }
    }
}