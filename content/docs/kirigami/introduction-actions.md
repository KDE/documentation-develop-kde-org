---
title: Adding actions
group: introduction
weight: 4
description: >
  Learning more about Kirigami's Actions will help us make our application more useful.
---
## Recap

So far, we have managed to build a simple app that can display cards. However, we don't yet have a way of adding new cards to our card view.

In this tutorial, we'll be looking at Kirigami actions. These will help us add interactivity to our app in a consistent, fast, and accessible way.

## Actions

A Kirigami Action encapsulates a user interface action. We can use these to provide our applications with easy-to-reach actions that are essential to their functionality.

{{< figure class="text-center" caption="Page actions on the desktop." src="actions_desktop_page.png" >}}

If you have used Kirigami apps before, you have certainly interacted with Kirigami Actions. In this image, we can see actions to the right of the page title with various icons. Kirigami Actions can be displayed in several ways and can do a wide variety of things.

## Adding countdowns

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

We are placing our Kirigami Action within our main page from our previous tutorials. If we wanted to, we could add more actions to our page (and even nest actions within actions!). `Kirigami.Action` components are used as contextual actions within Kirigami pages. We are setting it specifically to the `actions.main` property of the page: the `actions` object has properties that let us set different actions in different positions, but since our 'Add kountdown' action is central to our UI we are setting it as the main action of this page.

The `id` and `text` properties should be familiar from previous tutorials. However, the new `icon` property should be interesting: it is an object with several properties letting you display certain icons for your actions. Fortunately, to use KDE icons all we need to do is provide the name property for the icon property, `icon.name`.

{{< alert title="Note" color="info" >}}
Cuttlefish is a KDE application that lets you view all the icons that you can use for your application. It offers a number of useful features such as previews of their appearance across different installed themes, previews at different sizes, and more. You might find it a useful tool when deciding on which icons to use in your application. 

Many of KDE's icons follow the FreeDesktop Icon Naming specification. Therefore, you might also find it useful to consult The FreeDesktop project's website, [which lists all of the cross-desktop compatible icon names on their website](https://specifications.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html).
{{< /alert >}}

The `onTriggered` property is the most important. This is what our action will do when it is used. You'll notice that in our example we're using the method `kountdownModel.append` of the `kountdownModel` we created in our previous tutorial. This method lets us append a new element to our list model. We are providing it with an object that has the relevant properties for our countdowns (name, description, and a placeholder date).

{{< figure class="text-center" caption="Each time we click our now 'Add kountdown' button on the top left, our custom countdown is added." src="actions_result.png" >}}

## Global drawer

Did you notice those three lines next to the page title on the previous screenshot? That's a global drawer. Global drawers are useful for global navigation and actions: in other words, those things you might need to use throughout your application. We are going to create a simple global drawer that includes a quit button.

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

Here, we put our global drawer inside our application window. The main property we need to pay attention to is `actions`, which takes the form of an array of `Kirigami.Action` components. This action has an appropriate icon and triggers the `Qt.quit()` function, closing the application.

![](global_drawer.png)

Since we are keeping our global drawer simple for now, we are setting the `isMenu` property to true. This displays our global drawer as a normal application menu, taking up less space than the default global drawer pane.

![](quit_action.png)

{{< alert title="Note" color="info" >}}
The ['Actions'](https://develop.kde.org/docs/kirigami/actions/) page in the 'Components' section of these docs provides further detail on Kirigami actions and how they can be used.
{{< /alert >}}

