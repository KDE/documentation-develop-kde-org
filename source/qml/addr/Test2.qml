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
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.4 as Kirigami
import "../models/" as Models
import "../lib/annotate.js" as A

Kirigami.ApplicationItem {
    width: 320
    height: 600
    id: root

    property var mydata : Models.Contacts {
        Component.onCompleted: {
            detail.model =  mydata.get(3)
            detail.visible = true
            form.model =  mydata.get(3)
            form.visible = true
        }
    }

    pageStack.initialPage: ListPage {
        id: list
    }

    pageStack.defaultColumnWidth: root.width < 320 ? root.width : 320
    pageStack.globalToolBar.style: Kirigami.ApplicationHeaderStyle.Breadcrumb

    DetailPage {
        id: detail
        visible: false
    }

    FormPage {
        id: form
        visible: false
    }

    contextDrawer: Kirigami.ContextDrawer {
        id: contextDrawer
     }

    /*globalDrawer: Kirigami.GlobalDrawer {
        actions: [Kirigami.Action {
                iconName: "call-start"
            },
            Kirigami.Action {
                iconName: "mail-message"
            }
        ]
    }*/

    Component.onCompleted: {
        root.pageStack.push(detail)
        root.pageStack.push(form)
    }



    // HACK
    Timer {
        interval: 2000
        repeat: false
        running: true
        onTriggered: {
            var a = new A.An(list);
             a.find("swipelistitem").eq(3).swipe({fromX: +140, fromY: 0, toX: -80, toY: 0});
            //a.find("swipelistitem").eq(3).find("qquickimage").touch();
        }
    }

    Timer {
        interval: 5000
        repeat: false
        running: true
        onTriggered: {
            var b = new A.An(root);
            //b.find("pagerowglobaltoolbarui").find("heading").first().touch();
        }
    }
}
