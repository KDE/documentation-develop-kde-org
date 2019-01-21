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

// Show the padding of an element
Item {
    anchors.fill: parent;
    property string color: "rgba(147,206,233, 0.8)"
    property bool label: false
    property Item item
    property Item root : container.parent
    property var padding: []
    z: 10
    id: container

    Text {
        id: top
        color: "#da4453"
        font.pointSize: 8
        lineHeight: 8
        height: 8
        z: 2
    }
    Text {
        id: right
        color: "#da4453"
        font.pointSize: 8
        lineHeight: 8
        height: 8
        z: 2
    }
    Text {
        id: bottom
        color: "#da4453"
        font.pointSize: 8
        lineHeight: 8
        height: 8
        z: 2
    }
    Text {
        id: left
        color: "#da4453"
        font.pointSize: 8
        lineHeight: 8
        height: 8
        z: 2
    }

    Canvas {
        anchors.fill: parent;
        id: canvas

        onPaint: {
            // Determen padding
            var padding;
            if (typeof container.padding === "number") {
                padding = {
                    "top": container.padding,
                    "right": container.padding,
                    "bottom": container.padding,
                    "left": container.padding
                }
            }
            else if (Array.isArray(container.padding) && container.padding.length == 4) {
                padding = {
                    "top": container.padding[0],
                    "right": container.padding[1],
                    "bottom": container.padding[2],
                    "left": container.padding[3]
                }
            }
            else {
                padding = {
                    "top": item.topPadding,
                    "right": item.rightPadding,
                    "bottom": item.bottomPadding,
                    "left": item.leftPadding
                }
            }
            // setup drawing context
            var offset;
            var cItem = item.mapToItem(container.root, 0, 0);
            var ctx = getContext("2d");
            ctx.strokeStyle = container.color;
            ctx.beginPath();

            // Draw top
            ctx.lineWidth = padding.top;
            offset = ctx.lineWidth / 2;
            ctx.moveTo(cItem.x + offset,  cItem.y + offset);
            ctx.lineTo(cItem.x + item.width -  offset, cItem.y + offset);

            // Draw right
            ctx.lineWidth = padding.right;
            offset = ctx.lineWidth / 2;
            ctx.lineTo(cItem.x + item.width - offset, cItem.y + item.height - offset);

            // Draw bottom
            ctx.lineWidth = padding.bottom;
            offset = ctx.lineWidth / 2;
            ctx.lineTo(cItem.x + offset, cItem.y + item.height - offset);

            // Draw left
            ctx.lineWidth = padding.bottom;
            offset = ctx.lineWidth / 2;
            ctx.lineTo(cItem.x + offset, cItem.y + offset);

            ctx.stroke();

            // Write labels
            top.text = padding.top;
            top.x = cItem.x + item.width / 2;
            top.y = cItem.y - 4 - padding.top / 2;

            right.text = padding.right;
            right.x = cItem.x + item.width - right.width + padding.right / 2;
            right.y = cItem.y + item.height / 2 - right.height;

            bottom.text = padding.bottom;
            bottom.x = cItem.x + item.width / 2;
            bottom.y = cItem.y + item.height - bottom.height - 4 + padding.bottom / 2;

            left.text = padding.left;
            left.x = cItem.x - padding.left / 2;
            left.y = cItem.x + item.height / 2 - left.height;

        }
    }
}
