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
import QtTest 1.2

// Drawing a brace between to obejcts to show the distance between them
Item {
    id: canvas
    anchors.fill: parent;
    property int fromX
    property int fromY
    property int toX
    property int toY
    property int dur: 300
    property var sequence;
    property int i: 0

    /*MouseArea {
        anchors.fill: parent
        onPressed: {
            console.log(mouse.x + "x" + mouse.y)
        }
    }*/

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

    TestEvent {
        id: event
    }

    Timer {
        id: timer
        interval: 300
        repeat: false
        running: false
        onTriggered: {
            ind.visible = false;
            cursor.visible = false;
            swipeTimer.stop();
        }
    }

    Timer {
        id: swipeTimer
        interval: 30
        repeat: true
        running: false
        onTriggered: {
            i++;
            var stepX = (toX - fromX) / timer.interval * swipeTimer.interval
            var stepY = (toY - fromY) / timer.interval * swipeTimer.interval
            sequence.move(1, canvas.parent, fromX + i * stepX, toY + i * stepY);
            //console.log("move: " + (fromX + i * stepX) + "x" + (toY + i * stepY))
            sequence.commit();
        }
    }

    // Animate swipe
    function swipe() {
        cursor.x = fromX - Kirigami.Units.iconSizes.smallMedium;
        cursor.y = fromY - Kirigami.Units.iconSizes.smallMedium;
        cursor.visible = true;

        ind.y = fromY;
        ind.visible = true;

        xAnim.to = toX;
        xAnim.start();
        yAnim.to = toY;
        yAnim.start();
        indAnim.to = Math.abs(fromX - toX);
        indAnim.start();

        sequence = event.touchEvent(canvas.parent);
        sequence.press(1, canvas.parent, fromX, fromY);
        //console.log("press: " + fromX + "x" + fromY)
        sequence.commit();
        i = 0;

        swipeTimer.start();
        timer.start();

        timer.triggered.connect(function() {    
            sequence.release(1, canvas.parent,  toX, toY);
            //console.log("release: " + toX + "x" + toY)
            sequence.commit();
        });

    }

    function touch() {
        cursor.x = toX;
        cursor.y = toY;
        cursor.visible = true;
        timer.start()
        timer.triggered.connect(function() {
            sequence = event.touchEvent(canvas);
            sequence.press(1, canvas,  toX, toY);
            sequence.commit();
            sequence.release(1, canvas,  toX, toY);
            sequence.commit();
        });
    }
}
