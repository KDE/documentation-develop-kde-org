---
title: Context Drawer
---
==============

::: {.container .intend}
:::

::: {.container .available .plasma .qwidgets}
:::

![Examples of a context drawer on
mobile](/hig/Contextdrawer1.png){.border}

Purpose
-------

The Context Drawer is used to access controls that depend on the current
context. This can be, for example, controls that affect a selected
element in a list or that navigate through an opened document.

Guidelines
----------

### Is this the right control?

Use a Context Drawer if your application has any functions which are
only relevant in specific contexts, and which are not central enough to
the application\'s main purpose to put them in the main user interface
or in a toolbar. For actions which are always available, use the
`Global Drawer <globaldrawer>`{.interpreted-text role="doc"}.

### Behavior

-   The Context Drawer is opened by swiping in from the left or right
    edge of the screen (depending on a system-wide setting) and closed
    by swiping in the other direction or tapping outside of it.
-   At the top of the drawer, state which object the controls affect
    (e.g. \"Selected email\")
-   By default, the Context Drawer simply contains a vertical list of
    action buttons which affect the currently selected/opened element
    -   Center the list vertically instead of top-aligning, to allow an
        easier reach with the thumb
-   If needed, other controls related to the current context can be put
    in the Context Drawer
    -   Try to keep the content of the context drawer in one page. If
        there two distinct \"modes\" of contextual actions (for example
        navigating through a PDF either by table of contents or
        thumbnails), consider using two `Tabs <tab>`{.interpreted-text
        role="doc"} to separate them, but never use more than two tabs.

![Examples of a context drawer on
desktop](/hig/Contextdrawer2.png){.border}

Code
----

### Kirigami

> -   `Kirigami: Action <Action>`{.interpreted-text role="kirigamiapi"}
> -   `Kirigami: ScrollablePage <ScrollablePage>`{.interpreted-text
>     role="kirigamiapi"}

::: {.literalinclude language="qml"}
/../../examples/kirigami/AddressbookContextDrawer.qml
:::
