---
title: Menu Bar
groups: navigation
weight: 7
---

Purpose
-------

A menu bar appears at the top of an application's main window. It
provides access to all commands and most of the settings available in an
application.

Users refer frequently to the menu bar, especially when they are seeking
a function for which they know of no other interface. Ensuring that
menus are well organized, are worded clearly, and behave correctly is
crucial to the user's ability to explore and access the functionality of
the application.

![Menubar with 7 menus](/hig/Menubar1.png)

Guidelines
----------

### Is this the right control?

-   A menu bar is mandatory for applications that have a
    [very complex command structure]({{< relref "patterns-command" >}}), such
    as those used for content creation or editing, file manipulation,
    or other productivity work.
-   Menu bars are optional for simple apps that are able to expose all
    functionality using visible buttons and toolbars. If any
    functionality is not visible by default, err on the side of
    providing a menu bar.
-   Don't display a menu bar in secondary or internal windows, like the
    settings dialog or file dialog. Very small main windows are likewise
    usually poor candidates for menu bars.
-   Don't include a menu bar in a convergent application's mobile user
    interface.

### Behavior

-   Don't have more than nine menu categories within a menu bar. Too
    many categories are overwhelming and makes the menu bar difficult to
    use.
-   At the minimum, all windows should have File, Edit, Settings, and
    Help menus. If they apply, the window can also have View, Insert,
    Format, Tools and, Window menus.
-   Don't put more than 12 items within a single level of a menu. Add
    separators between logical groups within a menu. Organize the menu
    items into groups of seven or fewer strongly related items.
-   Assign shortcut keys to the most frequently used menu items. Use
    [KStandardAction](https://api.kde.org/frameworks/kconfigwidgets/html/namespaceKStandardAction.html)
    and
    [KStandardShortcut](https://api.kde.org/frameworks/kconfig/html/namespaceKStandardShortcut.html)
    items for common functions, which will result in menu items
    automatically receiving consistent names, icons, and shortcut keys.
    Any tool or function that is accessible using a keyboard shortcut
    must have an item in the menu bar so that users can discover it.
-   Don't hide the menu bar by default. If this is configurable, users
    should easily be able to make the menu bar viewable again.
-   Use submenus cautiously. Submenus add complexity to the interface
    and are physically more difficult to use, so you should take care
    not to overuse them.

### Appearance

-   Place the most frequently used items at the top of the menu.
-   Provide icons for all menu items. Don't re-use the same icon for
    multiple items.
-   For your menu items' text, follow the
    [general label guidelines][/hig/style/writing/labels).
-   Don't change menu items' labels dynamically.
-   Choose single word names for menu categories. Using multiple words
    makes the separation between categories confusing.
-   Disable menu items that don't apply to the current context instead
    of removing them from view. **Exception:** It is acceptable to hide
    menu items completely if they are permanently unavailable on the
    user's system due to missing hardware capabilities.
-   Assign shortcut keys to the most frequently used menu items (Ctrl+).
    For well-known shortcut keys, use standard assignments. Use function
    keys for commands that have a small-scale effect (F2 = Rename) and
    ctrl key for large-scale effect (Ctrl+S = Save).
-   For menu items that toggle some state on or off, always use the
    positive form. For example, use the text 'Show hidden files'
    instead of 'Hide hidden files', and don't change the text when
    hidden files are shown.

Code
----

### Kirigami

- [Kirigami: ApplicationWindow](docs:kirigami2;ApplicationWindow).
- [QML: MenuBar](https://doc.qt.io/qt-5/qml-qtquick-controls2-menubar.html)

{{< readfile file="/content/hig/examples/kirigami/AddressbookMenubar.qml" highlight="qml" >}}
