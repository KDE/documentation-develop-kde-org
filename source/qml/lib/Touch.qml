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
import org.kde.kirigami 2.4 as Kirigami

// Drawing a brace between to obejcts to show the distance between them
Item {
    id: canvas
    anchors.fill: parent;
    property int fromX
    property int fromY
    property int toX
    property int toY
    property int dur: 600

    Rectangle {
        id: ind
        z: 1
        width: height
        height: Kirigami.Units.iconSizes.smallMedium
        color: "#331d99f3"
        radius: height / 2
        visible: false
        x: cursor.x

        NumberAnimation on width {
            id: indAnim
            duration: dur
            running: false
        }
    }

    Image {
        id: cursor
        source: "../../img/transform-browse.svg"
        visible: false
        width: Kirigami.Units.iconSizes.smallMedium
        height: Kirigami.Units.iconSizes.smallMedium
        z: 2

        NumberAnimation on x {
            id: xAnim
            duration: dur
            running: false
        }
        NumberAnimation on y {
            id: yAnim
            running: false
            duration: dur
            onStopped: {
                timer.start()
            }
        }
    }

    Timer {
        id: timer
        interval: 1000
        repeat: false
        running: false
        onTriggered: {
            ind.visible = false;
            cursor.visible = false;
        }
    }

    // Animate swipe
    function swipe() {
        cursor.x = fromX - Kirigami.Units.iconSizes.smallMedium;
        cursor.y = fromY;
        cursor.visible = true;

        ind.y = fromY;
        ind.visible = true;

        xAnim.to = toX;
        xAnim.start();
        yAnim.to = toY;
        yAnim.start();
        indAnim.to = Math.abs(fromX - toX);
        indAnim.start();

        qmlControler.swipe(fromX, fromY, toX, toY);
    }
}
