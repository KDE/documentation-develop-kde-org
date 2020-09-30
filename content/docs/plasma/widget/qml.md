---
title: "Qml"
weight: 3
description: >
  Learn the basics of QML
---

This is a quick intro to QML. If you are already comfortable with it, skip to the next section.

The official QML tutorial can be found in the [QML Documentation](http://doc.qt.io/qt-5/qtqml-syntax-basics.html).

## Item

{{< sections >}}
{{< section-left >}}

An [Item](http://doc.qt.io/qt-5/qml-qtquick-item.html) is a simple visible object. It can have children as well. Item's have a default width and height of 0px, and will not grow to fit their contents. So unlike the HTML box model, you'll need to use layouts mentioned below.

{{< /section-left >}}
{{< section-right>}}
```qml
// main.qml
import QtQuick 2.0

Item {
    id: widget

    Item {
        id: childItemA
    }

    Item {
        id: childItemB
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## Rectangle

{{< sections >}}
{{< section-left >}}

If we want to draw a colored rectangle, we can easily do so with [Rectangle](http://doc.qt.io/qt-5/qml-qtquick-rectangle.html). For other properties of the Rectangle, like border color and width, read it's [page in the QML Documentation](http://doc.qt.io/qt-5/qml-qtquick-rectangle.html).

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0

Rectangle {
    color: "#0ff" // Teal
}
```
{{< /section-right >}}
{{< /sections >}}

![Teal QML Rectangle](rectangle.png)


## Items are 0px wide by default

{{< sections >}}
{{< section-left >}}

By default, an [Item](http://doc.qt.io/qt-5/qml-qtquick-item.html) will not expand to fit it's contents. Nor will it expand to fit the width of it's parent (like a `<div>` in HTML).

In the this example, only the Teal Rectangle will be visible, since the Green Rectangle has the default width of 0px and height of 0px. The Teal Rectangle is only visible since the root item in a widget's `main.qml` has a default size which will be explained later.

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0

Rectangle { // Unlike everything else, the widget's main item will have a default size.
    color: "#0ff" // Teal
    
    Rectangle { // For everything else, we need to set the size.
        color: "#0f0" // Green
    }
}
```
{{< /section-right >}}
{{< /sections >}}

![Teal QML Rectangle with invisible green Rectangle](rectangle2.png)


## anchors.fill

{{< sections >}}
{{< section-left >}}

In this second example, we make the Green Rectangle resize to the parent item, the Teal Rectangle. This will completely cover the Teal Rectangle so only the Green Rectangle will be visible.

![Green QML Rectangle completely covering the teal rectangle](anchorsfill.png)

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0

Rectangle { // Unlike everything else, the widget's main item will have a default size.
    color: "#0ff" // Teal
    
    Rectangle { // For everything else, we need to set the size.
        color: "#0f0" // Green
        anchors.fill: parent // Make sure we're the same size as the parent.
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## anchors.bottom

{{< sections >}}
{{< section-left >}}

In this third example, we anchor the Green Rectangle to the bottom right, and make it half the width & height of the Teal rectangle. So we end up with a rectangle which is 3/4 teal and 1/4 green.

![Green QML Rectangle in bottom right quadrant](anchorsbottom.png)

Other ways to use `anchors` properties can be read in the QML Documentation page on [Positioning with Anchors](https://doc.qt.io/qt-5/qtquick-positioning-anchors.html) and the [`Item.anchors` property group](https://doc.qt.io/qt-5/qml-qtquick-item.html#anchors-prop).

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0

Rectangle {
    color: "#0ff" // Teal
    
    Rectangle {
        color: "#0f0" // Green
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: parent.width / 2
        height: parent.height / 2
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## ColumnLayout

{{< sections >}}
{{< section-left >}}

If you want to stack a number of items on top of each other, you should use a [`ColumnLayout`](http://doc.qt.io/qt-5/qml-qtquick-layouts-columnlayout.html).

Labels (which are just fancy Text items which follow Plasma's colors) have a default font size, which means they have their own default height. So they will be stacked on top of each other.

Note that if the `ColumnLayout` is taller than it's contents, the children will have spacing between them.

![QML Label above another QML Label](columnlayout.png)

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 2.0 as PlasmaComponents

ColumnLayout {
    PlasmaComponents.Label {
        text: "Item 1"
    }
    PlasmaComponents.Label {
        text: "Item 2"
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## Layout.fillWidth: true

{{< sections >}}
{{< section-left >}}

If you want an item to scale to the parent's width, you have the option of setting it to be the same width as the parent (which doesn't work in a Layout). You can also try anchoring to the left and right (which does work).

Within a [Layout](http://doc.qt.io/qt-5/qml-qtquick-layouts-layout.html) however, the proper way to do so is to use the special property attached to the contents of a Layout, `Layout.fillWidth`. Setting it to `true` will make the item scale to fill up the empty space.

![](layoutfillwidth.png)

The other Layout related properties can be [read here](http://doc.qt.io/qt-5/qml-qtquick-layouts-layout.html).

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import QtQuick.Layouts 1.0

ColumnLayout {
    Rectangle {
        color: "#f00" // Red
        height: 40
        Layout.fillWidth: true
    }
    Rectangle {
        color: "#0f0" // Green
        height: 40
        width: parent.width // Does not work
    }
    Rectangle {
        color: "#00f" // Blue
        height: 40
        width: 40 // Does not fill parent
    }
    Rectangle {
        color: "#ff0" // Yellow
        height: 40
        anchors.left: parent.left
        anchors.right: parent.right
        // anchors in a ColumnLayout throws a "undefined behavior" warning.
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## Layout.fillHeight: true

{{< sections >}}
{{< section-left >}}

If you want one item (or several) in a Layout to expand to take up the unused space, you can use `Layout.fillHeight: true`.

![](layoutfillheight.png)

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import QtQuick.Layouts 1.0

ColumnLayout {
    Rectangle {
        color: "#f00" // Red
        height: 40
        Layout.fillWidth: true
    }
    Rectangle {
        color: "#0f0" // Green
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
    Rectangle {
        color: "#00f" // Blue
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
    Rectangle {
        color: "#ff0" // Yellow
        height: 40
        Layout.fillWidth: true
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## Spacing between items in a Layout

{{< sections >}}
{{< section-left >}}

In the last screenshot you might have noticed how there is still spacing between the items. That's because the default [ColumnLayout.spacing](http://doc.qt.io/qt-5/qml-qtquick-layouts-columnlayout.html#spacing-prop) property is set to `5`. Assigning it to `0` will remove the extra whitespace.

![](layoutspacing.png)

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import QtQuick.Layouts 1.0

ColumnLayout {
    spacing: 0

    Rectangle {
        color: "#f00" // Red
        height: 40
        Layout.fillWidth: true
    }
    Rectangle {
        color: "#0f0" // Green
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
    Rectangle {
        color: "#00f" // Blue
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
    Rectangle {
        color: "#ff0" // Yellow
        height: 40
        Layout.fillWidth: true
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## Other Layouts

{{< sections >}}
{{< section-left >}}

There's also [RowLayout](http://doc.qt.io/qt-5/qml-qtquick-layouts-rowlayout.html) and [GridLayout](http://doc.qt.io/qt-5/qml-qtquick-layouts-gridlayout.html). Lastly there's [Flow](http://doc.qt.io/qt-5/qml-qtquick-flow.html) which will treat it's contents as if they all had the CSS `display: inline-block`.

![](https://i.imgur.com/qrDdw8L.png)

{{< /section-left >}}
{{< section-right >}}
```qml
// main.qml
import QtQuick 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 2.0 as PlasmaComponents

RowLayout {
    PlasmaComponents.Label {
        text: "Item 1"
    }
    PlasmaComponents.Label {
        text: "Item 2"
    }
}
```
{{< /section-right >}}
{{< /sections >}}
