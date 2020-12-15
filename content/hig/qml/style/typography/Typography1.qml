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
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.2 as Controls
import org.kde.kirigami 2.4 as Kirigami

Rectangle {
    width: 480
    height: 320

    ColumnLayout {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: Kirigami.Units.gridUnit
        spacing: 2 * Kirigami.Units.largeSpacing

        Kirigami.Heading {
            level: 1
            text: "Header 1, Noto Sans 180%"
        }
        Kirigami.Heading {
            level: 2
            text: "Header 2, Noto Sans 130%"
        }
        Kirigami.Heading {
            level: 3
            text: "Header 3, Noto Sans 120%"
        }
        Kirigami.Heading {
            level: 4
            text: "Header 4, Noto Sans 110%"
        }
        Controls.Label {
            text: "Body, Noto Sans 100%"
        }
        Controls.Label {
            text: "Monospace/Code, Hack 100%"
            font.family: "Hack"
        }
        Controls.Label {
            text: "Small, Noto Sans 80%"
        }
    }
}
