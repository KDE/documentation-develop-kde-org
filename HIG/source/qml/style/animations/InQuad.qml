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
    
    width: 300
    height: 200
    property alias running : anim.running
    property int duration: 2000
    

    Canvas {
        anchors.fill: parent;
        antialiasing: true
        onPaint: {
            var ctx = getContext("2d");
            ctx.stroke();
            ctx.lineWidth = 1;
            ctx.moveTo(0, 0);
            ctx.lineTo(0, 200);
            ctx.lineTo(300, 200);
            ctx.stroke();
            
            ctx.beginPath();
            ctx.strokeStyle = "#F00";
            ctx.moveTo(0, 200);
            //ctx.bezierCurveTo(150, 192, 150, 8, 300, 0);
            ctx.quadraticCurveTo(150, 200, 300, 0);
            ctx.stroke();
        }
    }
    
    Rectangle {
        id: point
        x: 0 - height / 2; 
        y: 200 - width / 2; 
        height: Kirigami.Units.iconSizes.small
        width: height
        color: "#661D99F3"
        radius: height / 2
        border.width: 1
        border.color: "#1D99F3"
    }
    
    
    ParallelAnimation {
        running: false
        id: anim
        
        NumberAnimation {
            to: 300 - point.width / 2
            target: point
            property: "x"
            duration: root.duration
            easing.type: Easing.Linear
        }
        
        NumberAnimation {
            to: 0 - point.height / 2
            target: point
            property: "y"
            duration: root.duration
            easing.type: Easing.InQuad
        }
    }
}
