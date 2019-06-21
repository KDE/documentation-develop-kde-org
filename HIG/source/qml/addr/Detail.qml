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
import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.4 as Kirigami
import QtGraphicalEffects 1.0

import "../lib/" as HIG


Flickable  {
    id: root
    property var model;
    property alias history: history
    signal editClicked()

    HIG.Header {
        id: header
        content.anchors.leftMargin: root.width > 400 ? 100 : Kirigami.Units.largeSpacing
        content.anchors.topMargin: Kirigami.Units.largeSpacing
        content.anchors.bottomMargin: Kirigami.Units.largeSpacing
        //status: root.contentY == 0 ? 1 : Math.min(1, Math.max(2 / 11, 1 - root.contentY / Kirigami.Units.gridUnit))
        source: "../../img/" + model.image


        /*Kirigami.ActionToolBar {
            anchors.fill: parent
            //spacing: (header.width - 3 * Kirigami.Units.iconSizes.medium) / 4
            //anchors.leftMargin: spacing
            actions: [
                Kirigami.Action {
                    iconName: "favorite"
                    text: "Save as favorite"
                },
                Kirigami.Action {
                    iconName: "favorite"
                    text: "Save as favorite"
                },
                Kirigami.Action {
                    iconName: "favorite"
                    text: "Save as favorite"
                }
         ]}*/

        stripContent: Row {
            anchors.fill: parent
            spacing: (header.width - 3 * Kirigami.Units.iconSizes.medium) / 4
            anchors.leftMargin: spacing


            Kirigami.Icon {
                source: "favorite"
                width: Kirigami.Units.iconSizes.smallMedium
                height: width
                anchors.verticalCenter: parent.verticalCenter
            }
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
                MouseArea {
                    onClicked: root.editClicked()
                    anchors.fill: parent
                }
            }
        }

        Kirigami.Heading {
            text: model.firstname + " " + model.lastname
            //color: Kirigami.Theme.textColor
            color: "#fcfcfc" // Hard coded because of the ColorOverlay
            level: 1
            width: parent.width
            wrapMode: Text.WordWrap
        }
    }

    Column {
        id: comm
        anchors.top: header.bottom
        anchors.topMargin: 2 * Kirigami.Units.largeSpacing
        width: parent.width

        Repeater {
            model: root.model.communication

            delegate: Kirigami.BasicListItem {
                //height: Kirigami.Units.gridUnit * 2
                id: delegate
                contentItem: RowLayout {
                    spacing: delegate.leftPadding
                    anchors.verticalCenter: parent.verticalCenter

                    Kirigami.Icon {
                        id: icon
                        width: Kirigami.Units.iconSizes.smallMedium
                        height: width
                        source: model.icon
                        color: Kirigami.Theme.textColor
                        Layout.alignment: Qt.AlignVCenter
                    }
                    Column {
                        Layout.alignment: Qt.AlignVCenter
                        Label {
                            text: model.text
                            color: model.default ? Kirigami.Theme.linkColor : Kirigami.Theme.textColor //"#2980b9" : "#232627"
                        }
                        Label {
                            text: model.description
                            font.pointSize: 8
                            color: Kirigami.Theme.textColor //"#7f8c8d"
                        }
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter

                        Kirigami.Icon {
                            visible: typeof model.actions !== "undefined"
                            source: "kmouth-phrase-new"
                            width: Kirigami.Units.iconSizes.smallMedium
                            height: width
                            anchors.right: parent.right
                            anchors.rightMargin: Kirigami.Units.largeSpacing
                            anchors.verticalCenter: parent.verticalCenter
                            id: call
                        }
                    }
                }

                /*Component.onCompleted: {
                    if (typeof model.actions !== "undefined") {
                        delegate.actions = model.actions
                    }
                }*/
            }
        }
    }

    Kirigami.Heading {
        level: 4
        visible: typeof root.model.history !== "undefined" && root.model.history.count && history.visible
        text: "History"
        id: hTitle
        anchors.top: comm.bottom
        anchors.left: parent.left
        anchors.topMargin: 2 * Kirigami.Units.largeSpacing
        anchors.leftMargin: Kirigami.Units.largeSpacing
    }

    History {
        id: history
        anchors.top: hTitle.bottom
        anchors.topMargin: Kirigami.Units.largeSpacing
        width: root.width
        model: root.model
    }
}
