import QtQuick 2.6
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.4 as Kirigami

import "../../lib" as HIG
import "../../lib/annotate.js" as A

Rectangle {
    id: root
    width: 600
    height: 420



    Kirigami.CardsLayout {
        x: Kirigami.Units.gridUnit * 2
        y: x
        width: 500

        id: layout
        Kirigami.Card {
            banner.imageSource: "../banner.jpg"

            header: Rectangle {
                color: Qt.rgba(0,0,0,0.3)
                implicitWidth: headerLayout.implicitWidth
                implicitHeight: headerLayout.implicitHeight - avatarIcon.height/2
                ColumnLayout {
                    id: headerLayout
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    Controls.Label {
                        Layout.fillWidth: true
                        padding: Kirigami.Units.largeSpacing

                        color: "white"
                        wrapMode: Text.WordWrap
                        text: "It's possible to have custom contents overlapping the image, for cases where a more personalised design is needed."
                    }
                    Rectangle {
                        id: avatarIcon
                        color: "steelblue"
                        radius: width
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: Kirigami.Units.iconSizes.huge
                        Layout.preferredHeight: Kirigami.Units.iconSizes.huge
                    }
                }
            }
            contentItem: Controls.Label {
                                wrapMode: Text.WordWrap
                                topPadding: avatarIcon.height/2
                                text: "It's possible to customize the look and feel for Cards too, if the no padding behavior for headers is needed. This is usually discouraged in order to have greater consistency, but in some cases the design requires a more fancy layout, as shown in this example of a Card. If a custom header is used, the title and icon in the banner property shouldn't be used. If a custom footer is used (which is discouraged), actions shouldn't be used."
                            }
                            footer: RowLayout {
                                Controls.Label {
                                    Layout.fillWidth: true
                                    text: "Custom footer"
                                }
                                Controls.Button {
                                    text: "Ok"
                                }
                            }
        }
    }
    
    HIG.Raster {
        z: 1
    }

    // HACK coordinates are only final after a small delay
    Timer {
        interval: 1000
        repeat: false
        running: true
        onTriggered: {
            var a = new A.An(root);
            //a.tree();
            a.find("card").draw({
                "padding": {},
                "messure": [{
                    "to": a.find('qquickrectangle{"color": "#4682b4"}'),
                    "type": "top"
                }, {
                    "to": a.find('qquickrectangle{"color": "#4682b4"}'),
                    "type": "left"
                }, {
                    "to": a.find('qquickrectangle{"color": "#4682b4"}'),
                    "type": "right"
                }]

            });
            a.find('qquickrectangle{"color": "#4682b4"}').draw({
                "outline": {},
            });
            a.find("qquickrowlayout").last().draw({
                "outline": {}
            });
            qmlControler.start();
        }
    }
}
