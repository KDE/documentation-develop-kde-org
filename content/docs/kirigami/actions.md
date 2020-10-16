---
title: Actions
group: components
weight: 4
description: >
  Kirigami's Actions are used to add functionality to components.
---

A Kirigami Action encapsulates a user interface action.
It inherits from [Qt Quick Controls 2 Action](docs:qtquickcontrols;QtQuick.Controls.Action) and
can be assigned shortcuts. 

Like QtQuick Controls Actions, they can be assigned to menu items and toolbar buttons,
but also to multiple other Kirigami components.

```qml
import org.kde.kirigami 2.13 as Kirigami

Kirigami.Action {
    id: copyAction
    text: i18n("&Copy")
    icon.name: "edit-copy"
    shortcut: StandardKey.Copy
    onTriggered: { ... }
}
```

One feature offered by Kirigami Actions on top of QtQuick Actions is the possibility
to nest actions.

```qml
import org.kde.kirigami 2.13 as Kirigami

Kirigami.Action {
    text: "View"
    icon.name: "view-list-icons"
    Kirigami.Action {
        text: "action 1"
    }
    Kirigami.Action {
        text: "action 2"
    }
    Kirigami.Action {
        text: "action 3"
    }
}
```
Another feature of Kirigami Actions is to provide various hints to items using actions
about how they should display the action. These are primarily handled by the `displayHint`
and `displayComponent` properties.

These properties will be respected by the item if possible. For example, the following
action will be displayed as a TextField with the item trying its best to keep the item
visible as long as possible.

```qml
import org.kde.kirigami 2.13 as Kirigami

Kirigami.Action {
    text: "Search"
    icon.name: "search"

    displayComponent: TextField { }

    displayHint: Kirigami.DisplayHints.KeepVisible
}
```

## Using actions

### Page

In the [previous tutorial](../introduction-pages), we learned about pages, and one of
the features of pages is that Actions can be added to them.

You can add a main action, a left and right action and additional context actions
that are displayed on the toolbar if there is enough place or in a hamburger menu
on smaller screens.


```qml
import org.kde.kirigami 2.13 as Kirigami

Kirigami.Page {
    title: i18n("Demo")

    actions {
        main: Kirigami.Action {
            icon.name: "go-home"
            onTriggered: showPassiveNotification(i18n("Main action triggered"))
        }
        left: Kirigami.Action {
            icon.name: "go-previous"
            onTriggered: showPassiveNotification(i18n("Left action triggered"))
        }
        right: Kirigami.Action {
            icon.name: "go-next"
            onTriggered: showPassiveNotification(i18n("Right action triggered"))
        }
        contextualActions: [
            Kirigami.Action {
                text: i18n("Contextual Action 1")
                icon.name: "bookmarks"
                onTriggered: showPassiveNotification(i18n("Contextual action 1 clicked"))
            },
            Kirigami.Action {
                text: i18n("Contextual Action 2")
                icon.name: "folder"
                enabled: false
            }
        ]
    }
}
```

{{< compare >}}
{{< figure class="text-center" caption="Page actions on the desktop" src="desktop_page.png" >}}
{{< figure class="text-center" caption="Page actions on a mobile device" src="mobile_page.png" >}}
{{< /compare >}}

{{< alert color="warning" title="Warning" >}}
To make the context actions work on mobile, you need to add a [ContextDrawer](docs:kirigami2;ContextDrawer)
to your [Kirigami.ApplicationWindow](docs:kirigami2;ApplicationWindow).

```qml
Kirigami.ApplicationWindow {
    ...
    contextDrawer: Kirigami.ContextDrawer {
        id: contextDrawer
    }
    ...
}
```
{{< /alert >}}

### Global Drawer

The global drawer provides an action based navigation to your application. This is the place,
where nested actions are useful because it allows you to create nested navigation:

