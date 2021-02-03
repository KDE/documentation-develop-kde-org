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
import "../../models/" as Models
import "../../addr/" as Addr
import "../../lib" as HIG
import "../../lib/annotate.js" as A

Rectangle {
    width: 800
    height: 600
    id: root

    Addr.Addressbook {
        id: addrbook
        index: 2
        Component.onCompleted: {
            addrbook.pageStack.push(addrbook.detailPage)
        }
    }

    HIG.FTimer {
        running: true
        onTick: function(frameCounter) {
            if (frameCounter == 60) {
                var b = new A.An(root);
                b.find("pagerowglobaltoolbarui").tree();
                b.find("pagerowglobaltoolbarui").find("privateactiontoolbutton").draw({
                    outline: {label: false}
                });
            }
        }
    }
}
