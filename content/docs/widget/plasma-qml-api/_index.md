---
title: "Plasma's QML API"
weight: 4
description: >
  A rundown of the QML types shipped in KDE Frameworks
---

## Intro

KDE Frameworks ships with a number of useful extensions to Qt's QML. The [API documentation](https://api.kde.org/frameworks/plasma-framework/html/index.html) is a good start if you need to know what a specific property does. If you want to browse any of the sources easier, it's also [mirrored on GitHub](https://github.com/KDE/plasma-framework/tree/master/src/declarativeimports/).


## PlasmaComponents.Label

{{< sections >}}
{{< section-left >}}

QML ships with a [Text](http://doc.qt.io/qt-5/qml-qtquick-text.html) type, but Plasma extends it with `Label.qml` which assigns a number of defaults. One thing is it sets the text color to follow the panel's color scheme. For the specifics, you can read the [`Label.qml` source code](https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/plasmacomponents/qml/Label.qml).

{{< /section-left >}}
{{< section-right highlight="qml">}}
// main.qml
import QtQuick 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

PlasmaComponents.Label {
    text: i18n("Hello World")
}
{{< /section-right >}}
{{< /sections >}}



## Heading, Paragraph

{{< sections >}}
{{< section-left >}}
To be consistent with elsewhere in Plasma, Plasma ships with a couple different Label/Text types with preset default sizes. You will need to import `PlasmaExtras` to use them.

* [`Heading.qml`](https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/plasmaextracomponents/qml/Heading.qml)  
  Various Font Size levels, Wraps with `Layout.fillWidth: true`
* [`Paragraph.qml`](https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/plasmaextracomponents/qml/Paragraph.qml)  
  Justified Alignment, Wraps with `Layout.fillWidth: true`

{{< /section-left >}}
{{< section-right highlight="qml">}}
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
{{< /section-right >}}
{{< /sections >}}



## PlasmaComponents Controls

QML ships with various controls, like [CheckBox](https://doc.qt.io/qt-5/qml-qtquick-controls-checkbox.html), [RadioButton](https://doc.qt.io/qt-5/qml-qtquick-controls-radiobutton.html), [ComboBox](https://doc.qt.io/qt-5/qml-qtquick-controls-combobox.html) (DropDown Menu), [SpinBox](https://doc.qt.io/qt-5/qml-qtquick-controls-spinbox.html), [Slider](https://doc.qt.io/qt-5/qml-qtquick-controls-slider.html), [TextField](https://doc.qt.io/qt-5/qml-qtquick-controls-textfield.html), [TextArea](https://doc.qt.io/qt-5/qml-qtquick-controls-textarea.html), [Button](https://doc.qt.io/qt-5/qml-qtquick-controls-button.html), [ToolButton](https://doc.qt.io/qt-5/qml-qtquick-controls-toolbutton.html). Plasma extends these controls to style them using the SVGs from the [Plasma Theme](https://techbase.kde.org/Development/Tutorials/Plasma5/ThemeDetails). It also assigns a number of default settings like setting the text color to follow the panel's color scheme. For Plasma's specific changes, you can read the QML source code for each control in:

[`plasma-framework`/src/declarativeimports/plasmacomponents/qml/](https://github.com/KDE/plasma-framework/tree/master/src/declarativeimports/plasmacomponents/qml)



## CheckBox - Toggle

{{< sections >}}
{{< section-left >}}
For a simple toggle, QML ships with [CheckBox](https://doc.qt.io/qt-5/qml-qtquick-controls-checkbox.html). For Plasma's specific changes, you can read the QML source code at:

* [`CheckBox.qml`](https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/plasmacomponents/qml/CheckBox.qml)

{{< /section-left >}}
{{< section-right highlight="qml">}}
// main.qml
import QtQuick 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

PlasmaComponents.CheckBox {
    text: i18n("Hello World")
    checked: true
}
{{< /section-right >}}
{{< /sections >}}



## RadioButton, ComboBox - Multiple Choice

{{< sections >}}
{{< section-left >}}
For mutiple choices, QML ships with [RadioButton](https://doc.qt.io/qt-5/qml-qtquick-controls-radiobutton.html) and [ComboBox](https://doc.qt.io/qt-5/qml-qtquick-controls-combobox.html) (DropDown Menu). For Plasma's specific changes, you can read the QML source code for each:

* [`RadioButton.qml`](https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/plasmacomponents/qml/RadioButton.qml)
* [`ComboBox.qml`](https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/plasmacomponents/qml/ComboBox.qml)

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 2.0 as PlasmaComponents

ColumnLayout {
    ExclusiveGroup { id: tabPositionGroup }
    PlasmaComponents.RadioButton {
        text: i18n("Top")
        checked: true
        exclusiveGroup: tabPositionGroup
    }
    PlasmaComponents.RadioButton {
        text: i18n("Bottom")
        exclusiveGroup: tabPositionGroup
    }
}
```

---

```qml
// main.qml
import QtQuick 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

PlasmaComponents.ComboBox {
    textRole: "text"
    model: [
        { value: "a", text: i18n("A") },
        { value: "b", text: i18n("B") },
        { value: "c", text: i18n("C") },
    ]
}
```
{{< /section-right >}}
{{< /sections >}}



## SpinBox, Slider - Numbers

{{< sections >}}
{{< section-left >}}
To control Integer or Real numbers, QML ships with [SpinBox](https://doc.qt.io/qt-5/qml-qtquick-controls-spinbox.html) and [Slider](https://doc.qt.io/qt-5/qml-qtquick-controls-slider.html). For Plasma's specific changes, you can read the QML source code for each:

* [`SpinBox.qml`](https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/plasmacomponents3/SpinBox.qml) (not skinned)
* [`Slider.qml`](https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/plasmacomponents/qml/Slider.qml)

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 2.0 as PlasmaComponents

RowLayout {
    PlasmaComponents.Label {
        text: i18n("Label:")
        Layout.alignment: Qt.AlignRight
    }
    SpinBox {
        minimumValue: 0
        maximumValue: 100
        value: 25
        stepSize: 1
    }
}
```

---

```qml
// main.qml
import QtQuick 2.4
import QtQuick.Layouts 1.0
import org.kde.plasma.components 2.0 as PlasmaComponents

RowLayout {
    PlasmaComponents.Slider {
        id: slider
        Layout.fillWidth: true
        minimumValue: 0.0
        maximumValue: 1.0
        value: 0.25
        stepSize: 0.01
    }
    PlasmaComponents.Label {
        id: sliderValueLabel
        Layout.minimumWidth: textMetrics.width
        text: formatText(slider.value)
        function formatText(value) {
            return i18n("%1%", Math.round(value * 100))
        }
        TextMetrics {
            id: textMetrics
            font.family: sliderValueLabel.font.family
            font.pointSize: sliderValueLabel.font.pointSize
            text: sliderValueLabel.formatText(slider.maximumValue)
        }
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## TextField, TextArea - Input

{{< sections >}}
{{< section-left >}}
To enter text, QML ships with [TextField](https://doc.qt.io/qt-5/qml-qtquick-controls-textfield.html) and [TextArea](https://doc.qt.io/qt-5/qml-qtquick-controls-textarea.html). For Plasma's specific changes, you can read the QML source code for each:

* [`TextField.qml`](https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/plasmacomponents/qml/TextField.qml)
* [`TextArea.qml`](https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/plasmacomponents/qml/TextArea.qml)

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 2.0 as PlasmaComponents

RowLayout {
    PlasmaComponents.Label {
        Layout.alignment: Qt.AlignRight
        text: i18n("Name:")
    }
    PlasmaComponents.TextField {
        placeholderText: i18n("Name")
    }
}
```

---

```qml
// main.qml
import QtQuick 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

PlasmaComponents.TextArea {
    text: "Lorem ipsum\ndolor sit amet,\nconsectetur adipisicing elit"
}
```
{{< /section-right >}}
{{< /sections >}}



## Button, ToolButton

{{< sections >}}
{{< section-left >}}
For buttons, QML ships with [Button](https://doc.qt.io/qt-5/qml-qtquick-controls-button.html) and the flat [ToolButton](https://doc.qt.io/qt-5/qml-qtquick-controls-toolbutton.html) version. For Plasma's specific changes, you can read the QML source code for each:

* [`Button.qml`](https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/plasmacomponents/qml/Button.qml)
* [`ToolButton.qml`](https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/plasmacomponents/qml/ToolButton.qml)

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

PlasmaComponents.Button {
    iconSource: "view-refresh"
    text: i18n("Refresh")
}
```

---

```qml
// main.qml
import QtQuick 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

PlasmaComponents.ToolButton {
    iconSource: "view-refresh-symbolic"
    text: i18n("Refresh")
}
```
{{< /section-right >}}
{{< /sections >}}



## PlasmaExtras.ScrollArea

{{< sections >}}
{{< section-left >}}
To add a scrollbar to manage overflow, QML ships with [ScrollView](https://doc.qt.io/qt-5/qml-qtquick-controls-scrollview.html). For Plasma's specific changes, you can read the QML source code at:

* [`ScrollArea.qml`](https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/plasmaextracomponents/qml/ScrollArea.qml)

I recommend you set the ScrollArea's `contentItem.width` to `viewport.width`.

{{< /section-left >}}
{{< section-right highlight="qml">}}
// main.qml
import QtQuick 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

PlasmaExtras.ScrollArea {
    id: scrollArea
    readonly property int viewportWidth: viewport ? viewport.width : width

    ColumnLayout {
        width: scrollArea.viewportWidth

        Repeater {
            model: 100
            PlasmaComponents.CheckBox {
                text: i18n("CheckBox #%1", index+1)
            }
        }
    }
}
{{< /section-right >}}
{{< /sections >}}


