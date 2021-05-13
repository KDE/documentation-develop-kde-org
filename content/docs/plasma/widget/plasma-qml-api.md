---
title: "Plasma's QML API"
weight: 4
description: >
  A rundown of the QML types shipped in KDE Frameworks
---

## Intro

KDE Frameworks ships with a number of useful extensions to Qt's QML. The [API documentation](docs:plasma) is a good start if you need to know what a specific property does. If you want to browse any of the sources easier, it's also [available on GitLab](https://invent.kde.org/frameworks/plasma-framework/-/tree/master/src/declarativeimports).


## PlasmaComponents Controls

QML ships with various controls, like [CheckBox](docs:qtquickcontrols;Checkbox), [RadioButton](docs:qtquickcontrols;RadioButton), [ComboBox](docs:qtquickcontrols;Combobox) (dropdown menu), [SpinBox](docs:qtquickcontrols;Spinbox), [Slider](docs:qtquickcontrols;Slider), [TextField](docs:qtquickcontrols;TextField), [TextArea](docs:qtquickcontrols;TextArea), [Button](docs:qtquickcontrols;Button), [ToolButton](docs:qtquickcontrols;ToolButton). Plasma extends these controls to style them using the SVGs from the [Plasma Theme](https://techbase.kde.org/Development/Tutorials/Plasma5/ThemeDetails). It also assigns a number of default settings like setting the text color to follow the panel's color scheme.

PlasmaComponents 3 is a QML library that extends the [Qt Quick Controls 2 components](https://doc.qt.io/qt-5/qtquickcontrols-index.html) with defaults adapted to fit into Plasma widgets. Because PlasmaComponents 3 inherits from Qt Quick Controls 2, they have the same API, so the [Qt documentation](https://doc.qt.io/qt-5/qtquickcontrols-index.html) can be followed. For Plasma's specific behaviour changes, you can read the QML source code for each control in:

[`plasma-framework`/src/declarativeimports/plasmacomponents3/](https://invent.kde.org/frameworks/plasma-framework/-/tree/master/src/declarativeimports/plasmacomponents3)

You may see leftover imports to PlasmaComponents 2 in some widgets. It uses the older [Qt Quick Controls 1](https://doc.qt.io/qt-5/qtquickcontrols1-index.html) components which are deprecated. The source code for the older controls can also be found in the `plasma-frameworks` repo:

[`plasma-framework`/src/declarativeimports/plasmacomponents/qml/](https://invent.kde.org/frameworks/plasma-framework/-/tree/master/src/declarativeimports//plasmacomponents/qml)


### Label

{{< sections >}}
{{< section-left >}}
[Labels](docs:qtquickcontrols;Label) are used for displaying text to the user.
Plasma's Label are assigned a number of defaults. One thing
is it sets the text color to follow the panel's color scheme.

For the specifics, you can read the [`Label.qml` source code](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/Label.qml).
{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import org.kde.plasma.components 3.0 as PlasmaComponents3

PlasmaComponents3.Label {
    text: i18n("Hello World")
}
```
{{< /section-right >}}
{{< /sections >}}


### CheckBox - Toggle

{{< sections >}}
{{< section-left >}}
For a simple toggle, QML ships with [CheckBox](docs:qtquickcontrols;CheckBox). For Plasma's specific changes, you can read the QML source code at:

* [`CheckBox.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/CheckBox.qml)

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import org.kde.plasma.components 3.0 as PlasmaComponents3

PlasmaComponents3.CheckBox {
    text: i18n("Hello World")
    checked: true
}
```
{{< /section-right >}}
{{< /sections >}}


### RadioButton - Multiple Choice

{{< sections >}}
{{< section-left >}}
For mutiple choices, QML ships with [RadioButton](docs:qtquickcontrols;RadioButton). For Plasma's specific changes, you can read the QML source code at:

* [`RadioButton.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/RadioButton.qml)

Note the [KDE Human Interface Guidelines](/hig/components/editing/radiobutton) suggest using a ComboBox (dropdown menu) when your list is greater than 5 options.

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 3.0 as PlasmaComponents3

ColumnLayout {
    PlasmaComponents3.RadioButton {
        text: i18n("Top")
        checked: true
        autoExclusive: true
    }
    PlasmaComponents3.RadioButton {
        text: i18n("Bottom")
        autoExclusive: true
    }
}
```
{{< /section-right >}}
{{< /sections >}}


### ComboBox - Multiple Choice

{{< sections >}}
{{< section-left >}}

For mutiple choices, QML also ships with [ComboBox](docs:qtquickcontrols;Combobox) (dropdown menu). For Plasma's specific changes, you can read the QML source code at:

* [`ComboBox.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/ComboBox.qml)

Note that [`ComboBox.valueRole`](lhttps://doc.qt.io/qt-5/qml-qtquick-controls2-combobox.html#valueRole-prop) and [`ComboBox.currentValue`](https://doc.qt.io/qt-5/qml-qtquick-controls2-combobox.html#currentValue-prop) was introduced in Qt 5.14. [Ubuntu 20.04 only has Qt 5.12](https://repology.org/project/qt/versions) so you will need to use the following properties until Ubuntu 22.04. Make sure to not define a `currentValue` property or it will break when your users upgrade to Qt 5.14.

```
PlasmaComponents3.ComboBox {
    textRole: "text"
    property string _valueRole: "value"
    readonly property var _currentValue: _valueRole && currentIndex >= 0 ? model[currentIndex][_valueRole] : null
}
```

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import org.kde.plasma.components 3.0 as PlasmaComponents3

PlasmaComponents3.ComboBox {
    textRole: "text"
    valueRole: "value"
    model: [
        { value: "a", text: i18n("A") },
        { value: "b", text: i18n("B") },
        { value: "c", text: i18n("C") },
    ]
}
```
{{< /section-right >}}
{{< /sections >}}


### Slider - Numbers

{{< sections >}}
{{< section-left >}}

To control Integer or Real numbers, QML ships with [Spinbox](docs:qtquickcontrols;Spinbox) and [Slider](docs:qtquickcontrols;Slider). For Plasma's specific changes, you can read the QML source code at:

* [`Slider.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/Slider.qml)

See the [KDE Human Interface Guidelines](/hig/components/editing/slider) to determine wither to use a Slider or a SpinBox.

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.4
import QtQuick.Layouts 1.0
import org.kde.plasma.components 3.0 as PlasmaComponents3

RowLayout {
    PlasmaComponents3.Slider {
        id: slider
        Layout.fillWidth: true
        from: 0
        to: 100
        value: 50
        stepSize: 5
    }
    PlasmaComponents3.Label {
        id: sliderValueLabel
        function formatText(value) {
            return i18n("%1%", value)
        }
        text: formatText(slider.value)

        TextMetrics {
            id: textMetrics
            font.family: sliderValueLabel.font.family
            font.pointSize: sliderValueLabel.font.pointSize
            text: sliderValueLabel.formatText(slider.to)
        }
        Layout.minimumWidth: textMetrics.width
    }
}

```
{{< /section-right >}}
{{< /sections >}}



### SpinBox - Numbers

{{< sections >}}
{{< section-left >}}
To control Integer or Real numbers, QML ships with [SpinBox](docs:qtquickcontrols;Spinbox) and [Slider](docs:qtquickcontrols;Slider). For Plasma's specific changes, you can read the QML source code at:

* [`SpinBox.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/SpinBox.qml)

See the [KDE Human Interface Guidelines](/hig/components/editing/spinbox) to determine wither to use a SpinBox or a Slider.

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 3.0 as PlasmaComponents3

RowLayout {
    PlasmaComponents3.Label {
        text: i18n("Label:")
        Layout.alignment: Qt.AlignRight
    }
    PlasmaComponents3.SpinBox {
        from: 0
        to: 100
        value: 25
        stepSize: 1
    }
}
```
{{< /section-right >}}
{{< /sections >}}


### TextField, TextArea - Input

{{< sections >}}
{{< section-left >}}
To enter text, QML ships with [TextField](docs:qtquickcontrols;TextField) and [TextArea](docs:qtquickcontrols;TextArea). For Plasma's specific changes, you can read the QML source code for each:

* [`TextField.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/TextField.qml)
* [`TextArea.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/TextArea.qml)

See the [KDE Human Interface Guidelines](/hig/components/editing/lineedit) to determine wither to use a TextField (HIG calls it a Line Edit) or a TextArea.

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 3.0 as PlasmaComponents3

RowLayout {
    PlasmaComponents3.Label {
        Layout.alignment: Qt.AlignRight
        text: i18n("Name:")
    }
    PlasmaComponents3.TextField {
        placeholderText: i18n("Name")
    }
}
```

---

```qml
import QtQuick 2.0
import org.kde.plasma.components 3.0 as PlasmaComponents3

PlasmaComponents3.TextArea {
    text: "Lorem ipsum\ndolor sit amet,\nconsectetur adipisicing elit"
}
```
{{< /section-right >}}
{{< /sections >}}


### Button, ToolButton

{{< sections >}}
{{< section-left >}}
For buttons, QML ships with [Button](docs:qtquickcontrols;Button) and the flat [ToolButton](docs:qtquickcontrols;ToolButton) version. For Plasma's specific changes, you can read the QML source code for each:

* [`Button.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/Button.qml)
* [`ToolButton.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/ToolButton.qml)

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import org.kde.plasma.components 3.0 as PlasmaComponents3

PlasmaComponents3.Button {
    icon.name: "view-refresh"
    text: i18n("Refresh")
}
```

---

```qml
// main.qml
import QtQuick 2.0
import org.kde.plasma.components 3.0 as PlasmaComponents3

PlasmaComponents3.ToolButton {
    icon.name: "view-refresh-symbolic"
    text: i18n("Refresh")
}
```
{{< /section-right >}}
{{< /sections >}}



### ScrollView

{{< sections >}}
{{< section-left >}}
To add a scrollbar to manage overflow, QML ships with [ScrollView](docs:qtquickcontrols;ScrollView). For Plasma's specific changes, you can read the QML source code at:

* [`ScrollView.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/ScrollView.qml)

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import org.kde.plasma.components 3.0 as PlasmaComponents3

PlasmaComponents3.ScrollView {
    id: scrollView

    ListView {
        model: 100
        delegate: PlasmaComponents3.CheckBox {
            text: i18n("CheckBox #%1", index+1)
        }
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## PlasmaExtras

To be consistent with elsewhere in Plasma, Plasma ships with a couple of special components.
These components have their own API and are particulary helpful when creating a Plama Widget.

You will need to import `PlasmaExtras` to use them.

### Heading, Paragraph

{{< sections >}}
{{< section-left >}}
To be consistent with elsewhere in Plasma, Plasma ships with a couple different Label/Text
types with preset default sizes. The first one is [Heading](docs:plasma;org::kde::plasma::extras::Heading)
for subsections of texts and the second one is [Paragraph](docs:plasma;org::kde::plasma::extras::Paragraph).
Both wraps by default with `Layout.fillWidth: true`.

![Screenshot Paragraph and Heading](paragraphs.png)

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.extras 2.0 as PlasmaExtras

ColumnLayout {
    spacing: 0

    Repeater {
        model: 5
        PlasmaExtras.Heading {
            Layout.fillWidth: true
            level: index + 1
            text: i18n("Header level %1", level)
        }
    }

    PlasmaExtras.Paragraph {
        Layout.fillWidth: true
        text: i18n("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sit amet turpis eros, in luctus lectus. Curabitur pulvinar ligula at leo pellentesque non faucibus mauris elementum. Pellentesque convallis porttitor sodales. Maecenas risus erat, viverra blandit vestibulum eu, suscipit in est. Praesent quis mattis eros. Sed ante ante, adipiscing non gravida sed, ultrices ultrices urna. Etiam congue mattis convallis. Maecenas sollicitudin mauris at lorem aliquam in venenatis erat convallis. Fusce eleifend scelerisque porttitor. Praesent metus sapien, hendrerit ac congue eget, feugiat id enim. Morbi venenatis gravida felis, vitae varius nunc dictum a. Etiam accumsan, velit ac tempor convallis, leo nibh consequat purus, sit amet fringilla nisi mi et libero.")
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## PlasmaCore

```qml
import org.kde.plasma.core 2.0 as PlasmaCore
```


### PlasmaCore.Units.devicePixelRatio

In order to scale an Item by display scaling to support HiDPI monitors, you will need to multiply a pixel value by [`PlasmaCore.Units.devicePixelRatio`](docs:plasma;Units::devicePixelRatio). Plasma also ships with a few preset values for consitent spacing throughout Plasma.

* [`PlasmaCore.Units.devicePixelRatio`](docs:plasma;Units::devicePixelRatio) `=` [`QScreen::logicalDotsPerInchX`](https://doc.qt.io/qt-5/qscreen.html#logicalDotsPerInchX-prop) `/ 96` (Primary Screen)
* [`PlasmaCore.Units.smallSpacing`](docs:plasma;Units::smallSpacing) `= max(2, gridUnit/4)`
* [`PlasmaCore.Units.largeSpacing`](docs:plasma;Units::largeSpacing) `= gridUnit`
* [`PlasmaCore.Units.gridUnit`](docs:plasma;Units::gridUnit) (width of the capital letter M)

Note that [`Kirigami.Units`](https://invent.kde.org/frameworks/kirigami/blob/master/src/controls/Units.qml) does not use the exact same logic as `PlasmaCore.Units`.

```qml
import QtQuick 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3
RowLayout {
    spacing: PlasmaCore.Units.smallSpacing
    Rectangle {
        implicitWidth: 4 * PlasmaCore.Units.devicePixelRatio
        Layout.fillHeight: true
        color: PlasmaCore.Theme.highlightColor
    }
    PlasmaComponents3.Label {
        text: i18n("Label")
    }
}
```


### PlasmaCore.Units.iconSizes

{{< sections >}}
{{< section-left >}}

[`PlasmaCore.Units.iconSizes`](docs:plasma;Units::iconSizes) is scaled by DPI.

* `PlasmaCore.Units.iconSizes.small` `= 16px`
* `PlasmaCore.Units.iconSizes.smallMedium` `= 22px`
* `PlasmaCore.Units.iconSizes.medium` `= 32px`
* `PlasmaCore.Units.iconSizes.large` `= 48px`
* `PlasmaCore.Units.iconSizes.huge` `= 64px`
* `PlasmaCore.Units.iconSizes.enormous` `= 128px`

{{< /section-left >}}
{{< section-right >}}

![](iconsizes.png)

{{< /section-right >}}
{{< /sections >}}


### PlasmaCore.Units.shortDuration

These properties are scaled by the Animation Speed in System Settings.

* [`PlasmaCore.Units.veryShortDuration`](docs:plasma;Units::devicePixelRatio) `= 50ms`
* [`PlasmaCore.Units.shortDuration`](docs:plasma;Units::devicePixelRatio) `= 100ms`
* [`PlasmaCore.Units.longDuration`](docs:plasma;Units::devicePixelRatio) `= 200ms`
* [`PlasmaCore.Units.veryLongDuration`](docs:plasma;Units::devicePixelRatio) `= 400ms`

This property is a hardcoded value.

* [`PlasmaCore.Units.humanMoment`](docs:plasma;Units::humanMoment) `= 2000ms`


## Plasmoid property group

As discussed in [the `main.qml` setup widget section]({{< ref "setup.md#contentsuimainqml" >}}), when you `import org.kde.plasma.plasmoid 2.0`, the main `Item` in your widget will have the `Plasmoid` (with a capital) property group similar to when you `import QtQuick.Layouts 1.0`. This `Plasmoid` property group has properties from [`AppletInterface`](docs:plasma;AppletInterface) which inherits a few properties from [`PlasmaQuick::AppletQuickItem`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/plasmaquick/appletquickitem.h).


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

```qml
{{< readfile file="/content/docs/plasma/widget/snippet/popup-size.qml" >}}
```

{{< /section-right >}}
{{< /sections >}}


### Plasmoid.icon

{{< sections >}}
{{< section-left >}}

As discussed in [the `metadata.desktop` setup widget section]({{< ref "setup.md#metadatadesktop" >}}), by default the plasmoid icon is populated with `Icon=` in `metadata.desktop`.

To set a dynamic or user configurable icon, you will need to assign an icon name to `Plasmoid.icon`.

You can search for icon names in the `/usr/share/icon` folder. You can also look for an icon name by right clicking your app launcher widget then editing the icon in its settings. It uses a searchable interface and lists them by category. Plasma's SDK also has the Cuttlefish app ([screenshot](https://cdn.kde.org/screenshots/cuttlefish/cuttlefish.png)) which you can install with `sudo apt install plasma-sdk`.

Also checkout the [configurable panel icon example]({{< ref "examples.md#configurable-icon" >}})

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
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



## metadata.desktop

The common `metadata.desktop` properties are covered in the [setup widget section]({{< ref "setup.md#metadatadesktop" >}}).

The full list of custom `.desktop` file properties for widgets is defined in the [`Plasma/Applet` service type](
https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/plasma/data/servicetypes/plasma-applet.desktop).

`metadata.desktop` is the original format while `metadata.json` is the newer replacement format. The `.desktop` file is simpler to script with using `kreadconfig5` which is the reason why this tutorial prefers it. You can read up on [`metadata.json` in the API Documentation](docs:kcoreaddons;KPluginMetaData).

### Name, Comment

{{< sections >}}
{{< section-left >}}

These two are standard [XDG desktop file](https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s06.html) properties. You can also translate these properties with `Name[fr]`. The translated `Name` is used in the "Add Widgets" list. The `Comment` is only used for the default tooltip subtext when the widget is added to a panel.

{{< /section-left >}}
{{< section-right >}}
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
```ini
[Desktop Entry]
Icon=office-calendar
```

![](https://cdn.kde.org/screenshots/cuttlefish/cuttlefish.png)

{{< /section-right >}}
{{< /sections >}}


### X-KDE-PluginInfo-Name


{{< sections >}}
{{< section-left >}}

`X-KDE-PluginInfo-Name` needs to be a unique name, since it's used for the folder name its installed into. You could use `com.github.zren.helloworld` if you're on github, or use `org.kde.plasma.helloworld` if you're planning on contributing the widget to KDE. You should consider this the widget's namespace.


{{< /section-left >}}
{{< section-right >}}
```
~/.local/share/plasma/plasmoids/com.github.zren.helloworld/
/usr/share/plasma/plasmoids/com.github.zren.helloworld/
```
{{< /section-right >}}
{{< /sections >}}

### X-KDE-PluginInfo-Category

`X-KDE-PluginInfo-Category` is the category the widget can be filtered with in the widget list.

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


### X-KDE-ServiceTypes

`X-KDE-ServiceTypes` is a comma seperated list of types. For a plasma widget, it should be `Plasma/Applet`. You may encounter widgets with `Plasma/Containment` as well, like [the System Tray widget](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/applets/systemtray/package/metadata.desktop#L93).

The defined plasma sevice types and their custom `.desktop` file properties are found in:  
[`plasma-framework/src/plasma/data/servicetypes`](https://invent.kde.org/frameworks/plasma-framework/-/tree/master/src/plasma/data/servicetypes)


### X-Plasma-API, X-Plasma-MainScript

{{< sections >}}
{{< section-left >}}

`X-Plasma-API` tells plasma what script engine to use. `declarativeappletscript` is the standard `QML` loader.

`X-Plasma-MainScript` is the entry point of your qml code. The standard throughout plasma is to use `ui/main.qml`.

{{< /section-left >}}
{{< section-right >}}
```ini
[Desktop Entry]
X-Plasma-API=declarativeappletscript
X-Plasma-MainScript=ui/main.qml
```
{{< /section-right >}}
{{< /sections >}}


### X-Plasma-Provides (Alternatives)

A Plasmoid can specify the type of functionality it offers, for example whether it's a clock, an application launcher, etc. This mechanism is used to list alternative plasmoids for a certain function. When you open the context menu of the Application Launcher (aka kickoff) in the Plasma desktop panel, you'll see that a number of different Plasmoids are offered here as alternatives, like the Application Menu (aka kicker) and Application Dashboard (aka kickerdash). All three of these widgets define:

```ini
[Desktop Entry]
X-Plasma-Provides=org.kde.plasma.launchermenu
```

These "Provides" are in fact arbitrary, so you can choose your own here. The field accepts multiple values separated by a comma. Here are some possible values that are used throughout Plasma: 

* `org.kde.plasma.launchermenu`: App Launcher Menus
* `org.kde.plasma.multimediacontrols`: Multimedia controls
* `org.kde.plasma.time`: Clocks
* `org.kde.plasma.date`: Calendars
* `org.kde.plasma.time,org.kde.plasma.date`: Clocks with calendars ([Eg: Digital Clock](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/applets/digital-clock/package/metadata.desktop#L154))
* `org.kde.plasma.powermanagement`: Power management ([Eg: Battery and Brightness](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/applets/batterymonitor/package/metadata.desktop#L191))
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

The Media Controller widget serves as a good example since it uses most of the systemtray metadata features. [Its metadata contains](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/applets/mediacontroller/metadata.desktop) the following:

```ini
[Desktop Entry]
X-KDE-PluginInfo-EnabledByDefault=true
X-Plasma-NotificationArea=true
X-Plasma-NotificationAreaCategory=ApplicationStatus
X-Plasma-DBusActivationService=org.mpris.MediaPlayer2.*
```

By specifiying `X-Plasma-NotificationArea`, this widget will be found by the systemtray widget.

`X-KDE-PluginInfo-EnabledByDefault` will make sure it's enabled in the systemtray by default.

It's prudent for the widget to also set the `X-Plasma-NotificationAreaCategory` so that the icons are grouped together. Its allowed values are:

* `ApplicationStatus`: indicates that this item represents an active application
* `Hardware`: indicates that this item allows managing hardware (could be a battery monitor or the wifi applet)
* `SystemServices`: indicates that this item shows information about system services, for example the status of file indexing, software updates, etc.

You can search plasma's code for more examples:

* [Search `plasma-workspace` for `X-Plasma-NotificationArea`](https://invent.kde.org/search?utf8=%E2%9C%93&search=X-Plasma-NotificationArea&group_id=1568&project_id=2703&scope=&search_code=true&snippets=false&repository_ref=master&nav_source=navbar)
* [Search `plasma-desktop` for `X-Plasma-NotificationArea`](https://invent.kde.org/search?utf8=%E2%9C%93&search=X-Plasma-NotificationArea&group_id=1568&project_id=2802&scope=&search_code=true&snippets=false&repository_ref=master&nav_source=navbar)
* [Search `kdeplasma-addons` for `X-Plasma-NotificationArea`](https://invent.kde.org/search?utf8=%E2%9C%93&search=X-Plasma-NotificationArea&group_id=1568&project_id=2828&scope=&search_code=true&snippets=false&repository_ref=master&nav_source=navbar)


### X-Plasma-DBusActivationService

`X-Plasma-DBusActivationService` will load and unload widgets in the systemtray automatically when a DBus service becomes avaiable or is stopped. This is very convenient to load widgets automatically, so the user doesn't have to explicitely go to the notification area settings and enable or remove a widget.

An example of this is the Media Controller widget, which is auto-loaded as soon as an application starts offering the `org.mpris.MediaPlayer2` DBus service in the session. As you can see [in its `metadata.desktop` file](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/applets/mediacontroller/metadata.desktop#L123), `X-Plasma-DBusActivationService` accepts wildcards which makes it a bit easier to match DBus names. This key can also be very useful to avoid having a widget loaded when it's unnecessary, so it can help to avoid visual clutter and wasted memory.

```ini
[Desktop Entry]
X-Plasma-NotificationArea=true
X-Plasma-NotificationAreaCategory=ApplicationStatus
X-Plasma-DBusActivationService=org.mpris.MediaPlayer2.*
```

[Search `plasma-workspace` for `X-Plasma-DBusActivationService`](https://invent.kde.org/search?utf8=%E2%9C%93&search=X-Plasma-DBusActivationService&group_id=1568&project_id=2703&scope=&search_code=true&snippets=false&repository_ref=master&nav_source=navbar) for more examples.

