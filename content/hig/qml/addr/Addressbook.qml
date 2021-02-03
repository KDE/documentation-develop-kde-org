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
    property Item detailPage;
    property Item listPage;
    property Item historyPage;
    property int index: -1

    property bool wide: false

    property var mydata : Models.Contacts {
        Component.onCompleted: {
            adjustGlobalDrawer();
            root.pageStack.push(Qt.resolvedUrl("ListPage.qml"), {model: root.mydata});
            listPage = root.pageStack.lastItem;
            if (root.index >= 0) {
                setIndex(root.index)
            }
            listPage.currentIndexChanged.connect(function() {
                setIndex(listPage.currentIndex);
            });
        }
    }

    /*pageStack.initialPage: ListPage {
        id: list
        onCurrentIndexChanged: {
            setIndex(list.currentIndex)
        }
        Kirigami.ColumnView.fillWidth: false
    }*/

    function setIndex(i) {
        //return;
        console.log("setIndex")       
        if (root.pageStack.depth == 1) {
            root.pageStack.push(Qt.resolvedUrl("DetailPage.qml"), {model: root.mydata.get(i)});
            detailPage = root.pageStack.lastItem;
        }
        detailPage.model =  mydata.get(i)

        if (root.wide) {
            if (root.pageStack.depth == 2) {
                root.pageStack.push(Qt.resolvedUrl("HistoryPage.qml"), {model: root.mydata.get(i)})
                historyPage = root.pageStack.lastItem;
            }
            historyPage.model =  mydata.get(i)
            show3Columns();
        }
        else {
            show2Columns();
        }
    }

    pageStack.defaultColumnWidth: root.width < 320 ? root.width : 320
    pageStack.globalToolBar.style: Kirigami.ApplicationHeaderStyle.Auto

    /*DetailPage {
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
    }*/
    function show3Columns() {
        if (listPage) {
            listPage. Kirigami.ColumnView.fillWidth = false
        }
        if (detailPage) {
            detailPage.Kirigami.ColumnView.reservedSpace = pageStack.defaultColumnWidth * 2
            detailPage.Kirigami.ColumnView.fillWidth = true
        }
        if (historyPage) {
            historyPage.Kirigami.ColumnView.fillWidth =  false
        }
    }
    
    function show2Columns() {
        //listPage. Kirigami.ColumnView.fillWidth = true
        if (detailPage) {
            detailPage.Kirigami.ColumnView.reservedSpace = pageStack.defaultColumnWidth
            detailPage.Kirigami.ColumnView.fillWidth = true
        }
        while (root.pageStack.depth > 2) {
            root.pageStack.pop()
        }
    }
    
    function adjustGlobalDrawer() {
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


    onWidthChanged: {
        // Show 3 columns
        if (width >= 1050 && !root.wide) {
            console.log("onWidthChanged wide")
            root.wide = true
            show3Columns();
        }

        // Show 2 columns
        if (width < 1050 && root.wide) {
            console.log("onWidthChanged narrow")
            root.wide = false
            show2Columns()
        }

        adjustGlobalDrawer();
    }

    globalDrawer: Kirigami.GlobalDrawer {
        id: global
        title: "Joanne Doe"
        bannerVisible: true
        bannerImageSource: "../../img/BernaFace-16x9.jpg"

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
