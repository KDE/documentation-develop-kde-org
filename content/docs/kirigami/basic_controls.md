---
title: Basic Controls
weight: 2
---

In the first part of this tutorial, you created a stub Python/Kirigami app that
doesn’t do anything. Time to change that! In this post you will be filling the
screen with some controls.

## Kirigami Pages

Kirigami apps are typically organized in Pages. Those are the different ‘Screens’
of an app. If you come from the Android world you can think of them as the view
part of activities. In our case we want to have an initial page that offers to
enter a stop or a destination and opens a new page that shows a list of possible
routes. Clicking on one of the list items opens a new page with a detailed view
about the connections.

Pages are organized in a pagestack where pages can be pushed and popped. On a phone
only the topmost page is shown, whereas on a larger screen (desktop or tablet)
multiple pages can be shown next to each other.

{{< figure src="mobile.png" title="A single page on the phone" >}}

{{< figure src="desktop.png" title="Two pages next to each other on the desktop" >}}

So let’s create some pages! To simplify the QML code, you are going to put each
page in its own .qml file and let the name end with Page. The first version of
StartPage.qml looks like this:

```json
import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.4
import org.kde.kirigami 2.0 as Kirigami

Kirigami.Page
{
    title: "Start journey"
}
```

It produces an empty page with a title. Before we can actually see it we need to add
it to the pageStack. Replace the `Label {}` declaration in main.qml with

```js
pageStack.initialPage: Qt.resolvedUrl("StartPage.qml")
```

`pageStack.initialPage` is, well, setting the initial Page of the Page stack.
`Qt.resolveUrl` is converting the relative URL of the QML file into an absolute one.
Starting the app gives us an empty page

## Basic controls

Remember the original goal, building a application that check departures and routes
for public transport. So on the start page you need need a way to enter start and
destination of our journey as well as the date and time of our travel. For start
and destination you can use simple TextFields from QtQuick Controls 2. Note that
the older version 1 of QtQuick Controls is still around for the foreseable future,
but you want to avoid using that. We’re extending StartPage.qml with our controls

```json
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

```json
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
app to use the org.kde.desktop style by running `QT_QUICK_CONTROLS_STYLE=”org.kde.desktop” ./main.py`.

![Application screenshot](style2.png)

Looks closer to what you have on the desktop, doesn’t it? Qt also offers a ‘material’
style that follows Android’s material guidelines

![Application screenshot](style3.png)

Next we need a way to press “Search”. We could solve that with yet another button, but Kirigami offers another way. Pages in Kirigami can have Actions associated with them. The presentation differes from the phone to the desktop. On the phone actions are displayed on the bottom where they are easily reachable while on the desktop they are displayed in form of a toolbar at the top of the page. Let’s add an action to our page.

```json
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

```json
import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.4
import org.kde.kirigami 2.4 as Kirigami

Kirigami.Page
{
    title: "Connections"
}
```

<!-- Right now it’s just an empty page, you’re going to fill it with life in the [next part of this turorial](search_page). -->

