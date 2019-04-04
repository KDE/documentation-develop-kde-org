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

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.4 as Kirigami
import "../../lib/annotate.js" as A

Rectangle {
    width: 320
    height: 220
    id: root

    ListView {
        anchors.fill: parent
        model: [1,2,3,4]

        delegate: Kirigami.BasicListItem {
            icon: "folder"
            iconColor: "#27ae60"
            iconSize: Kirigami.Units.iconSizes.medium
            label: "Folder " + (index + 1)
        }
    }

    Timer {
        interval: 1500
        repeat: false
        running: true
        onTriggered: {
            var a = new A.An(root);
            var item0 = a.find("basiclistitem").first();
            item0.draw({
                "padding": {}
            });

            var item1 = a.find("basiclistitem").eq(1);
            var icon1 = item1.find("desktopicon");
            icon1.draw({
                "outline": {label: false},
                "ruler": {horizontal: true, offset: "center"}
            });
            item1.find("qquicklabel").draw({
                "outline": {label: false}
            });

            var item2 = a.find("basiclistitem").eq(3);
            var label2 = item2.find("qquicklabel");
            item2.find("desktopicon").draw({
                "outline": {},
                "brace": {to: label2, center: false}
            });
            qmlControler.start();
        }
    }

}
