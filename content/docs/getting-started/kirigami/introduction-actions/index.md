---
title: Adding actions
group: introduction
weight: 13
description: >
  Learning more about Kirigami's Actions will help us make our application more useful.
aliases:
  - /docs/getting-started/kirigami/introduction-actions/
---
## Recap

So far, we built a simple app that can display cards. However, there is currently no way for the user to add new cards to the card view.

In this tutorial, we'll be looking at Kirigami actions. These will help us add interactivity to our app in a consistent, fast, and accessible way.

## Actions

A [Kirigami.Action](docs:kirigami;org.kde.kirigami.Action) encapsulates a user interface action. We can use these to provide our applications with easy-to-reach actions that are essential to their functionality.

If you have used Kirigami apps before, you have certainly interacted with Kirigami actions. In this image, we can see actions to the right of the page title with various icons. Kirigami actions can be displayed in several ways and can do a wide variety of things.

{{< compare >}}

{{< figure class="text-center mx-auto" src="actions-desktop.webp" >}}

{{< figure class="text-center mx-auto" src="actions-mobile.webp" >}}

{{< /compare >}}

## Adding countdowns

A countdown app is pretty useless without the ability to add countdowns. Let's create an action that'll let us do this.

{{< sections >}}

{{< section-left >}}

```qml

pageStack.initialPage: Kirigami.ScrollablePage {
    // Other page properties...
    actions: [
        Kirigami.Action {
            id: addAction
            icon.name: "list-add-symbolic"
            text: i18nc("@action:button", "Add kountdown")
            onTriggered: kountdownModel.append({
                name: "Kirigami Action added card!",
                description: "Congratulations, your Kirigami Action works!",
                date: 1000
            })
        }
    ]
    // ...
}
```

We are placing our [Kirigami.Action](docs:kirigami;org.kde.kirigami.Action) within our main page from the previous tutorials. If we wanted to, we could add more actions to our page (and even nest actions within actions!).

