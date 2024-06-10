---
title: Explaining pages
weight: 2
group: introduction
description: Pages allow you to organize your application content
aliases:
  - /docs/getting-started/kirigami/introduction-pages/
---
# Our app

In the previous tutorial, we managed to set up, build, and compile our first Kirigami application. With the basics in place, we can begin our journey towards creating a fully-featured application.

These tutorials will focus on creating an application that lets the user see how many days are left until an event of their choice.

We also recommend you check out the [Kirigami Gallery](https://apps.kde.org/en/kirigami2.gallery), which provides a number of useful UI examples.

In this section we'll be focusing on pages, one of the key structural elements of any Kirigami application.

## Pages

Kirigami apps are typically organized in pages by using [Kirigami.Page](docs:kirigami2;Page). Pages are the different "screens" of an app. You will want to have a page dedicated to specific aspects of your app's interaction, and to make things easier you can create different QML files for each page.

Pages are organized in a [page stack](docs:kirigami2;AbstractApplicationWindow::pageStack) where they can be pushed and popped. On a phone only the top-most page is shown, whereas on a larger screen (desktop or tablet), if desired, multiple pages can be shown next to each other.

{{< compare >}}

{{< figure class="text-left mx-auto" caption="A single page on the phone" src="mobile.webp" >}}

{{< figure class="text-right mx-auto" caption="Two pages next to each other on the desktop" src="desktop.webp" >}}

{{< /compare >}}

{{< alert title="Note" color="info" >}}

A [Kirigami.Page](docs:kirigami2;Page) inherits from a [Controls.Page](docs:qtquickcontrols;QtQuick.Controls.Page), and as such you can use the latter's properties as well.

When looking through QML API documentation, make sure to look into the functions and properties inherited by the API you are looking at as well.

{{< /alert >}}

Let's go back to the `Main.qml` file we created in our previous tutorial:

{{< readfile file="/content/docs/getting-started/kirigami/introduction-getting_started/src/qml/Main.qml" highlight="qml" >}}

We make our application start to our [Kirigami.Page](docs:kirigami2;Page). All we have included in it is a label containing "Hello World", but we're going to spruce things up a little.

The idea behind our app is that we're going to be able to display a bunch of countdowns to the user. The problem with a normal [Kirigami.Page](docs:kirigami2;Page) is that it has a fixed vertical size, so instead we can use a [Kirigami.ScrollablePage](docs:kirigami2;ScrollablePage), which already comes with its own built-in scrollbar.

{{< readfile file="content/docs/getting-started/kirigami/introduction-pages/Main.qml" highlight="qml" >}}

Kirigami pages also feature neat titles placed within the toolbar, quickly indicating to the user which page they are on. All we need to do is to set a page title using the `title` property of [Kirigami.ScrollablePage](docs:kirigami2;ScrollablePage). In this case, we used one of the `i18nc()` functions we explored in our previous tutorial to this end.

{{< alert title="Note" color="info" >}}

You could also choose to define your page within its own QML document. To do so, you'd create the new QML file, for example `kirigami-tutorial/src/qml/StartPage.qml`, add it to your `kirigami-tutorial/src/CMakeLists.txt` file, and set the window's first page to load it, like so:

```js
pageStack.initialPage: Qt.resolvedUrl("StartPage.qml")
```

`pageStack.initialPage` sets the initial Page of the application's page stack, and [Qt.resolvedUrl](docs:qtqml;QtQml.Qt::resolvedUrl) converts the relative URL of the QML file into an absolute one.

There is further information about alternative page structures [within our Kirigami documentation](/docs/getting-started/kirigami/components-pagerow_pagestack).

{{< /alert >}}
