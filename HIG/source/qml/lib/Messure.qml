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

//window containing the application
Canvas {
    anchors.fill: parent;
    id: canvas
    property string color: "rgba(218, 68, 83, 0.8)"
    property Item from
    property Item to
    property string type: "left"
    property int rx;
    property int ry;
    z: 3
    property string text

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

        }
    }

    onPaint: {
        var ctx = getContext("2d");
        ctx.strokeStyle = canvas.color;
        ctx.lineWidth = 1
        ctx.beginPath();

        var cFrom = from.mapToItem(canvas.parent, 0, 0);
        var cTo = to.mapToItem(canvas.parent, 0, 0);

        // Horizontal messure
        if (type == "left" || type == "right") {
            var y;
            if (canvas.ry) {
                y = ry;
            }
            else {
                if (from.height < to.height) {
                    y = cFrom.y + from.height / 2;
                }
                else {
                    y = cTo.y + to.height / 2;
                }
            }
            if (type == "right") {
                cFrom.x += from.width
                cTo.x += to.width
            }
            ctx.moveTo(cFrom.x + 4, y);
            ctx.lineTo(cTo.x - 4, y);

            // Write distance
            // TODO center it for real
            if (canvas.text == "") {
                label.text = Math.abs(cTo.x - cFrom.x);
            }
            prot.x = cFrom.x + (cTo.x - cFrom.x) / 2  - 8
            prot.y = y - 16
        }
        else {
            var x;
            if (canvas.rx) {
                x = rx;
            }
            else {
                if (from.width < to.width) {
                    x = cFrom.x + from.width / 2;
                }
                else {
                    x = cTo.x + to.width / 2;
                }

            }
            if (type == "bottom") {
                cFrom.y += from.height
                cTo.y += to.height
            }
            ctx.moveTo(x, cFrom.y + 4);
            ctx.lineTo(x, cTo.y - 4);

            // Write distance
            if (canvas.text == "") {
                label.text = Math.abs(cTo.y - cFrom.y);
            }
            prot.y = cFrom.y + (cTo.y - cFrom.y) / 2 - 8
            prot.x = x + 8
        }

        ctx.stroke();
    }
}
