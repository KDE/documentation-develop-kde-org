import QtQuick 2.6
import QtQuick.Controls 2.0 as Controls
import org.kde.kirigami 2.4 as Kirigami

Rectangle {
    id: root
    width: 400 + Kirigami.Units.gridUnit * 2
    height: 300 + Kirigami.Units.gridUnit * 2

    Rectangle {
        color: "#444"
        x: Kirigami.Units.gridUnit * 1
        y: Kirigami.Units.gridUnit * 1
        width: 400
        height: 300
        clip: true

        Kirigami.CardsLayout {
            x: Kirigami.Units.gridUnit * 1
            y: Kirigami.Units.gridUnit * 1
            width: parent.width - 2 * Kirigami.Units.gridUnit
            columns: width > 350 ? 3 : width > 200 ? 2 : 1
            id: layout

            Kirigami.Card {
                banner {
                    imageSource: "../../../img/coastal-fog/coastal-fog-40x30.png"
                }
                contentItem: Controls.Label {
                    wrapMode: Text.WordWrap
                    text: "This is an instance of the Card type."
                }
            }
            Kirigami.Card {
                banner {
                    imageSource: "../../../img/coastal-fog/coastal-fog-40x30.png"
                }
                contentItem: Controls.Label {
                    wrapMode: Text.WordWrap
                    text: "This is an instance of the Card type."
                }
            }
            Kirigami.Card {
                banner {
                    imageSource: "../../../img/coastal-fog/coastal-fog-40x30.png"
                }
                contentItem: Controls.Label {
                    wrapMode: Text.WordWrap
                    text: "This is an instance of the Card type."
                }
            }
            Kirigami.Card {
                banner {
                    imageSource: "../../../img/coastal-fog/coastal-fog-40x30.png"
                }
                contentItem: Controls.Label {
                    wrapMode: Text.WordWrap
                    text: "This is an instance of the Card type."
                }
            }
            Behavior on columns {
                NumberAnimation { duration: 300 }
            }
        }

        SequentialAnimation on width {
            id: anim
            PropertyAnimation { to: 150; duration: 3500 }
            PropertyAnimation { to: 400; duration: 3500  }
            running: false;
        }
        Component.onCompleted: function() {
            anim.start();
            qmlControler.start();
        }
    }
}
