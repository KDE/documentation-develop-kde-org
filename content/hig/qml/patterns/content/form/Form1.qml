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

import QtQuick 2.6
import "../../../addr/" as Addr

Rectangle {
    width: 800
    height: 600
    id: root

    Addr.Addressbook {
        id: addrbook
        index: 0
        Component.onCompleted: {
            addrbook.pageStack.push(addrbook.detailPage)
        }
    }

    // HACK
    Timer {
        interval: 1000
        repeat: false
        running: true
        onTriggered: {
            addrbook.detailPage.form.open();
            //contextDrawer.open();
        }
    }
    Timer {
        interval: 2500
        repeat: false
        running: true
        onTriggered: {
            qmlControler.start();
        }
    }
}
