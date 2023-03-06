import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami

Kirigami.AbstractCard {
    id: kountdownDelegate
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
                Layout.fillHeight: true
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
                // Column spanning within grid layout (vertically in this case)
                Layout.columnSpan: 2
                text: i18n("Edit")
                onClicked: openPopulatedSheet("edit", index, name, description, new Date(date).toISOString().slice(0,10))
            }
        }
    }
}
