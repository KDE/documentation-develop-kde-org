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
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.4 as Kirigami
import "../../lib" as HIG
import QtTest 1.2

import "../../lib/annotate.js" as A

Rectangle {
    id: root
    width: 420
    height: 220
        
    Kirigami.InlineMessage {
        id: msg
        x: Kirigami.Units.gridUnit * 2
        y: Kirigami.Units.gridUnit * 2
        width: parent.width - 2 * Kirigami.Units.gridUnit * 2
        
        visible: true
        text: "Found new audio CD"
        actions: [
            Kirigami.Action {
                text: "Play"
                icon.name: "media-playback-start"
            },
            Kirigami.Action {
                text: "Append to playlist"
                icon.name: "media-playlist-append"
            }
        ]
        
        states: State {
            name: "small"
            PropertyChanges { target: msg; width: 200 }
        }

        transitions: Transition {
            PropertyAnimation { properties: "width"; easing.type: Easing.InOutQuad; duration: 2000 }
        }
    }

    HIG.Raster {
        z: 1
    }
    
    HIG.FAnimation {
        actions: {
            120: function() {
                msg.state = "small"
            },
            // open popup
            240: function() {
                var a = new A.An(msg);
                a.find("privateactiontoolbutton").eq(2).click();
            },
            // Close popup
            420: function() {
                event.mouseClick(root.parent, 1, 1, Qt.LeftButton, Qt.NoModifier, 0)
            },
            480: function() {
                msg.state = "";
            }
        }
    }
    
    TestEvent {
        id: event
    }
}
