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

import "tools.js" as T

// Show a touch event
Item {
    id: canvas
    anchors.fill: parent;
    // Define the pinch movement
    property rect from;
    property int angle;
    property int duration : 300;
    
    // For internal
    property int i: 0;
    property real step;
    property real offsetX : Math.floor(canvas.width / 2);
    property real offsetY : Math.floor(canvas.height / 2);
    property var sequence;
    property int frames: 0;
    
    Item {
        
        anchors.fill: parent
            
        VisualTouchPoint {
            id: touchPointA;
            x: from.right
            y: from.top
            dur: duration
        }
        
        VisualTouchPoint {
            id: touchPointB
            x: from.left
            y: from.bottom
            dur: duration
        }
        
        transform: Rotation {
            id: rotateHelper
            
            origin.x: canvas.width / 2
            origin.y: canvas.height / 2
            
            Behavior on angle {
                NumberAnimation {duration: canvas.duration; easing.type: Easing.Linear}
            }
        }
        
    }
    
    TestEvent {
        id: event
    }
    
    FTimer {
        id: swipeTimer
        onTick: function(frameCounter) {
            // Move both touch pointer
            var p = rotatePoint(Qt.point(from.right, from.top), frameCounter * step);
            sequence.move(1, canvas.parent, p.x, p.y);
            p = rotatePoint(Qt.point(from.left, from.bottom), frameCounter * step);
            sequence.move(2, canvas.parent, p.x, p.y);
            sequence.commit();
            
            if (frameCounter >= frames) {
                running = false;
                touchPointA.moved();
            }
        }
    }
    
    // Rotate a point around the center of the canvas
    function rotatePoint(point, angle) {
        // to radian
        angle = 2 * Math.PI / 360 * angle
        // Translate point to 0/0 for rotation
        var tPoint = Qt.point(
            point.x - offsetX, 
            point.y - offsetY
        );
        tPoint = Qt.point(
            tPoint.x * Math.cos(angle) - tPoint.y * Math.sin(angle), 
            tPoint.x * Math.sin(angle) + tPoint.y * Math.cos(angle)
        );
        return Qt.point(tPoint.x + offsetX, tPoint.y + offsetY);
    }
    
    function rotate() {
        touchPointA.animate = true;
        touchPointB.animate = true;
        
        // Calculate how many frames the animation is running
        frames = Math.floor(60 / 1000 * duration);
        
        step = canvas.angle / frames;
        
        // Wait till both touch points are pressed
        T.join([touchPointA.pressed, touchPointB.pressed], function() {
            sequence = event.touchEvent(canvas.parent);
            sequence.press(1, canvas.parent, from.right, from.top);
            sequence.press(2, canvas.parent, from.left, from.bottom);
            sequence.commit();
            
            // Rotate
            rotateHelper.angle = canvas.angle
            
            // Start the gesture
            i = 0;
            swipeTimer.start();
        });
        
        // Release after swipes are done
        touchPointA.moved.connect(function() {
            touchPointA.state = "RELEASED";
            touchPointB.state = "RELEASED";
        });
        
        touchPointA.released.connect(function() {
            var p = rotatePoint(Qt.point(from.right, from.top), canvas.angle);
            sequence.release(1, canvas.parent, p.x, p.y);
            p = rotatePoint(Qt.point(from.left, from.bottom), canvas.angle);
            sequence.release(2, canvas.parent, p.x, p.y);
            sequence.commit();
        });
        
        touchPointA.state = "PRESSED"
        touchPointB.state = "PRESSED"
    }
}
