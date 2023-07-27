---
title: "Porting Plasmoids to KF6"
weight: 2
description: >
  Porting guide for Plasmoids to KF6/Plasma6
aliases:
  - /docs/plasma/porting_kf6/
authors:
  - SPDX-FileCopyrightText: Marco Martin <mart@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
categories: [Porting Guide]
---

The Plasma API used to make desktop widgets (also known as "applets" or "plasmoids") is changing for the Plasma 6.0 release.

Note that the final API is still a work in progress and this document will be updated over time to reflect them. **If you are reading this message, expect further changes before the final release of Plasma 6**.

## Changes Overview
### Background Information
A plasmoid's base component is a C++ class called `Applet`, which is a `QObject`. Applets are contained in an Applet subclass called `Containment`, which manages the lifecycle of all of its applets. On Plasma Desktop, each screen has one containment which manages its desktop area, and another for each panel on that desktop.

The root of the QML part of a plasmoid is a C++ `QQuickItem` implementation called `AppletInterface`. If a plasmoid is also a `Containment`, then its base is a `ContainmentInterface`, which is a subclass of `AppletInterface`.

### How it worked in Plasma 5
In Plasma 5, `AppletInterface` exposed and wrapped most of the `Applet` API, plus some QtQuick-related additions. The root QML object of each plasmoid could be any QML Item, and the `AppletInterface` was accessed in QML via the `Plasmoid` attached property or the `plasmoid` (lowercase) context property.

The `Applet` base instance was usually not accessible, unless the plasmoid offered a C++ `Applet` plugin, in which case it was accessible via the property `Plasmoid.nativeInterface`.

### How it works in Plasma 6
In Plasma 6, `AppletInterface` and `Applet` have a more clear task separation. All the wrapper properties and methods from `AppletInterface` to `Applet` (and from `ContainmentInterface` to `Containment`) have been removed. `AppletInterface` and `ContainmentInterface` only offer QtQuick-specific API now.

The root QML object of a plasmoid is now required to be a `PlasmoidItem` which is the QML name for `AppletInterface`. If it is also a containment, it must be of type `ContaimentItem`, which is the QML name for `ContainmentInterface`. This approach is similar and consistent with the `ApplicationWindow` type for QML-based applications.

The attached `Plasmoid` object, as well the lowercase `plasmoid` context property are now instances of the underlying `Applet` (or `Containment` for panels and desktops), keeping most of the API present in the Plasma 5 version of the attached property.

The new `PlasmoidItem` root element--which is the QML frontend to the C++ `AppletInterface` class--maintains the following properties, which were already there in Plasma 5:

* `compactRepresentation`
* `fullRepresentation`
* `preferredRepresentation`
* `switchWidth`
* `switchHeight`
* `activationTogglesExpanded`
* `toolTipMainText`
* `toolTipSubText`
* `toolTipTextFormat`
* `toolTipItem`
* `hideOnWindowDeactivate`

In Plasma 6, a new `plasmoid` property has been added, which points to the `Applet` instance.

The new `ContainmentItem` root element--which is the QML frontend to the C++ `ContainmentInterface` class--maintains the following properties, which were already there in Plasma 5:

* `wallpaper`

Methods already present in Plasma 5:
* `processMimeData`
* `containmentAt`
* `mapFromApplet`
* `mapToApplet`
* `adjustToAvailableScreenRegion`
* `openContextMenu`

In Plasma 6, a new method `AppletInterface *itemFor(Plasma::Applet *applet)` has been added, which is used to get the `AppletItem` instance of a given `Applet`. NOTE: it may return null when invoked before `componentComplete` of the `ContainmentItem` is executed (FIXME).

### Porting an existing plasmoid
The main thing to consider is adapting to the new subdivision of API between `PlasmoidItem` and `Plasmoid`. In general, you will need to take the following steps:

* Port the root `Item` of the plasmoid to `PlasmoidItem` (or `ContainmentItem`, if the plasmoid is a containment). If the root item wasn't an `Item` but rather something functional like a `MouseArea`, that item should be made a child of the new root `PlasmoidItem` or `ContainmentItem`.
* All the properties and methods mentioned above will have to be ported from the `Plasmoid` attached property (or `plasmoid` context property) to be properties set on the root `PlasmoidItem` or `ContainmentItem` item. Other properties, such as `icon` and `title` can remain using the `Plasmoid` attached property.
* for plasmoids that offer a C++ plugin as an `Applet` subclass, the C++ part doesn't change.  The QML part drops its `nativeInterface` intermediary property, so change properties like `Plasmoid.nativeInterface.myProperty` to `Plasmoid.myProperty`

### Example porting of a minimal plasmoid

#### Qt5

```qml
import QtQuick 2.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0


Item {
    id: root
    Plasmoid.toolTipMainText: i18n("This is %1", Plasmoid.title)
    Plasmoid.fullRepresentation: Item { ... }
    Plasmoid.compactRepresentation: Item { ... }
}
```

