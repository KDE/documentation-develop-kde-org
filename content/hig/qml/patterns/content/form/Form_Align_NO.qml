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
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import "../../../lib/" as HIG

Rectangle {
    width: 420
    height: 300
    id: root

    GridLayout {
        x: units.largeSpacing
        y: units.largeSpacing
        columnSpacing: units.smallSpacing
        rowSpacing: units.smallSpacing
        columns: 2
        z: 2
        id: group1

        Label {
            id: label1
            text: "Caption:"
            horizontalAlignment: Text.AlignRight
            Layout.minimumWidth: 120
        }
        TextField {
            Layout.minimumWidth: 400 - 120 - 2 * 20
        }
        Label {
            text: "Long caption:"
            horizontalAlignment: Text.AlignRight
            Layout.minimumWidth: 120
        }
        TextField {
            Layout.minimumWidth: 400 - 120 - 2 * 20
        }
        Label {
            text: "Very long caption:"
            horizontalAlignment: Text.AlignRight
            Layout.minimumWidth: 120
        }
        TextField {
            Layout.minimumWidth: 400 - 120 - 2 * 20
        }
    }

    GridLayout {
        anchors.top: group1.bottom
        anchors.topMargin: 16
        y: 20
        columns: 2

        Label {
            text: "Caption:"
            horizontalAlignment: Text.AlignRight
            Layout.minimumWidth: 120
        }
        ComboBox {
            model: ["alpha"]
            Layout.minimumWidth: 120
        }
        Label {
            text: "One more:"
            horizontalAlignment: Text.AlignRight
            Layout.minimumWidth: 120
        }
        SpinBox {
            value: 42
            Layout.minimumWidth: 120
        }
        Label {
            text: "Long caption:"
            horizontalAlignment: Text.AlignRight
            Layout.minimumWidth: 120
        }
        CheckBox {
            text: "Check me"
        }
    }

    HIG.Raster {
    }
}
