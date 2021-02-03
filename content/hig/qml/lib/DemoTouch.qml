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

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.4 as Kirigami
import "tools.js" as T
import "annotate.js" as A

Kirigami.ApplicationItem {
    width: 640
    height: 320
    id: root

    pageStack.initialPage: Kirigami.Page {
        padding: 0
    
        Row {
            anchors.fill: parent
            spacing: Kirigami.Units.largeSpacing
            anchors.margins: Kirigami.Units.gridUnit * 2

            ComboBox {
                model: [ "Item1", "Item2", "Item3" ]
            }

            Component {
                id: delegateComponent
                Kirigami.SwipeListItem {
                    id: listItem
                    contentItem: RowLayout {
                        Label {
                            Layout.fillWidth: true
                            height: Math.max(implicitHeight, Kirigami.Units.iconSizes.smallMedium)
                            text: model.title
                            color: listItem.checked || (listItem.pressed && !listItem.checked && !listItem.sectionDelegate) ? listItem.activeTextColor : listItem.textColor
                        }
                    }
                    actions: [
                        Kirigami.Action {
                            iconName: "document-decrypt"
                            text: "Action 1"
                            onTriggered: showPassiveNotification(model.text + " Action 1 clicked")
                        },
                        Kirigami.Action {
                            iconName: "mail-reply-sender"
                            text: "Action 2"
                            onTriggered: showPassiveNotification(model.text + " Action 2 clicked")
                        }]
                }
            }
            ListView {
                width: 200
                height: 200
                id: mainList
                Timer {
                    id: refreshRequestTimer
                    interval: 3000
                    onTriggered: page.refreshing = false
                }
                model: ListModel {
                    id: listModel

                    Component.onCompleted: {
                        for (var i = 0; i < 200; ++i) {
                            listModel.append({"title": "Item " + i,
                                "actions": [{text: "Action 1", icon: "document-decrypt"},
                                            {text: "Action 2", icon: "mail-reply-sender"}]
                            })
                        }
                    }
                }
                moveDisplaced: Transition {
                    YAnimator {
                        duration: Kirigami.Units.longDuration
                        easing.type: Easing.InOutQuad
                    }
                }
                delegate: Kirigami.DelegateRecycler {
                    width: parent ? parent.width : implicitWidth
                    sourceComponent: delegateComponent
                }
            }
        }
    }

    // HACK coordinates are only final after a small delay
    FAnimation {
        actions: {
            60: function() {
                var a = new A.An(root);
                //a.tree();
                a.find("swipelistitem").first().swipe({fromX: +90, fromY: 0, toX: -80, toY: 0});
            }
        }
    }

    // Draw helpers and anotation
    Raster {
        base: Kirigami.Units.gridUnit
        desktop: true
    }
}
