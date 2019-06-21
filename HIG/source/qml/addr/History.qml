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

Column {
    id: root
    property var model;

    Repeater {
        model: root.model.history

        delegate: Kirigami.SwipeListItem {
            id: listItem
            Row {
                spacing: listItem.leftPadding
                anchors.verticalCenter: parent.verticalCenter

                Kirigami.Icon {
                    width: Kirigami.Units.iconSizes.smallMedium
                    height: width
                    source: model.icon
                    color: Kirigami.Theme.disabledTextColor //"#232627"
                    anchors.verticalCenter: parent.verticalCenter
                }
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    Label {
                        text: model.text
                        color: Kirigami.Theme.textColor //"#232627"
                    }
                    Label {
                        text: model.date
                        font.pointSize: 8
                        color: Kirigami.Theme.disabledTextColor // "#7f8c8d"
                    }
                }
            }
        }
    }
}
