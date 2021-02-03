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

Item {
    width: 1
    height: 1
    visible: false
    signal tick(int frameCounter)
    
    property int frameCounter: 0
    property bool running : false
    
    NumberAnimation on rotation {
        from:0
        to: 360
        duration: 800
        loops: Animation.Infinite
    }
    // 1 tick per frame, 
    // Since we are recording with exact 60 frames/sec
    // 60 ticks are 1 sec
    onRotationChanged: function() {
        if (running) {
            frameCounter++;
            tick(frameCounter);
        }
    }
    
    function start() {
        frameCounter = 0;
        running = true;
    }
    
    function stop() {
        running = false;
    }
}
