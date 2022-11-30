---
title: "Widget Properties"
weight: 5
description: >
  A rundown of the QML Properties in a widget
---

## Plasmoid property group

As discussed in [the `main.qml` setup widget section]({{< ref "setup.md#contentsuimainqml" >}}), when you `import org.kde.plasma.plasmoid 2.0`, the main `Item` in your widget will have the `Plasmoid` (with a capital) property group similar to when you `import QtQuick.Layouts 1.0`. This `Plasmoid` [property group](https://doc.qt.io/qt-6/qtqml-syntax-objectattributes.html#grouped-properties) has properties from [`AppletInterface`](docs:plasma;AppletInterface) which inherits a few properties from [`PlasmaQuick::AppletQuickItem`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/plasmaquick/appletquickitem.h).


### Plasmoid properties

| Property | Type | Notes |
|-----|-----|-----|
| `Plasmoid.activationTogglesExpanded` | `bool` | Keyboard shortcut will toggle `Plasmoid.expanded`. [Since KDE Frameworks 5.76](https://invent.kde.org/frameworks/plasma-framework/-/commit/d6a5b10b3b9a4984209f6509a3ed9196b0c1d5d6), this is `true` by default. |
| `Plasmoid.apiVersion` | `int` | **Due not use.** Always returns `0`. [Source code](https://invent.kde.org/frameworks/plasma-framework/-/blob/9131ac91e73f8096d5c687985c5840c6e12e5ade/src/scriptengines/qml/plasmoid/appletinterface.cpp#L555-568). |
| `Plasmoid.associatedApplication` | `string` |  |
| `Plasmoid.associatedApplicationUrls` | `QList<QUrl>` |  |
| `Plasmoid.availableScreenRect` | [`rect`](https://doc.qt.io/qt-5/qml-rect.html) |  |
| `Plasmoid.availableScreenRegion` | `QVariantList` |  |
| `Plasmoid.backgroundHints` | [`Plasma::Types::BackgroundHints`](docs:plasma;Plasma::Types::BackgroundHints) | [Documentation](#plasmoidbackgroundhints). Turn off the desktop widget bg. |
| `Plasmoid.busy` | `bool` | Draw the [`BusyIndicator`](#busyindicator) overtop the widget. |
| `Plasmoid.compactRepresentation` | [`Component`](https://doc.qt.io/qt-6/qml-qtqml-component.html) | [Documentation](#plasmoidcompactrepresentation). The smaller "icon" view view of the widget shown in the panel. |
| `Plasmoid.compactRepresentationItem` | [`Item`](https://doc.qt.io/qt-6/qml-qtquick-item.html) | The instance of the `compactRepresentation` Component. May be `null` on load if not visible. |
| `Plasmoid.configuration` | [`KDeclarative::ConfigPropertyMap`](docs:kdeclarative;KDeclarative::ConfigPropertyMap) | [Documentation](#plasmoidconfiguration). Provides access to all user configurable values as sub-properties. |
| `Plasmoid.configurationRequired` | `bool` | Wither to show a Configure button on top of the compact/full representation. It may look better to create your own button that calls `plasmoid.action("configure").trigger()`. |
| `Plasmoid.configurationRequiredReason` | `string` | Not currently implemented to do anything. |
| `Plasmoid.constraintHints` | [`Plasma::Types::ConstraintHints`](docs:plasma;Plasma::Types::ConstraintHints) |  |
| `Plasmoid.containmentDisplayHints` | [`Plasma::Types::ContainmentDisplayHints`](docs:plasma;Plasma::Types::ContainmentDisplayHints) |  |
| `Plasmoid.contextualActions` | `QList<QObject*>` |  |
| `Plasmoid.currentActivity` | `string` |  |
| `Plasmoid.editMode` | `bool` |  |
| `Plasmoid.effectiveBackgroundHints` | [`Plasma::Types::BackgroundHints`](docs:plasma;Plasma::Types::BackgroundHints) |  |
| `Plasmoid.expanded` | `bool` |  |
| `Plasmoid.formFactor` | [`Plasma::Types::FormFactor`](docs:plasma;Plasma::Types::FormFactor) |  |
| `Plasmoid.fullRepresentation` | [`Component`](https://doc.qt.io/qt-6/qml-qtqml-component.html) | [Documentation](plasmoidfullrepresentation). The full "popup" view of the widget. |
| `Plasmoid.fullRepresentationItem` | [`Item`](https://doc.qt.io/qt-6/qml-qtquick-item.html) | The instance of the `fullRepresentation` Component. Since widget popup's a lazy loaded, it is `null` until the popup is opened. |
| `Plasmoid.globalShortcut` | [`QKeySequence`](https://doc.qt.io/qt-5/qkeysequence.html) |  |
| `Plasmoid.hideOnWindowDeactivate` | `bool ` |  |
| `Plasmoid.icon` | `string` | [Example](#plasmoidicon) |
| `Plasmoid.id` | `uint` |  |
| `Plasmoid.immutability` | [`Plasma::Types::ImmutabilityType`](docs:plasma;Plasma::Types::ImmutabilityType) | Detect if Kiosk mode has locked the widgets, or the user Lock Widget mode from Plasma 5.18 and below. |
| `Plasmoid.immutable` | `bool` | `true` if either `UserImmutable` or `SystemImmutable`. |
| `Plasmoid.loading` | `bool` | Always `false` when widget is running. |
| `Plasmoid.location` | [`Plasma::Types::Location`](docs:plasma;Plasma::Types::Location) | Location of widget on the screen. |
| `Plasmoid.metaData` | [`KPluginMetaData`](docs:kcoreaddons;KPluginMetaData) | Reads `metadata.json` (or `metadata.desktop`). See the [`AboutPlugin.qml` source code](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/desktoppackage/contents/configuration/AboutPlugin.qml) for examples. |
| `Plasmoid.metaData.authors` | `QVariantList` |  |
| `Plasmoid.metaData.category` | `string` |  |
| `Plasmoid.metaData.copyrightText` | `string` |  |
| `Plasmoid.metaData.dependencies` | `QStringList` |  |
| `Plasmoid.metaData.description` | `string` |  |
| `Plasmoid.metaData.extraInformation` | `string` |  |
| `Plasmoid.metaData.fileName` | `string` |  |
| `Plasmoid.metaData.formFactors` | `QStringList` |  |
| `Plasmoid.metaData.iconName` | `string` |  |
| `Plasmoid.metaData.initialPreference` | `int` |  |
| `Plasmoid.metaData.isEnabledByDefault` | `bool` |  |
| `Plasmoid.metaData.isHidden` | `bool` |  |
| `Plasmoid.metaData.isValid` | `bool` |  |
| `Plasmoid.metaData.license` | `string` |  |
| `Plasmoid.metaData.licenseText` | `string` |  |
| `Plasmoid.metaData.metaDataFileName` | `string` |  |
| `Plasmoid.metaData.mimeTypes` | `QStringList` |  |
| `Plasmoid.metaData.name` | `string` | The translated widget `Name`. Also see `Plasmoid.title` |
| `Plasmoid.metaData.otherContributors` | `QVariantList` |  |
| `Plasmoid.metaData.pluginId` | `string` | The widget namespace. `Id` in `metadata.json`, or `X-KDE-PluginInfo-Name` in `metadata.desktop`. |
| `Plasmoid.metaData.rawData` | `QJsonObject` |  |
| `Plasmoid.metaData.serviceTypes` | `QStringList` |  |
| `Plasmoid.metaData.translators` | `QVariantList` |  |
| `Plasmoid.metaData.version` | `string` | Reads `Version` in `metadata.json` or `X-KDE-PluginInfo-Version` in `metadata.desktop`. |
| `Plasmoid.metaData.website` | `string` |  |
| `Plasmoid.nativeInterface` | `QObject` |  |
| `Plasmoid.pluginName` | `string` | The widget namespace. Alias of `Plasmoid.metaData.pluginId` |
| `Plasmoid.preferredRepresentation` | [`Component`](https://doc.qt.io/qt-6/qml-qtqml-component.html) | Force a representation and ignore `Plasmoid.switchHeight`. [Example](#plasmoidfullrepresentation) |
| `Plasmoid.rootItem` | `QObject` | Reference the widget's root item. Cannot be used in the config dialog. |
| `Plasmoid.screen` | `int` |  |
| `Plasmoid.screenGeometry` | [`rect`](https://doc.qt.io/qt-5/qml-rect.html) |  |
| `Plasmoid.self` | `AppletInterface` |  |
| `Plasmoid.status` | [`Plasma::Types::ItemStatus`](docs:plasma;Plasma::Types::ItemStatus) |  |
| `Plasmoid.switchHeight` | `int` | The minimum height required to switch to `fullRepresentation`. |
| `Plasmoid.switchWidth` | `int` | The minimum width required to switch to `fullRepresentation`. |
| `Plasmoid.title` | `string` | The translated widget name. |
| `Plasmoid.toolTipItem` | [`Item`](https://doc.qt.io/qt-6/qml-qtquick-item.html) |  |
| `Plasmoid.toolTipMainText` | `string` | The mainText in the default tooltip layout. |
| `Plasmoid.toolTipSubText` | `string` | The subText in the default tooltip layout. |
| `Plasmoid.toolTipTextFormat` | `int` | The [`TextFormat`](https://doc.qt.io/qt-5/qml-qtquick-text.html#textFormat-prop) of the subText. Defaults to `PlainText`. |
| `Plasmoid.userBackgroundHints` | [`Plasma::Types::BackgroundHints`](docs:plasma;Plasma::Types::BackgroundHints) |  |
| `Plasmoid.userConfiguring` | `bool` |  |


### plasmoid context property

You can reference a property from the `Plasmoid.___` property group by the root `Item { id: widget }` of the widget with `widget.Plasmoid.___`. An easier method is to use the global context property `plasmoid` (lowercase) which is [dynamically defined at runtime](https://invent.kde.org/frameworks/plasma-framework/-/blob/ca97fada4215df0aa1725578c160df9105a4c2e2/src/plasmaquick/appletquickitem.cpp#L644) when the property group is imported.

<div class="filepath">contents/ui/main.qml</div>

```qml
import QtQuick 2.0
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.plasmoid 2.0
Item {
    id: widget
    Plasmoid.icon: 'starred-symbolic'
    Plasmoid.fullRepresentation: PlasmaComponents3.Label {
        text: plasmoid.icon
        // OR
        // text: widget.Plasmoid.icon
    }
}
```


### Plasmoid.compactRepresentation

The compact representation uses [`DefaultCompactRepresentation.qml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/desktoppackage/contents/applet/DefaultCompactRepresentation.qml) by default. To summarize, it:

* Draws the `plasmoid.icon` using a [`PlasmaCore.IconItem`](docs:plasma;IconItem)
* Defines a [`MouseArea`](https://doc.qt.io/qt-5/qml-qtquick-mousearea.html) to toggle the `expanded` property which displays the full representation.


https://invent.kde.org/plasma/plasma-desktop/-/blob/master/desktoppackage/contents/applet/CompactApplet.qml


### Plasmoid.fullRepresentation

{{< sections >}}
{{< section-left >}}

If there's enough room (more than [`Plasmoid.switchHeight`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/plasmaquick/appletquickitem.h#L49-50)) then the widget's full representation can be drawn directly in the panel or on the desktop. If you want to force this behaviour you can set [`Plasmoid.preferredRepresentation`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/plasmaquick/appletquickitem.h#L58-61).

```qml
Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
```

If there isn't enough room, then the widget will display `Plasmoid.compactRepresentation` instead, and the full representation will be visible when [`plasmoid.expanded`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/plasmaquick/appletquickitem.h#L63-67) is `true`.

In a plasma widget, the full representation will be shown in a [`PlasmaCore.Dialog`](docs:plasma;PlasmaQuick::Dialog) which you cannot access directly. You can manipulate the dialog with:

* Set `Layout.preferredWidth` and `Layout.preferredHeight` in your full representation `Item` to change to dialog size.
* Set `Plasmoid.hideOnWindowDeactivate` to prevent the dialog from closing. You can use this to have a configurable "pin" [like the digital clock widget does](https://invent.kde.org/plasma/plasma-workspace/-/blob/333e8ef54733bb764d6cebf4b03ab794d139684c/applets/digital-clock/package/contents/ui/CalendarView.qml#L240-244).

The dialog's source code can be found in [`CompactApplet.qml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/desktoppackage/contents/applet/CompactApplet.qml) to see the exact behavior.

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
{{< readfile file="/content/docs/extend/plasma/widget/snippet/popup-size.qml" >}}
```

{{< /section-right >}}
{{< /sections >}}


### Plasmoid.icon

{{< sections >}}
{{< section-left >}}

As mentioned in [the setup widget `metadata.json` section]({{< ref "setup.md#metadatajson" >}}), by default the plasmoid icon is populated with the `Icon` value in `metadata.json`.

To set a dynamic or user configurable icon, you will need to assign an icon name to `Plasmoid.icon`.

You can search for icon names in the `/usr/share/icon` folder. You can also look for an icon name by right clicking your app launcher widget then editing the icon in its settings. It uses a searchable interface and lists them by category. Plasma's SDK also has the Cuttlefish app ([screenshot](https://cdn.kde.org/screenshots/cuttlefish/cuttlefish.png)) which you can install with `sudo apt install plasma-sdk`.

Also checkout the [configurable panel icon example]({{< ref "examples.md#configurable-icon" >}})

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0

Item {
    id: widget
    property bool hasUnread: true
    Plasmoid.icon: hasUnread ? "mail-unread" : "mail-message"

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: widget.hasUnread = !widget.hasUnread
    }
}
```
{{< /section-right >}}
{{< /sections >}}


### Plasmoid.configuration

{{< sections >}}
{{< section-left >}}

This property provides access to the values user configurable values. You can easily access config values with `plasmoid.configuration.varName`. By default it populates with the keys and values in `config/main.xml`. You can easily write to `plasmoid.configuration.varName = "value"` to change the value for the user.

Read more about configuration and the config dialog in [it's section of the tutorial]({{< ref "configuration.md" >}}).

The user's configuration is serialized to `~/.config/plasma-org.kde.plasma.desktop-appletsrc` when the `plasmashell` process terminates and is only loaded at startup.

Since: **KDE Frameworks 5.78**, you can reference the default value of `plasmoid.configuration.varName` with  `plasmoid.configuration.varNameDefault`.

Note: Since **KDE Frameworks 5.89**, the [`KDeclarative::ConfigPropertyMap`](docs:kdeclarative;KDeclarative::ConfigPropertyMap) datatype [was deprecated](https://invent.kde.org/frameworks/plasma-framework/-/commit/6750b75bf02e420630144f2ea1d3f9940a85c0ba) and will eventually change to KConfig's [`KConfigPropertyMap`](docs:kconfig;KConfigPropertyMap).

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
import QtQuick 2.0
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.plasmoid 2.0

RowLayout {
    id: widget
    PlasmaComponents.Label {
        text: i18np("%1 Click", "%1 Clicks", plasmoid.configuration.numClicked)
    }
    PlasmaComponents3.Button {
        icon.name: "value-increase-symbolic"
        text: i18n("Add")
        onClicked: plasmoid.configuration.numClicked += 1
    }
}
```
{{< /section-right >}}
{{< /sections >}}


### Plasmoid.backgroundHints

{{< sections >}}
{{< section-left >}}

* `PlasmaCore.Types.DefaultBackground` **(default)** is equal to `StandardBackground`.
* `PlasmaCore.Types.StandardBackground` The standard background from the theme is drawn.  
  ![](backgroundhint-standard.png)
* `PlasmaCore.Types.TranslucentBackground` An alternate version of the background is drawn, usually more translucent.
* `PlasmaCore.Types.ShadowBackground` The applet won't have a svg background but a drop shadow of its content done via a shader. The text color will also invert.
  ![](backgroundhint-shadow.png)
* `PlasmaCore.Types.NoBackground` This property is used to hide a desktop widget background. An example would be [the Analog Clock widget](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/applets/analog-clock/contents/ui/analogclock.qml#L34).  
  ![](backgroundhint-nobg.png)
* `PlasmaCore.Types.ConfigurableBackground` Allows the user to toggle between `StandardBackground` and `ShadowBackground`. Note that this is a bit flag to be used with another enum value.  
  ![](backgroundhint-toggle.png)

To use `ConfigurableBackground`, combine the flag with another value with the bitwise OR operator `|`.

```qml
PlasmaCore.Types.NoBackground | PlasmaCore.Types.ConfigurableBackground
```

Note: For `ShadowBackground`, make sure you use `PlasmaCore.ColorScope.colorGroup` in your `IconItem` to have the symbolic icons follow the text color.

```qml
PlasmaCore.IconItem {
    colorGroup: PlasmaCore.ColorScope.colorGroup
}
```

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
import QtQuick 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {
    id: widget
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground
}
```

---

<div class="filepath">contents/ui/main.qml</div>

```qml
import QtQuick 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents3
import org.kde.plasma.plasmoid 2.0

Item {
    id: widget
    Plasmoid.icon: 'starred-symbolic'
    Plasmoid.backgroundHints: PlasmaCore.Types.StandardBackground | PlasmaCore.Types.ConfigurableBackground
    // Plasmoid.backgroundHints: PlasmaCore.Types.ShadowBackground | PlasmaCore.Types.ConfigurableBackground
    // Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground | PlasmaCore.Types.ConfigurableBackground

    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    Plasmoid.fullRepresentation: RowLayout {
        PlasmaCore.IconItem {
            source: plasmoid.icon
            colorGroup: PlasmaCore.ColorScope.colorGroup
            Layout.fillHeight: true
            Layout.preferredWidth: height
        }
        PlasmaComponents3.Label {
            text: "Text"
            font.pointSize: 30
        }
    }
}

```
{{< /section-right >}}
{{< /sections >}}


## metadata.json

The common `metadata.json` properties are covered in the [setup widget section]({{< ref "setup.md#metadatajson" >}}).

`metadata.desktop` is the older format while `metadata.json` is the newer replacement format. The `.desktop` file is simpler to script using `kreadconfig5` which is the reason why this tutorial prefers it in certain places like translations.

You can read the generated [C++ API Documentation for `metadata.json`](docs:kcoreaddons;KPluginMetaData) for the json schema. The full list of properties for the older `metadata.desktop` properties for widgets is defined in the [`Plasma/Applet` service type](
https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/plasma/data/servicetypes/plasma-applet.desktop).

### Name, Description

{{< sections >}}
{{< section-left >}}

These two are based on the standard [XDG desktop file](https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s06.html) properties. You can also translate these properties with `Name[fr]`. The translated `Name` is used in the "Add Widgets" list. The `Description` (previously known as `Comment` in the `metadata.desktop`) is only used for the default tooltip subtext when the widget is added to a panel.

{{< /section-left >}}
{{< section-right >}}

<div class="filepath">metadata.json</div>

```json
{
    "KPlugin": {
        "Description": "Month display with your appointments and events",
        "Description[fr]": "Vue mensuelle avec vos rendez-vous et évènements",
        "Name": "Calendar",
        "Name[fr]": "Calendrier"
    }
}
```

<div class="filepath">metadata.desktop</div>

```ini
[Desktop Entry]
Name=Calendar
Name[fr]=Calendrier
Comment=Month display with your appointments and events
Comment[fr]=Vue mensuelle avec vos rendez-vous et évènements
```
{{< /section-right >}}
{{< /sections >}}

### Icon

{{< sections >}}
{{< section-left >}}

`Icon` is the icon name associated with the widget. You can search for icon names in the `/usr/share/icon` folder. You can also look for an icon name by right clicking your app launcher widget then editing the icon in its settings. It uses a searchable interface and lists them by category. Plasma's SDK also has the Cuttlefish app which you can install with `sudo apt install plasma-sdk`.

{{< /section-left >}}
{{< section-right >}}

<div class="filepath">metadata.json</div>

```json
{
    "KPlugin": {
        "Icon": "office-calendar",
    }
}
```

<div class="filepath">metadata.desktop</div>

```ini
[Desktop Entry]
Icon=office-calendar
```

![](https://cdn.kde.org/screenshots/cuttlefish/cuttlefish.png)

{{< /section-right >}}
{{< /sections >}}


### Id


{{< sections >}}
{{< section-left >}}

The `Id` (or `X-KDE-PluginInfo-Name` in `metadata.desktop`) needs to be a unique name, since it's used for the folder name it's installed into. You could use `com.github.zren.helloworld` if you're on github, or use `org.kde.plasma.helloworld` if you are planning on contributing the widget to KDE. You should consider this the widget's namespace.


{{< /section-left >}}
{{< section-right >}}
```
~/.local/share/plasma/plasmoids/com.github.zren.helloworld/
/usr/share/plasma/plasmoids/com.github.zren.helloworld/
```

<div class="filepath">metadata.json</div>

```json
{
    "KPlugin": {
        "Id": "org.kde.plasma.calendar",
    }
}
```

<div class="filepath">metadata.desktop</div>

```ini
[Desktop Entry]
X-KDE-PluginInfo-Name=org.kde.plasma.calendar
```

{{< /section-right >}}
{{< /sections >}}

### Category

The `Category` (or `X-KDE-PluginInfo-Category` in `metadata.desktop`) is used to filter widgets in the widget list.

<div class="filepath">metadata.json</div>

```json
{
    "KPlugin": {
        "Category": "Date and Time",
    }
}
```

<div class="filepath">metadata.desktop</div>

```ini
[Desktop Entry]
X-KDE-PluginInfo-Category=Date and Time
```

* `Accessibility`: tools that help those with special needs or disabilities use their computer
* `Application Launchers`: application starters and file openers.
* `Astronomy`: anything to do with the night sky or other celestial bodies.
* `Date and Time`: clocks, calendars, scheduling, etc
* `Development Tools`: tools and utilities to aid software developers
* `Education`: teaching and educational aides
* `Environment and Weather`: add-ons that display information regarding the weather or other environmentally related data
* `Examples`: samples that are not meant for production systems
* `File System`: anything that operates on files or the file system as its primary purpose, such as file watchers or directory listings. Simply using a file as storage does not qualify the add-on for this category.
* `Fun and Games`: for games and amusements
* `Graphics`: for add-ons where displaying images, photos or graphical eye candy is the primary purpose
* `Language`: add-ons whose primary purpose is language related, such as dictionaries and translators.
* `Mapping`: geography and geographic data add-ons
* `Multimedia`: music and video.
* `Online Services`: add-ons that provide an interface to online services such as social networking or blogging sites. If there is another more appropriate category for the add-on given the topic (e.g. mapping if the applet's purpose is to show maps), even if the data is retrieved from the Internet prefer that other category over this one.
* `System Information`: display and interaction with information about the computer such as network activity, hardware health, memory usage, etc
* `Utilities`: Useful tools like calculators
* `Windows and Tasks`: managers for application windows and/or tasks, such as taskbars

This list was taken from: <https://techbase.kde.org/Projects/Plasma/PIG>


### ServiceTypes

{{< sections >}}
{{< section-left >}}

`ServiceTypes` (or `X-KDE-ServiceTypes` in `metadata.desktop`) is a comma-separated list of types. For a plasma widget, it should be `Plasma/Applet`. You may encounter widgets with `Plasma/Containment` as well, like [the System Tray widget](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/applets/systemtray/package/metadata.json#L147).

The defined plasma service types and their custom `.desktop` file properties are found in:  
[`plasma-framework/src/plasma/data/servicetypes`](https://invent.kde.org/frameworks/plasma-framework/-/tree/master/src/plasma/data/servicetypes)

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">metadata.json</div>

```json
{
    "KPlugin": {
        "ServiceTypes": [
            "Plasma/Applet"
        ]
    }
}
```

<div class="filepath">metadata.desktop</div>

```ini
[Desktop Entry]
X-KDE-ServiceTypes=Plasma/Applet
```
{{< /section-right >}}
{{< /sections >}}

### X-Plasma-API, X-Plasma-MainScript

{{< sections >}}
{{< section-left >}}

`X-Plasma-API` tells plasma what script engine to use. `declarativeappletscript` is the standard `QML` loader.

`X-Plasma-MainScript` is the entry point of your qml code. The standard throughout plasma is to use `ui/main.qml`.

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">metadata.json</div>

```json
{
    "X-Plasma-API": "declarativeappletscript",
    "X-Plasma-MainScript": "ui/main.qml"
}
```

<div class="filepath">metadata.desktop</div>

```ini
[Desktop Entry]
X-Plasma-API=declarativeappletscript
X-Plasma-MainScript=ui/main.qml
```
{{< /section-right >}}
{{< /sections >}}


### X-Plasma-Provides (Alternatives)

A Plasmoid can specify the type of functionality it offers, for example whether it's a clock, an application launcher, etc. This mechanism is used to list alternative plasmoids for a certain function. When you open the context menu of the Application Launcher (aka kickoff) in the Plasma desktop panel, you'll see that a number of different Plasmoids are offered here as alternatives, like the Application Menu (aka kicker) and Application Dashboard (aka kickerdash). All three of these widgets define:

<div class="filepath">metadata.json</div>

```json
{
    "X-Plasma-Provides": [
        "org.kde.plasma.launchermenu"
    ]
}
```

<div class="filepath">metadata.desktop</div>

```ini
[Desktop Entry]
X-Plasma-Provides=org.kde.plasma.launchermenu
```

These "Provides" are in fact arbitrary, so you can choose your own here. The field accepts multiple values separated by a comma. Here are some possible values that are used throughout Plasma: 

* `org.kde.plasma.launchermenu`: App Launcher Menus
* `org.kde.plasma.multimediacontrols`: Multimedia controls
* `org.kde.plasma.time`: Clocks
* `org.kde.plasma.date`: Calendars
* `org.kde.plasma.time,org.kde.plasma.date`: Clocks with calendars ([Eg: Digital Clock](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/applets/digital-clock/package/metadata.json#L197))
* `org.kde.plasma.powermanagement`: Power management ([Eg: Battery and Brightness](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/applets/batterymonitor/package/metadata.json#L222))
* `org.kde.plasma.notifications`: Notifications
* `org.kde.plasma.removabledevices`: Removable devices, auto mounter, etc.
* `org.kde.plasma.multitasking`: Task switchers
* `org.kde.plasma.virtualdesktops`: Virtual desktop switcher
* `org.kde.plasma.activities`: Switchers for Plasma activities
* `org.kde.plasma.trash`: Trash / file deletion

You can search plasma's code for more examples:

* [Search `plasma-workspace` for `X-Plasma-Provides`](https://invent.kde.org/search?utf8=%E2%9C%93&search=X-Plasma-Provides&group_id=1568&project_id=2703&scope=&search_code=true&snippets=false&repository_ref=master&nav_source=navbar)
* [Search `plasma-desktop` for `X-Plasma-Provides`](https://invent.kde.org/search?utf8=%E2%9C%93&search=X-Plasma-Provides&group_id=1568&project_id=2802&scope=&search_code=true&snippets=false&repository_ref=master&nav_source=navbar)
* [Search `kdeplasma-addons` for `X-Plasma-Provides`](https://invent.kde.org/search?utf8=%E2%9C%93&search=X-Plasma-Provides&group_id=1568&project_id=2828&scope=&search_code=true&snippets=false&repository_ref=master&nav_source=navbar)



### X-Plasma-NotificationArea (System Tray)

The Media Controller widget serves as a good example since it uses most of the systemtray metadata features. [Its metadata contains](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/applets/mediacontroller/metadata.json) the following:

<div class="filepath">metadata.json</div>

```json
{
    "KPlugin": {
        "EnabledByDefault": true
    },
    "X-Plasma-DBusActivationService": "org.mpris.MediaPlayer2.*",
    "X-Plasma-NotificationArea": "true",
    "X-Plasma-NotificationAreaCategory": "ApplicationStatus"
}
```

<div class="filepath">metadata.desktop</div>

```ini
[Desktop Entry]
X-KDE-PluginInfo-EnabledByDefault=true
X-Plasma-NotificationArea=true
X-Plasma-NotificationAreaCategory=ApplicationStatus
X-Plasma-DBusActivationService=org.mpris.MediaPlayer2.*
```

By specifying `X-Plasma-NotificationArea`, this widget will be found by the systemtray widget.

`EnabledByDefault` will make sure it's enabled in the systemtray by default.

It's prudent for the widget to also set the `X-Plasma-NotificationAreaCategory` so that the icons are grouped together. Its allowed values are:

* `ApplicationStatus`: indicates that this item represents an active application
* `Hardware`: indicates that this item allows managing hardware (could be a battery monitor or the wifi applet)
* `SystemServices`: indicates that this item shows information about system services, for example the status of file indexing, software updates, etc.

You can search plasma's code for more examples:

* [Search `plasma-workspace` for `X-Plasma-NotificationArea`](https://invent.kde.org/search?utf8=%E2%9C%93&search=X-Plasma-NotificationArea&group_id=1568&project_id=2703&scope=&search_code=true&snippets=false&repository_ref=master&nav_source=navbar)
* [Search `plasma-desktop` for `X-Plasma-NotificationArea`](https://invent.kde.org/search?utf8=%E2%9C%93&search=X-Plasma-NotificationArea&group_id=1568&project_id=2802&scope=&search_code=true&snippets=false&repository_ref=master&nav_source=navbar)
* [Search `kdeplasma-addons` for `X-Plasma-NotificationArea`](https://invent.kde.org/search?utf8=%E2%9C%93&search=X-Plasma-NotificationArea&group_id=1568&project_id=2828&scope=&search_code=true&snippets=false&repository_ref=master&nav_source=navbar)


### X-Plasma-DBusActivationService

`X-Plasma-DBusActivationService` will load and unload widgets in the systemtray automatically when a DBus service becomes available or is stopped. This is very convenient to load widgets automatically, so the user doesn't have to explicitly go to the notification area settings and enable or remove a widget.

An example of this is the Media Controller widget, which is auto-loaded as soon as an application starts offering the `org.mpris.MediaPlayer2` DBus service in the session. As you can see [in its `metadata.json` file](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/applets/mediacontroller/metadata.json#L167), `X-Plasma-DBusActivationService` accepts wildcards which makes it a bit easier to match DBus names. This key can also be very useful to avoid having a widget loaded when it's unnecessary, so it can help to avoid visual clutter and wasted memory.

<div class="filepath">metadata.json</div>

```json
{
    "X-Plasma-DBusActivationService": "org.mpris.MediaPlayer2.*"
}
```

<div class="filepath">metadata.desktop</div>

```ini
[Desktop Entry]
X-Plasma-DBusActivationService=org.mpris.MediaPlayer2.*
```

[Search `plasma-workspace` for `X-Plasma-DBusActivationService`](https://invent.kde.org/search?utf8=%E2%9C%93&search=X-Plasma-DBusActivationService&group_id=1568&project_id=2703&scope=&search_code=true&snippets=false&repository_ref=master&nav_source=navbar) for more examples.




{{< readfile file="/content/docs/extend/plasma/widget/snippet/code-filepath.html" >}}
<style>
.td-content > table td:nth-child(1) code,
.td-content > table td:nth-child(2) code {
    background: none;
    border: none;
    color: inherit;
    font-size: 100%;
}
</style>
