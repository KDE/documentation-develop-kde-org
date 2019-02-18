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

Kirigami.ApplicationItem {
    width: parent.width
    height: parent.height
    id: root

    property alias gDrawer: global
    property alias cDrawer: context
    property alias detailPage: detail
    property alias listPage: list
    property int index: -1

    property var mydata : Models.Contacts {
        Component.onCompleted: {
            if (root.index >= 0) {
                detail.model =  mydata.get(root.index)
                detail.visible = true
            }
        }
    }

    pageStack.initialPage: ListPage {
        id: list
        onCurrentIndexChanged: {
            detail.model =  mydata.get(list.currentIndex)
            root.pageStack.push(detail)
            detail.visible = true

            if (root.width > 900) {
                history.model =  mydata.get(list.currentIndex)
                root.pageStack.push(history)
            }
        }
    }

    pageStack.defaultColumnWidth: root.width < 320 ? root.width : 320
    pageStack.globalToolBar.style: Kirigami.ApplicationHeaderStyle.Auto

    DetailPage {
        id: detail
        visible: false
        showHistory: root.width <= 900
    }

    HistoryPage {
        id: history
        visible: false
    }

    globalDrawer: Kirigami.GlobalDrawer {
        id: global
        title: "Joanne Doe"
        titleIcon: "../../img/BernaFace.jpg"

        /*modal: root.width <= 1000;
        collapsible: root.width > 1000;
        collapsed: root.width > 1000;

        Kirigami.Theme.inherit: root.width <= 1000
        Kirigami.Theme.colorSet: Kirigami.Theme.Complementary*/

        topContent: [
            Row {
                Layout.alignment: Qt.AlignRight | Qt.AlignBottom
                //anchors.right: parent.right
                anchors.rightMargin: Kirigami.Settings.tabletMode ? Kirigami.Units.largeSpacing : Kirigami.Units.smallSpacing
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

    contextDrawer: Kirigami.ContextDrawer {
        id: context
     }
}
