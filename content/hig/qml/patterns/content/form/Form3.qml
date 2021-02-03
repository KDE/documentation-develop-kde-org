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

import org.kde.kcm 1.1 as KCM
import org.kde.kirigami 2.4 as Kirigami

import "../../../lib/annotate.js" as A
import "../../../lib/" as HIG

Kirigami.ApplicationItem {
    width: 640
    height: 320
    
    Kirigami.ScrollablePage {
        id: root
        anchors.fill: parent
        Kirigami.Theme.colorSet: Kirigami.Theme.View
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
            }
    
            Controls.CheckBox {
                id: middleEmulation
                text: i18nd("kcmmouse", "Press left and right buttons for middle-click")
            }
    
            Item {
                Kirigami.FormData.isSection: false
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
                    onCheckedChanged: accelProfile.syncCurrent()
                }
    
                Controls.RadioButton {
                    id: accelProfileAdaptive
                    text: i18nd("kcmmouse", "Adaptive")
                    onCheckedChanged: accelProfile.syncCurrent()
                }
            }
    
            Item {
                Kirigami.FormData.isSection: false
            }
    
            // Scrolling
            Controls.CheckBox {
                Kirigami.FormData.label: i18nd("kcmmouse", "Scrolling:")
                id: naturalScroll
                text: i18nd("kcmmouse", "Invert scroll direction")
            }
        }
    }
        
    HIG.Raster {
    }
    
    // HACK
    HIG.FTimer {
        running: true
        onTick: function(frameCounter) {
            if (frameCounter == 30) {
                var a = new A.An(formLayout);
                a.find("checkbox").eq(1).draw({
                    brace: {to: a.find("slider"), horizontal: false}
                })
            }
        }
    }
}
