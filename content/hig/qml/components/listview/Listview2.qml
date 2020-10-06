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
import org.kde.kirigami 2.7 as Kirigami
import "../../addr/" as Addr
import "../../lib/annotate.js" as A

Rectangle {
    width: 320
    height: 200
    id: root

    ListviewMobile {

    }

    Timer {
        interval: 2000
        repeat: false
        running: true
        onTriggered: {
            var a = new A.An(root);
            var item = a.find("swipelistitem").first();
            var label = item.find("qquicklabel").last();
            
            label.draw({
                "outline": {label: false},
                "ruler": {horizontal: true, offset: "center"}
            });
            var icon = item.find("qquickimage").first();
            icon.draw({
                "outline": {label: false},
                "brace": {to: label}
            });
        }
    }
    Timer {
        interval: 2500
        repeat: false
        running: true
        onTriggered: {
            qmlControler.start();
        }
    }
}
