---
title: Create a custom Window Switcher
authors:
 - SPDX-FileCopyrightText: 2011 Martin Gräßlin <mgraesslin@kde.org>
 - SPDX-FileCopyrightText: 2021 Carl Schwan <carlschwan@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
aliases:
  - /docs/plasma/windowswitcher/
---

## Introduction

The Window Switcher (Alt+Tab) can be custom styled using layouts written in QML
since KDE Plasma Workspaces (now Plasma) in version 4.8. The window manager
supports multiple Window Switchers and exchanges the loaded layout at runtime.
Additionally the underlying Model is recreated each time the switcher is invoked
and some properties might change due to screen changes and different settings for
the multiple switchers. To support this the QML loader can set properties in the
custom QML component if available.

All the QML API is available with `import org.kde.kwin 2.0 as KWin`.

## KWin.Switcher QML element

`KWin.Switcher` is the base element of a window switcher and doesn't provide any
visual representation. It provides 5 properties to its users:

* `QAbstractItemModel *model`: (read only) The model listing all windows. More on that later.
* `QRect screenGeometry`: (read only) Contains the height, width, x and y positions of the primary screen. This property can be used to restrain the dimension and position of the switcher to the current screen.
* `bool visible`: (read only) True, if the switcher is currently visible.
* `bool allDesktops`: (read only) Whether the Model includes windows from all desktops or only the current desktop. This property can be used to e.g. hide the desktop a window is on when the switcher only shows windows of the current desktop. Do not use this property to filter the list. This is done by the Model.
* `int currentIndex`: Current selected item in the model. Updating `currentIndex` will switch to the selected window.

## Model

The Model is available as a property `model` from our Switcher object. It's a standard QAbstractItemModel and can be used in a ListView/Repeater.

The Model provides the following roles:
* `string caption`: the window title
* `bool minimized`: whether the window is minimized
* `string desktopName`: the name of the desktop the window is on
* `ulonglong windowId`: the window Id (XId) of the window
* `string icon`: the icon name for the window

## Thumbnails

The window manager provides a QML component to render a live thumbnail of the window. It is important to know that this thumbnail is not rendered in QML's scene graph, but by the compositor after the window has been rendered. Because of that it is not possible to put other visual components on top of the thumbnail. If compositing is not available an icon will be rendered instead of the thumbnail.

The component is called `ThumbnailItem` and has one required property `wId`. Example

```qml
import QtQuick 2.0
import org.kde.kwin 2.0 as KWin
KWin.Switcher {
    id: tabBox
    currentIndex: thumbnailListView.currentIndex
    ListView {
        model: tabBox.model
        delegate: KWin.ThumbnailItem {
            wId: windowId
            width: 200
            height: 200
        }
    }
}
```

## Installation

The QML file(s) has to be stored in `~/.local/share/kwin/tabbox/` and are using KPackage. Some
examples Tab Switchers can be found on [Gitlab](https://invent.kde.org/plasma/kdeplasma-addons/-/tree/master/windowswitchers).

A Tab Switcher can also be bundled in a Global Theme [like Breeze does](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/lookandfeel/contents/windowswitcher/WindowSwitcher.qml).

