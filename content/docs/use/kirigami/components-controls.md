---
title: Controls and interactive elements
weight: 207
description: Make your apps more interactive by using buttons, selection controls, sliders, and text fields.
group: components
aliases:
  - /docs/kirigami/components-controls/
---


Kirigami offers a wide selection of different interactive elements that you can use in your applications. Each different type has slightly different interaction styles, visual styles, and functionality. Using the right type of control in your application can help make your user interface more responsive and intuitive.

## Buttons

In Kirigami apps, we use buttons from QtQuick Controls. Using them is pretty straightforward: we set the text to the [text](https://doc.qt.io/qt-6/qml-qtquick-controls2-abstractbutton.html#text-prop) property and any action we want it to perform is set to the [onClicked](docs:qtquickcontrols;QtQuick.Controls.AbstractButton::clicked) property.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20

Kirigami.Page {

    Controls.Button {
        text: "Beep!"
        onClicked: showPassiveNotification("Boop!")
    }

}
```

{{< /section-left >}}

{{< section-right >}}

![A window containing a button "Beep" on the upper left side, which when clicked shows a passive notification "Boop" at the bottom of the window](/docs/use/kirigami/components-controls/controls-button.png)

{{< /section-right >}}

{{< /sections >}}

### Toggleable buttons

The behavior of buttons can be changed to make them toggleable: in this mode, they will stay pressed until clicked on once more. This mode can be activated by setting their [checkable](https://doc.qt.io/qt-6/qml-qtquick-controls2-abstractbutton.html#checkable-prop) property to `true`; we can also set buttons to be toggled on by default by setting [checked](https://doc.qt.io/qt-5/qml-qtquick-controls2-abstractbutton.html#checked-prop) to `true`.

We can get the most out of toggleable buttons by using the `onCheckedChanged` signal handler which is [automatically generated](https://doc.qt.io/qt-6/qtqml-syntax-signals.html#property-change-signal-handlers) from the [checked](https://doc.qt.io/qt-5/qml-qtquick-controls2-abstractbutton.html#checked-prop) signal. It works similarly to `onClicked`, except here the assigned action will be executed when the button's state changes. It is a boolean property, which can come in handy for specific use cases.

In this example, we set the visibility of an inline drawer according to the status of a toggleable button:

{{< sections >}}

{{< section-left >}}

```qml
Controls.Button {
    text: "Toggle!!"
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
```

{{< /section-left >}}

{{< section-right >}}

![A window containing a toggleable button "Toggle" which when toggled displays "Peekaboo" in the contentItem area like a status bar](/docs/use/kirigami/components-controls/controls-togglebutton.png)

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
Controls.ToolButton {
    text: "Tool beep..."
    onClicked: showPassiveNotification("Tool boop!")
}
```

{{< /section-left >}}

{{< section-right >}}

![A window showing a tool button "Tool beep" which is completely flat](/docs/use/kirigami/components-controls/controls-toolbutton.png)

{{< /section-right >}}

{{< /sections >}}

## Selection controls

Selection controls let users make a choice or pick an option. There are different types that are best suited to different situations.

### Checkboxes

A [Controls.CheckBox](docs:qtquickcontrols;QtQuick.Controls.CheckBox) is meant for options where the choices are non-exclusive and where each option has a clear alternative.

{{< sections >}}

{{< section-left >}}

```qml
Controls.CheckBox {
    text: "Beep!"
    checked: true
}
Controls.CheckBox {
    text: "Boop!"
    checked: false
}
```

{{< /section-left >}}

{{< section-right >}}

![A window showing a set of checkboxes where more than one checkbox can be ticked at the same time](/docs/use/kirigami/components-controls/controls-checkbox.png)

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
ColumnLayout {
    Controls.RadioButton {
        text: "Tick!"
        checked: true
    }
    Controls.RadioButton {
        text: "Tock!"
        checked: false
    }
}
```

{{< /section-left >}}

{{< section-right >}}

![A window showing a set of radio buttons where only one radio button can be ticked at the same time](/docs/use/kirigami/components-controls/controls-radiobutton.png)

{{< /section-right >}}

{{< /sections >}}

### Switches

On the desktop, changing settings usually involves changing the setting and then applying it by clicking on an "Apply" or "OK" button. On mobile, we can use a [Controls.Switch](docs:qtquickcontrols;QtQuick.Controls.Switch) instead.

Switches can be toggled between an on and off state. They can be toggled by clicking or tapping on them, or they can be dragged towards the on or off position. Once again, switches can be set to be on or off by default with the [checked](https://doc.qt.io/qt-6/qml-qtquick-controls2-abstractbutton.html#checked-prop) property.

{{< sections >}}

{{< section-left >}}

```qml
Controls.Switch {
    text: "Switchy"
    checked: true
}
Controls.Switch {
    text: "Swootchy"
    checked: false
}
```

{{< /section-left >}}

{{< section-right >}}

![A window showing a set of switches that function as toggles](/docs/use/kirigami/components-controls/controls-switch.png)

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
- [to](https://doc.qt.io/qt-5/qml-qtquick-controls2-slider.html#to-prop): defines the range of the slider by specifying the maximum value it can go to
- [orientation](https://doc.qt.io/qt-5/qml-qtquick-controls2-slider.html#orientation-prop): allows the slider to be set to a vertical orientation with `Qt.Vertical`

{{< sections >}}

{{< section-left >}}

```qml
Controls.Slider {
    id: normalSlider
    orientation: Qt.Vertical
    value: 5.0
    to: 10.0
}
```

{{< /section-left >}}

{{< section-right >}}

![A window showing a set of sliders, one horizontal and one vertical](/docs/use/kirigami/components-controls/controls-sliders.png)

{{< /section-right >}}

{{< /sections >}}

Another useful property we can use is [stepSize](https://doc.qt.io/qt-6/qml-qtquick-controls2-slider.html#stepSize-prop). Setting this to a numerical value allows us to create a slider that snaps onto values that are multiples of the specified `stepSize`, with these multiples being indicated by tickmarks. Therefore if we set this property to `2.0`, when the user drags the slider handle, they will only be able to select `0.0`, `2.0`, `4.0`, etc. up to the value specified in the `to` property.

{{< sections >}}

{{< section-left >}}

```qml
Controls.Slider {
    id: tickmarkedSlider
    value: 6.0
    to: 10.0
    stepSize: 2.0
}
```

{{< /section-left >}}

{{< section-right >}}

![A window showing a set of tickmarked sliders that are symmetrically divided, with each division being called a step](/docs/use/kirigami/components-controls/controls-tickmarkedsliders.png)

{{< /section-right >}}

{{< /sections >}}

### Range sliders

QtQuick Controls also provides [Controls.RangeSliders](docs:qtquickcontrols;QtQuick.Controls.RangeSlider). These have two handles, hence allowing you to define a range of numbers between the two handles.

Two new properties are important to keep in mind: [first.value](https://doc.qt.io/qt-6/qml-qtquick-controls2-rangeslider.html#first-prop) and [second.value](https://doc.qt.io/qt-5/qml-qtquick-controls2-rangeslider.html#second-prop), which hold the values of the two handles. Like the [value](https://doc.qt.io/qt-6/qml-qtquick-controls2-slider.html#value-prop) property of the standard sliders, these can be pre-set.

{{< sections >}}

{{< section-left >}}

```qml
Controls.RangeSlider {
    id: rangeSlider
    to: 10.0
    first.value: 3.0
    second.value: 6.0
}
```

{{< /section-left >}}

{{< section-right >}}

![A window showing a set of range sliders with two movable circles used to delimit a certain range](/docs/use/kirigami/components-controls/controls-rangesliders.png)

{{< /section-right >}}

{{< /sections >}}

We can also make it a tickmarked slider by setting the [stepSize](https://doc.qt.io/qt-6/qml-qtquick-controls2-rangeslider.html#stepSize-prop) property value to a number, in the exact same way as a standard slider.

```qml
Controls.RangeSlider {
    id: rangeTickmarkedSlider
    to: 10.0
    first.value: 4.0
    second.value: 6.0
    stepSize: 2.0
}
```
