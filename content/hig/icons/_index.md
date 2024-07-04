---
title: "Icons"
weight: 10
aliases:
- /hig/style/icons
- /hig/components/assistance/emblem/
- /hig/patterns-content/iconandtext/
---

KDE apps respect the FreeDesktop [icon theme](https://specifications.freedesktop.org/icon-theme-spec/latest/) and [icon naming](https://specifications.freedesktop.org/icon-naming-spec/latest/) standards, and make extensive use of themable icons.

KDE's Breeze icon theme complies with the above specifications and contains thousands of icons suitable for a wide range of apps. While the user can change the icon theme to something else, ensure your app looks perfect with Breeze. Browse the library of Breeze icons using Icon Explorer, contained within the `plasma-sdk` package.

If you find that your app needs a new icon not present in the Breeze icon theme, [request one here](https://bugs.kde.org/enter_bug.cgi?product=Breeze&component=Icons). Members of KDE's Visual Design Group will create one and add it to the Breeze icon theme so everyone else can use it too.


## General icon use guidelines
- Set an icon on every button and menu item.
- Don't use the same icon for multiple UI elements that are visible at the same time.
- For icons on parent menu items, or buttons that open menus, use symbolism relevant to all child menu items.
- Only overlay icons beginning with `emblem-` directly on top of user content or other icons, as they are designed for this.
- Don't use the same icon in the leading position of every item in a list view; vary them, or remove the icons.


## Implementation details
- Don't bundle custom icons with your app or specify pixmaps for your icons. Instead get them from the system's icon theme using [QIcon::IconFromTheme()](https://doc.qt.io/qt-6/qicon.html#fromTheme-1) in C++ code, or using the `icon.name` property for QML components that accept icons.
- Make the Breeze icon theme a dependency for your application to ensure that it gets installed.
- For standard actions, use [KStandardAction](https://api.kde.org/frameworks/kconfigwidgets/html/namespaceKStandardAction.html) so that it gets a standard icon, too.
- Use [standard icon sizes](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1Units.html#a7e729a19d3cdd6107828dcfc14950706) in any context where the icon size is not automatically chosen for you.


## Icons-only buttons
Most buttons should include text. Only use Icons-only buttons where saving space is critical and their icons use imagery that is common and universal across all operating systems and apps. Examples include:

<!--TODO: Add pictures of these icons -->

- `go-previous`
- `go-home`
- `search`
- `configure`
- `edit-delete`
- `print`
- `player-volume-muted`
- `media-playback-start`
- `documentinfo`
- `open-menu`

It's also acceptable to use icons-only buttons for actions not relevant to the app's core workflow (where it's not a disaster if the user ignores it) or where groups of related icons reveal each other's meaning by proximity. An example would be icons-only buttons to choose text justification in a word processing app:

<!-- TODO: this needs a picture as evidence that it's true -->

If in doubt, show the button's text. If the app has so many buttons visible at once that this looks overwhelming, rethink the UI. For example:

- Only show buttons relevant to the current context.
- Place buttons in a Contextual Toolview that can be hidden when not relevant.
- Group buttons by function in the tabs of a [Kirigami.NavigationTabBar](https://api.kde.org/frameworks/kirigami/html/classNavigationTabBar.html).
- Put the buttons on a [Kirigami.ActionToolBar](https://develop.kde.org/docs/getting-started/kirigami/components-actiontoolbar/) so that buttons without sufficient space get moved into an overflow menu.
- Reduce the length of the buttons' labels.
- Condense related buttons into a single one that opens a menu of actions.

To make a button icons-only, hide the text using the [display](https://doc.qt.io/qt-6/qml-qtquick-controls-abstractbutton.html#display-prop) property. Always set the [text](https://doc.qt.io/qt-6/qml-qtquick-controls-abstractbutton.html#text-prop) property.


## Icons for destructive actions
Destructive actions must be consistently indicated as such using icons that are are red or have red elements (in the Breeze icon theme, at least):

- Use a red trash can via the `edit-delete` icon for actions that delete files or destroy content the user has created.
- Use a red X via the `edit-delete-remove` icon for actions that remove abstract or standard items in a way that's possible to restore later.
- Use one of the more detailed deletion icons (e.g. `delete-comment`) only where multiple deletion actions are visible and must be visually disambiguated, or on icons-only buttons where the icon itself has to convey all meaning and the context is not sufficient to indicate what will be deleted.
- Use a black trash can via the `trash-empty` icon for moving an item to the trash, and give its button or menu item a label that includes the “move to trash” phrasing.

Avoid the use of icons with red elements or X symbols for non-destructive actions.


## Symbolic vs full-color
At small sizes (especially `small` and `smallMedium`), append `-symbolic` to the name of the icon you're asking the icon theme to provide; this gives you a symbolic monochrome icon if the theme has one. At these small sizes, full-color icons can become visual smudges or contribute to a “heavy” appearance when many are shown in a row or column, so we prefer symbolic ones. Full-color icons are better at `medium` size and larger.

Always use symbolic icons for menu items and standard-sized buttons.

Always use symbolic icons for the `small` icon size in list items, and *generally* at the `smallMedium` size too. Context dictates whether this makes sense or not: with only a small number of list items, full-color icons may look better. For large or dense lists, prefer symbolic icons.


## Designing your own icons
Every app needs a great icon. Learn how to make one [here]({{< relref "colorful" >}}).

Learn how to create symbolic action icons [here]({{< relref "monochrome" >}}).
