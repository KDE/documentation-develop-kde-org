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

import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.kirigami 2.4 as Kirigami
import "../../lib" as HIG
import "../../lib/annotate.js" as A

Kirigami.ApplicationItem {
    width: 320
    height: 180
    id: root

    pageStack.initialPage: Kirigami.Page {
        ComboBox {
            id: cbx1
            model: [ "Item1", "Item2", "Item3" ]
        }
    }

    HIG.FAnimation {
        actions: {
            60: function() {
                var a = new A.An(cbx1);
                a.click();
            },
            180: function() {
                var a = new A.An(root);
                a.click({fromX: 140});
            }
        }
    }
}
