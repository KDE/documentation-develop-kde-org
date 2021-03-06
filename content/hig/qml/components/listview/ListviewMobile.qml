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
import QtTest 1.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.4 as Kirigami
import "../../models/" as Models
import "../../addr/" as Addr
import "../../lib/annotate.js" as A

Kirigami.ApplicationItem {
    width: 320
    height: 600
    id: root

    property var mydata : Models.Contacts {
    }

    pageStack.initialPage: Addr.ListPage {
        id: list
        model: root.mydata
    }

    pageStack.defaultColumnWidth: root.width
    pageStack.globalToolBar.style: Kirigami.ApplicationHeaderStyle.Breadcrumb


    // HACK
    TestEvent {
        id: event
    }

}
