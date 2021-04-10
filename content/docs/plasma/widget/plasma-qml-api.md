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

