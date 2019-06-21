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
import QtQuick.Controls 2.2
import org.kde.kirigami 2.4 as Kirigami
import QtGraphicalEffects 1.0
import QtQuick.Templates 2.0 as T

// A breeze surface with shadows, rounded borders, blur
ItemDelegate {
    id: root
    default property alias contents: content.data
    property string color : "#fcfcfc"
    property int radius: 3
    property int elevation: 1
    property Item sourceItem;


    background: Item {
        anchors.fill: parent
        id: background

        FastBlur{
            id: blur
            anchors.fill: surface
            // TODO visible: surface.isColorHasAlphaValue
            source: ShaderEffectSource {
                id: effectSource
                sourceItem: root.sourceItem
                sourceRect: Qt.rect(root.x * 2, root.y * 2, root.width, root.height)
            }
            radius: 32
        }

        Rectangle {
            anchors.fill: parent
            radius: root.radius
            color: root.color
            id: surface
        }
    }

    DropShadow {
        anchors.fill: background
        horizontalOffset: elevation < 2 ? 1 : 3
        verticalOffset: elevation < 2 ? 1 : 3
        radius: root.elevation  * 4
        samples: root.elevation * 10
        color: "#92232627"
        source: background
    }

    Item {
        anchors.fill: parent
        id: content
    }
}
