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

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.7 as Kirigami
import "../../lib/annotate.js" as A

Rectangle {
    width: 1200
    height: 300
    id: root
    color: "#eff0f1"

    property var myModel : [1, 2, 3, 4, 5, 6];

    Row {
        anchors.fill: parent
        spacing:  Kirigami.Settings.tabletMode ? 2 * Kirigami.Units.largeSpacing : 2 * Kirigami.Units.smallSpacing

        Rectangle {
            border.width: 1
            border.color: "#bdc3c7"
            width: 300
            height: root.height

            ListView {
                model: root.myModel
                anchors.fill: parent
                delegate: Folder {
                    iconSize: 0
                }    
            }
        }
        Rectangle {
            border.width: 1
            border.color: "#bdc3c7"
            width: 300
            height: root.height

            ListView {
                model: root.myModel
                anchors.fill: parent
                delegate: Folder {
                    iconSize: Kirigami.Units.iconSizes.small
                }    
            }
        }
        Rectangle {
            border.width: 1
            border.color: "#bdc3c7"
            width: 300
            height: root.height

            ListView {
                model: root.myModel
                anchors.fill: parent
                delegate: Folder {
                    iconSize: Kirigami.Units.iconSizes.medium
                }    
            }
        }
        Rectangle {
            border.width: 1
            border.color: "#bdc3c7"
            width: 300
            height: root.height

            ListView {
                model: root.myModel
                anchors.fill: parent
                delegate: Folder {
                    iconSize: Kirigami.Units.iconSizes.large
                }    
            }
        }
    }
    
    Timer {
        interval: 2000
        repeat: false
        running: true
        onTriggered: {
            qmlControler.start();
        }
    }
}
