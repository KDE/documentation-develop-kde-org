---
title: Drawers
weight: 105
description: Drawers provide applications with quick access to controls and pages of your application.
group: components
---

Drawers are panels that slide out of the sides of the application window. They can be populated with interactive elements such as Kirigami Actions, buttons, text, and more.

Drawers come in different types, shapes, and forms. In this page we will go over each type and provide an overview of their characteristics.

## Global drawer

The global drawer is a standard feature in KDE's mobile applications and can sometimes be found in their desktop incarnations too. It contains an application's main menu: included here are any functions that are not specific to the current page but still significant to general navigation or interaction within the application.

`Kirigami.GlobalDrawer` components are what we use to create such drawers. These are set to the `globalDrawer` property of the `Kirigami.ApplicationWindow` that forms the basis of our Kirigami application.

{{< sections >}}
{{< section-left >}}

```qml
Kirigami.ApplicationWindow {

    globalDrawer: Kirigami.GlobalDrawer {
		actions: [
			Kirigami.Action {
				text: "Kirigami Action 1"
			},
			Kirigami.Action {
				text: "Kirigami Action 2"
			},
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

{{< /section-left >}}
{{< section-right >}}

![Our new global drawer](globaldrawer_simple.png)

{{< /section-right >}}
{{< /sections >}}

### Header

Headers can be used to place sticky components at the top of your global drawer. Header components will stay in place even if your global drawer contains nested Kirigami actions that replace the current layer on the global drawer. 

Your chosen header component can be set with the global drawer's `header` property.

{{< sections >}}
{{< section-left >}}

```qml
globalDrawer: Kirigami.GlobalDrawer {

	header: Kirigami.AbstractApplicationHeader { 
		
		contentItem: Kirigami.SearchField {
			id: searchField
			Layout.fillWidth: true
		}

	}

	actions: [
		Kirigami.Action {
			text: "Kirigami Action 1"
		},
		Kirigami.Action {
			text: "Kirigami Action 2"
		},
		Kirigami.Action {
			text: i18n("Quit")
			icon.name: "application-exit"
			shortcut: StandardKey.Quit
			onTriggered: Qt.quit()
		}
	]
}
```

{{< /section-left >}}
{{< section-right >}}

![Search bar header global drawer](globaldrawer_header.png)

Our global drawer now shows the search bar component we set as the header.

{{< /section-right >}}
{{< /sections >}}


### Adapting for the desktop

While panel-style global drawers can be useful in mobile environments, they might be too large on the desktop. 

Thankfully, Kirigami global drawers provide an `isMenu` property. When set to `true`, our global drawers turn into more traditional menus only on the desktop. 

{{< alert title="Note" color="info" >}}

In this menu mode, headers and banners are not visible.

{{< /alert >}}

{{< sections >}}
{{< section-left >}}

```qml
globalDrawer: Kirigami.GlobalDrawer {
	isMenu: true

	actions: [
		Kirigami.Action {
			text: "Kirigami Action 1"
		},
		Kirigami.Action {
			text: "Kirigami Action 2"
		},
		Kirigami.Action {
			text: i18n("Quit")
			icon.name: "application-exit"
			shortcut: StandardKey.Quit
			onTriggered: Qt.quit()
		}
	]
}
```

{{< /section-left >}}
{{< section-right >}}

![Global drawer as a menu on the desktop](globaldrawer_menu.png)

{{< /section-right >}}
{{< /sections >}}

### Banners

Banners allow you to display a title and an icon at the top of your global drawer (even above the header).

Titles, set with the `title` property, can be used to pretty up your global drawer and make it seem less sparse. More importantly, it can remind your users that this is a global and app-wide drawer rather than a local drawer.

There is also a `titleIcon` property, which can be paired with your title to make the global drawer even more aesthetically pleasing. This icon will be placed to the left of the title.

{{< sections >}}
{{< section-left >}}

```qml
globalDrawer: Kirigami.GlobalDrawer {
	title: "My Global Drawer"
	titleIcon: "kde"

	actions: [
		Kirigami.Action {
			text: "Kirigami Action 1"
		},
		Kirigami.Action {
			text: "Kirigami Action 2"
		},
		Kirigami.Action {
			text: i18n("Quit")
			icon.name: "application-exit"
			shortcut: StandardKey.Quit
			onTriggered: Qt.quit()
		}
	]
}
```

{{< /section-left >}}
{{< section-right >}}

![Global drawer with title and icon in banner](globaldrawer-banner.png)

{{< /section-right >}}
{{< /sections >}}

{{< alert title="Note" color="info" >}}

The `titleIcon` property takes names for system-wide icons per the FreeDesktop specification. These icons and icon names can be viewed with KDE's CuttleFish application, or by visiting [FreeDesktop's icon naming specification](https://specifications.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html).

{{< /alert >}}

However, by default, banners are only visible on mobile environments. You can change this by setting the global drawer component's `bannerVisible` property to `true`.

## Modal and Inline drawers

Kirigami offers two aditional types of drawers, modal drawers and inline drawers. They are quite similar to each other: both span the entirety of the application's width or height and can be placed on the edges of the app window. However, they do react differently to user interaction.

- Modal drawers darken the rest of the application and, like overlay sheets, will be dismissed when clicking on a darkened area.
- Inline drawers allow the user to still interact with the rest of the application without being dismissed, and do not darken other areas.

These two drawers are so similar because they are, in fact, the same Kirigami component: `Kirigami.OverlayDrawer`. Important properties of this component to keep in mind:

- `modal` controls whether the drawer will be modal or inline depending on a boolean value
- `edge` controls which edge of the application window the drawer will appear on; options for this property are `Qt.TopEdge`, `Qt.RightEdge`, `Qt.BottomEdge`, and `Qt.LeftEdge`
- `contentItem` contains the component that will form the content of your drawer

{{< sections >}}
{{< section-left >}}

```qml
Kirigami.Page {

	Kirigami.OverlayDrawer {
		id: bottomDrawer
		edge: Qt.BottomEdge
		// Set modal to false to make this drawer inline!
		modal: true

		contentItem: RowLayout {
			Layout.fillWidth: true

			Kirigami.Label {
				Layout.fillWidth: true
				text: "Say hello to my little drawer!"
			}
			Controls.Button {
				text: "Close"
				onClicked: bottomDrawer.close()
			}
		}
	}

	Controls.Button {
		text: "Open bottomDrawer"
		onClicked: bottomDrawer.open()
	}

}
```
{{< /section-left >}}
{{< section-right >}}

{{< compare >}}
{{< figure class="text-center" caption="Modal drawer on the bottom edge of the screen." src="modal_drawer.png" >}}
{{< figure class="text-center" caption="Inline drawer on the bottom edge of the screen." src="inline_drawer.png" >}}
{{< /compare >}}

{{< /section-right >}}
{{< /sections >}}

### A usecase for overlay bottom drawers: NeoChat

NeoChat uses bottom overlay drawers to provide user with a number of actions they can perform on a message they have long-pressed. Here is a simplified example of what that looks like:

```qml
Kirigami.Page {
    ListView {
        model: App.MessageModel
        delegate: MessageDelegate {
            onPressAndHold: bottomDrawer.open()
       }
    }

   Kirigami.OverlayDrawer {
       id: bottomDrawer
       height: popupContent.implicitHeight
       edge: Qt.BottomEdge
       padding: 0
       leftPadding: 0
       rightPadding: 0
       bottomPadding: 0
       topPadding: 0

       parent: applicationWindow().overlay

       ColumnLayout {
           id: popupContent
           width: parent.width
           spacing: 0
           
           // Message information
           ...
           
           // Message actions
           Kirigami.BasicListItem {
               text: "Reply"
               onClicked: {
                   bottomDrawer.close();
               }
           }
           ...
       }
    }
}
```
