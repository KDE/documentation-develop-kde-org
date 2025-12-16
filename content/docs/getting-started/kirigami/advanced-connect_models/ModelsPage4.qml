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
    // ...
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
        // ...
    }
}
