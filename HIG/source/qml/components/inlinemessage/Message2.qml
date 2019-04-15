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

import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.4 as Kirigami
import "../../lib" as HIG

Rectangle {
    id: root
    width: 600
    height: 160

    ColumnLayout {
        x: Kirigami.Units.gridUnit * 2
        y: Kirigami.Units.gridUnit * 2
        width: parent.width - 2 * Kirigami.Units.gridUnit * 2
        Kirigami.InlineMessage {
            Layout.fillWidth: true
            visible: true
            text: "Remember password?"
            actions: [
                Kirigami.Action {
                    text: "Remember"
                    icon.name: "dialog-ok-apply"
                },
                Kirigami.Action {
                    text: "Do not remember"
                    icon.name: "dialog-cancel"
                }
            ]
        }
    }

    HIG.Raster {
        z: 1
    }
}
