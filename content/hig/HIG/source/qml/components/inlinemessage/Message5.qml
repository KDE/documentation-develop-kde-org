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
    height: 340

    ColumnLayout {
        x: Kirigami.Units.gridUnit * 2
        y: Kirigami.Units.gridUnit * 2
        width: parent.width - 2 * Kirigami.Units.gridUnit * 2
        spacing: Kirigami.Units.largeSpacing

        Kirigami.InlineMessage {
            Layout.fillWidth: true
            visible: true
            text: "This is an informational inline message (the default type). Use it for example to announce a result or provide commentary."
        }

        Kirigami.InlineMessage {
            Layout.fillWidth: true
            visible: true
            type: Kirigami.MessageType.Positive
            text: "This is a positive inline message. Use it for example to announce a successful result or the succesful completion of a procedure."
        }

        Kirigami.InlineMessage {
            Layout.fillWidth: true
            visible: true
            type: Kirigami.MessageType.Warning
            text: "This is a warning inline message. Use it for example to provide critical guidance or warn about something that is not going to work."
        }

        Kirigami.InlineMessage {
            Layout.fillWidth: true
            visible: true
            type: Kirigami.MessageType.Error
            text: "This is an error inline message. Use it for example to announce something has gone wrong or that input will not be accepted."
        }
    }

    HIG.Raster{
        z: 1
    }
}
