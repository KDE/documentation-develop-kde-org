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
    z: 10000000000
    
    // Define the pinch movement
    property rect from
    property rect to
    property int duration : 300;
    
    // For internal
    property int i: 0
    property real aStepX;
    property real aStepY;
    property real bStepX;
    property real bStepY;
    property var sequence;
    property int frames: 0
    
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
    
    TestEvent {
        id: event
    }
    
    FTimer {
        id: swipeTimer
        onTick: function(frameCounter) {
            // Move both touch pointer
            sequence.move(1, canvas.parent, from.right + frameCounter * aStepX, from.top + frameCounter * aStepY);
            sequence.move(2, canvas.parent, from.left + frameCounter * bStepX, from.bottom + frameCounter * bStepY);
            sequence.commit();
            //console.log("M " + (from.right + frameCounter * aStepX) + " x " + (from.top + frameCounter * aStepY) + " - " + (from.left + frameCounter * bStepX) + " x " + (from.bottom + frameCounter * bStepY));
                
            if (frameCounter >= frames) {
                swipeTimer.stop();
                touchPointA.moved();
            }
        }
    }
    
    function pinch() {
        // Calculate how many frames the animation is running
        frames = Math.floor(60 / 1000 * duration);
        //console.log(frames)
        
        touchPointA.animate = true;
        touchPointB.animate = true;
        
        // Calculate step size
        // aStepX and aStepX should both > 0 
        // and bStepX and bStepY both < 0
        // (or the other way around)
        aStepX = -1 * (from.right - to.right) / frames
        aStepY = -1 * (from.top - to.top) / frames
        bStepX = -1 * (from.left - to.left) / frames
        bStepY = -1 * (from.bottom - to.bottom) / frames

        
        // Wait till both touch points are pressed
        T.join([touchPointA.pressed, touchPointB.pressed], function() {
            sequence = event.touchEvent(canvas.parent);
            sequence.press(1, canvas.parent, from.right, from.top);
            sequence.press(2, canvas.parent, from.left, from.bottom);
            sequence.commit();
            //console.log("P " + from.right + " x " + from.top + " - " + from.left + " x " + from.bottom);
            
            // Move the visual touchpointer to the end
            touchPointA.x = to.right;
            touchPointA.y = to.top;
            touchPointB.x = to.left;
            touchPointB.y = to.bottom;
            
            
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
            sequence.release(1, canvas.parent, to.right, to.top);
            sequence.release(2, canvas.parent, to.left, to.bottom);
            sequence.commit();
            //console.log("R " + to.right + " x " + to.top + " - " + to.left + " x " + to.bottom);
        });
        
        touchPointA.state = "PRESSED"
        touchPointB.state = "PRESSED"
    }
}
