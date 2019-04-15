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
import org.kde.kirigami 2.4 as Kirigami
import "tools.js" as T

// Draw a frame around an element
Item {
    anchors.fill: parent;
    property string color: "rgba(236, 161, 169, 0.6)"
    property bool label: true
    property bool aspectratio: false
    property Item item
    property Item root : container.parent
    z: 10
    id: container

    Rectangle {
        id: prot
        color: "#cc93cee9"
        width: childrenRect.width + 10
        height: childrenRect.height + 10
        visible: false
        z: 2

        Label {
            x: Kirigami.Units.smallSpacing
            y: Kirigami.Units.smallSpacing
            id: dim
            color: "#000"
            font.pointSize: 8
            lineHeight: 8
            height: 8
        }
    }

    Canvas {
        anchors.fill: parent;
        id: canvas

        onPaint: {
            // get scale because annotation should not be scaled
            var scale = T.getScale(container.parent)

            var ctx = getContext("2d");
            ctx.strokeStyle = container.color;
            ctx.lineWidth = 4 / scale
            ctx.beginPath();

            // Draw an rectangle around the element
            var offset = ctx.lineWidth / 2;
            var cItem = item.mapToItem(container.root, 0, 0);
            ctx.moveTo(cItem.x + offset,  cItem.y + offset);
            ctx.lineTo(cItem.x + offset, cItem.y + item.height - offset);
            ctx.lineTo(cItem.x + item.width - offset, cItem.y + item.height - offset);
            ctx.lineTo(cItem.x + item.width - offset, cItem.y + offset);
            ctx.lineTo(cItem.x + offset, cItem.y + offset);

            if (container.aspectratio) {
                // Write proportions of an object instead of dimensions / px
                ctx.moveTo(cItem.x + offset,  cItem.y + offset);
                ctx.lineTo(cItem.x + item.width - offset, cItem.y + item.height - offset);
                ctx.moveTo(cItem.x + item.width - offset, cItem.y + offset);
                ctx.lineTo(cItem.x + offset, cItem.y + item.height - offset);

                var aspect =  Math.round(item.width / item.height * 100) / 100
                // Well known aspect ratios
                switch (aspect) {
                case 1:
                    aspect = "1 x 1"
                    break;
                case 1.33:
                    aspect = "4 x 3"
                    break;
                case 1.5:
                    aspect = "3 x 2"
                    break;
                case 1.78:
                    aspect = "16 x 9"
                    break;
                }
                dim.text = aspect
                prot.visible = true;
                prot.x = Math.round(cItem.x + item.width / 2 - prot.width / 2)
                prot.y = Math.round(cItem.y + item.height / 2 - prot.height / 2)

            }
            else {
                // Write dimensions / px
                if (container.label) {
                    dim.text = Math.round(item.width * 100) / 100 + " x " + Math.round(item.height * 100) / 100;
                    prot.visible = true;
                    prot.x = Math.round(cItem.x + item.width / 2 - prot.width / 2)
                    prot.y = Math.round(cItem.y + item.height / 2 - prot.height / 2)
                }
            }

            ctx.stroke();
        }
    }
}
