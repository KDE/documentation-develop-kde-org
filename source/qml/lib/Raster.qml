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

// Drawing a semi transparent raster and a legend
Item {
    anchors.fill: parent;
    property int base: Kirigami.Units.gridUnit
    property string color: "rgba(200, 200, 200, 0.7)"
    property string label: "Units.gridUnit / 18px"
    property bool touch: false; // Indicate touch support
    property bool mobile: false; // Indicate mobile/small display support
    property bool mouse: false; // Indicate mouse support
    property bool desktop: false; // Indicate large display support

    // Painting the grid on a canvas
    Canvas {
        anchors.fill: parent;
        id: canvas
        onPaint: {
            var ctx = getContext("2d");
            ctx.strokeStyle = color;
            ctx.beginPath();

            // Horizontal grid lines
            var i = 0;
            while (i < canvas.height / base) {
                ctx.moveTo(0, i * base);
                ctx.lineTo(canvas.width, i * base);
                i++;
            }

            // Vertical grid lines
            i = 0;
            while (i < canvas.width / base) {
                ctx.moveTo(i * base, 0);
                ctx.lineTo(i * base, canvas.height);
                i++;
            }
            ctx.stroke();

            // draw scale on the bottom right
            // |---|
            if (label != "") {
                ctx.strokeStyle = "#da4453";
                ctx.beginPath();
                var left = canvas.width - 2 * base - canvas.width % base;
                var top;
                if (canvas.height % base  > 2 * Kirigami.Units.smallSpacing) {
                    top = canvas.height - canvas.height % base;
                }
                else {
                    top = canvas.height - base - canvas.height % base;
                }

                ctx.moveTo(left, top - Kirigami.Units.smallSpacing);
                ctx.lineTo(left, top + Kirigami.Units.smallSpacing);

                ctx.moveTo(left, top);
                ctx.lineTo(left + base, top);

                ctx.moveTo(left + base, top - Kirigami.Units.smallSpacing);
                ctx.lineTo(left + base, top + Kirigami.Units.smallSpacing);
                ctx.stroke();
            }
         }
    }

    Label {
        id: lbl
        text: label
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: canvas.height % base  > 2 * Kirigami.Units.smallSpacing ? canvas.height % base + Kirigami.Units.smallSpacing : base + canvas.height % base + Kirigami.Units.smallSpacing
        anchors.rightMargin: base
        color: "#da4453"
        font.pixelSize: 10
        renderType: Text.QtRendering
    }

    Row {
        anchors.bottom: lbl.top
        anchors.right: lbl.right
        anchors.margins: Kirigami.Units.smallSpacing
        spacing: Kirigami.Units.smallSpacing
        Image {
            visible: mouse
            height: Kirigami.Units.iconSizes.medium;
            width: Kirigami.Units.iconSizes.medium;
            source: "../../img/edit-select.svg"
            //smooth: true
        }
        Image {
            visible: touch
            height: Kirigami.Units.iconSizes.medium;
            width: Kirigami.Units.iconSizes.medium;
            source: "../../img/transform-browse.svg"
            //smooth: true
        }
        Image {
            visible: desktop
            height: Kirigami.Units.iconSizes.medium;
            width: Kirigami.Units.iconSizes.medium;
            source: "../../img/video-display.svg"
            //smooth: true
        }
        Image {
            visible: mobile
            height: Kirigami.Units.iconSizes.medium;
            width: Kirigami.Units.iconSizes.medium;
            source: "../../img/smartphone.svg"
            //smooth: true
        }
    }
}
