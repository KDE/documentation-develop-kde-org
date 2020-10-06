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
import QtQuick.Layouts 1.3 as Layouts

import "../../../lib/" as HIG

Rectangle {
    width: 400
    height: 180

    Layouts.GridLayout {
        x: units.largeSpacing
        y: units.largeSpacing
        columnSpacing: units.smallSpacing
        rowSpacing: units.smallSpacing
        columns: 2
        z: 2

        Label {
            text: "Profile name:"
            horizontalAlignment: Text.AlignRight
            Layouts.Layout.minimumWidth: 150
        }
        TextField {
            Layouts.Layout.minimumWidth: 400 - 200 - 2 * 20
        }
        Label {
            text: "Command:"
            horizontalAlignment: Text.AlignRight
            Layouts.Layout.minimumWidth: 150
        }
        TextField {
            Layouts.Layout.minimumWidth: 400 - 200 - 2 * 20
        }
        Label {
            text: "Initial directory:"
            horizontalAlignment: Text.AlignRight
            Layouts.Layout.minimumWidth: 150
        }
        TextField {
            Layouts.Layout.minimumWidth: 400 - 200 - 2 * 20
        }
    }

    HIG.Raster {
    }
}