#### Qt6

```qml
import QtQuick 2.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0


PlasmoidItem {
    id: root
    // toolTipMainText is a direct property of root, title is a property of Plasmoid attached property
    toolTipMainText: i18n("This is %1", Plasmoid.title)
    fullRepresentation: Item { ... }
    compactRepresentation: Item { ... }
}
```

### Components to replace with others of same functionality

#### Port to Kirigami or upstream QQC2

The following Plasma components have been replaced by their Kirigami or upstream
QtQuickControls 2 counterparts:

| Plasma 5                                      | Plasma 6                                         |
|-----------------------------------------------|--------------------------------------------------|
| PlasmaCore.ColorScope.colorGroup              | Kirigami.Theme.colorSet                          |
| PlasmaCore.ColorScope.inherit                 | Kirigami.Theme.inherit                           |
| PlasmaCore.Theme.smallestFont                 | Kirigami.Theme.smallFont                         |
| PlasmaCore.Theme.NormalColorGroup             | Kirigami.Theme.Window                            |
| PlasmaCore.Theme.*anything else*              | Kirigami.Theme.*the same thing*                  |
| PlasmaCore.Theme.mSize(font).height           | Kirigami.Units.gridUnit                          |
| PlasmaCore.Units.largeSpacing                 | Kirigami.Units.gridUnit                          |
| PlasmaCore.Units.devicePixelRatio             | 1                                                |
| PlasmaCore.Units.roundtoIconSize(font height) | Kirigami.Units.iconSizes.sizeForLabels           |
| PlasmaCore.Units.roundtoIconSize(value)       | Kirigami.Units.iconSizes.roundedIconSize(value)  |
| PlasmaCore.Units.*anything else*              | Kirigami.Units.*the same thing*                  |
| PlasmaExtras.Heading                          | Kirigami.Heading                                 |
| PlasmaExtras.DescriptiveLabel                 | QtQuickControls2.Label with ``opacity: 0.7``     |
| PlasmaComponents3.Label                       | QtQuickControls2.Label                           |


Note: remember to add ``import org.kde.kirigami 2.20 as Kirigami`` in
files that don't have it yet

#### Port to KSvg

Everything regarding SVG theming has moved from Plasma Framework to a new framework called KSvg.
The API is compatible, but the import needs to be changed to:
```import org.kde.ksvg 1.0 as KSvg```

| Plasma 5                | Plasma 6          |
|-------------------------|-------------------|
| PlasmaCore.Svg          | KSvg.Svg          |
| PlasmaCore.SvgItem      | KSvg.SvgItem      |
| PlasmaCore.FrameSvgItem | KSvg.FrameSvgItem |

Also, even if the old syntax is still compatible, it's recommended to change:

```qml
KSvg.SvgItem {
    svg: KSvg.Svg {
        imagePath: "widgets/background"
    }
}
```

To the more compact form:

```qml
KSvg.SvgItem {
    imagePath: "widgets/background"
}
```

### New Actions API

Plasmoids can add contextual actions, which appear in their headers (when used in the System Tray) and context menus.

In Plasma 5 these actions were defined using an imperative API in ``Component.onCompleted:``, like so:

```qml
Component.onCompleted: {
    Plasmoid.clearActions()
    Plasmoid.setAction("previous", i18nc("Play previous track", "Previous Track"),
                        Qt.application.layoutDirection === Qt.RightToLeft ? "media-skip-forward" : "media-skip-backward");
    Plasmoid.action("previous").enabled = Qt.binding(() => root.canGoPrevious)
    Plasmoid.action("previous").visible = Qt.binding(() => root.canControl)
    Plasmoid.action("previous").priority = Plasmoid.LowPriorityAction
    ...
}

// Handling of actions then had to be done by adding "magic" functions:

function action_previous() {
  serviceOp(mpris2Source.current, "Previous");
}
```

This has been replaced with a purely declarative API, in the form of a new QML type
called ``PlasmaCore.Action`` and a ``contextualActions:`` list property on the ``Plasmoid``
item, where all the actions are declared with standard array syntax. The Plasma 6 version
of the above example can be rewritten as follows:

```qml
Plasmoid.contextualActions: [
    PlasmaCore.Action {
        text: i18nc("Play previous track", "Previous Track")
        icon.name: Qt.application.layoutDirection === Qt.RightToLeft ? "media-skip-forward" : "media-skip-backward"
        priority: Plasmoid.LowPriorityAction
        visible: root.canControl
        enabled: root.canGoPrevious
        onTriggered: serviceOp(mpris2Source.current, "Previous")
    },
    ...
]
```

This way, both property bindings and the code to be executed when the action is
activated are all defined inline in a declarative way inside the ``PlasmaCore.Action``
definition.

{{< readfile file="/content/docs/plasma/widget/snippet/plasma-doc-style.html" >}}
