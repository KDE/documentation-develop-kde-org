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

// Visual touch point with pressed and release state
Rectangle {
    id: touchPoint
    
    property int dur: 300
    property alias animate : behave.enabled;

    signal released()
    signal pressed()
    signal moved()
    
    state: "RELEASED"
    
    height: Kirigami.Units.iconSizes.small
    width: height
    color: "#668e44ad"
    radius: height / 2
    border.width: 1
    border.color: "#8e44ad"
    
    Behavior on x {
        id: behave
        enabled: false
        NumberAnimation {duration: dur; easing.type: Easing.Linear;}
    }
    Behavior on y {
        enabled: behave.enabled
        NumberAnimation {duration: dur; easing.type: Easing.Linear}
    }
    
    states: [
        State {
            name: "PRESSED"
            PropertyChanges { target: touchPoint; color: "#FF8e44ad"; visible: true }
        }
    ]
    
    transitions: [
        Transition {
            from: "PRESSED"
            to: "RELEASED"
            SequentialAnimation {
                ColorAnimation {target: touchPoint; duration: 300}
                PropertyAction {target: touchPoint; property: "visible"; value: false}
                ScriptAction { 
                    script: touchPoint.released()
                }
            }
        },
        Transition {
            from: "RELEASED"
            to: "PRESSED"
            SequentialAnimation {
                PropertyAction {target: touchPoint; property: "visible";  value: true}
                ColorAnimation {target: touchPoint; duration: 300}
                ScriptAction { 
                    script: touchPoint.pressed()
                }
            }
        }
    ]
}
