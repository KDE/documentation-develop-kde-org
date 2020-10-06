import QtQuick 2.6
import QtQuick.Controls 2.0 as Controls
import org.kde.kirigami 2.4 as Kirigami

Rectangle {
    id: root
    width: 600 + Kirigami.Units.gridUnit * 2
    height: 300 + Kirigami.Units.gridUnit * 2
    color: "white"

    Rectangle {
        color: "#444"
        x: Kirigami.Units.gridUnit * 1
        y: Kirigami.Units.gridUnit * 1
        width: 600
        height: 300

        Kirigami.CardsLayout {
            x: Kirigami.Units.gridUnit * 1
            y: Kirigami.Units.gridUnit * 1
            width: parent.width - 2 * Kirigami.Units.gridUnit
            columns: 3
            id: layout

            Kirigami.Card {
                actions: [
                    Kirigami.Action {
                        text: "Action1"
                        icon.name: "add-placemark"
                    },
                    Kirigami.Action {
                        text: "Action2"
                        icon.name: "address-book-new-symbolic"
                    }
                ]
                banner {
                    imageSource: "../../../img/coastal-fog/coastal-fog-160x90.png"
                }
                contentItem: Controls.Label {
                    wrapMode: Text.WordWrap
                    text: "This is an instance of the Card type."
                }
            }
            Kirigami.Card {
                actions: [
                    Kirigami.Action {
                        text: "Action1"
                        icon.name: "add-placemark"
                    },
                    Kirigami.Action {
                        text: "Action2"
                        icon.name: "address-book-new-symbolic"
                    }
                ]
                banner {
                    imageSource: "../../../img/coastal-fog/coastal-fog-160x90.png"
                }
                contentItem: Controls.Label {
                    wrapMode: Text.WordWrap
                    text: "This is an instance of the Card type."
                }
            }
        }

        SequentialAnimation on width {
            id: anim
            PropertyAnimation { to: 400; duration: 3000 }
            PropertyAnimation { to: 600; duration: 3000  }
            running: false;
        }
        Component.onCompleted: function() {
            anim.start();
            qmlControler.start();
        }
    }
}
