---
title: Drawers
weight: 35
description: Drawers provide applications with quick access to controls and pages of your application.
group: components
aliases:
  - /docs/getting-started/kirigami/components-drawers/
---

Drawers are panels that slide out of the sides of the application window. They can be populated with interactive elements such as Kirigami Actions, buttons, text, and more.

Drawers come in different types, shapes, and forms. In this page we will go over each type and provide an overview of their characteristics.

## Global drawer

The global drawer is a standard feature in KDE's mobile applications and can sometimes be found in their desktop incarnations too. It contains an application's main menu: included here are any functions that are not specific to the current page but still significant to general navigation or interaction within the application.

It can be activated by tapping the hamburger menu or by swiping from the left edge to the middle of the screen in Left to Right mode or from the right edge in Right to Left mode.

[Kirigami.GlobalDrawer](docs:kirigami;org.kde.kirigami.GlobalDrawer) components are what we use to create such drawers. These are set to the [globalDrawer](https://api.kde.org/qml-org-kde-kirigami-abstractapplicationwindow.html#globalDrawer-prop) property of the [Kirigami.ApplicationWindow](docs:kirigami;org.kde.kirigami.ApplicationWindow) that forms the basis of our Kirigami application.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Drawers App"
    width: 600
    height: 600
    pageStack.initialPage: Kirigami.Page { /* Page code here... */ }

    globalDrawer: Kirigami.GlobalDrawer {
        title: "Global Drawer"
        titleIcon: "applications-graphics"
        actions: [
            Kirigami.Action {
                text: "Kirigami Action 1"
                icon.name: "user-home-symbolic"
                onTriggered: showPassiveNotification("Action 1 clicked")
            },
            Kirigami.Action {
                text: "Kirigami Action 2"
                icon.name: "settings-configure-symbolic"
                onTriggered: showPassiveNotification("Action 2 clicked")
            },
            Kirigami.Action {
                text: i18n("Quit")
                icon.name: "application-exit-symbolic"
                shortcut: StandardKey.Quit
                onTriggered: Qt.quit()
            }
        ]
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

![Screenshot of a global drawer in desktop mode that looks like a sidebar](/docs/getting-started/kirigami/components-drawers/globaldrawer_simple.webp)

{{< /section-right >}}

{{< /sections >}}

{{< alert title="Note" color="info" >}}

The [titleIcon](https://api.kde.org/qml-org-kde-kirigami-globaldrawer.html#titleIcon-prop) property takes names for system-wide icons according to the FreeDesktop specification. These icons and icon names can be viewed with KDE's CuttleFish application which comes with [plasma-sdk](https://invent.kde.org/plasma/plasma-sdk), or by visiting [FreeDesktop's icon naming specification](https://specifications.freedesktop.org/icon-naming-spec).

{{< /alert >}}

### Header

Headers can be used to place sticky components at the top of your global drawer. Header components will stay in place even if your global drawer contains nested Kirigami actions that replace the current layer on the global drawer. 

Your chosen header component can be set with the global drawer's [header](https://api.kde.org/qml-org-kde-kirigami-globaldrawer.html#header-prop) property, and it will replace the global drawer's title. This is useful to add a [Kirigami.SearchField](https://api.kde.org/qml-org-kde-kirigami-searchfield.html), for example:

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Drawers App"
    width: 600
    height: 600
    pageStack.initialPage: Kirigami.Page { /* Page code here... */ }

    globalDrawer: Kirigami.GlobalDrawer {
        title: "Global Drawer with searchfield (not visible)"

        header: Kirigami.SearchField {
                id: searchField
        }

        actions: [
            Kirigami.Action {
                text: "Kirigami Action 1"
                icon.name: "user-home-symbolic"
                onTriggered: showPassiveNotification("Action 1 clicked")
            },
            Kirigami.Action {
                text: "Kirigami Action 2"
                icon.name: "settings-configure-symbolic"
                onTriggered: showPassiveNotification("Action 2 clicked")
            },
            Kirigami.Action {
                text: i18n("Quit")
                icon.name: "application-exit-symbolic"
                shortcut: StandardKey.Quit
                onTriggered: Qt.quit()
            }
        ]
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

{{< figure class="text-center" caption="Our global drawer now shows the search bar component we set as the header" src="globaldrawer_header.webp" >}}

{{< /section-right >}}

{{< /sections >}}


### Adapting for the desktop

While panel-style global drawers can be useful in mobile environments, they might be too large on the desktop, especially when the application has few actions.

Thankfully, Kirigami global drawers provide an [isMenu](https://api.kde.org/qml-org-kde-kirigami-globaldrawer.html#isMenu-prop) property. When set to `true`, they turn into more traditional menus only on the desktop.

{{< alert title="Note" color="info" >}}

In this menu mode, headers and banners are not visible.

{{< /alert >}}

{{< sections >}}

{{< section-left >}}

```qml
globalDrawer: Kirigami.GlobalDrawer {
    isMenu: true

    actions: [
        // Kirigami Actions here...
    ]
}
```

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="Global drawer in menu mode, without a header or banner" src="globaldrawer_menu.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Context Drawers

While a [Kirigami.GlobalDrawer](docs:kirigami;org.kde.kirigami.GlobalDrawer) displays global actions available throughout your application, a [Kirigami.ContextDrawer](docs:kirigami;org.kde.kirigami.ContextDrawer) should be used to display actions that are only relevant in certain contexts. This is usually used in separate [pages](/docs/getting-started/kirigami/introduction-pages).

<!-- TODO: mention actions -->

A context drawer will behave differently depending on whether it is being used on a mobile platform or on a desktop.

On a desktop, when a window has enough space, contextual actions show up as part of the [actions](https://api.kde.org/qml-org-kde-kirigami-contextdrawer.html#actions-prop) group in the top toolbar. When space is limited, such as on a mobile device or in a narrow window, contextual actions are hidden behind a hamburger menu on the right side. This is different from other actions in the `actions` group, namely `actions.main`, `actions.left` and `actions.right`; these do not get hidden in space-constrained windows, and are instead collapsed into their respective icons.

{{< readfile file="/content/docs/getting-started/kirigami/components-drawers/contextdrawer.qml" highlight="qml" >}}

{{< compare >}}

{{< figure class="text-center mx-auto" src="contextdrawer-retracted.webp" caption="Context drawer with contextual actions hidden" >}}

{{< figure class="text-center mx-auto" src="contextdrawer-expanded.webp" caption="Context drawer showing all contextual actions" >}}

{{< /compare >}}

On mobile, the drawer always consists of actions hidden behind a hamburger menu. It can be activated by tapping the hamburger menu or by swiping from the right edge to the middle of the screen in Left to Right mode or from the left edge in Right to Left mode.

{{< compare >}}

{{< figure class="text-center mx-auto" src="contextdrawer-mobile.webp" caption="Same example above, running in mobile mode" >}}

{{< figure class="text-center mx-auto" src="contextdrawer-mobile-drawer.webp" caption="Context drawer open in mobile mode" >}}

{{< /compare >}}

## Modal and Inline drawers

Kirigami offers two additional types of drawers, modal drawers and inline drawers. They are quite similar to each other: both span the entirety of the application's width or height and can be placed on the edges of the app window. However, they do react differently to user interaction.

- Modal drawers are hidden by default and darken the rest of the application, being dismissed when clicking on a darkened area.
- Inline drawers are shown by default and allow the user to still interact with the rest of the application without being dismissed, and do not darken other areas.

This kind of drawer is open ended and flexible, but generally, you may want to use this kind of drawer when you want a small list of options to appear on a long press or right click.

These two drawers are so similar because they can, in fact, be implemented using the same Kirigami component: [Kirigami.OverlayDrawer](docs:kirigami;org.kde.kirigami.OverlayDrawer). Here are a few important inherited properties of this component to keep in mind:

- [Popup.modal](https://doc.qt.io/qt-6/qml-qtquick-controls2-popup.html#modal-prop) controls whether the drawer will be modal or inline depending on a boolean value.
- [Drawer.edge](https://doc.qt.io/qt-6/qml-qtquick-controls2-drawer.html#edge-prop) controls which edge of the application window the drawer will appear on; options for this property are part of the [Edge enum](docs:qtcore;Qt::RightEdge), namely `Qt.TopEdge`, `Qt.RightEdge`, `Qt.BottomEdge`, and `Qt.LeftEdge`.
- [Popup.contentItem](https://doc.qt.io/qt-6/qml-qtquick-controls2-popup.html#contentItem-prop) contains the component that will form the content of your drawer.

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Drawers App"
    width: 400
    height: 600
    pageStack.initialPage: Kirigami.Page {
        title: "OverlayDrawer at the bottom"
        actions: [
            Kirigami.Action {
                text: "Open bottomDrawer"
                onTriggered: bottomDrawer.open()
            }
        ]
        Kirigami.OverlayDrawer {
            id: bottomDrawer
            edge: Qt.BottomEdge
            // Set modal to false to make this drawer inline!
            modal: true

            contentItem: RowLayout {
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
    }
}
```


{{< compare >}}

{{< figure class="text-center mx-auto" caption="Modal drawer not visible" src="modaldrawer1.webp" >}}

{{< figure class="text-center mx-auto" caption="Modal drawer at the bottom edge of the screen" src="modaldrawer2.webp" >}}

{{< /compare >}}