```qml
Kirigami.ApplicationWindow {
    title: i18n("Demo")
    globalDrawer: Kirigami.GlobalDrawer {
        title: i18n("Demo")
        titleIcon: "applications-graphics"
        actions: [
            Kirigami.Action {
                text: i18n("View")
                icon.name: "view-list-icons"
                Kirigami.Action {
                    text: i18n("View Action 1")
                    onTriggered: showPassiveNotification(i18n("View Action 1 clicked"))
                }
                Kirigami.Action {
                    text: i18n("View Action 2")
                    onTriggered: showPassiveNotification(i18n("View Action 2 clicked"))
                }
            },
            Kirigami.Action {
                text: i18n("Action 1")
                onTriggered: showPassiveNotification(i18n("Action 1 clicked"))
            },
            Kirigami.Action {
                text: i18n("Action 2")
                onTriggered: showPassiveNotification(i18n("Action 2 clicked"))
            }
        ]
    }
    ...
}
```

{{< compare >}}
{{< figure class="text-center" caption="Global Drawers actions on the desktop" src="desktop_global_drawers.png" >}}
{{< figure class="text-center" caption="Global Drawers actions on a mobile device" src="mobile_global_drawers.png" >}}
{{< /compare >}}

### ActionTextFields

A [Kirigami ActionTextField](docs:kirigami2;ActionTextField) is used to add some contextual
actions to a text field, for example to clear the text, or to search for the text.

```qml
Kirigami.ActionTextField {
    id: searchField
    rightActions: [
        Kirigami.Action {
            icon.name: "edit-clear"
            visible: searchField.text !== ""
            onTriggered: {
                searchField.text = ""
                searchField.accepted()
            }
        }
    ]
}
```

In this example, we are creating a clear button for a search field only visible when text is entered.

![Search field with text: "I want ](searchfield.png)

{{< alert title="Note" color="info" >}}
You should only rarely use an ActionTextField directly. The two major use cases for an
ActionTextField are provided by [SearchField](docs:kirigami2;SearchField) and
[PasswordField](docs:kirigami2;PaswordField). Both inherit from ActionTextField.
{{< /alert >}}

### SwipeListItem

A [SwipeListItem](docs:kirigami2;SwipeListItem) is a delegate intended to support extra actions.
When using a mouse, they will be shown on hover. On a touch device, they can be shown by dragging
the item with the handle.

```qml
ListView {
    model: myModel
    delegate: SwipeListItem {
        QQC2.Label {
            text: model.text
        }
        actions: [
             Action {
                 icon.name: "document-decrypt"
                 onTriggered: print("Action 1 clicked")
             },
             Action {
                 icon.name: model.action2Icon
                 onTriggered: //do something
             }
        ]
    }
}
```

{{< figure src="swipe_desktop.png" caption="SwipeListItem on a computer" class="text-center" >}}

{{< figure src="swipe_mobile.png" caption="SwipeListItem on a mobile device" class="text-center mt-4" >}}

###  ActionToolBar

An [ActionToolBar](docs:kirigami2;ActionToolBar) is a toolbar built out of a 
list of actions. By default, each action that will fit on the toolbar will be 
represented by a ToolButton, with those that do not fit being moved into a 
menu at the end of the toolbar.

Like ActionTextField, you may not need to use ActionToolBar directly as it is
used by page headers and cards to provide their action display.

```qml
Kirigami.ActionToolBar {
    actions: [
        Kirigami.Action {
            text: i18n("View Action 1")
            onTriggered: showPassiveNotification(i18n("View Action 1 clicked"))
        },
        Kirigami.Action {
            text: i18n("View Action 2")
            onTriggered: showPassiveNotification(i18n("View Action 2 clicked"))
        },
        Kirigami.Action {
            text: i18n("Action 1")
            onTriggered: showPassiveNotification(i18n("Action 1 clicked"))
        },
        Kirigami.Action {
            text: i18n("Action 2")
            onTriggered: showPassiveNotification(i18n("Action 2 clicked"))
        }
    ]
}
```

![](action_tool_bar.png)

### Cards

The cards components can also take an action. For more information consult the next part of this tutorial about Card.
