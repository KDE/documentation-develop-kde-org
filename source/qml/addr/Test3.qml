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
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.5 as Kirigami
import "../models/" as Models
import "../lib/annotate.js" as A

Kirigami.ApplicationWindow {
    width: 800
    height: 600
    id: root

    property var mydata : Models.Contacts {
        Component.onCompleted: {
            detail.model =  mydata.get(3)
            detail.visible = true
        }
    }

    pageStack.initialPage: ListPage {
        id: list
    }
    pageStack.globalToolBar.style: Kirigami.ApplicationHeaderStyle.Auto
    pageStack.defaultColumnWidth: root.width < 320 ? root.width : 320

    /*menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            Action { text: qsTr("&New...") }
            Action { text: qsTr("&Import") }
            Action { text: qsTr("&Export") }
        }
        Menu {
            title: qsTr("&Edit")
            Action { text: qsTr("&Merge contacts") }
            Action { text: qsTr("&Search dupplicate contacts") }
            Action { text: qsTr("&Export") }
        }
        Menu {
            title: qsTr("&Settings")
            Action { text: qsTr("&About") }
        }
        Menu {
            title: qsTr("&Help")
            Action { text: qsTr("&About") }
        }
    }*/

    DetailPage {
        id: detail
        visible: false
    }

    globalDrawer: Kirigami.GlobalDrawer {
        actions: [Kirigami.Action {
                text: "Import"
            },
            Kirigami.Action {
                text: "Export"
            },
            Kirigami.Action {
                text: "Merge contacts"
            },
            Kirigami.Action {
                text: "Search dupplicate contacts"
            },
            Kirigami.Action {
                text: "Settings"
            }
        ]
    }

    Component.onCompleted: {
        root.pageStack.push(detail)
    }
}
