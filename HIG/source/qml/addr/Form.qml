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


ColumnLayout  {
    id: root
    property var model;
    spacing: 2 * Kirigami.Units.largeSpacing


    Kirigami.FormLayout {
        id: form
        Layout.preferredWidth: Math.round(page.width * 0.9)

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
}
