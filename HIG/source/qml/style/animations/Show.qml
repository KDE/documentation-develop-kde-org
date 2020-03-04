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
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.2
import org.kde.kirigami 2.4 as Kirigami
import "../../lib/annotate.js" as A
import "../../addr/" as Addr
import "../../lib/" as HIG

Rectangle {
    id: root
    width: 540
    height: 260
    property int duration: 600

    OutQuad {
        id: diagram
        x: 80;
        y: 30;
        duration: root.duration
    }
    
    Label {
        text: "Y Position"
        anchors.right: diagram.left
        anchors.verticalCenter: diagram.verticalCenter;
        anchors.rightMargin: Kirigami.Units.largeSpacing
    }
    
    Label {
        text: "Time"
        anchors.top: diagram.bottom
        anchors.horizontalCenter: diagram.horizontalCenter;
        anchors.topMargin: Kirigami.Units.largeSpacing
    }

    
    
    Rectangle {
        id: dot
        x: 440;
        y: 230 - width / 2; 
        height: Kirigami.Units.iconSizes.small
        width: height
        color: "#661D99F3"
        radius: height / 2
        border.width: 1
        border.color: "#1D99F3"

            
        NumberAnimation on y {
            running: false
            id: dotAnimation
            to: 30 - dot.height / 2
            duration: root.duration
            easing.type: Easing.OutQuad
        }
    }
    
    Rectangle {
        id: screen
        x: 400
        y: 10
        width: 100
        height: 220
        border.width: 10
        border.color: "#ccc"
        color: "#00000000"
        radius: 5
    }
    
    HIG.FTimer {
        running: true;
        onTick: function(frameCounter) {
            
            if (frameCounter == 60) {
               dotAnimation.running = true;
               diagram.running = true;
            }
        }
    }
}
