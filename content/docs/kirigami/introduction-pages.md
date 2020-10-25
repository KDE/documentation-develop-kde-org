---
title: Pages
weight: 3
group: components
description: Pages allow you to organize your application content
---

## `Kirigami.Page`

Kirigami apps are typically organized in [Pages](docs:kirigami2;Page)
Those are the different ‘Screens’
of an app. If you come from the Android world you can think of them as the view
part of activities. In our case we want to have an initial page that offers to
enter a stop or a destination and opens a new page that shows a list of possible
routes. Clicking on one of the list items opens a new page with a detailed view
about the connections.

Pages are organized in a pagestack where they can be pushed and popped. On a phone
only the topmost page is shown, whereas on a larger screen (desktop or tablet)
multiple pages can be shown next to each other.

![A single page on the phone](mobile.png)

![Two pages next to each other on the desktop](desktop.png)

So let’s create some pages! To simplify the QML code, you are going to put each
page in its own `.qml` file and let the name end with `Page`. The first version of
`StartPage.qml` looks like this:

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
it to the pageStack. Replace the `Label {}` declaration in `main.qml` with

```js
pageStack.initialPage: Qt.resolvedUrl("StartPage.qml")
```

`pageStack.initialPage` is, well, setting the initial Page of the Page stack.
`Qt.resolveUrl` is converting the relative URL of the QML file into an absolute one.

You will also need to add the new page into the .qrc file, so that it can be bundled
into the binary.

```xml
<RCC>
    <qresource prefix="/">
        <file alias="main.qml">contents/ui/main.qml</file>
        <file alias="StartPage.qml">contents/ui/StartPage.qml</file>
    </qresource>
</RCC>
```

## `Kirigami.ScrollablePage`

A [ScrollablePage](docs:kirigami2;ScrollablePage)
is a Page that holds scrollable content, such as ListViews. Scrolling and scrolling indicators will
be automatically managed.

```json
ScrollablePage {
    id: root
    //The rectangle will automatically be scrollable
    Rectangle {
        width: root.width
        height: 99999
    }
}
```

{{< alert color="danger" title="Warning" >}}
Do not put a ScrollView inside of a ScrollablePage; children of a ScrollablePage are already inside a ScrollView.
{{< /alert >}}

Another behavior added by this class is a "pull to refresh" behavior.
To use this, activate it as follows:


```json
Kirigami.ScrollablePage {
    id: view
    supportsRefreshing: true
    onRefreshingChanged: {
        if (refreshing) {
            myModel.refresh();
        }
    }
    ListView {
        // NOTE: MyModel doesn't come from the components,
        // it's purely an example on how it can be used together
        // some application logic that can update the list model
        // and signals when it's done.
        model: MyModel {
            onRefreshDone: view.refreshing = false;
        }
        delegate: BasicListItem {}
    }
}
```

By pulling down, you can also activate a special mode with a larger top margin making single-handed usage of the application easier.

## More on pages

A Kirigami [Page](docs:kirigami2;Page) inherits from a [QQC2 Page](https://doc.qt.io/qt-5/qml-qtquick-controls2-page.html)
and as such, you can add a header and footer to the Page.
