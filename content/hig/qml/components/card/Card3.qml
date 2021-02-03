import QtQuick 2.6
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.4 as Kirigami

import "../../lib" as HIG
import "../../lib/annotate.js" as A

Rectangle {
    id: root
    width: 600
    height: 300

    Kirigami.CardsLayout {
        x: Kirigami.Units.gridUnit * 2
        y: x
        width: 500

        id: layout
        Kirigami.Card {
            width: 320
            height: 180
            
            headerOrientation: Qt.Horizontal
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
                imageSource: "../../../img/wallpaper/BytheWater.jpg"
                title: "Title"
            }
            contentItem: Controls.Label {
                wrapMode: Text.WordWrap
                text: "A card can optionally have horizontal orientation.\n In this case will be wider than tall, so is fit to be used also in a ColumnLayout.\nIf you need to put it in a CardsLayout, it will have by default a columnSpan of 2 (which can be overridden)."
            }
        }
    }
    
    HIG.Raster {
        z: 1
    }

    // HACK coordinates are only final after a small delay
    HIG.FTimer {
        running: true
        onTick: function(frameCounter) {
            if (frameCounter == 60) {
                var a = new A.An(root);
                a.find("privateactiontoolbutton").draw({
                    "outline": {},
                }).first().draw({
                    "brace": {
                        "to": a.find("privateactiontoolbutton").last(),
                        "center": false
                    },
                });
                a.find("bannerimage").draw({
                    "outline": {label: false}
                });
            }
        }
    }
}
