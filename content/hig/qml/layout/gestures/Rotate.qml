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

import QtQuick 2.13
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.2
import org.kde.kirigami 2.4 as Kirigami
import "../../lib/annotate.js" as A
import "../../addr/" as Addr
import "../../lib/" as HIG

Rectangle {
    width: 320
    height: 600
    id: root
    
    Image {
        anchors.fill: root
        id: myImage
        source: "../../../img/wallpaper/next.png"
        fillMode: Image.PreserveAspectCrop
        smooth: true
        
        Behavior on rotation {
            id: behave
            enabled: false
            NumberAnimation {duration: 300; easing.type: Easing.Linear}
        }
        Behavior on scale {
            enabled: behave.enabled
            NumberAnimation {duration: 300; easing.type: Easing.Linear}
        }
        
        PinchArea {
            id: pinchArea
            anchors.fill: parent
            pinch.target: myImage
            
            pinch.minimumRotation: -360
            pinch.maximumRotation: 360
            pinch.minimumScale: 1
            pinch.maximumScale: 1
            pinch.dragAxis: Pinch.XAndYAxis
            
            onPinchFinished: function(event) {
                behave.enabled = true
                myImage.rotation = 0
                myImage.scale = 1
            }
        }
    }


    // HACK coordinates are only final after a small delay
    HIG.FTimer {
        running: true
        onTick: function(frameCounter) {
            if (frameCounter == 90 ) {
                var a = new A.An(pinchArea);
                a.rotate({ from: Qt.point(0, 0), angle: -90});
            }
        }
    }
}
