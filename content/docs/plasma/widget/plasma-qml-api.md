---
title: "Plasma's QML API"
weight: 4
description: >
  A rundown of the QML types shipped in KDE Frameworks
aliases:
  - /docs/plasma/widget/plasma-qml-api/
---

## Intro

KDE Frameworks ships with a number of useful extensions to Qt's QML. The [API documentation](docs:plasma-framework) is a good start if you need to know what a specific property does. If you want to browse any of the sources easier, it's also [available on GitLab](https://invent.kde.org/frameworks/plasma-framework/-/tree/master/src/declarativeimports).


## PlasmaComponents Controls

QML ships with various controls, like [CheckBox](docs:qtquickcontrols;QtQuick.Controls.CheckBox), [RadioButton](docs:qtquickcontrols;QtQuick.Controls.RadioButton), [ComboBox](docs:qtquickcontrols;QtQuick.Controls.ComboBox) (dropdown menu), [SpinBox](docs:qtquickcontrols;QtQuick.Controls.SpinBox), [Slider](docs:qtquickcontrols;QtQuick.Controls.Slider), [TextField](docs:qtquickcontrols;QtQuick.Controls.TextField), [TextArea](docs:qtquickcontrols;QtQuick.Controls.TextArea), [Button](docs:qtquickcontrols;QtQuick.Controls.Button), [ToolButton](docs:qtquickcontrols;QtQuick.Controls.ToolButton). Plasma extends these controls to style them using the SVGs from the [Plasma Style]({{< ref "../theme/_index.md" >}}). It also assigns a number of default settings like setting the text color to follow the panel's color scheme.

PlasmaComponents 3 is a QML library that extends the [Qt Quick Controls 2 components](https://doc.qt.io/qt-5/qtquickcontrols-index.html) with defaults adapted to fit into Plasma widgets. Because PlasmaComponents 3 inherits from Qt Quick Controls 2, they have the same API, so the [Qt documentation](https://doc.qt.io/qt-5/qtquickcontrols-index.html) can be followed. For Plasma's specific behaviour changes, you can read the QML source code for each control in:

[`plasma-framework`/src/declarativeimports/plasmacomponents3/](https://invent.kde.org/frameworks/plasma-framework/-/tree/master/src/declarativeimports/plasmacomponents3)

Removed in Plasma 6.0: [PlasmaComponents 2](https://invent.kde.org/plasma/libplasma/-/tree/v5.102.0/src/declarativeimports/plasmacomponents/qml) was used in Plasma 5. It used the older [Qt Quick Controls 1](https://doc.qt.io/qt-5/qtquickcontrols1-index.html).


### Label

{{< sections >}}
{{< section-left >}}
[Labels](docs:qtquickcontrols;QtQuick.Controls.Label) are used for displaying text to the user.
Plasma's Label are assigned a number of defaults. One thing
is it sets the text color to follow the panel's color scheme.

For the specifics, you can read the [`Label.qml` source code](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/Label.qml).
{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
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
For a simple toggle, QML ships with [CheckBox](docs:qtquickcontrols;QtQuick.Controls.CheckBox). For Plasma's specific changes, you can read the QML source code at:

* [`CheckBox.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/CheckBox.qml)

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
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
For multiple choices, QML ships with [RadioButton](docs:qtquickcontrols;QtQuick.Controls.RadioButton). For Plasma's specific changes, you can read the QML source code at:

* [`RadioButton.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/RadioButton.qml)

Note that the [KDE Human Interface Guidelines]({{< ref "/hig/getting_input" >}}) suggest using a ComboBox when there are  more than 3 options.

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
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

For multiple choices, QML also ships with [ComboBox](docs:qtquickcontrols;QtQuick.Controls.ComboBox) (dropdown menu). For Plasma's specific changes, you can read the QML source code at:

* [`ComboBox.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/ComboBox.qml)

Note that [`ComboBox.valueRole`](https://doc.qt.io/qt-5/qml-qtquick-controls2-combobox.html#valueRole-prop) and [`ComboBox.currentValue`](https://doc.qt.io/qt-5/qml-qtquick-controls2-combobox.html#currentValue-prop) was introduced in Qt 5.14. [Ubuntu 20.04 only has Qt 5.12](https://repology.org/project/qt/versions) so you will need to use your own `_valueRole` and `_currentValue` properties until Ubuntu 22.04. Make sure to not define a `valueRole` or `currentValue` property or it will break when your users upgrade to Qt 5.14.

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
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

```qml
PlasmaComponents3.ComboBox {
    textRole: "text"
    property string _valueRole: "value"
    readonly property var _currentValue: _valueRole && currentIndex >= 0 ? model[currentIndex][_valueRole] : null
}
```
{{< /section-right >}}
{{< /sections >}}


### Slider - Numbers

{{< sections >}}
{{< section-left >}}

To control Integer or Real numbers, QML ships with [SpinBox](docs:qtquickcontrols;QtQuick.Controls.SpinBox) and [Slider](docs:qtquickcontrols;QtQuick.Controls.Slider). For Plasma's specific changes, you can read the QML source code at:

* [`Slider.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/Slider.qml)

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
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
To control Integer or Real numbers, QML ships with [SpinBox](docs:qtquickcontrols;QtQuick.Controls.SpinBox) and [Slider](docs:qtquickcontrols;QtQuick.Controls.Slider). For Plasma's specific changes, you can read the QML source code at:

* [`SpinBox.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/SpinBox.qml)

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
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
To enter text, QML ships with [TextField](docs:qtquickcontrols;QtQuick.Controls.TextField) and [TextArea](docs:qtquickcontrols;QtQuick.Controls.TextArea). For Plasma's specific changes, you can read the QML source code for each:

* [`TextField.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/TextField.qml)
* [`TextArea.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/TextArea.qml)

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
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

<div class="filepath">contents/ui/main.qml</div>

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
For buttons, QML ships with [Button](docs:qtquickcontrols;QtQuick.Controls.Button) and the flat [ToolButton](docs:qtquickcontrols;QtQuick.Controls.ToolButton) version. For Plasma's specific changes, you can read the QML source code for each:

* [`Button.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/Button.qml)
* [`ToolButton.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/ToolButton.qml)

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
import QtQuick 2.0
import org.kde.plasma.components 3.0 as PlasmaComponents3

PlasmaComponents3.Button {
    icon.name: "view-refresh"
    text: i18n("Refresh")
}
```

---

<div class="filepath">contents/ui/main.qml</div>

```qml
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
To add a scrollbar to manage overflow, QML ships with [ScrollView](docs:qtquickcontrols;QtQuick.Controls.ScrollView). For Plasma's specific changes, you can read the QML source code at:

* [`ScrollView.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/ScrollView.qml)

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
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


### BusyIndicator

{{< sections >}}
{{< section-left >}}

This draws `widgets/busywidget.svg` from the Plasma Style and spins it. If animation speed is Instant in System Settings, it will not rotate.

* [`BusyIndicator.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/BusyIndicator.qml)
* [Default `widgets/busywidget.svg` from Breeze](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/desktoptheme/breeze/widgets/busywidget.svg)

{{< /section-left >}}
{{< section-right >}}

{{< /section-right >}}
{{< /sections >}}


## PlasmaExtras

To be consistent with elsewhere in Plasma, Plasma ships with a couple of special components.
These components have their own API and are particularly helpful when creating a Plasma Widget.

You will need to import `PlasmaExtras` to use them.

### Heading, Paragraph

<!-- TODO change to Kirigami::Heading and remove Paragraph -->

{{< sections >}}
{{< section-left >}}
To be consistent with elsewhere in Plasma, Plasma ships with a couple different Label/Text
types with preset default sizes. The first one is [Heading](docs:plasma-framework;org::kde::plasma::extras::Heading)
for subsections of texts and the second one is [Paragraph](docs:plasma-framework;org::kde::plasma::extras::Paragraph).
Both wraps by default with `Layout.fillWidth: true`.

![Screenshot Paragraph and Heading](paragraphs.png)

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
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

* The very useful `Theme` and `Units` singletons.
* A number of enums listed in [`Types`](docs:plasma-framework;Plasma::Types).
* [`Icon`](docs:kirigami2;Icon) for drawing icons.
* [`SvgItem`](docs:plasma-framework;Plasma::SvgItem), [`Svg`](docs:plasma-framework;Plasma::Svg) and [`FrameSvgItem`](docs:plasma-framework;Plasma::FrameSvgItem) for drawing SVGs coloured with the Plasma Style color palette.
* [`DataSource`](docs:plasma-framework;Plasma::DataSource) for connecting to a Plasma DataEngine.

[See the API docs](https://api.kde.org/frameworks/plasma-plasma-framework/html/core.html) for the full list of types in `PlasmaCore`. You can also skim the generated [`.../core/plugins.qmltypes`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/core/plugins.qmltypes) file.


### PlasmaCore.Theme

`PlasmaCore.Theme` contains the [Plasma Style]({{< ref "../theme/_index.md" >}}) color palette.

* `PlasmaCore.Theme.textColor`
* `PlasmaCore.Theme.highlightColor`
* `PlasmaCore.Theme.highlightedTextColor`
* `PlasmaCore.Theme.backgroundColor`
* `PlasmaCore.Theme.linkColor`
* `PlasmaCore.Theme.visitedLinkColor`
* `PlasmaCore.Theme.positiveTextColor`
* `PlasmaCore.Theme.neutralTextColor`
* `PlasmaCore.Theme.negativeTextColor`
* `PlasmaCore.Theme.disabledTextColor`

There is also properties for the various color groups using a prefix.

* `PlasmaCore.Theme.buttonTextColor`
* `PlasmaCore.Theme.viewTextColor`
* `PlasmaCore.Theme.complementaryTextColor`
* `PlasmaCore.Theme.headerTextColor`

The full list of `PlasmaCore.Theme` color properties can be found in the `QuickTheme` class definition:
[`plasma-framework/src/declarativeimports/core/quicktheme.h`](https://invent.kde.org/frameworks/plasma-framework/blob/master/src/declarativeimports/core/quicktheme.h)

The `QuickTheme` class extends `Plasma::Theme` which also contains:

* `PlasmaCore.Theme.defaultFont` [`font`](https://doc.qt.io/qt-5/qml-font.html)
* `PlasmaCore.Theme.palette` [`palette`](https://doc.qt.io/qt-5/qml-palette.html)
* `PlasmaCore.Theme.smallestFont` [`font`](https://doc.qt.io/qt-5/qml-font.html)
* `PlasmaCore.Theme.styleSheet` [`string`](https://doc.qt.io/qt-5/qml-string.html)
* `PlasmaCore.Theme.themeName` [`string`](https://doc.qt.io/qt-5/qml-string.html)
* `PlasmaCore.Theme.useGlobalSettings` [`bool`](https://doc.qt.io/qt-5/qml-bool.html)
* `PlasmaCore.Theme.wallpaperPath` [`string`](https://doc.qt.io/qt-5/qml-string.html)


### PlasmaCore.Units.devicePixelRatio

In order to scale an Item by display scaling to support HiDPI monitors, you will need to multiply a pixel value by `PlasmaCore.Units.devicePixelRatio`. Plasma also ships with a few preset values for consistent spacing throughout Plasma.

* `PlasmaCore.Units.devicePixelRatio` `=` [`QScreen::logicalDotsPerInchX`](https://doc.qt.io/qt-5/qscreen.html#logicalDotsPerInchX-prop) `/ 96` (Primary Screen)
* `PlasmaCore.Units.smallSpacing` `= max(2, gridUnit/4)`
* `PlasmaCore.Units.largeSpacing` `= gridUnit`
* `PlasmaCore.Units.gridUnit` (width of the capital letter M)

Note that [`Kirigami.Units`](https://invent.kde.org/frameworks/kirigami/blob/master/src/controls/Units.qml) does not use the exact same logic as [`PlasmaCore.Units`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/core/units.cpp).

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

`PlasmaCore.Units.iconSizes` is scaled by DPI.

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

* `PlasmaCore.Units.veryShortDuration` `= 50ms`
* `PlasmaCore.Units.shortDuration` `= 100ms`
* `PlasmaCore.Units.longDuration` `= 200ms`
* `PlasmaCore.Units.veryLongDuration` `= 400ms`

This property is a hardcoded value and shouldn't be used for animations. Instead, it can be used to measure how long to wait until the user should be informed of something, or can be used as the limit for how long something should wait before being automatically initiated.

* `PlasmaCore.Units.humanMoment` `= 2000ms`




{{< readfile file="/content/docs/plasma/widget/snippet/plasma-doc-style.html" >}}
