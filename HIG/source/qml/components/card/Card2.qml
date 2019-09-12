import QtQuick 2.6
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.4 as Kirigami

import "../../lib" as HIG
import "../../lib/annotate.js" as A

Rectangle {
    id: root
    width: 400
    height: 420

    Kirigami.CardsLayout {
        x: Kirigami.Units.gridUnit * 2
        y: x
        width: 320
        //height: Layout.preferredHeight

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
                title: "This is a title"
            }
            contentItem: Controls.Label {
                wrapMode: Text.WordWrap
                text: "This is an instance of the Card type: it can optionally have an image, a title and an icon assigned to its banner group property, one or all of the properties together. A Card can also have Actions that will appear in the footer."
            }
        }
    }
    /*HIG.Grid {
        z: 1
    }*/

    // HACK coordinates are only final after a small delay
    Timer {
        interval: 1000
        repeat: false
        running: true
        onTriggered: {
            var a = new A.An(root);
            a.find("privateactiontoolbutton").draw({
                "outline": {},
            });
            a.find("bannerimage").draw({
                "outline": {
//                    "aspectratio": true
                }
            });
            a.find("card").draw({
                "padding": {}
            });
            qmlControler.start();
        }
    }
}
