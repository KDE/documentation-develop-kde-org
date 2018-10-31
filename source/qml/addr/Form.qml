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


Item  {
    id: root
    property var model;
    height: childrenRect.height

    /*HIG.Header {
        id: header
        content.anchors.leftMargin: Kirigami.Units.largeSpacing
        content.anchors.topMargin: Kirigami.Units.largeSpacing
        content.anchors.bottomMargin: Kirigami.Units.largeSpacing
        source: "../../img/" + model.image


        stripContent: Row {
            anchors.fill: parent
            spacing: (header.width - 3 * Kirigami.Units.iconSizes.medium) / 4
            anchors.leftMargin: spacing


            Kirigami.Icon {
                source: "view-preview"
                width: Kirigami.Units.iconSizes.smallMedium
                height: width
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Label {
            text: model.firstname + " " + model.lastname
            color: "#fcfcfc"
            font.pointSize: 12
        }
    }*/

    Label {
        id: header
        text: "Edit details"
        font.pointSize: 16
    }

    Kirigami.FormLayout {
        id: form
        anchors.top: header.bottom
        anchors.topMargin: Kirigami.Units.largeSpacing
        width: root.width



        TextField {
            Kirigami.FormData.label: "Firstname:"
            text: model.firstname
        }
        TextField {
            Kirigami.FormData.label: "Lastname:"
            text: model.lastname
        }
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Phone"
        }
        Repeater {
            model: root.model.communication
            delegate: TextField {
                visible: model.type === "phone"
                Kirigami.FormData.label: model.description + ":"
                text: model.text
            }
        }
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Email"
        }
        Repeater {
            model: root.model.communication
            delegate: TextField {
                visible: model.type === "email"
                Kirigami.FormData.label: model.description + ":"
                text: model.text
            }
        }
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
        }

        Switch {
            Kirigami.FormData.label: "Additional fields"
        }

    }
    Button {
        text: "Save"
        anchors.top: form.bottom
        anchors.right: parent.right
        anchors.rightMargin: Kirigami.Units.largeSpacing
        anchors.topMargin: 4 * Kirigami.Units.largeSpacing
    }

}
