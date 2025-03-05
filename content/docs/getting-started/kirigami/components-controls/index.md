---
title: Controls and interactive elements
weight: 38
description: Make your apps more interactive by using buttons, selection controls, sliders, and text fields.
group: components
aliases:
  - /docs/getting-started/kirigami/components-controls/
---


Kirigami makes use of a wide selection of different interactive elements from Qt that you can use in your applications. Each different type has slightly different interaction styles, visual styles, and functionality. Using the right type of control in your application can help make your user interface more responsive and intuitive.

## Buttons

In Kirigami apps, we use buttons from QtQuick Controls. Using them is pretty straightforward: we set the text to the [text](https://doc.qt.io/qt-6/qml-qtquick-controls2-abstractbutton.html#text-prop) property and any action we want it to perform is set to the [onClicked](docs:qtquickcontrols;QtQuick.Controls.AbstractButton::clicked) property.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Controls.Button"
    width: 400
    height: 400
    pageStack.initialPage: Kirigami.Page {
        ColumnLayout {
            anchors.fill: parent
            Controls.Button {
                Layout.alignment: Qt.AlignCenter
                text: "Beep!"
                onClicked: showPassiveNotification("Boop!")
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

![A window containing a button "Beep" in the center, which when clicked shows a passive notification "Boop" at the bottom of the window](/docs/getting-started/kirigami/components-controls/controls-button.webp)

{{< /section-right >}}

{{< /sections >}}

### Toggleable buttons

The behavior of buttons can be changed to make them toggleable: in this mode, they will stay pressed until clicked on once more. This mode can be activated by setting their [checkable](https://doc.qt.io/qt-6/qml-qtquick-controls2-abstractbutton.html#checkable-prop) property to `true`; we can also set buttons to be toggled on by default by setting [checked](https://doc.qt.io/qt-6/qml-qtquick-controls2-abstractbutton.html#checked-prop) to `true`.

We can get the most out of toggleable buttons by using the `onCheckedChanged` signal handler which is [automatically generated](https://doc.qt.io/qt-6/qtqml-syntax-signals.html#property-change-signal-handlers) from the [checked](https://doc.qt.io/qt-6/qml-qtquick-controls2-abstractbutton.html#checked-prop) signal. It works similarly to `onClicked`, except here the assigned action will be executed when the button's state changes. It is a boolean property, which can come in handy for specific use cases.

In this example, we set the visibility of an inline drawer according to the status of a toggleable button:

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Controls.Button (toggleable version)"
    width: 400
    height: 400
    pageStack.initialPage: Kirigami.Page {
        ColumnLayout {
            anchors.fill: parent
            Controls.Button {
                Layout.alignment: Qt.AlignCenter
                text: "Hide inline drawer"
                checkable: true
                checked: true
                onCheckedChanged: myDrawer.visible = checked
            }

            Kirigami.OverlayDrawer {
                id: myDrawer
                edge: Qt.BottomEdge
                modal: false

                contentItem: Controls.Label {
                    text: "Peekaboo!"
                }
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

![A window containing a toggleable button "Hide inline drawer" in the center which when toggled hides the "Peekaboo" inline drawer](/docs/getting-started/kirigami/components-controls/controls-togglebutton.webp)

{{< /section-right >}}

{{< /sections >}}

{{< alert title="Note" color="info" >}}

With the default Breeze theme in KDE Plasma it can be hard to tell whether a button is toggled, since buttons are coloured blue when they are clicked on. Make sure you take this into account when creating your application: a different control might be more user friendly.

{{< /alert >}}

### Toolbar buttons

There is a specific button type meant for use in toolbars, [Controls.ToolButton](docs:qtquickcontrols;QtQuick.Controls.ToolButton). The most obvious difference between this and a conventional [Button](docs:qtquickcontrols;QtQuick.Controls.Button) is the styling, with toolbuttons being flat (though this is alterable with the boolean property [flat](https://doc.qt.io/qt-6/qml-qtquick-controls2-button.html#flat-prop)).

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Controls.ToolButton"
    width: 600
    height: 600

    header: Controls.ToolBar {
        RowLayout {
            anchors.fill: parent
            Controls.ToolButton {
                icon.name: "application-menu-symbolic"
                onClicked: showPassiveNotification("Kirigami Pages and Actions are better!")
            }
            Controls.Label {
                text: "Global ToolBar"
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            Controls.ToolButton {
                text: "Beep!"
                onClicked: showPassiveNotification("ToolButton boop!")
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

![A window showing a custom toolbar in the window header simulating a Kirigami.globalToolBar, with a left menu icon that shows a passive notification "Kirigami Pages and Actions are better!" and a right toolbutton "Beep" which is completely flat simulating a Kirigami.Action](/docs/getting-started/kirigami/components-controls/controls-toolbutton.webp)

{{< /section-right >}}

{{< /sections >}}

## Selection controls

Selection controls let users make a choice or pick an option. There are different types that are best suited to different situations.

### Checkboxes

A [Controls.CheckBox](docs:qtquickcontrols;QtQuick.Controls.CheckBox) is meant for options where the choices are non-exclusive and where each option has a clear alternative.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Controls.CheckBox"
    width: 400
    height: 400
    pageStack.initialPage: Kirigami.Page {
        ColumnLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            Controls.CheckBox {
                Layout.alignment: Qt.AlignHCenter
                text: "This checkbox is checked!"
                checked: true
            }
            Controls.CheckBox {
                Layout.alignment: Qt.AlignHCenter
                text: "This checkbox is not checked!"
                checked: false
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

![A window showing two checkboxes where more than one checkbox can be ticked at the same time](/docs/getting-started/kirigami/components-controls/controls-checkbox.webp)

{{< /section-right >}}

{{< /sections >}}

As you can see, they are simple to use. The [checked](https://doc.qt.io/qt-6/qml-qtquick-controls2-abstractbutton.html#checked-prop) property holds a boolean value determining whether or not they have been checked.

### Radio buttons

A [Controls.RadioButton](docs:qtquickcontrols;QtQuick.Controls.RadioButton) is designed for situations where the user must choose one option from a set of several options.

Radio buttons are exclusive by default: only one button can be checked in the same parent item.

Like checkboxes, they can be set to be checked or unchecked by default with the [checked](https://doc.qt.io/qt-6/qml-qtquick-controls2-abstractbutton.html#checked-prop) property.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Controls.RadioButton"
    width: 400
    height: 400
    pageStack.initialPage: Kirigami.Page {

        ColumnLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            Controls.RadioButton {
                Layout.alignment: Qt.AlignCenter
                text: "Tick!"
                checked: true
            }
            Controls.RadioButton {
                Layout.alignment: Qt.AlignCenter
                text: "Tock!"
                checked: false
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

![A window showing two radio buttons where only one radio button can be ticked at the same time](/docs/getting-started/kirigami/components-controls/controls-radiobutton.webp)

{{< /section-right >}}

{{< /sections >}}

### Switches

On the desktop, changing settings usually involves changing the setting and then applying it by clicking on an "Apply" or "OK" button. On mobile, we can use a [Controls.Switch](docs:qtquickcontrols;QtQuick.Controls.Switch) instead.

Switches can be toggled between an on and off state. They can be toggled by clicking or tapping on them, or they can be dragged towards the on or off position. Once again, switches can be set to be on or off by default with the [checked](https://doc.qt.io/qt-6/qml-qtquick-controls2-abstractbutton.html#checked-prop) property.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Controls.Switch"
    width: 400
    height: 400
    pageStack.initialPage: Kirigami.Page {
        ColumnLayout {
            anchors.fill: parent
            Controls.Switch {
                Layout.alignment: Qt.AlignCenter
                text: "Switchy"
                checked: true
            }
            Controls.Switch {
                Layout.alignment: Qt.AlignCenter
                text: "Swootchy"
                checked: false
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

![A window showing two evenly-spaced switches that function as toggles](/docs/getting-started/kirigami/components-controls/controls-switch.webp)

{{< /section-right >}}

{{< /sections >}}

## Sliders

Sliders allow users to select certain values by sliding a handle along a track. There are several types that you can choose from depending on the values you'd like your users to choose in your application.

### Standard and tickmarked sliders

A standard [Controls.Slider](docs:qtquickcontrols;QtQuick.Controls.Slider) provides the user with very fine control over the selection they wish to make.

In Left to Right mode, sliders go left to right to increase when in horizontal orientation, while in Right to Left mode they go in the reverse direction. In both modes, sliders in vertical orientation go from the bottom up.

The coloration provides a visual indicator of how large the value you are selecting is.

Sliders have a few important properties we must pay attention to:

- [value](https://doc.qt.io/qt-6/qml-qtquick-controls2-slider.html#value-prop): contains the value at which the handle is placed, and can also be set manually to provide a default starting value
- [to](https://doc.qt.io/qt-6/qml-qtquick-controls2-slider.html#to-prop): defines the range of the slider by specifying the maximum value it can go to
- [orientation](https://doc.qt.io/qt-6/qml-qtquick-controls2-slider.html#orientation-prop): allows the slider to be set to a vertical orientation with [Qt.Vertical](https://doc.qt.io/qt-6/qt.html#Orientation-enum)

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Controls.Slider"
    width: 400
    height: 400
    pageStack.initialPage: Kirigami.Page {
        ColumnLayout {
            anchors.fill: parent
            Controls.Slider {
                id: normalSlider
                Layout.alignment: Qt.AlignHCenter
                Layout.fillHeight: true
                orientation: Qt.Vertical
                value: 60
                to: 100
            }
            Controls.Label {
                Layout.alignment: Qt.AlignHCenter
                text: Math.round(normalSlider.value)
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

![A window showing a vertical slider with its current value underneath it](/docs/getting-started/kirigami/components-controls/controls-slider.webp)

{{< /section-right >}}

{{< /sections >}}

Another useful property we can use is [stepSize](https://doc.qt.io/qt-6/qml-qtquick-controls2-slider.html#stepSize-prop). Setting this to a numerical value allows us to create a slider that snaps onto values that are multiples of the specified `stepSize`, with these multiples being indicated by tickmarks. Therefore if we set this property to `2.0`, when the user drags the slider handle, they will only be able to select `0.0`, `2.0`, `4.0`, etc. up to the value specified in the `to` property.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Controls.Slider (with steps)"
    width: 400
    height: 400
    pageStack.initialPage: Kirigami.Page {
        ColumnLayout {
            anchors.fill: parent
            Controls.Slider {
                id: tickmarkedSlider
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                orientation: Qt.Horizontal
                snapMode: Controls.Slider.SnapAlways
                value: 6.0
                to: 10.0
                stepSize: 2.0
            }
            Controls.Label {
                Layout.alignment: Qt.AlignHCenter
                text: tickmarkedSlider.value
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

![A window showing a set of tickmarked sliders that are symmetrically divided, with each division being called a step](/docs/getting-started/kirigami/components-controls/controls-slidersteps.webp)

{{< /section-right >}}

{{< /sections >}}

### Range sliders

QtQuick Controls also provides [Controls.RangeSliders](docs:qtquickcontrols;QtQuick.Controls.RangeSlider). These have two handles, hence allowing you to define a range of numbers between the two handles.

Two new properties are important to keep in mind: [first.value](https://doc.qt.io/qt-6/qml-qtquick-controls2-rangeslider.html#first-prop) and [second.value](https://doc.qt.io/qt-6/qml-qtquick-controls2-rangeslider.html#second-prop), which hold the values of the two handles. Like the [value](https://doc.qt.io/qt-6/qml-qtquick-controls2-slider.html#value-prop) property of the standard sliders, these can be pre-set.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Controls.RangeSlider"
    width: 400
    height: 400
    pageStack.initialPage: Kirigami.Page {
        ColumnLayout {
            anchors.fill: parent
            Controls.RangeSlider {
                id: rangeSlider
                Layout.alignment: Qt.AlignHCenter
                to: 10.0
                first.value: 2.0
                second.value: 8.0
                stepSize: 1.0
                snapMode: Controls.Slider.SnapAlways
            }
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Controls.Label {
                    Layout.fillWidth: true
                    text: "The slider's first value is: " + Math.round(rangeSlider.first.value)
                }
                Controls.Label {
                    Layout.fillWidth: true
                    text: "The slider's second value is: " + Math.round(rangeSlider.second.value)
                }
            }
            Controls.Label {
                Layout.alignment: Qt.AlignHCenter
                font.bold: true
                text: "Is the selected range between 2 and 8?"
            }
            Controls.Button {
                Layout.alignment: Qt.AlignHCenter
                icon.name: {
                    if (rangeSlider.first.value >= 2 && rangeSlider.second.value <= 8)
                        return "emblem-checked"
                    else
                        return "emblem-error"
                }
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

![A window showing a range slider, followed by a few labels underneath and a button with a checkmark icon](/docs/getting-started/kirigami/components-controls/controls-rangeslider.webp)

{{< /section-right >}}

{{< /sections >}}
