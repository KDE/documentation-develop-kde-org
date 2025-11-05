import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kirigamiaddons.formcard as FormCard
import org.kde.simplemdviewer

Kirigami.ApplicationWindow {
    id: root

    title: "Simple Markdown Viewer in Rust 🦀"
    minimumWidth: Kirigami.Units.gridUnit * 20
    minimumHeight: Kirigami.Units.gridUnit * 20
    width: minimumWidth
    height: minimumHeight
    pageStack.initialPage: initPage
    globalDrawer: Kirigami.GlobalDrawer {
        isMenu: true
        actions: [
            Kirigami.Action {
                icon.name: "kde"
                text: "Open About page"
                onTriggered: pageStack.pushDialogLayer(Qt.createComponent("org.kde.kirigamiaddons.formcard", "AboutPage"))
            }
        ]
    }
    Component {
        id: initPage

        Kirigami.Page {
            title: "Markdown Viewer"

            MdConverter {
                id: mdconverter
                sourceText: sourceArea.text
            }

            ColumnLayout {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                Controls.TextArea {
                    id: sourceArea

                    placeholderText: "Write some Markdown code here"
                    wrapMode: Text.WrapAnywhere
                    Layout.fillWidth: true
                    Layout.minimumHeight: Kirigami.Units.gridUnit * 5
                }

                RowLayout {
                    Layout.fillWidth: true

                    Controls.Button {
                        text: "Format"
                        onClicked: formattedText.text = mdconverter.mdFormat()
                    }

                    Controls.Button {
                        text: "Clear"
                        onClicked: {
                            sourceArea.text = "";
                            formattedText.text = "";
                        }
                    }
                }

                Controls.Label {
                    id: formattedText

                    textFormat: Text.RichText
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                    Layout.minimumHeight: Kirigami.Units.gridUnit * 5
                }
            }
        }
    }
}
