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
                imageSource: "../../../img/wallpaper/BytheWater.jpg"
                title: "This is a title"
            }
            contentItem: Controls.Label {
                wrapMode: Text.WordWrap
                text: "This is an instance of the Card type: it can optionally have an image, a title and an icon assigned to its banner group property, one or all of the properties together. A Card can also have Actions that will appear in the footer."
            }
        }
    }
    //HIG.Raster {
        //z: 1
    //}

    // HACK coordinates are only final after a small delay
    HIG.FTimer {
        running: true
        onTick: function(frameCounter) {
            if (frameCounter == 60) {
                var a = new A.An(root);
                var label = a.find("label");
                var toolbar = a.find("toolbarlayout");
                var bannerimage = a.find("bannerimage");
                bannerimage.draw({
                    "outline": {label: false},
                    "brace": {to: label, horizontal: false, center: false, text: 16}
                });
                label.draw({
                    "outline": {label: false},
                    "brace": {to: toolbar, horizontal: false, center: false}
                });
                toolbar.draw({
                    "outline": {label: false},
                });
            }
        }
    }
}
