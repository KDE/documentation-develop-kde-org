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

import QtQuick 2.7
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.3 as Layouts
import org.kde.kirigami 2.4 as Kirigami

import "../../../lib/annotate.js" as A
import "../../../lib/" as HIG

Kirigami.ApplicationItem {
    width: 640
    height: 320
    
    Kirigami.ScrollablePage {
        id: root
        anchors.fill: parent
        spacing: Kirigami.Units.smallSpacing
        
        property size sizeHint: Qt.size(formLayout.width, Math.round(1.1 * formLayout.height))
        property size minimumSizeHint: Qt.size(formLayout.width, Math.round(1.1 * formLayout.height))
        
        signal changeSignal()
    
        property QtObject device: deviceModel[0]
    
        property bool loading: false
    
        Kirigami.FormLayout {
            id: formLayout
    
            // General
            Controls.CheckBox {
                Kirigami.FormData.label: i18nd("kcmmouse", "General:")
                id: leftHanded
                text: i18nd("kcmmouse", "Left handed mode")

    
//                 ToolTip {
//                     text: i18nd("kcmmouse", "Swap left and right buttons.")
//                 }
            }
    
            Controls.CheckBox {
                id: middleEmulation
                text: i18nd("kcmmouse", "Press left and right buttons for middle-click")
    
//                 ToolTip {
//                     text: i18nd("kcmmouse", "Clicking left and right button simultaneously sends middle button click.")
//                 }
            }
    
            Kirigami.Separator {
                Kirigami.FormData.isSection: true
            }
    
            // Acceleration
            Controls.Slider {
                Kirigami.FormData.label: i18nd("kcmmouse", "Pointer speed:")
                id: accelSpeed
    
                from: 1
                to: 11
                stepSize: 1
            }
    
            Layouts.ColumnLayout {
                id: accelProfile
                spacing: Kirigami.Units.smallSpacing
                Kirigami.FormData.label: i18nd("kcmmouse", "Acceleration profile:")
                Kirigami.FormData.buddyFor: accelProfileFlat
    
                Controls.RadioButton {
                    id: accelProfileFlat
                    text: i18nd("kcmmouse", "Flat")
    
//                     ToolTip {
//                         text: i18nd("kcmmouse", "Cursor moves the same distance as the mouse movement.")
//                     }
                    onCheckedChanged: accelProfile.syncCurrent()
                }
    
                Controls.RadioButton {
                    id: accelProfileAdaptive
                    text: i18nd("kcmmouse", "Adaptive")
    
//                     ToolTip {
//                         text: i18nd("kcmmouse", "Cursor travel distance depends on the mouse movement speed.")
//                     }
                    onCheckedChanged: accelProfile.syncCurrent()
                }
            }
    
            Item {
                Kirigami.FormData.isSection: false
            }
        }
    }
        
    HIG.Raster {
    }
    
    // HACK
    Timer {
        interval: 500
        repeat: false
        running: true
        onTriggered: {
            console.log(Kirigami.Units.smallSpacing);
            var a = new A.An(formLayout);
            //a.tree();
            a.find("qquickcheckbox").eq(1).draw({
                brace: {to: a.find("qquickslider"), horizontal: false}
            })
            
//             a.find("qquickradiobutton").eq(1).draw({
//                 brace: {to: a.find("qquickcheckbox").eq(2), horizontal: false}
//             })
            
            qmlControler.start();
        }
    }
}
