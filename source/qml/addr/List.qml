
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
import QtQuick 2.2
import QtQuick.Controls 2.2
import org.kde.kirigami 2.4 as Kirigami
import QtGraphicalEffects 1.0

import "../lib/" as HIG

ListView {
    currentIndex: -1
    id: list

    delegate: Kirigami.SwipeListItem {
        property alias image: img
        onClicked: list.currentIndex = index

        contentItem: Row {
            spacing: 2 * Kirigami.Units.largeSpacing

            Item {
                width: Kirigami.Units.iconSizes.medium
                height: width

                Image {
                    id: img
                    width: Kirigami.Units.iconSizes.medium
                    height: width
                    source: "../../img/" + model.image
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
        actions: [
            Kirigami.Action {
                iconName: "call-start"
            },
            Kirigami.Action {
                iconName: "mail-message"
            }
        ]
    }
}
