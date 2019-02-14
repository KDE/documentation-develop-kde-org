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
import "../../models/" as Models
import "../../addr/" as Addr
import "../../lib/annotate.js" as A
import QtGraphicalEffects 1.0

Kirigami.ApplicationItem {
    width: parent.width
    height: parent.height
    id: root

    property alias gDrawer: global

    property var mydata : Models.Contacts {
        Component.onCompleted: {
            detail.model =  mydata.get(2)
            detail.visible = true
        }
    }

    pageStack.initialPage: Addr.ListPage {
        id: list
    }

    pageStack.defaultColumnWidth: root.width < 320 ? root.width : 320
    pageStack.globalToolBar.style: Kirigami.ApplicationHeaderStyle.Auto

    Addr.DetailPage {
        id: detail
        visible: false
    }

    Component.onCompleted: {
        root.pageStack.push(detail)
    }

    globalDrawer: Kirigami.GlobalDrawer {
        id: global
        title: "Joanne Doe"
        titleIcon: "../../../img/BernaFace.jpg"

        //Kirigami.Theme.inherit: false
        //Kirigami.Theme.colorSet: Kirigami.Theme.Complementary

        topContent: [
            Row {
                anchors.right: parent.right
                anchors.rightMargin: Kirigami.Settings.tabletMode ? Kirigami.Units.largeSpacing : Kirigami.Units.smallSpacing
                anchors.bottom: parent.bottom
                spacing: Kirigami.Settings.tabletMode ? 2 * Kirigami.Units.largeSpacing : 2 * Kirigami.Units.smallSpacing
                //anchors.bottomMargin: 4 * Kirigami.Units.largeSpacing

                Kirigami.Icon {
                    source: "document-share"
                    width: Kirigami.Units.iconSizes.smallMedium
                    height: width
                    anchors.verticalCenter: parent.verticalCenter
                }
                Kirigami.Icon {
                    source: "document-edit"
                    width: Kirigami.Units.iconSizes.smallMedium
                    height: width
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        ]
        actions: [
            Kirigami.Action {
                iconName: "document-import"
                text: i18n("&Import contacts")
            },
            Kirigami.Action {
                iconName: "document-export"
                text: i18n("&Export contacts")
            },
            Kirigami.Action {
                iconName: "user-group-delete"
                text: i18n("&Merge contacts")
            },
            Kirigami.Action {
                iconName: "user-group-new"
                text: i18n("&Search duplicate contacts")
            },
            Kirigami.Action {
                iconName: "configure"
                text: i18n("&Settings")
            }
        ]
    }
}
