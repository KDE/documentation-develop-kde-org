---
title: Tabs
weight: 9
group: navigating
---

Purpose
-------

A *tab control* is a way to present related information on separate
pages. Tabs are used for dynamic window surface to increase the surface,
to manage multiple documents within a single window, or as a view of
exclusive options.

![Tabs-HIG.png](/hig/Tabs-HIG.png)

Tabs have several advantages. Users can easily access available options
or see which forms have been opened. Because foreground tabs are
visually differentiated from background tabs the user knows what item is
currently in use. Having tabs beyond the screen size may lead to visual
clutter.

General Guidelines
------------------

### Is this the right control?

-   Use tabs:
    -   for many controls that can be organized within a few categories,
        like extended configuration settings
    -   for a variable number of sections, like browser pages
    -   to manage multiple documents
-   Don't use tabs:
    -   for only one page (but show the tab bar when more pages are
        expected, for example in a web browser).
    -   for global application controls.
    -   for sequential steps, like wizards.

Guidelines for Desktop User Interfaces
--------------------------------------

### Behavior

-   Don't abuse other controls to simulate tab behavior.
-   Use horizontal tabs with seven or fewer tabs and all the tabs fit on
    one row.
-   Don't use vertically stacked tabs. Tabs are drawn above the pages
    only (QTabWidget::TabPosition = North).
-   Don't use too many tabs. Use a
    `list view <../editing/list>` with
    icons and associated pages if there are many pages or if you want to
    group static pages, e.g. in case of configuration content. This also
    gives ability to present hierarchy of pages as a tree.
-   Don't use multiple tab bars.
-   Don't disable a tab when it does not apply to the current context.
    Instead, disable the controls on the page.
-   Make content from one page independent and differentiated from
    another through the use of tabs.
-   Don't nest tabs.
-   Display scroll buttons in the tab bar to allow navigating tabs when
    there are too many to see at once.

#### Tabs with Pages Containing Documents

Special considerations apply for tabs that contain documents rather than
settings or controls.

-   Make it possible to re-order tabs.
-   Make tabs closable.
-   Provide a context menu on each tab if their pages contain documents.
    This menu should only include actions for manipulating the tab
    itself, such as Move Left, Move Right, Move to New Window, Close,
    Close All, Reload.
-   Don't resize tabs when adding a status icon or when the content of
    the page changes. For applications where the tab title changes, like
    Dolphin or Konsole, it is recommended to have a fixed tab size for
    all tabs.
-   Consider providing an 'Add New Tab' button on the right side of
    the tab bar for tabs that contain documents or other user-editable
    content. In this case the 'Add Tab' button should be used as a
    corner widget placed on the right hand of the tab bar. Display
    keyboard shortcuts or menu items for easy access, but don't show
    the 'Add Tab' function in the application toolbar.
-   Provide keyboard navigation to switch between tabs with Ctrl + Tab
    (Ctrl
    + Shift + Tab for backward navigation). For compatibility reasons
    it is recommended to also support Ctrl + PgDown (Ctrl + PgUp for
    backward navigation).

### Appearance

-   Make last used tab persistent. Otherwise, select the first page by
    default.
-   Don't assign effects to changing tabs; tabs must be accessible in
    any order.
-   Only use text in horizontal tabs and not icons.
-   Provide a label with an access key for each tab. Use nouns with
    `title capitalization </style/writing/capitalization>`{.interpreted-text
    role="doc"} to describe the content.
-   Don't expand tabs to use empty space of the widget (see the
    `expanding` property of the Qt tab bar, unfortunately true by
    default).
-   Avoid long tab names. Use a compelling, easy to understand label.
    Phrases not sentences.
-   Don't use
    `abbreviations </style/writing/wording>`{.interpreted-text
    role="doc"} (acronyms such as HTML are allowed).

Guidelines for Phone User Interfaces
------------------------------------

![Tabs in global drawer](/hig/Tabs_in_drawer.png)

### Behavior

-   Don't abuse other controls to simulate tab behavior.
-   Don't nest tabs.
-   When the tabs are used to group controls, put them at the top of the
    screen. Don't use more than three tabs.
    -   Don't disable a tab when it does not apply to the current
        context; disable the controls on the page.
    -   Keep interdependent elements in the same tab.
-   When using tabs to open multiple documents (e.g. websites) in the
    same instance of an application, show them as a list at the top of
    the `global drawer <globaldrawer>`
    -   Offer the user the option to choose between "Use tabs" and
        "Use separate windows", the default of which is specified by
        the gobal setting, if it is set, otherwise the default is new
        windows unless users are used to tabs from existing apps of the
        same type (e.g. for web browsers).
    -   Swiping on a tab away from the screen edge that the menu drawer
        is attached to (e.g. to the right if the drawer is on the left
        side) closes the tab.

### Appearance

-   Use short labels for tabs that group controls.
-   Use descriptive names for tabs, e.g. page titles for browser tabs.
    -   Put a control to open a new tab below the list of tabs.
