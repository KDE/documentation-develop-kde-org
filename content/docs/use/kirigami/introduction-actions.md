---
title: Adding actions
group: introduction
weight: 4
description: >
  Learning more about Kirigami's Actions will help us make our application more useful.
aliases:
  - /docs/kirigami/introduction-actions/
---
## Recap

So far, we have managed to build a simple app that can display cards. However, we don't yet have a way of adding new cards to our card view.

In this tutorial, we'll be looking at Kirigami actions. These will help us add interactivity to our app in a consistent, fast, and accessible way.

## Actions

A [Kirigami.Action](docs:kirigami2;Action) encapsulates a user interface action. We can use these to provide our applications with easy-to-reach actions that are essential to their functionality.

{{< compare >}}

{{< figure class="text-center" caption="Page actions on the desktop" src="actions_desktop_page.webp" >}}

{{< figure class="text-center" caption="Page actions on mobile" src="actions_mobile_page.webp">}}

{{< /compare >}}


If you have used Kirigami apps before, you have certainly interacted with Kirigami Actions. In this image, we can see actions to the right of the page title with various icons. Kirigami Actions can be displayed in several ways and can do a wide variety of things.

## Adding countdowns

{{< sections >}}

{{< section-left >}}

A countdown app is pretty useless without the ability to add countdowns. Let's create an action that'll let us do this.

```qml

pageStack.initialPage: Kirigami.ScrollablePage {
    ...
    actions.main: Kirigami.Action {
        id: addAction
        icon.name: "list-add"
        text: i18nc("@action:button", "Add kountdown")
        onTriggered: kountdownModel.append({
            name: "Kirigami Action added card!",
            description: "Congratulations, your Kirigami Action works!",
            date: 1000
        })
    }
    ...
}
```

We are placing our Kirigami Action within our main page from our previous tutorials. If we wanted to, we could add more actions to our page (and even nest actions within actions!). [Kirigami.Action](docs:kirigami2;Action) components are used as contextual actions within Kirigami pages. We are setting it specifically to the [actions.main](docs:kirigami2;Page::actions) property of our [Kirigami.Page](docs:kirigami2;Page): the `actions` object has properties that let us set different actions in different positions, but since our "Add kountdown" action is central to our UI we are setting it as the main action of this page.

The `id` and `text` properties should be familiar from previous tutorials. However, the inherited [Action.icon](https://doc.qt.io/qt-5/qml-qtquick-controls2-action.html#icon-prop) property should be interesting: it is an object with several properties letting you display certain icons for your actions. Fortunately, to use KDE icons all we need to do is provide the name property for the icon property, `icon.name`.

{{< alert title="Note" color="info" >}}

Cuttlefish is a KDE application that lets you view all the icons that you can use for your application. It offers a number of useful features such as previews of their appearance across different installed themes, previews at different sizes, and more. You might find it a useful tool when deciding on which icons to use in your application. 

Many of KDE's icons follow the FreeDesktop Icon Naming specification. Therefore, you might also find it useful to consult The FreeDesktop project's website, [which lists all cross-desktop compatible icon names](https://specifications.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html).

{{< /alert >}}

The [onTriggered](docs:qtquickcontrols;QtQuick.Controls.Action::triggered) signal handler is the most important. This is what our action will do when it is used. You'll notice that in our example we're using the method [kountdownModel.append](https://doc.qt.io/qt-6/qml-qtqml-models-listmodel.html#append-method) of the `kountdownModel` we created in our previous tutorial. This method lets us append a new element to our list model. We are providing it with an object (indicated by curly braces `{}`) that has the relevant properties for our countdowns (`name`, `description`, and a placeholder `date`).

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="Each time we click our \"Add kountdown\" button on the top right, our custom countdown is added" src="action_result.webp" >}}

{{< figure class="text-center" caption="Mobile version" src="action_result_mobile.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Global drawer

{{< sections >}}

{{< section-left >}}

Did you notice those three lines next to the page title on the previous screenshot? That's a hamburger menu that opens a [Kirigami.GlobalDrawer](docs:kirigami2;GlobalDrawer). Global drawers are useful for global navigation and actions: in other words, those things you might need to use throughout your application. We are going to create a simple global drawer that includes a "quit" button.

```qml
Kirigami.ApplicationWindow {
    id: root
    ...
    globalDrawer: Kirigami.GlobalDrawer {
        isMenu: true
        actions: [
            Kirigami.Action {
                text: i18n("Quit")
                icon.name: "gtk-quit"
                shortcut: StandardKey.Quit
                onTriggered: Qt.quit()
            }
        ]
    }
    ...
}

```

Here, we put our global drawer inside our application window. The main property we need to pay attention to is [GlobalDrawer.actions](docs:kirigami2;GlobalDrawer::actions), which takes the form of an array of [Kirigami.Action](docs:kirigami2;Action) components. This action has an appropriate icon and executes the [Qt.quit()](docs:qtqml;QtQml.Qt::quit) function when triggered, closing the application.


Since we are keeping our global drawer simple for now, we are setting the [GlobalDrawer.isMenu](docs:kirigami2;GlobalDrawer::isMenu) property to `true`. This displays our global drawer as a normal application menu, taking up less space than the default global drawer pane.

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="Global drawer" src="global_drawer.webp" >}}

{{< figure class="text-center" caption="Global drawer as a menu" src="quit_action.webp" >}}

{{< /section-right >}}

{{< /sections >}}

{{< alert title="Note" color="info" >}}

The [Actions based components](/docs/kirigami/components-actions/) page of these docs provides further detail on Kirigami Actions and how they can be used.

{{< /alert >}}

### Our app so far

{{< readfile file="/content/docs/use/kirigami/introduction-actions/main.qml" highlight="qml" >}}
