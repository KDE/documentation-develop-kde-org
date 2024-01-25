import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Layouts 1.15
import org.kde.simplemdviewer 1.0

Kirigami.ApplicationWindow {
    id: root

    title: qsTr("Simple markdown viewer")

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

                    placeholderText: qsTr("Write here some markdown code")
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