The brackets `[]` used above are similar to [JavaScript arrays](https://www.w3schools.com/js/js_arrays.asp), which means you can pass one or more things to them, separated by comma:

```qml
// General JavaScript array of components:
variable: [ component1, component2 ]
// Passing an array of Kirigami actions to QML:
actions: [ Kirigami.Action {}, Kirigami.Action {} ]
```

The `id` and `text` properties should be familiar from previous tutorials. However, the inherited [Action.icon](https://doc.qt.io/qt-6/qml-qtquick-controls2-action.html#icon-prop) property should be interesting: it is an object with several properties letting you display certain icons for your actions. Fortunately, to use KDE icons all we need to do is provide the name property for the icon property, `icon.name`.

{{< alert title="Viewing the available icons" color="info" >}}

<details>
<summary>Click here to see how to check the available icons on your system</summary>
<br>
Icon Explorer is a KDE application that lets you view all the icons that you can use for your application. It offers a number of useful features such as previews of their appearance across different installed themes, previews at different sizes, and more. You might find it a useful tool when deciding on which icons to use in your application.<br><br>

Many of KDE's icons follow the FreeDesktop Icon Naming specification. Therefore, you might also find it useful to consult The FreeDesktop project's website, [which lists all cross-desktop compatible icon names](https://specifications.freedesktop.org/icon-naming-spec).

</details>

{{< /alert >}}

The [onTriggered](docs:qtquickcontrols;QtQuick.Controls.Action::triggered) signal handler is the most important. This is what our action will do when it is used. You'll notice that in our example we're using the method [kountdownModel.append](https://doc.qt.io/qt-6/qml-qtqml-models-listmodel.html#append-method) of the `kountdownModel` we created in our previous tutorial. This method lets us append a new element to our list model. We are providing it with an object (indicated by curly braces `{}`) that has the relevant properties for our countdowns (`name`, `description`, and a placeholder `date`).

{{< /section-left >}}

{{< section-right >}}

<br>

{{< figure class="text-center" caption="Each time we click our \"Add kountdown\" button on the top right, our custom countdown is added" src="action_result.webp" >}}

{{< figure class="text-center" caption="Mobile version" src="action_result_mobile.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Global drawer

{{< sections >}}

{{< section-left >}}

The next component is a [Kirigami.GlobalDrawer](docs:kirigami;org.kde.kirigami.GlobalDrawer). It shows up as a [hamburger menu](https://en.wikipedia.org/wiki/Hamburger_button). By default it opens a sidebar, which is especially useful on mobile, as the user can just swipe in a side of the screen to open it. Global drawers are useful for global navigation and actions. We are going to create a simple global drawer that includes a "quit" button.

```qml
Kirigami.ApplicationWindow {
    id: root
    // Other window properties...
    globalDrawer: Kirigami.GlobalDrawer {
        isMenu: true
        actions: [
            Kirigami.Action {
                text: i18n("Quit")
                icon.name: "application-exit-symbolic"
                shortcut: StandardKey.Quit
                onTriggered: Qt.quit()
            }
        ]
    }
    // ...
}

```

Here, we put our global drawer inside our application window. The main property we need to pay attention to is [GlobalDrawer.actions](https://api.kde.org/qml-org-kde-kirigami-globaldrawer.html#actions-prop), which takes the form of an array of [Kirigami.Action](docs:kirigami;org.kde.kirigami.Action) components. This action has an appropriate icon and executes the [Qt.quit()](docs:qtqml;QtQml.Qt::quit) function when triggered, closing the application.


Since we are keeping our global drawer simple for now, we are setting the [GlobalDrawer.isMenu](https://api.kde.org/qml-org-kde-kirigami-globaldrawer.html#isMenu-prop) property to `true`. This displays our global drawer as a normal application menu, taking up less space than the default global drawer pane.

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="Global drawer" src="global_drawer.webp" >}}

{{< figure class="text-center" caption="Global drawer as a menu" src="quit_action.webp" >}}

{{< /section-right >}}

{{< /sections >}}

{{< alert title="Tip" color="success" >}}

The [Actions based components](/docs/getting-started/kirigami/components-actions/) page of these docs provides further detail on Kirigami Actions and how they can be used.

{{< /alert >}}

## Actions are contextual

Kirigami components are designed in such a way that the place where you put Kirigami Actions is relevant. As seen above, if you add actions to a [Kirigami.Page](docs:kirigami;org.kde.kirigami.Page), [Kirigami.ScrollablePage](docs:kirigami;org.kde.kirigami.ScrollablePage) or any other derivative Page component, they will show up on the right side of the header in desktop mode, and on the bottom in mobile mode.

Similarly, if Kirigami Actions are added to a [Kirigami.GlobalDrawer](docs:kirigami;org.kde.kirigami.GlobalDrawer), they will show up in the resulting drawer or menu.

Other examples of Kirigami Actions showing up differently depending on their parent component are:

* [Kirigami.ContextDrawer](docs:kirigami;org.kde.kirigami.ContextDrawer) - [ContextDrawer tutorial here](/docs/getting-started/kirigami/components-drawers#context-drawers)
* [Kirigami.AbstractCard](docs:kirigami;org.kde.kirigami.AbstractCard) and derivatives - [Card tutorial here](/docs/getting-started/kirigami/components-card)
* [Kirigami.Dialog](docs:kirigami;org.kde.kirigami.dialogs.Dialog) and derivatives - [Dialog tutorial here](/docs/getting-started/kirigami/components-dialogs)
* [Kirigami.ActionToolBar](docs:kirigami;org.kde.kirigami.ActionToolBar) - [ActionToolBar tutorial here](/docs/getting-started/kirigami/components-actions#actiontoolbar)

Among other Kirigami components.

## Our app so far

<details>
<summary><b>Main.qml:</b></summary>

{{< readfile file="/content/docs/getting-started/kirigami/introduction-actions/Main.qml" highlight="qml" >}}

</details>
