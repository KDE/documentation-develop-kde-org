---
title: Basic Controls
weight: 3
group: introduction
description: >
  Learn how to add some basic components to your application
---

In the first part of this tutorial, you generated a sample Kirigami application that
doesn’t do much yet. Time to change that! In this part you will be filling the
screen with some controls.

## Basic controls

In the following, we will use the example of an application that checks departures
and routes for public transport.
On the start page, there needs to be a way to enter start and 
destination of our journey as well as the date and time of our travel. For start
and destination you can use the `TextField` component from QtQuick Controls 2. Note that
the older version 1 of QtQuick Controls is still around for the foreseable future,
but you want to avoid using that. We’re extending `StartPage.qml` with our controls

```qml
ColumnLayout {
    width: parent.width

    Label {
        text: "From:"
    }
    TextField {
        Layout.fillWidth: true
        placeholderText: "Würzburg..."
    }
    Label {
        text: "To:"
    }
    TextField {
        Layout.fillWidth: true
        placeholderText: "Berlin..."
    }
}
```

A [ColumnLayout](https://doc.qt.io/qt-5/qml-qtquick-layouts-columnlayout.html) is a
component that positions its children vertically. We set it to be as wide as its
parent, the page. The TextFields shall span the whole width as well. Instead of
using the same ‘width: parent.width’ we are using ‘Layout.fillWidth: true’. This
property is only available to children of a Layout. The difference to the first way
is that all the width that is not already occupied by other elements in the layout
is filled.

Next you need some way to enter a departure date and time. Creating a time and date
picker requires the need of the Kirigami Addons, so for the time being two simple
placeholder buttons shall be enough. Let’s add them to our ColumnLayout

```qml
RowLayout {
    width: parent.width
    Button {
        text: "Pick date"
        Layout.fillWidth: true
    }
    Button {
        text: "Pick time"
        Layout.fillWidth: true
    }
}
```

Now your app looks like this. Both buttons have the `Layout.fillWidth` property set to
true, resulting in each one getting 50% of the space.

![Application screenshot](style1.png)

The buttons look a bit weird, don’t they? That’s because they are using the built-in
QtQuick Controls style. If you are using Plasma you are probably used to the
`org.kde.desktop` style which emulates the active Qt Widgets style. You can force your
app to use the `org.kde.desktop` style by running `QT_QUICK_CONTROLS_STYLE="org.kde.desktop" <app name>`.

![Application screenshot](style2.png)

Looks closer to what you have on the desktop, doesn’t it? Qt also offers a ‘material’
style that follows Android’s material guidelines

![Application screenshot](style3.png)

Next we need a way to press “Search”. We could solve that with yet another button, but Kirigami offers another way. Pages in Kirigami can have Actions associated with them. The presentation differes from the phone to the desktop. On the phone actions are displayed on the bottom where they are easily reachable while on the desktop they are displayed in form of a toolbar at the top of the page. Let’s add an action to our page.

```qml
Kirigami.Page
{
    id: root

    title: "Start journey"

    actions.main: Kirigami.Action {
        icon.name: "search"
        text: "Search"
        onTriggered: pageStack.push(Qt.resolvedUrl("ConnectionsPage.qml"))
    }

    ColumnLayout {
```

On the phone you get this

![Application with Search button on the bottom](search1.png)

while on the desktop you get that:

![Application with Search button on the top](search2.png)

You can force the mobile view on the desktop by setting the `QT_QUICK_CONTROLS_MOBILE` environement variable to `1`.

Triggering the action pushes ConnectionsPage.qml on the pageStack. Of cource you need to create that one now:

```qml
import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.4
import org.kde.kirigami 2.4 as Kirigami

Kirigami.Page
{
    title: "Connections"
}
```

Now that you know how to add elements to the user interface of your application, you will probably want them to have useful functionality.
[Continue to the next page](../connect_backend) on how to do that.
