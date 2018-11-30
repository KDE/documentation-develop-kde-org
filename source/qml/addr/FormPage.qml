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

Kirigami.OverlaySheet {
    property var model;
    Kirigami.Theme.colorSet: Kirigami.Theme.View
    id: page
    Layout.fillWidth: true

    background: Rectangle {
        color: Kirigami.Theme.backgroundColor
    }

    Form {
        model: page.model
    }

    /*actions {
        main: Kirigami.Action {
            iconName: "dialog-ok-apply"
            //onTriggered: d.state = "large"
        }
    }

    /*contextualActions: [
        Kirigami.Action {
            iconName: "edit"
            text: "Action text"
        }
    ]*/

}
