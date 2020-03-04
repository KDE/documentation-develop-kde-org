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
    width: 480
    height: 260

    InOutQuad {
        id: diagram
        x: 80;
        y: 10;
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
        y: 210 - width / 2; 
        height: Kirigami.Units.iconSizes.small
        width: height
        color: "#661D99F3"
        radius: height / 2
        border.width: 1
        border.color: "#1D99F3"

            
        NumberAnimation on y {
            running: false
            id: dotAnimation
            to: 10 - dot.height / 2
            duration: 2000
            easing.type: Easing.InOutQuad
        }
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
