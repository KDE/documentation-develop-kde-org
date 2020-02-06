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

import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import org.kde.kirigami 2.7 as Kirigami
import "../../lib/annotate.js" as A
import "../../addr/" as Addr
import "../../lib/" as HIG

Rectangle {
    width: 320
    height: 600
    id: root
    
    Image {
        z: 2
        anchors.fill: parent
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
            
            pinch.minimumRotation: 0
            pinch.maximumRotation: 0
            pinch.minimumScale: 0.1
            pinch.maximumScale: 3
            pinch.dragAxis: Pinch.XAndYAxis

            onPinchFinished: function(event) {
                behave.enabled = true
                myImage.rotation = 0
                myImage.scale = 1
            }
        }
    }

    HIG.FTimer {
        running: true
        onTick: function(frameCounter) {
            if (frameCounter == 120) {
                var a = new A.An(pinchArea);
                a.pinch({ from: Qt.rect(0, 0, 20, 20), distance: 100});
            }
        }
    }
}
