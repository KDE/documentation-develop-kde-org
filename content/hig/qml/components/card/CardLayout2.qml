import QtQuick 2.6
import QtQuick.Controls 2.0 as Controls
import org.kde.kirigami 2.4 as Kirigami
import "../../lib" as HIG

Rectangle {
    id: root
    width: 640
    height: 480

    Rectangle {
        color: "#444"
        x: Kirigami.Units.gridUnit
        y: Kirigami.Units.gridUnit
        width: root.width - Kirigami.Units.gridUnit * 2
        height: root.height - Kirigami.Units.gridUnit * 2
        clip: true

        Kirigami.CardsLayout {
            x: Kirigami.Units.gridUnit * 1
            y: Kirigami.Units.gridUnit * 1
            width: parent.width - 2 * Kirigami.Units.gridUnit
            columns: width > 350 ? 3 : width > 200 ? 2 : 1
            id: layout

            Kirigami.Card {
                banner {
                    imageSource: "../../../img/wallpaper/Autumn.jpg"
                }
                contentItem: Controls.Label {
                    wrapMode: Text.WordWrap
                    text: "Autumn"
                }
            }
            Kirigami.Card {
                banner {
                    imageSource: "../../../img/wallpaper/BytheWater.jpg"
                }
                contentItem: Controls.Label {
                    wrapMode: Text.WordWrap
                    text: "By the water"
                }
            }
            Kirigami.Card {
                banner {
                    imageSource: "../../../img/wallpaper/ColdRipple.jpg"
                }
                contentItem: Controls.Label {
                    wrapMode: Text.WordWrap
                    text: "Cold ripple"
                }
            }
            Kirigami.Card {
                banner {
                    imageSource: "../../../img/wallpaper/Canopee.png"
                }
                contentItem: Controls.Label {
                    wrapMode: Text.WordWrap
                    text: "Canopee"
                }
            }
            Behavior on columns {
                NumberAnimation { duration: 300 }
            }
        }

        SequentialAnimation on width {
            id: anim
            PropertyAnimation { to: 150; duration: 4000 }
            PropertyAnimation { to: root.width - Kirigami.Units.gridUnit * 2; duration: 4000  }
            running: false;
        }
        HIG.FTimer {
            running: true
            onTick: function(frameCounter) {
                if (frameCounter == 120) {
                    anim.start();
                }
            }
        }
    }
}
