import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import org.kde.simplemdviewer 1.0

Kirigami.ApplicationWindow {
    id: root

    title: qsTr("Simple Markdown viewer")

    minimumWidth: Kirigami.Units.gridUnit * 20
    minimumHeight: Kirigami.Units.gridUnit * 20
    width: minimumWidth
    height: minimumHeight

    pageStack.initialPage: initPage

    Component {
        id: initPage

        Kirigami.Page {
            title: qsTr("Markdown Viewer")

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

                    placeholderText: qsTr("Write some Markdown code here")
                    wrapMode: Text.WrapAnywhere
                    Layout.fillWidth: true
                    Layout.minimumHeight: Kirigami.Units.gridUnit * 5 
                }

                RowLayout {
                    Layout.fillWidth: true

                    Controls.Button {
                        text: qsTr("Format")

                        onClicked: formattedText.text = mdconverter.mdFormat()
                    }

                    Controls.Button {
                        text: qsTr("Clear")

                        onClicked: {
                            sourceArea.text = ""
                            formattedText.text = ""
                        }
                    }
                } 

                Text {
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
