---
title: Drawers
weight: 205
description: Drawers provide applications with quick access to controls and pages of your application.
group: components
aliases:
  - /docs/kirigami/components-drawers/
---

Drawers are panels that slide out of the sides of the application window. They can be populated with interactive elements such as Kirigami Actions, buttons, text, and more.

Drawers come in different types, shapes, and forms. In this page we will go over each type and provide an overview of their characteristics.

## Global drawer

The global drawer is a standard feature in KDE's mobile applications and can sometimes be found in their desktop incarnations too. It contains an application's main menu: included here are any functions that are not specific to the current page but still significant to general navigation or interaction within the application.

It can be activated by tapping the hamburger menu or by swiping from the left edge to the middle of the screen in Left to Right mode or from the right edge in Right to Left mode.

[Kirigami.GlobalDrawer](docs:kirigami2;GlobalDrawer) components are what we use to create such drawers. These are set to the [globalDrawer](docs:kirigami2;AbstractApplicationWindow::globalDrawer) property of the [Kirigami.ApplicationWindow](docs:kirigami2;ApplicationWindow) that forms the basis of our Kirigami application.

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

![Screenshot of a global drawer in desktop mode that looks like a sidebar](/docs/use/kirigami/components-drawers/globaldrawer_simple.png)

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

{{< figure class="text-center" caption="Our global drawer now shows the search bar component we set as the header" src="globaldrawer_header.png" >}}

{{< /section-right >}}

{{< /sections >}}


### Adapting for the desktop

While panel-style global drawers can be useful in mobile environments, they might be too large on the desktop. 

Thankfully, Kirigami global drawers provide an [isMenu](docs:kirigami2;GlobalDrawer::isMenu) property. When set to `true`, they turn into more traditional menus only on the desktop.

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

{{< figure class="text-center" caption="Global drawer in menu mode, without a header or banner" src="globaldrawer_menu.png" >}}

{{< /section-right >}}

{{< /sections >}}

### Banners

Banners allow you to display a title and an icon at the top of your global drawer (even above the header).

By default, banners are only visible on mobile environments. You can change this by setting the global drawer component's [bannerVisible](docs:kirigami2;GlobalDrawer) property to `true`.

Titles, set with the [title](docs:kirigami2;GlobalDrawer::title) property, can be used to pretty up your global drawer and make it seem less sparse. More importantly, it can remind your users that this is a global and app-wide drawer rather than a local drawer.

There is also a [titleIcon](docs:kirigami2;GlobalDrawer::titleIcon) property, which can be paired with your title to make the global drawer even more aesthetically pleasing. This icon will be placed to the left of the title.

{{< sections >}}

{{< section-left >}}

