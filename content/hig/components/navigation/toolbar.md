---
title: Toolbar
group: navigation
weight: 10
---

![Toolbar with the most important actions and an overflow
menu](/hig/Toolbar1.png)

Purpose
-------

A *toolbar* is a graphical presentation of commands optimized for fast
access. A toolbar can be either be defined for a whole application or as
part of another component.

As an application toolbar it contains buttons that correspond to items
in the application\'s menu, providing direct access to application\'s
most frequently used functions. A good menu bar is a comprehensive
catalog of all the available top-level commands, whereas a good toolbar
gives quick, convenient access to frequently used commands.

As part of another component, like a card or an inline mesage, it is
used to allow quick access to the most important commands for a single,
focused content item.

Guidelines for Applications
---------------------------

### Is this the right control?

-   For standard applications, show a toolbar by default.
-   Provide a toolbar in addition to the menu bar, but don\'t replace
    the menu bar.

### Behavior

-   A toolbar should contain only a few frequently used operations. If
    the number of operations is above 5 they have to be grouped with
    separators. Not more than 3 of those sections should be implemented.
-   Don\'t abuse the toolbar to expose hidden or esoteric features. Only
    the most frequently-used functions should be accessible from the
    toolbar.
-   Execute operations immediately; don\'t require additional input.
-   Try to avoid using `split buttons <pushbutton>`{.interpreted-text
    role="doc"} or
    `toggle buttons <../editing/togglebutton>`{.interpreted-text
    role="doc"} in order to keep the interaction with all buttons in the
    toolbar consistent.
-   Don\'t hide toolbars by default. If a toolbar can be hidden, users
    should easily be able to make the toolbar viewable again.
-   Disable buttons that don\'t apply to the current context.
-   Consider making toolbar content and position customizable.
-   Provide both a label and an icon for actions.

Guidelines for Components
-------------------------

### Is this the right control?

-   Use a toolbar only if an item has few actions or few frequently used
    actions.
-   Embed a toolbar only in another control that is clearly visually
    seperated like a card or an inline message.

### Behavior

-   A toolbar should contain only a few, frequently used operations. The
    number of operations should not exceed 3.
-   Don\'t group with separators.
-   Execute operations immediately; don\'t require additional input.
-   Don\'t hide toolbars or make them configurable.
-   Toolbars can be responsive. If there is not enough space to display
    all the buttons, an overflow menu is shown instead.

```{=html}
<video src="https://cdn.kde.org/hig/video/20180620-1/CardLayout1.webm" loop="true" playsinline="true" width="536" controls="true" onended="this.play()" class="border"></video>
```
Appearance
----------

-   Don\'t change the button style from the default, which is
    `text beside icons </patterns/content/iconandtext>`{.interpreted-text
    role="doc"}.
-   Use and design toolbar icons with special care. Users remember
    location of an object but rely as well on icon properties.
-   A distinct association between the underlying function and its
    visual depiction is crucial. Follow the advices for `icon design
    </style/icons/index>`.
-   Don\'t simulate Microsoft\'s ribbon controls.

Code
----

### Kirigami

> -   `Kirigami: Action <Action>`{.interpreted-text role="kirigamiapi"}
> -   `Kirigami: ScrollablePage <ScrollablePage>`{.interpreted-text
>     role="kirigamiapi"}
> -   `Kirigami: ActionToolBar <ActionToolBar>`{.interpreted-text
>     role="kirigamiapi"}

#### Application Toolbar

> ::: {.literalinclude language="qml"}
> /../../examples/kirigami/ApplicationToolbar.qml
> :::

##### Component Toolbar

> ::: {.literalinclude language="qml"}
> /../../examples/kirigami/ComponentToolbar.qml
> :::

### Plasma Components

> -   `Plasma ToolBar <ToolBar>`{.interpreted-text role="plasmaapi"}
