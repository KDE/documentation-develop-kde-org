---
title: Explaining Pages
weight: 2
group: introduction
description: Pages allow you to organize your application content
---
# Our app

In the previous tutorial, we managed to set up, build, and compile our first Kirigami application. With the basics in place, we can begin our journey towards creating a fully-featured application.

These tutorials will focus on creating an application that lets the user see how many days are left until an event of their choice. That doesn't mean you shouldn't deviate and try to create your own thing! Just make sure you pay close attention to how things work *first*, so that you can adjust when things are different in your own code. We also recommend you check out the [Kirigami Gallery](https://apps.kde.org/en/kirigami2.gallery), which provides a number of useful UI examples and provides easy access to all the code.

In this section we'll be focusing on pages, one of the key structural elements of any Kirigami application.

## Pages

Kirigami apps are typically organized in [Pages](docs:kirigami2;Page). Those are the different ‘Screens’ of an app. You will want to have a page dedicated to specific aspects of your app's interaction, and you can create different QML files each containing the code for separate pages.

Pages are organized in a pagestack where they can be pushed and popped. On a phone only the topmost page is shown, whereas on a larger screen (desktop or tablet) multiple pages can be shown next to each other.

![A single page on the phone](mobile.png)

![Two pages next to each other on the desktop](desktop.png)

{{< alert title="Note" color="info" >}}
KDE has a handy [Human Interface Guidelines (HIG) page](/hig/introduction/architecture/) that goes into detail about how to best design your application. The guides there will help ensure your application remain usable, consistent, and aesthetic.

A Kirigami [Page](docs:kirigami2;Page) also inherits from a [QQC2 Page](https://doc.qt.io/qt-5/qml-qtquick-controls2-page.html)
and as such, you can add a number of extra elements to them. The Qt docs are another useful resource to use when designing your pages.
{{< /alert >}}

Let's go back to the `main.qml` file we created in our previous tutorial:

{{< readfile file="/content/docs/kirigami/introduction-getting_started/src/contents/ui/main.qml" highlight="qml" >}}

We make our application start to our `Kirigami.Page`. All we have included in it is a label containing 'Hello World', but we're going to spruce things up a little.

The idea behind our app is that we're going to be able to display a bunch of countdowns to the user. The problem with a normal `Kirigami.Page` is that it has a fixed vertical size, but don't worry: Kirigami also supports scrollable pages. `Kirigami.ScrollablePage` is going to replace our `Kirigami.Page` now.

{{< alert title="Warning" color="warning" >}}
If you've gone ahead of the tutorial, you might have noticed that there is also such a thing as a `ScrollView` that you can use to contain your components. However, do NOT put a `ScrollView` inside a `ScrollablePage` as this can cause problems. Children of a `ScrollablePage` are functionally already in a `ScrollView`.
{{< /alert >}}

```qml
Kirigami.ScrollablePage {
    title: i18nc("@title", "Kountdown")
    ...
}
```

Kirigami pages also feature neat titles placed within the toolbar, quickly indicating to the user which page they are on. All we need to do to set a page title using the `title` property of `Kirigami.ScrollablePage`. In this case, we used one of the `i18nc()` functions we explored in our previous tutorial to this end.

{{< alert title="Note" color="note" >}}
You could also choose to define your page within its own QML document. To do so, you'd create the new QML doc, add it to your `resources.qrc` file, and set `Kirigami.ApplicationWindow`'s first page to it like so:

```js
pageStack.initialPage: Qt.resolvedUrl("StartPage.qml")
```

`pageStack.initialPage` sets the initial Page of the Page stack, and `Qt.resolvedUrl` is converting the relative URL of the QML file into an absolute one.

There is further information about alternative page structures [within our Kirigami documentation](/docs/kirigami/manipulate-pages/).
{{< /alert >}}