```qml
globalDrawer: Kirigami.GlobalDrawer {
    title: "My Global Drawer"
    titleIcon: "kde"
    bannerVisible: true
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

{{< figure class="text-center" caption="Global drawer with title and icon in banner" src="globaldrawer-banner.png" >}}

{{< /section-right >}}

{{< /sections >}}

{{< alert title="Note" color="info" >}}

The [titleIcon](docs:kirigami2;GlobalDrawer::titleIcon) property takes names for system-wide icons according to the FreeDesktop specification. These icons and icon names can be viewed with KDE's CuttleFish application which comes with [plasma-sdk](https://invent.kde.org/plasma/plasma-sdk), or by visiting [FreeDesktop's icon naming specification](https://specifications.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html).

{{< /alert >}}

## Context Drawers

While a [Kirigami.GlobalDrawer](docs:kirigami2;GlobalDrawer) displays global actions available throughout your application, a [Kirigami.ContextDrawer](docs:kirigami2;ContextDrawer) should be used to display actions that are only relevant in certain contexts. This is usually used in separate [pages](/docs/kirigami/introduction-pages).

A context drawer will only show up if any [contextualActions](docs:kirigami2;Page::contextualActions) have been created as part of the [Page.actions group](docs:kirigami2;Page::actions). It also behaves differently depending on whether it is being used on a mobile platform or on a desktop.

On a desktop, when a window has enough space, contextual actions show up as part of the `actions` group in the top toolbar. When space is limited, such as on a mobile device or in a narrow window, contextual actions are hidden behind a hamburger menu on the right side. This is different from other actions in the `actions` group, namely `actions.main`, `actions.left` and `actions.right`; these do not get hidden in space-constrained windows, and are instead collapsed into their respective icons.


{{< sections >}}

{{< section-left >}}

{{< readfile file="/content/docs/use/kirigami/components-drawers/contextdrawer.qml" highlight="qml" >}}

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" src="contextdrawer-retracted.webp" caption="Context drawer with contextual actions hidden" >}}

{{< figure class="text-center" src="contextdrawer-expanded.webp" caption="Context drawer showing all contextual actions" >}}

{{< /section-right >}}

{{< /sections >}}

On mobile, the drawer always consists of actions hidden behind a hamburger menu. It can be activated by tapping the hamburger menu or by swiping from the right edge to the middle of the screen in Left to Right mode or from the left edge in Right to Left mode. If you are on a desktop and want to test the mobile interface, you can run your application with the environment variable `QT_QUICK_CONTROLS_MOBILE=1`.

{{< sections >}}

{{< section-left >}}

{{< figure class="text-center" src="contextdrawer-mobile.webp" caption="Same example above, running in mobile mode" >}}

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" src="contextdrawer-mobile-draweropen.webp" caption="Context drawer open in mobile mode" >}}

{{< /section-right >}}

{{< /sections >}}

## Modal and Inline drawers

Kirigami offers two additional types of drawers, modal drawers and inline drawers. They are quite similar to each other: both span the entirety of the application's width or height and can be placed on the edges of the app window. However, they do react differently to user interaction.

- Modal drawers darken the rest of the application and, like [overlay sheets](docs:kirigami2;OverlaySheet), will be dismissed when clicking on a darkened area.
- Inline drawers allow the user to still interact with the rest of the application without being dismissed, and do not darken other areas.

These two drawers are so similar because they can, in fact, be implemented using the same Kirigami component: [Kirigami.OverlayDrawer](docs:kirigami2;OverlayDrawer). Here are a few important inherited properties of this component to keep in mind:

- [Popup.modal](https://doc.qt.io/qt-6/qml-qtquick-controls2-popup.html#modal-prop) controls whether the drawer will be modal or inline depending on a boolean value
- [Drawer.edge](https://doc.qt.io/qt-6/qml-qtquick-controls2-drawer.html#edge-prop) controls which edge of the application window the drawer will appear on; options for this property are part of the [Edge enum](docs:qtcore;Qt::RightEdge), namely `Qt.TopEdge`, `Qt.RightEdge`, `Qt.BottomEdge`, and `Qt.LeftEdge`
- [Popup.contentItem](https://doc.qt.io/qt-6/qml-qtquick-controls2-popup.html#contentItem-prop) contains the component that will form the content of your drawer

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick.Controls 2.15 as Controls

Kirigami.Page {

    Kirigami.OverlayDrawer {
        id: bottomDrawer
        edge: Qt.BottomEdge
        // Set modal to false to make this drawer inline!
        modal: true

        contentItem: RowLayout {
            Layout.fillWidth: true

            Controls.Label {
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

{{< figure class="text-center" caption="Modal drawer on the bottom edge of the screen" src="modal_drawer.png" >}}

{{< figure class="text-center" caption="Inline drawer on the bottom edge of the screen" src="inline_drawer.png" >}}

{{< /compare >}}

{{< /section-right >}}

{{< /sections >}}

### A use case for bottom overlay drawers: NeoChat

NeoChat uses bottom overlay drawers to provide the user with a number of actions they can perform on a message they have long pressed. Here is a simplified example of what that looks like:

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
