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
import "tools.js" as T

// Draw a ruler for highlighting alignment
Item {
    id: canvas
    anchors.fill: parent;
    property int rx;
    property int ry;
    property bool horizontal: true;
    property string stroke: "rgba(41,128,185, 1)"
    property double scale: T.getScale(canvas)

    // using Rectangles because they scale smooth
    Row {
        y: canvas.ry
        x: 0
        id: hackRow
        visible: canvas.horizontal
        spacing: Kirigami.Units.smallSpacing / scale
        Repeater {
           model: new Array(Math.floor(canvas.width / hackRow.spacing / 2))
           Rectangle {
               width: Kirigami.Units.smallSpacing / scale
               height: 2 / scale
               color: "#2980b9"
           }
        }
    }
    Column {
        x: canvas.rx
        y: 0
        id: hackColumn
        visible: !canvas.horizontal
        spacing: Kirigami.Units.smallSpacing / scale
        Repeater {
           model: new Array(Math.floor(canvas.height / hackColumn.spacing / 2))
           Rectangle {
               height: Kirigami.Units.smallSpacing / scale
               width: 1 / scale
               color: "#2980b9"
           }
        }
    }
}
