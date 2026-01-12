import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

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
                header: Kirigami.Heading {
                    text: model.species
                    level: 2
                }
                contentItem: Controls.Label {
                    text: model.characters
                }
            }
        }
    }
}