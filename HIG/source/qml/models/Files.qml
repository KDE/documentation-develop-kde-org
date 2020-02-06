
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

ListModel {
    id: model
    // Pattern
    ListElement {
        name: ""
        icon: ""

        subfolder: [
            ListElement {
                name: ""
                icon: ""
                subfolder: ListElement {
                    name: ""
                    icon: ""

                    subfolder: [
                        ListElement {
                            name: ""
                            icon: ""
                            subfolder: ListElement {
                                name: ""
                                icon: ""
                            }
                        }
                    ]
                }
            }
        ]
    }

    Component.onCompleted: {
        model.clear()
        var data = [{
                        "name": "HIG",
                        "icon": "folder-development",
                        "subfolder": [{
                                "name": "build",
                                "icon": "folder",
                                 "subfolder": [{
                                        "name": "doctrees",
                                        "icon": "folder-text"
                                    }, {
                                        "name": "html",
                                        "icon": "folder-internet"
                                }]
                            }, {
                                "name": "source",
                                "icon": "folder-development",
                                "subfolder": [{
                                        "name": "components",
                                        "icon": "folder-text"
                                    }, {
                                        "name": "img",
                                        "icon": "folder-picture"
                                    }, {
                                        "name": "introduction",
                                        "icon": "folder-text"
                                    }, {
                                        "name": "layout",
                                        "icon": "folder-text"
                                    }, {
                                        "name": "patterns",
                                        "icon": "folder-text"
                                    }, {
                                        "name": "qml",
                                        "icon": "folder",
                                        "subfolder": [{
                                                "name": "ui",
                                                "icon": "folder-text"
                                            }, {
                                                "name": "lib",
                                                "icon": "folder-text"
                                            }, {
                                                "name": "models",
                                                "icon": "folder-text"
                                            }]
                                    }, {
                                        "name": "resources",
                                        "icon": "folder-text"
                                    }, {
                                        "name": "style",
                                        "icon": "folder"
                                    }, {
                                        "name": "video",
                                        "icon": "folder-video"
                                    }]
                            }]
                    }]
        model.insert(0, data)
    }
}
