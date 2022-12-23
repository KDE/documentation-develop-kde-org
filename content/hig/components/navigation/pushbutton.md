    ---
title: Push Button
weight: 7
group: navigation
---

Purpose
-------

A *Push Button* initiates an action when the user clicks it.

Push buttons are among the most easily understood user interface elements
because they have the benefit of *affordance.* their raised visual appearance
suggests how they are used. Use them liberally.

Guidelines
----------

### Behavior

-   Push Buttons are left-click-only; don't initiate a different action when
    the button is double-clicked or right-clicked--except to open a menu.


### Appearance

-   Always display an icon.
-   Text labels are optional but recommended. If hidden, the button should
    display a ToolTip on hover. Use
    [title style capitalization]({{< relref "capitalization" >}}) and begin
    with a verb.
-   If the button's action requires further information from the user before
    it completes, add an ellipsis at the end of the button label.
-   Except for split buttons, don't change Buttons' icon or text depending on
    the context.
-   Don't make buttons flat except on [toolbars]({{< relref "toolbar" >}}).


### Is this the right control?

Push Buttons come in several flavors. Choose the right one for the situation:

#### Action Button

-   Use an Action Button to initiate an immediate action when clicked.
-   The text label should be localized using the "@action:button" translation
    context. For example `i18nc("@action:button", "Add New User…")`

#### Menu Button

![MenuButton closed](/hig/MenuButton-closed.png)

![MenuButton open](/hig/MenuButton-open.png)

-   Use a Menu Button to offer the user a set of related actions they can
    choose.
-   Indicate that the button opens a menu when clicked by showing a
    downward-pointing triangle on the right side.
-   Don't use the delayed menu button pattern; the menu should be shown when
    clicking the button, without requiring a press-and-hold.
-   The menu items' labels should be localized using the "@action:inmenu"
    translation context. For example `i18nc("@action:inmenu", "Add New User…")`

#### Split Button

![Split Button](/hig/Button_SplitButton.png)

-   Use a Split Button to allow the user to choose from among multiple actions
    or tools, with the last-used one being remembered.
-   Clicking the left part triggers the active action or tool; clicking the
    split area opens the menu to suggest a different one.
-   The menu items' labels should be localized using the "@action:inmenu"
    translation context. For example `i18nc("@action:inmenu", "Add New User…")`


