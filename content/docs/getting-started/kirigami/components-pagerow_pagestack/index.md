---
title: Page rows and page stacks
description: "Add flow to your application: Add, remove and replace pages in different ways"
weight: 202
group: components
aliases:
  - /docs/getting-started/kirigami/components-pagerow_pagestack/
---

## A row of pages

We have seen so far that one of the core components of a Kirigami window is a [Kirigami.Page](docs:kirigami2;Page). A single page can envelop the whole screen of the application, or it can be shown together with other pages at the same time, if there is space.

Whenever a page gets added, or *pushed*, it appears to the right of the existing page(s), forming a row. This row of pages can be managed with the fittingly named [Kirigami.PageRow](docs:kirigami2;PageRow).

A minimal page row with a single page could look like this:

```qml
import QtQuick
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Single Page"
    width: 500
    height: 200

    Kirigami.PageRow {
        anchors.fill: parent

        Kirigami.Page {
            id: mainPage
            anchors.fill: parent
            Rectangle {
                anchors.fill: parent
                color: "lightblue"
            }
        }
    }
}
```

{{< figure class="text-center" caption="A single page with light blue color to show the page's dimensions" src="singlepage.webp" >}}

There are two improvements that can be done here. The first is that, with [initialPage](docs:kirigami2;PageRow::initialPage), we can both set `mainPage` to be the first page that appears in the page row, and have its dimensions be managed by the page row instead of via manual [anchors](https://doc.qt.io/qt-6/qtquick-positioning-anchors.html), [positioners](https://doc.qt.io/qt-6/qtquick-positioning-layouts.html) or [layouts](https://doc.qt.io/qt-6/layout.html). The second is to have a toolbar, which can be set by defining a toolbar style with [globalToolBar.style](docs:kirigami2;PageRow::globalToolBar). There are a few styles we can choose from, but we'll go with [Kirigami.ApplicationHeaderStyle.Auto](docs:kirigami2;templates::ApplicationHeader::headerStyle) for now.

```qml
import QtQuick
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "With globalToolBar and initialPage"
    width: 500
    height: 200
    Kirigami.PageRow {
        anchors.fill: parent
        globalToolBar.style: Kirigami.ApplicationHeaderStyle.Auto
        initialPage: Kirigami.Page {
            Rectangle {
                anchors.fill: parent
                color: "lightblue"
            }
        }
    }
}
```

{{< figure class="text-center" caption="A single page with toolbar and light blue color to show the page's dimensions" src="initialpage.webp" >}}

There are only two ways of adding pages to a page row: by setting its [initialPage](docs:kirigami2;PageRow::initialPage) (which can optionally take an array of pages) or by using [push()](docs:kirigami2;PageRow::push). To delete a page from the page row, you should use [pop()](docs:kirigami2;PageRow::pop), whereas [goBack()](docs:kirigami2;PageRow::goBack) or [goForward()](docs:kirigami2;PageRow::goForward) can be used to navigate between pages.

```qml
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Multiple pages in a row"
    width: 700
    height: 300
    Kirigami.PageRow {
        id: mainRow
        anchors.fill: parent
        globalToolBar.style: Kirigami.ApplicationHeaderStyle.Auto
        initialPage: Kirigami.Page {
            id: firstPage
            Rectangle {
                anchors.fill: parent
                color: "lightblue"
                Controls.Button {
                    anchors.centerIn: parent
                    text: "Push!"
                    onClicked: mainRow.push(secondPage)
                }
            }
        }

        Component {
            id: secondPage
            Kirigami.Page {
                Rectangle {
                    anchors.fill: parent
                    color: "lightgreen"
                    Controls.Button {
                        anchors.centerIn: parent
                        text: "Pop!"
                        onClicked: mainRow.pop()
                    }
                }
            }
        }
    }
}
```

{{< figure class="text-center" caption="Initial page with light blue color" src="multiplepages1.webp" >}}

{{< figure class="text-center" caption="Upon clicking \"Push!\", a second page with light green color shows up" src="multiplepages2.webp" >}}

## The application's stack of pages

If a [Kirigami.PageRow](docs:kirigami2;PageRow) with a toolbar looks familiar to you, that is because you have seen it before. An [ApplicationWindow.pageStack](docs:kirigami2;AbstractApplicationWindow::pageStack) is nothing more than a very convenient, global page row. Every function available to a `PageRow` is also available to the `pageStack`.

The previous example can be reduced significantly with a `pageStack`, with the added bonus of navigation actions:

```qml
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Using the pageStack"
    width: 500
    height: 200
    pageStack.initialPage: Kirigami.Page {
            id: firstPage
            Rectangle {
                anchors.fill: parent
                color: "lightblue"
                Controls.Button {
                    anchors.centerIn: parent
                    text: "Push!"
                    onClicked: pageStack.push(secondPage)
                }
            }
        }
        Component {
            id: secondPage
            Kirigami.Page {
                Rectangle {
                    anchors.fill: parent
                    color: "lightgreen"
                    Controls.Button {
                        anchors.centerIn: parent
                        text: "Pop!"
                        onClicked: pageStack.pop()
                }
            }
        }
    }
}
```

{{< compare >}}

{{< figure class="text-center mx-auto" src="pagestack1.webp" >}}

{{< figure class="text-center mx-auto" src="pagestack2.webp" >}}

{{< /compare >}}

In general you'll want to use a `pageStack` rather than implement your own [PageRow](docs:kirigami2;PageRow), especially when your application gets bigger and you need your components living in separate files. If you create your window in your `Main.qml` using a [Kirigami.ApplicationWindow](docs:kirigami2;ApplicationWindow), a component residing in another file can still directly invoke the global `pageStack` by means of a call to the [applicationWindow()](docs:kirigami2;AbstractApplicationWindow::applicationWindow):

```qml
// "Main.qml"
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Pushing a Page from a different QML file"
    width: 700
    height: 400
    pageStack.initialPage: BasicPage {}
}
```

and

```qml
// "BasicPage.qml"
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.Page {
    Controls.Button {
        anchors.centerIn: parent
        text: "This pushes page1 from BasicPage\ninto the pageStack from Main.qml!"
        onClicked: {
            applicationWindow().pageStack.push(page1)
        }
        Component {
            id: page1
            Kirigami.Page {
                Controls.Label {
                    anchors.centerIn: parent
                    text: "page1 was pushed!"
                }
            }
        }
    }
}
```


{{< figure class="text-center" caption="Clicking the button pushes a new page with help of applicationWindow" src="pushpage.webp" >}}
