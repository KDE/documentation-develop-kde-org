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

## Changes Overview
### Background Information
A plasmoid's base component is a C++ class called `Applet`, which is a `QObject`. Applets are contained in an Applet subclass called `Containment`, which manages the lifecycle of all of its applets. On Plasma Desktop, each screen has one containment which manages its desktop area, and another for each panel on that desktop.

The root of the QML part of a plasmoid is a C++ `QQuickItem` implementation called `AppletInterface`. If a plasmoid is also a `Containment`, then its base is a `ContainmentInterface`, which is a subclass of `AppletInterface`.

### How it worked in Plasma 5
In Plasma 5, `AppletInterface` exposed and wrapped most of the `Applet` API, plus some QtQuick-related additions. The root QML object of each plasmoid could be any QML Item, and the `AppletInterface` was accessed in QML via the `Plasmoid` attached property or the `plasmoid` (lowercase) context property.

The `Applet` base instance was usually not accessible, unless the plasmoid offered a C++ `Applet` plugin, in which case it was accessible via the property `Plasmoid.nativeInterface`.

### How it works in Plasma 6
In Plasma 6, `AppletInterface` and `Applet` have a more clear task separation. All the wrapper properties and methods from `AppletInterface` to `Applet` (and from `ContainmentInterface` to `Containment`) have been removed. `AppletInterface` and `ContainmentInterface` only offer QtQuick-specific API now.

The root QML object of a plasmoid is now required to be a `PlasmoidItem` which is the QML name for `AppletInterface`. If it is also a containment, it must be of type `ContainmentItem`, which is the QML name for `ContainmentInterface`. This approach is similar and consistent with the `ApplicationWindow` type for QML-based applications.

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
* Un-version your QML module imports. This is unnecessary in Qt6 and can cause bugs.

In addition, some changes to applets' metadata are needed. In Plasma 6, all plasmoids must use JSON metadata. You can convert your plasmoid's old-style .desktop file to the new-style .json file using the `desktoptojson` command line utility. Beyond the automatic desktop-to-json metadata conversion, a few manual  tweaks are also needed:

* Set `"X-Plasma-API-Minimum-Version": "6.0"` so that the system sees the plasmoid. Plasmoids without this key are assumed to only work with Plasma 5 and will not be mad available in the UI.
* Remove the `X-Plasma-MainScript` entry. In Plasma 6, `ui/main.qml` is always used as the entry point, so make sure that's the name of your "main" file.
* Remove the `X-Plasma-API` entry.

If you automatically converted the `metadata.json` from a `metadata.desktop`, the `KPlugin` section may still contain the `ServiceTypes` key.
This needs to be replaced by a `KPackageStructure` entry in the json's top level.

For example, the following `ServiceTypes` section must be reworked:

```json
{
    "ServiceTypes": [
        "Plasma/Applet"
    ]
}
```

into this `KPackageStructure` definition:

```json
{
    "KPackageStructure": "Plasma/Applet"
}
```

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
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid


PlasmoidItem {
    id: root
    // toolTipMainText is a direct property of root, title is a property of Plasmoid attached property
    toolTipMainText: i18n("This is %1", Plasmoid.title)
    fullRepresentation: Item { ... }
    compactRepresentation: Item { ... }
}
```

### Components to replace with others of same functionality

#### Things moved to Kirigami

The following things have been replaced by their Kirigami counterparts:

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
| PlasmaCore.IconItem                           | Kirigami.Icon                                    |
| PlasmaExtras.Heading                          | Kirigami.Heading                                 |

Note: remember to add ``import org.kde.kirigami as Kirigami`` in
files that don't have it yet

#### New KSvg framework

Everything regarding SVG theming has moved from Plasma Framework to a new framework called KSvg.

The API is compatible, with the exception of the ``colorGroup:`` property which
has been removed from KSvg because its functionality is now provided automatically.

The import needs to be changed to:
```import org.kde.ksvg as KSvg```

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

### New Plasma5Support library

Some parts of Plasma Framework have moved to Plasma5Support, such as types for the Data Engines system.

Their new import is:

```import org.kde.plasma.plasma5support as Plasma5Support```

| Plasma 5                | Plasma 6          |
|-------------------------|-------------------|
| PlasmaCore.DataSource   | Plasma5Support.DataSource          |
| PlasmaCore.DataModel      | Plasma5Support.DataModel      |

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


### PlasmaCore.SortFilterModel to KItemModels.KSortFilterProxyModel

The item ``SortFilterModel`` from the import ``org.kde.plasma.core`` has been removed.
Any usages of it should be ported to the ``KSortFilterProxyModel`` component which offers
the same functionality. You can import it using ``org.kde.kitemmodels``.

There are some key differences. While ``SortFilterModel`` has properties ``sortRole``
and ``filterRole`` that take strings as role names, ``KSortFilterProxyModel``
has the same two properties accepting only integers as the actual role values.
Usages of role names must be ported to the properties ``sortRoleName``
and ``filterRoleName`` (``sortRole`` and ``filterRole`` will automatically sync to the coresponding role number)

The ``filterRegExp`` property becomes ``filterRegularExpression`` which will have to be a ``RegExp()``
type, such as ```filterRegularExpression: RegExp(".*foo.+")```.

Another change in usage is ``filterCallback`` which becomes ``filterRowCallback`` and ``filterColumnCallback``
with a different API: the ``value`` parameter is gone, replaced by the parent index, from which the data of any role number can be extracted.

Example usage:

```qml
KItemModels.KSortFilterProxyModel {
    id: configDialogFilterModel
    sourceModel: ...
    filterRoleName: "name"
    filterRowCallback: (sourceRow, sourceParent) => {
        // filterRole will be the corresponding number for the role named the value set in filterRoleName
        let value = sourceModel.data(sourceModel.index(sourceRow, 0, sourceParent), filterRole);
        return value === "foo";
    }
}
```

### ExpandableListItem

- Rename property ``contextualActionsModel`` to ``contextualActions``.
- Properties ``iconUsesPlasmaSVG``, ``contextMenu`` and ``enabledActions`` are gone.
- Port ``isEnabled`` property to the standard ``enabled`` one.

{{< readfile file="/content/docs/plasma/widget/snippet/plasma-doc-style.html" >}}

### Configuration UI

If the plasmoid ships with a configuration UI this needs to be adjusted. The root item for a configuration page now must be one of the KCM components from the ``org.kde.kcmutils`` import.

Available are:
- ``SimpleKCM``: Use this for arbitrary content, e.g. a FormLayout or a column of controls. This will be the right thing for most applets.
- ``AbstractKCM``: Similar to SimpleKCM, but does not contain a ScrollView. Use this when you need control over where and how to use a ScrollView in the UI.
- ``ScrollViewKCM``: Use this when your configuration features a central ListView or similar view. Additional controls can be placed as ``header`` and ``footer`` of the control.
- ``GridViewKCM``: Use this when your configuration features a central GridView.

Example usage:

```qml
import QtQuick
import QtQuick.Controls
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {

    property var cfg_myConfigKey

    Kirigami.FormLayout {
        Button {
            ...
        }
    }
}

```
