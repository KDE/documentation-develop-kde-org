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

import "../../../lib/" as HIG
import "../../../lib/annotate.js" as A

Rectangle {
    width: 420
    height: 300
    id: root

    Form_Align {
        id: align;
        anchors.fill: parent;
    }

    HIG.Raster {
        desktop: true
    }

    // HACK
    Timer {
        interval: 500
        repeat: false
        running: true
        onTriggered: {
            var a = new A.An(align);
            a.find("qquicktextfield").eq(1).draw({ruler: {}})
            qmlControler.start();
        }
    }
}
