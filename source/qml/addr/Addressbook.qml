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
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.7 as Kirigami
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

    property bool wide: false

    property var mydata : Models.Contacts {
        Component.onCompleted: {
            if (root.index >= 0) {
                setIndex(root.index)
            }
        }
    }

    pageStack.initialPage: ListPage {
        id: list
        onCurrentIndexChanged: {
            setIndex(list.currentIndex)
        }
        Kirigami.ColumnView.fillWidth: false
    }

    function setIndex(i) {
        console.log("setIndex")
        detail.model =  mydata.get(i)
        detail.visible = true
        root.pageStack.push(detail)

        console.log(root.wide)
        if (root.wide) {
            history.model =  mydata.get(i)
            history.visible = true
            root.pageStack.push(history)
        }
    }

    pageStack.defaultColumnWidth: root.width < 320 ? root.width : 320
    pageStack.globalToolBar.style: Kirigami.ApplicationHeaderStyle.Auto

    DetailPage {
        id: detail
        visible: false
        showHistory: root.wide
        Kirigami.ColumnView.fillWidth: true
        //Kirigami.ColumnView.reservedSpace: pageStack.defaultColumnWidth * 2

        Share {
            id: share
            sheetOpen: true
            model: mydata
        }
    }

    HistoryPage {
        id: history
        visible: false
        //Kirigami.ColumnView.fillWidth: false
    }


    onWidthChanged: {
        console.log()
        if (width >= 1050 && !root.wide) {
            root.wide = true
            detail.Kirigami.ColumnView.reservedSpace = pageStack.defaultColumnWidth * 2
            if (list.currentIndex >= 0) {
                console.log("onWidthChanged wide")
                history.model =  mydata.get(list.currentIndex)
                history.visible = true
                root.pageStack.push(history)
            }
        }

        if (width < 1050 && root.wide) {
            console.log("onWidthChanged narrow")
            console.log(list.currentIndex)
            root.wide = false
            detail.Kirigami.ColumnView.reservedSpace = pageStack.defaultColumnWidth
            //if (list.currentIndex >= 0) {
                console.log("removing")
                root.pageStack.removePage(history);
                list.Kirigami.ColumnView.fillWidth = true
            //}
        }


        // Change drawer to collapsible if there is enough space
        if (width >= 1100 && !global.collapsible) {
            console.log("onWidthChanged collapsible")
            global.modal = false;
            global.collapsible = true
            global.collapsed = true;
            global.drawerOpen = true
        }

        if (width < 1100 && global.collapsible) {
            console.log("onWidthChanged not collapsible")
            global.drawerOpen = false
            global.collapsible = false
            global.modal = true
        }
    }

    globalDrawer: Kirigami.GlobalDrawer {
        id: global
        title: "Joanne Doe"
        titleIcon: "../../img/BernaFace.jpg"

        Kirigami.Theme.inherit: false
        Kirigami.Theme.colorSet: Kirigami.Theme.Complementary

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
