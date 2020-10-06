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

    Kirigami.CardsLayout {
        x: Kirigami.Units.gridUnit * 2
        y: x
        width: 800
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
                imageSource: "../../../img/coastal-fog/coastal-fog-40x30.png"
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
                imageSource: "../../../img/coastal-fog/coastal-fog.png"
            }
            contentItem: Controls.Label {
                wrapMode: Text.WordWrap
                text: "This is an instance of the Card type."
            }
        }
    }

    // HACK coordinates are only final after a small delay
    Timer {
        interval: 1000
        repeat: false
        running: true
        onTriggered: {
            var a = new A.An(root);
            //a.tree();
            a.find("bannerimage").draw({
                "outline": {
                    "aspectratio": true
                }
            });
            qmlControler.start();
        }
    }
}
