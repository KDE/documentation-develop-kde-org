---
title: "Plasma's QML API"
weight: 4
description: >
  A rundown of the QML types shipped in KDE Frameworks
---

## Intro

KDE Frameworks ships with a number of useful extensions to Qt's QML. The [API documentation](docs:plasma) is a good start if you need to know what a specific property does. If you want to browse any of the sources easier, it's also [available on GitLab](https://invent.kde.org/frameworks/plasma-framework/-/tree/master/src/declarativeimports).


## PlasmaComponents Controls

QML ships with various controls, like [CheckBox](https://doc.qt.io/qt-5/qml-qtquick-controls2-checkbox.html), [RadioButton](https://doc.qt.io/qt-5/qml-qtquick-controls2-radiobutton.html), [ComboBox](https://doc.qt.io/qt-5/qml-qtquick-controls2-combobox.html) (dropdown menu), [SpinBox](https://doc.qt.io/qt-5/qml-qtquick-controls2-spinbox.html), [Slider](https://doc.qt.io/qt-5/qml-qtquick-controls2-slider.html), [TextField](https://doc.qt.io/qt-5/qml-qtquick-controls2-textfield.html), [TextArea](https://doc.qt.io/qt-5/qml-qtquick-controls2-textarea.html), [Button](https://doc.qt.io/qt-5/qml-qtquick-controls2-button.html), [ToolButton](https://doc.qt.io/qt-5/qml-qtquick-controls2-toolbutton.html). Plasma extends these controls to style them using the SVGs from the [Plasma Theme](https://techbase.kde.org/Development/Tutorials/Plasma5/ThemeDetails). It also assigns a number of default settings like setting the text color to follow the panel's color scheme.

PlasmaComponents 3 is QML library that extends the [Qt Quick Controls 2 components](https://doc.qt.io/qt-5/qtquickcontrols-index.html) with defaults adapted to fit into Plasma widgets. Because PlasmaComponents 3 inherits from Qt Quick Controls 2, they have the same API, so the [Qt documentation](https://doc.qt.io/qt-5/qtquickcontrols-index.html) can be followed. For Plasma's specific behaviour changes, you can read the QML source code for each control in:

[`plasma-framework`/src/declarativeimports/plasmacomponents3/](https://invent.kde.org/frameworks/plasma-framework/-/tree/master/src/declarativeimports/plasmacomponents3)

You may see leftover imports to PlasmaComponents 2 in some widgets. It uses the older [Qt Quick Controls 1](https://doc.qt.io/qt-5/qtquickcontrols1-index.html) components which are deprecated. The source code for the older controls can also be found in the `plasma-frameworks` repo:

[`plasma-framework`/src/declarativeimports/plasmacomponents/qml/](https://invent.kde.org/frameworks/plasma-framework/-/tree/master/src/declarativeimports//plasmacomponents/qml)


### Label

{{< sections >}}
{{< section-left >}}

[Labels](https://doc.qt.io/qt-5/qml-qtquick-controls2-label.html) are used for displaying text to
the user. Plasma's Label are assigned a number of defaults. One thing is it sets the text color to
follow the panel's color scheme. For the specifics, you can read the
[`Label.qml` source code](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/Label.qml).

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
For a simple toggle, QML ships with [CheckBox](https://doc.qt.io/qt-5/qml-qtquick-controls2-checkbox.html). For Plasma's specific changes, you can read the QML source code at:

* [`CheckBox.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/CheckBox.qml)

{{< /section-left >}}
{{< section-right >}}
```
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
For mutiple choices, QML ships with [RadioButton](https://doc.qt.io/qt-5/qml-qtquick-controls2-radiobutton.html). For Plasma's specific changes, you can read the QML source code at:

* [`RadioButton.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/RadioButton.qml)

Note the [KDE Human Interface Guidelines](https://hig.kde.org/components/editing/radiobutton.html) suggest using a ComboBox (dropdown menu) when your list is greater than 5 options.

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
For mutiple choices, QML also ships with [ComboBox](https://doc.qt.io/qt-5/qml-qtquick-controls2-combobox.html) (dropdown menu). For Plasma's specific changes, you can read the QML source code at:

* [`ComboBox.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/ComboBox.qml)

Note that [`ComboBox.valueRole`](https://doc.qt.io/qt-5/qml-qtquick-controls2-combobox.html#valueRole-prop) and [`ComboBox.currentValue`](https://doc.qt.io/qt-5/qml-qtquick-controls2-combobox.html#currentValue-prop) was introduced in Qt 5.14. [Ubuntu 20.04 only has Qt 5.12](https://repology.org/project/qt/versions) so you will need to use the following properties until Ubuntu 22.04. Make sure to not define a `currentValue` property or it will break when your users upgrade to Qt 5.14.

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
To control Integer or Real numbers, QML ships with [SpinBox](https://doc.qt.io/qt-5/qml-qtquick-controls2-spinbox.html) and [Slider](https://doc.qt.io/qt-5/qml-qtquick-controls2-slider.html). For Plasma's specific changes, you can read the QML source code at:

* [`Slider.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/Slider.qml)

See the [KDE Human Interface Guidelines](https://hig.kde.org/components/editing/slider.html) to determine wither to use a Slider or a SpinBox.

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
To control Integer or Real numbers, QML ships with [SpinBox](https://doc.qt.io/qt-5/qml-qtquick-controls2-spinbox.html) and [Slider](https://doc.qt.io/qt-5/qml-qtquick-controls2-slider.html). For Plasma's specific changes, you can read the QML source code at:

* [`SpinBox.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/SpinBox.qml)

See the [KDE Human Interface Guidelines](https://hig.kde.org/components/editing/spinbox.html) to determine wither to use a SpinBox or a Slider.

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
To enter text, QML ships with [TextField](https://doc.qt.io/qt-5/qml-qtquick-controls2-textfield.html) and [TextArea](https://doc.qt.io/qt-5/qml-qtquick-controls2-textarea.html). For Plasma's specific changes, you can read the QML source code for each:

* [`TextField.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/TextField.qml)
* [`TextArea.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/TextArea.qml)

See the [KDE Human Interface Guidelines](https://hig.kde.org/components/editing/lineedit.html) to determine wither to use a TextField (HIG calls it a Line Edit) or a TextArea.

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
// main.qml
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
For buttons, QML ships with [Button](https://doc.qt.io/qt-5/qml-qtquick-controls2-button.html) and the flat [ToolButton](https://doc.qt.io/qt-5/qml-qtquick-controls2-toolbutton.html) version. For Plasma's specific changes, you can read the QML source code for each:

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
To add a scrollbar to manage overflow, QML ships with [ScrollView](https://doc.qt.io/qt-5/qml-qtquick-controls2-scrollview.html). For Plasma's specific changes, you can read the QML source code at:

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
To be consistent with elsewhere in Plasma, Plasma ships with a couple different Label/Text types with preset default sizes. 

* [`Heading.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmaextracomponents/qml/Heading.qml)  
  Various Font Size levels, Wraps with `Layout.fillWidth: true`
* [`Paragraph.qml`](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmaextracomponents/qml/Paragraph.qml)  
  Justified Alignment, Wraps with `Layout.fillWidth: true`

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
{{< /section-right >}}
{{< /sections >}}




