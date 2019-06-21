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


            // Draw top
            ctx.beginPath();
            ctx.lineWidth = padding.top;
            offset = ctx.lineWidth / 2;
            ctx.moveTo(cItem.x + offset,  cItem.y + offset);
            ctx.lineTo(cItem.x + item.width, cItem.y + offset);
            ctx.stroke();

            // Draw right
            ctx.beginPath();
            ctx.lineWidth = padding.right;
            offset = ctx.lineWidth / 2;
            ctx.moveTo(cItem.x + item.width - offset,  cItem.y);
            ctx.lineTo(cItem.x + item.width - offset, cItem.y + item.height);
            ctx.stroke();

            // Draw bottom
            ctx.beginPath();
            ctx.lineWidth = padding.bottom;
            offset = ctx.lineWidth / 2;
            ctx.moveTo(cItem.x + item.width,  cItem.y + item.height - offset);
            ctx.lineTo(cItem.x, cItem.y + item.height - offset);
            ctx.stroke();

            // Draw left
            ctx.beginPath();
            ctx.lineWidth = padding.left;
            offset = ctx.lineWidth / 2;
            ctx.moveTo(cItem.x + offset, cItem.y + item.height);
            ctx.lineTo(cItem.x + offset, cItem.y);
            ctx.stroke();

            ctx.stroke();

            // Write labels
            top.text = padding.top;
            top.x = cItem.x + item.width / 2;
            top.y = Math.max(cItem.y - top.height + padding.top / 2, 0);

            right.text = padding.right;
            right.x = Math.min(cItem.x + item.width - right.width / 2 - padding.right / 2, root.width - right.width);
            right.y = cItem.y + item.height / 2 - right.height;

            bottom.text = padding.bottom;
            bottom.x = cItem.x + item.width / 2;
            bottom.y = Math.min(cItem.y + item.height - bottom.height - padding.bottom / 2, root.height);

            left.text = padding.left;
            left.x = Math.max(cItem.x - padding.left / 2 - left.width / 2, 0);
            left.y = cItem.y + item.height / 2 - left.height;
        }
    }
}
