import QtQuick 2.6
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.4 as Kirigami

import "../../lib" as HIG
import "../../lib/annotate.js" as A

Rectangle {
    id: root
    width: 400
    height: 340

    Kirigami.CardsLayout {
        x: Kirigami.Units.gridUnit * 2
        y: x
        width: 320

        id: layout
        Kirigami.Card {
            actions: [
                Kirigami.Action {
                    text: "Actions"
                }
            ]
            banner {
                imageSource: "../../../img/coastal-fog/coastal-fog-160x90.png"
                title: "Header"
            }
            contentItem: Controls.Label {
                wrapMode: Text.WordWrap
                text: "Content"
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
                a.find("qquickgridlayout").children("qquickitem").draw({
                    "outline": {"label": false}
                });
                a.find("card").draw({
                    "padding": {}
                });
            }
        }
    }
}
