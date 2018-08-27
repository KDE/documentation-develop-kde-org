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
import "annotate.js" as A

Rectangle {
    width: 320
    height: 280
    color: "white"

    Item {
        anchors.fill: parent
        id: root

        Row {
            spacing: Kirigami.Units.largeSpacing * 2
            x: Kirigami.Units.gridUnit * 2
            y: Kirigami.Units.gridUnit * 2

            Rectangle {
                id: left1
                width: Kirigami.Units.largeSpacing * 8
                height: Kirigami.Units.largeSpacing * 8
                color: "#27ae60"
            }

            Rectangle {
                id: right1
                width: Kirigami.Units.largeSpacing * 8
                height: Kirigami.Units.largeSpacing * 8
                color: "#27ae60"
                anchors.top: parent.top;
            }
            ComboBox {
                model: [ "Item1", "Item2", "Item3" ]
            }
        }

        Row {
            spacing: Kirigami.Units.smallSpacing * 8
            x: Kirigami.Units.gridUnit * 2
            y: Kirigami.Units.gridUnit * 8

            Rectangle {
                id: left2
                width: Kirigami.Units.largeSpacing * 8
                height: Kirigami.Units.largeSpacing * 8
                color: "#27ae60"
            }

            Rectangle {
                id: right2
                width: Kirigami.Units.largeSpacing * 12
                height: Kirigami.Units.largeSpacing * 12
                color: "#27ae60"
                anchors.top: parent.top;

                Rectangle {
                    id: right3
                    width: Kirigami.Units.largeSpacing * 4
                    height: Kirigami.Units.largeSpacing * 4
                    color: "black"
                    anchors.top: parent.top;
                    anchors.right: parent.right;
                    anchors.margins: Kirigami.Units.smallSpacing
                }
            }
        }

    }

    // HACK coordinates are only final after a small delay
    Timer {
        interval: 1000
        repeat: false
        running: true
        onTriggered: {
            var a = new A.An(root);
            a.tree();
            a.find("qquickrectangle").first().draw({
                outline: {},
                ruler: {},
                brace: {to: new A.An(right2), text: "16px", center: false}
            });

            a.find("qquickrectangle").eq(2).draw({
                outline: {aspectratio: true},
                ruler: {horizontal: true}
            });

            a.find("qquickrectangle").eq(3).draw({
                messure: { to: a.find("qquickrectangle").eq(4)}
            });

            a.find("qquickcombobox").click();
        }
    }

    // Draw helpers and anotation
    Raster {
        base: Kirigami.Units.gridUnit
        mobile: true
        desktop: true
    }
}
