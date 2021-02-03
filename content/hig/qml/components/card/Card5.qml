import QtQuick 2.6
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.4 as Kirigami

import "../../lib" as HIG
import "../../lib/annotate.js" as A

Rectangle {
    id: root
    width: 900
    height: 400

    Row {
        x: Kirigami.Units.gridUnit * 2
        y: x
        width: 800
        spacing: Kirigami.Units.gridUnit * 2

        Kirigami.Card {
            //height: 100
            x: 10
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
            //height: 200
            x: 200
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
                imageSource: "../../../img/coastal-fog/coastal-fog-40x30.png"
            }
            contentItem: Controls.Label {
                wrapMode: Text.WordWrap
                text: "This is an instance of the Card type."
            }
        }
        Kirigami.Card {
            //height: 300
            x: 400
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
                imageSource: "../../../img/coastal-fog/coastal-fog.png"
            }
            contentItem: Controls.Label {
                wrapMode: Text.WordWrap
                text: "This is an instance of the Card type."
            }
        }
    }

    // HACK coordinates are only final after a small delay
    HIG.FTimer {
        running: true
        onTick: function(frameCounter) {
            if (frameCounter == 60) {
                var a = new A.An(root);
                //a.tree();
                a.find("bannerimage").draw({
                    "outline": {
                        "aspectratio": true
                    }
                });
            }
        }
    }
}
