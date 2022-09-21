---
title: Controls and interactive elements
weight: 107
description: Make your apps more interactive by using buttons, selection controls, sliders, and text fields.
group: components
aliases:
  - /docs/kirigami/components-controls/
---


Kirigami offers a wide selection of different interactive elements that you can use in your applications. Each different type has slightly different interaction styles, visual styles, and functionality. Using the right type of control in your application can help make your user interface more responsive and intuitive.

## Buttons

In Kirigami apps, we use buttons from QtQuick Controls. Using them is pretty straightforward: we set the text to the `text` property and any action we want it to perform is set to the `onClicked` property.

{{< sections >}}
{{< section-left >}}

```qml
import QtQuick 2.0
import QtQuick.Controls 2.2 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.5

Kirigami.Page {

    Controls.Button {
        text: "Beep!"
        onClicked: showPassiveNotification("Boop!")
    }

}
```

{{< /section-left >}}
{{< section-right >}}

![A freshly-clicked button](/docs/use/kirigami/components-controls/controls-button.png)

{{< /section-right >}}
{{< /sections >}}

### Toggleable buttons

Buttons' behaviour can be changed to make them toggleable: in this mode, they will stay pressed until clicked on once more. This mode can be activated by setting the `checkable` property to `true`; we can also set buttons to be toggled on by default by setting the `checked` property to `true`. 

We can get the most out of toggleable buttons by using the `onCheckedChanged` property. It works similarly to `onClicked`, except here the assigned action will be executed when the button's `checked` property changes. `checked` is a boolean property, which can come in handy for specific use-cases.

In this example, we set the visibility of an in-line drawer according to the status of a toggleable button:

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

![A toggleable button](/docs/use/kirigami/components-controls/controls-togglebutton.png)

{{< /section-right >}}
{{< /sections >}}

{{< alert title="Note" color="info" >}}

With the default Breeze theme in KDE Plasma it can be hard to tell whether a button is toggled, since buttons are coloured blue when they are clicked on. Make sure you take this into account when creating your application: a different control might be more user-friendly.

{{< /alert >}}

### Toolbar buttons

There is a specific button type meant for use in toolbars, `Controls.ToolButton`. The most obvious difference between this and a conventional button is the styling, with toolbuttons being flat (though this is alterable with the boolean property `flat`).

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

![A tool button](/docs/use/kirigami/components-controls/controls-toolbutton.png)

{{< /section-right >}}
{{< /sections >}}

## Selection controls

Selection controls let users make a choice or pick an option. There are different types that are best suited to different situations.

### Checkboxes

Checkboxes are meant for options where the choices are non-exclusive and where each option has a clear alternative.

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

![A set of checkboxes](/docs/use/kirigami/components-controls/controls-checkbox.png)

{{< /section-right >}}
{{< /sections >}}

As you can see, they are simple to use. The property `checked` holds a boolean value determining whether or not they have been checked.

### Radio buttons

Radio buttons are designed for situations where the user must choose one option from a set of several options.

Radio buttons are exclusive by default: only one button can be checked in the same parent item.

Like checkboxes, they can be set to be checked or unchecked by default with the `checked` property.

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

![A set of radio buttons](/docs/use/kirigami/components-controls/controls-radiobutton.png)

{{< /section-right >}}
{{< /sections >}}

### Switches

Switches are primarily designed for use on mobile devices. 

On the desktop, changing settings usually involves changing the setting and then applying the setting by clicking on an 'Apply' or 'OK' button. On mobile, we can use switches instead.

Switches can be toggled between an on and off state. They can be clicked or tapped on to toggle them, or they can be dragged towards the 'on' or 'off' position. Once again, switches can be set to be on or off by default with the `checked` property.

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

![A set of switches](/docs/use/kirigami/components-controls/controls-switch.png)

{{< /section-right >}}
{{< /sections >}}

## Sliders

Sliders allow users to select certain values by sliding a handle along a track. Thanks to QtQuick Controls, there are several types that you can choose from depending on the values you'd like your users to choose from in your application.

### Standard and tickmarked sliders

A standard slider provides the user with very fine control over the selection they wish to make.

By default, sliders go left to right to increase (and bottom up to increase when vertical). The coloration provides a visual indicator of how large the value you are selecting is.

Sliders have a few important properties we must pay attention to:

- `value`: contains the value at which the handle is placed, and can also be set manually to provide a default starting value
- `to`: defines the range of the slider by specifying the maximum value it can go to
- `orientation`: allows the slider to be set to a vertical orientation with `Qt.Vertical`

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

![A set of sliders](/docs/use/kirigami/components-controls/controls-sliders.png)

{{< /section-right >}}
{{< /sections >}}

Another useful property we can use is `stepSize`. Setting this to a numerical value allows us to create a slider that snaps onto values that are multiples of the specified `stepSize`, with these multiples being indicated by tickmarks. Therefore if we set this property to `2.0`, when the user drags the slider handle, they will only be able to select `0.0`, `2.0`, `4.0`, etc. up to the value specified in the `to` property. 

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

![A set of tickmarked sliders](/docs/use/kirigami/components-controls/controls-tickmarkedsliders.png)

{{< /section-right >}}
{{< /sections >}}

### Range slider

QtQuick Controls also provides ranged sliders. These have two handles, hence allowing you to define a range of numbers between the two handles.

Two new properties are important to keep in mind: `first.value` and `second.value`, which hold the values of the two handles. Like the `value` property of the standard sliders, these can be pre-set.

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

![A set of range sliders](/docs/use/kirigami/components-controls/controls-rangesliders.png)

{{< /section-right >}}
{{< /sections >}}

We can also make it a tickmarked slider by setting the `stepSize` property value to a number, in the exact same way as a standard slider.

```qml
Controls.RangeSlider {
    id: rangeTickmarkedSlider
    to: 10.0
    first.value: 4.0
    second.value: 6.0
    stepSize: 2.0
}
```
