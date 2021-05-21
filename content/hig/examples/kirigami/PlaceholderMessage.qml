...
import org.kde.kirigami 2.15 as Kirigami
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.13
...

Kirigami.ApplicationWindow {
    ...
    ColumnLayout {
        QQC2.ScrollView {
        id: scrollview
            ...
            Kirigami.PlaceholderMessage {
                visible: scrollview.count === 0
                text: "No content"
                explanation: "click the button below to add some"
            }
        }
        QQC2.Button {
            Layout.Alignment: Qt.AlignRight
            text: "Add content"
            icon.name: "list-add"
        }
    }
}
