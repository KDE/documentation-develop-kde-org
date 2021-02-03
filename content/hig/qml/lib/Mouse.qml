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
import QtTest 1.2
import org.kde.kirigami 2.4 as Kirigami

// Drawing a brace between to obejcts to show the distance between them
Item {
    id: canvas
    anchors.fill: parent;
    property int px
    property int py
    property bool animate: true
    z: 1000000

    Rectangle {
        id: ind
        x: cursor.x - width / 2
        y: cursor.y - width / 2 + 5
        z: 2
        width: Kirigami.Units.iconSizes.medium
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
                cursor.visible = false;
                event.mouseClick(canvas.parent, px, py, Qt.LeftButton, Qt.NoModifier, 0)
            }
        }
    }

    TestEvent {
        id: event
    }


    Image {
        id: cursor
        source: "../../img/left_ptr.png"
        visible: false
        width: Kirigami.Units.iconSizes.medium
        height: Kirigami.Units.iconSizes.medium
        z: 3

        ParallelAnimation {
            running: false
            id: cursorAnimation
            NumberAnimation {
                id: cursorAnimationX
                target: cursor
                property: "x"
                duration: 1000
            }
            NumberAnimation {
                id: cursorAnimationY
                target: cursor
                property: "y"
                duration: 1000
            }
        }
    }

    Timer {
        id: moveMouse
        interval: 50
        repeat: true
        running: false
        onTriggered: {
            event.mouseMove(canvas.parent, cursor.x, cursor.y, 0, Qt.NoButton);
        }
    }


    // Animate mouse to x/y and then click
    function click() {
        cursor.x = px - 60;
        cursor.y = py + 60;
        cursor.visible = true;

        cursorAnimation.onStopped.connect(function() {
            ind.visible = true;
            indAnim.to = Kirigami.Units.iconSizes.smallMedium;
            indAnim.start();
            moveMouse.stop();
        });

        cursorAnimationX.to = px;
        cursorAnimationY.to = py;
        cursorAnimation.start();
        moveMouse.start();
    }

    function hover() {
        if (canvas.animate) {
            cursor.x = px - 60;
            cursor.y = py + 60;
            cursor.visible = true;

            cursorAnimation.onStopped.connect(function() {
                event.mouseMove(canvas.parent, px, py, 0, Qt.NoButton);
                moveMouse.stop();
            });

            cursorAnimationX.to = px;
            cursorAnimationY.to = py;
            cursorAnimation.start();
            moveMouse.start();
        }
        else {
            cursor.x = px;
            cursor.y = py;
            cursor.visible = true;
            event.mouseMove(canvas.parent, px, py, 0, Qt.NoButton);
        }
    }
}
