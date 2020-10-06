/*
 *   Copyright 2018 Fabian Riethmayer
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Library General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.7 as Kirigami
import QtGraphicalEffects 1.0
import "../../lib/annotate.js" as A
import "../../models/" as Models

Rectangle {
    width: 620
    height: 300
    id: root
    color: "#eff0f1"

    property var mydata : Models.Contacts {
    }

    Row {
        anchors.fill: parent
        spacing:  Kirigami.Settings.tabletMode ? 2 * Kirigami.Units.largeSpacing : 2 * Kirigami.Units.smallSpacing

        Rectangle {
            border.width: 1
            border.color: "#bdc3c7"
            width: 300
            height: root.height

            ListView {
                model: root.mydata
                anchors.fill: parent


                delegate: Kirigami.AbstractListItem {
                    width: 300

                    Row {
                        spacing:  Kirigami.Settings.tabletMode ? 2 * Kirigami.Units.largeSpacing : 2 * Kirigami.Units.smallSpacing

                        CheckBox {
                            checked: index < 2
                            anchors.verticalCenter: parent.verticalCenter
                            text: ""
                        }
                        Item {
                            width: Kirigami.Units.iconSizes.medium
                            height: width

                            Image {
                                id: img
                                width: parent.width
                                height: width
                                source: "../../../img/" + model.image
                                visible: false
                            }
                            OpacityMask {
                                anchors.fill: img
                                source: img
                                maskSource: Rectangle {
                                    height: img.width
                                    width: height
                                    radius: height / 2
                                }
                            }
                        }
                        Label {
                            anchors.verticalCenter: parent.verticalCenter
                            text: model.firstname + " " + model.lastname
                        }
                    }
                }
            }
        }

        Rectangle {
            border.width: 1
            border.color: "#bdc3c7"
            width: 300
            height: root.height


            ListView {
                model: root.mydata
                anchors.fill: parent

                delegate: Kirigami.AbstractListItem {
                    width: 300

                    background: Rectangle {
                        color: index < 2 ? Kirigami.Theme.highlightColor : Kirigami.Theme.backgroundColor

                        Rectangle {
                            width: parent.width
                            height: 1
                            color: "#bdc3c7"
                            anchors.bottom: parent.bottom
                        }
                    }

                    Row {
                        spacing:  Kirigami.Settings.tabletMode ? 2 * Kirigami.Units.largeSpacing : 2 * Kirigami.Units.smallSpacing
                        Item {
                            width: Kirigami.Units.iconSizes.medium
                            height: width

                            Image {
                                id: img2
                                width: parent.width
                                height: width
                                source: "../../../img/" + model.image
                                visible: false
                            }
                            OpacityMask {
                                anchors.fill: img2
                                source: img2
                                maskSource: Rectangle {
                                    height: img2.width
                                    width: height
                                    radius: height / 2
                                }
                            }
                        }
                        Label {
                            anchors.verticalCenter: parent.verticalCenter
                            text: model.firstname + " " + model.lastname
                        }
                    }
                }
            }
        }
    }

    Timer {
        interval: 2000
        repeat: false
        running: true
        onTriggered: {
            qmlControler.start();
            return;
            var a = new A.An(root);
            var item = a.find("abstractlistitem").first();
            //console.log(item.nodes.length)
            item.draw({
                "padding": {}
            });
            var icon = item.find("qquickimage").first();
            /*icon.draw({
                "outline": {label: false}
            });
            var checkbox = item.find("qquickcheckbox").first();
            checkbox.draw({
                "outline": {label: false},
            });*/

            a.find("abstractlistitem").eq(1).find("qquickcheckbox").draw({
                "ruler": {horizontal: true, offset: "center"}
            });
            qmlControler.start();
        }
    }
}
