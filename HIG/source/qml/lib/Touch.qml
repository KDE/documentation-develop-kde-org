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

// Show a touch event
Item {
    id: canvas
    anchors.fill: parent;
    property int fromX
    property int fromY
    property int toX
    property int toY
    property int dur: 300
    property var sequence;
    property int touchId: 0
    property int frames: 0
    z: 10000000000

    VisualTouchPoint {
        x: fromX;
        y: fromY;
        id: touchPoint
    }

    TestEvent {
        id: event
    }

    // needs to be synced with the animations of the touchPoint
    FTimer {
        id: swipeTimer
        onTick: function(frameCounter) {
            // Move the touch pointer
            var stepX = (toX - fromX) / frames;
            var stepY = (toY - fromY) / frames;
            sequence.move(touchId, canvas.parent, fromX + frameCounter * stepX, toY + frameCounter * stepY);
            sequence.commit();
            //console.log("M " + (fromX + frameCounter * stepX) + " x " + ( toY + frameCounter * stepY));
            
            if (frameCounter >= frames) {
                swipeTimer.stop();
                touchPoint.moved();
            }
        }
    }

    // Animate swipe
    function swipe() {
        // Calculate how many frames the animation is running
        frames = Math.floor(60 / 1000 * dur);
        
        touchPoint.animate = true;
        // Start swipe after animation is done
        touchPoint.pressed.connect(function() {
            touchPoint.x = toX;
            touchPoint.y = toY;
            if (!sequence) {
                // Only create a new sequence if not 1 exists already
                sequence = event.touchEvent(canvas.parent);
            }
            sequence.press(touchId, canvas.parent, fromX, fromY);
            sequence.commit();
            //console.log("P " + fromX + " x " + fromY);
            
            swipeTimer.start();
        });
        
        // Finish touch event
        // Release touch pointer
        touchPoint.moved.connect(function() {
            sequence.release(touchId, canvas.parent,  toX, toY);
            sequence.commit();
            //console.log("R " + toX + " x " + toY);
            touchPoint.state = "RELEASED";
        });
        touchPoint.state = "PRESSED"
    }

    function touch() {
        touchPoint.x = toX;
        touchPoint.y = toY;
        
        // Emit touch event after animation is done
        touchPoint.pressed.connect(function() {
            if (!sequence) {
                sequence = event.touchEvent(canvas);
            }
            sequence.press(touchId, canvas,  toX, toY);
            sequence.commit();
            touchPoint.state = "RELEASED"
        });
        
        touchPoint.released.connect(function() {
            sequence.release(touchId, canvas,  toX, toY);
            sequence.commit();
        });
        touchPoint.state = "PRESSED"
    }
}
