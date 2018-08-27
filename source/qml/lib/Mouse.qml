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
    property int px
    property int py

    Rectangle {
        id: ind
        x: cursor.x - width / 2
        y: cursor.y - width / 2 + 5
        z: 1
        width: Kirigami.Units.iconSizes.small
        height: width
        color: "#9911d116"
        radius: width / 2
        visible: false

        NumberAnimation on width {
            id: indAnim
            duration: 300
            running: false

            onStopped: {
                ind.visible = false;
                if (qmlControler) {
                    qmlControler.click(px, py);
                }
                else {
                   console.error("Can't find qmlControler.");
                }

            }
        }
    }

    Image {
        id: cursor
        source: "../../img/left_ptr.png"
        visible: false
        width: Kirigami.Units.iconSizes.smallMedium
        height: Kirigami.Units.iconSizes.smallMedium
        z: 2

        NumberAnimation on x {
            id: xAnim
            duration: 1000
            running: false
        }
        NumberAnimation on y {
            id: yAnim
            running: false
            duration: 1000
            onStopped: {
                ind.visible = true;
                indAnim.to = Kirigami.Units.iconSizes.smallMedium;
                indAnim.start();
            }
        }
    }


    // Animate mouse to x/y and then click
    function click() {
        cursor.x = px - 60;
        cursor.y = py + 60;
        cursor.visible = true;

        xAnim.to = px;
        xAnim.start();
        yAnim.to = py;
        yAnim.start();
    }
}
