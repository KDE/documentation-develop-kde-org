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

// Drawing a brace between to obejcts to show the distance between them
Item {
    id: canvas
    anchors.fill: parent;
    property Item from
    property Item to
    property bool flip: false
    property bool center: true
    property string text
    property string color: "rgba(236, 161, 169, 0.8)"
    property bool horizontal: true;

    Rectangle {
        id: prot
        color: "#cc93cee9"
        width: childrenRect.width + 10
        height: childrenRect.height + 10
        z: 2

        Label {
            x: Kirigami.Units.smallSpacing
            y: Kirigami.Units.smallSpacing
            id: label
            color: "#000"
            text: canvas.text
            font.pointSize: 8
            lineHeight: 8
            height: 8
            renderType: Text.QtRendering
        }
    }


    Canvas {
        anchors.fill: parent;
        onPaint: {
            // it might be necessary to calculate scale
            // because annotation should not be scaled
            // var scale = T.getScale(canvas.parent)

            var ctx = getContext("2d");
            ctx.strokeStyle = canvas.color;
            ctx.beginPath();

            var cfrom = from.mapToItem(canvas.parent, 0, 0);
            var cto = to.mapToItem(canvas.parent, 0, 0);

            // Determine direction
            // draw either horizontal or vertical
            if (horizontal) {
                // If no label was provided calulate it
                if (canvas.text == "") {
                    if (cfrom.x > cto.x) {
                        canvas.text = cfrom.x - cto.x - to.width;
                    }
                    else {
                        canvas.text = cto.x - cfrom.x - from.width;
                    }
                }

                // Calculate anchor points for braces
                if (!canvas.center) {
                    // Draw from closest borders
                    if (cfrom.x > cto.x) {
                        cfrom.x = cfrom.x + Math.min(Math.floor(from.width / 2), 2 * Kirigami.Units.smallSpacing)
                        cto.x = cto.x + to.width - Math.min(Math.floor(to.width / 2), 2 * Kirigami.Units.smallSpacing)
                    }
                    else {
                        cfrom.x = cfrom.x + from.width - Math.min(Math.floor(from.width / 2), 2 * Kirigami.Units.smallSpacing)
                        cto.x = cto.x + Math.min(Math.floor(to.width / 2), 2 * Kirigami.Units.smallSpacing)
                    }
                }
                else {
                    // Draw from the center
                    cfrom.x = cfrom.x + from.width / 2;
                    cto.x = cto.x + to.width / 2;
                }

                // Draw the brace
                ctx.moveTo(cfrom.x, cfrom.y);
                ctx.lineTo(cfrom.x, cfrom.y - Kirigami.Units.smallSpacing);
                ctx.lineTo(cto.x, cfrom.y - Kirigami.Units.smallSpacing);
                ctx.lineTo(cto.x, cfrom.y);

                // Position label
                prot.x = (cfrom.x + cto.x) / 2 - prot.width / 2
                prot.y = cfrom.y - prot.height - 2 * Kirigami.Units.smallSpacing
            }
            else {
                // If no label was provided calulate it
                if (canvas.text == "") {
                    if (cfrom.y > cto.y) {
                        canvas.text = cfrom.y - cto.y - to.height;
                    }
                    else {
                        canvas.text = cto.y - cfrom.y - from.height;
                    }
                }

                if (!canvas.center) {
                    // Draw from closest borders
                    if (cfrom.y > cto.y) {
                        cfrom.y = cfrom.y + Math.min(Math.floor(from.height / 2), 2 * Kirigami.Units.smallSpacing)
                        cto.y = cto.y + to.height - Math.min(Math.floor(to.height / 2), 2 * Kirigami.Units.smallSpacing)

                    }
                    else {
                        cfrom.y = cfrom.y + from.height - Math.min(Math.floor(from.height / 2), 2 * Kirigami.Units.smallSpacing)
                        cto.y = cto.y + Math.min(Math.floor(to.height / 2), 2 * Kirigami.Units.smallSpacing)
                    }
                }
                else {
                    // Draw from the center
                    cfrom.y = cfrom.y + from.height / 2;
                    cto.y = cto.y + to.height / 2;
                }

                // Draw the brace
                ctx.moveTo(cfrom.x, cfrom.y);
                ctx.lineTo(cfrom.x - Kirigami.Units.smallSpacing, cfrom.y);
                ctx.lineTo(cfrom.x - Kirigami.Units.smallSpacing, cto.y);
                ctx.lineTo(cfrom.x, cto.y);

                // Position label
                prot.x = cfrom.x - prot.width - 2 * Kirigami.Units.smallSpacing
                prot.y = (cfrom.y + cto.y ) / 2 - prot.height / 2 - 4
            }

            ctx.stroke();
         }
    }
}
