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

Many considerations go into choosing the right icon for each button, menu item, and list item in your app:


## Universal or specific icons?
The Breeze icon theme — as well as most others — includes icons consisting of just a base shape with a broad meaning, as well as icons consisting of multiple base shapes and/or emblems that narrow the icon's meaning to only a certain type of object or target. We call these *universal* and *specific* icons. For example:

<!-- HACK: blank column headers to get a horizontal table with fake row headers, which flows better and makes better use of horizontal space. -->
&nbsp;        |                                                    |                                                       |
--------------|----------------------------------------------------|-------------------------------------------------------|------------------------------------------------------------|
**Universal** | <img src="/hig/icon-list-add.png" width="76px">   | <img src="/hig/icon-edit-entry.png" width="76px">     | <img src="/hig/icon-edit-delete-remove.png" width="76px"> |
**Specific**  | <img src="/hig/icon-folder-add.png" width="76px"> | <img src="/hig/icon-edit-image.png" width="76px"> | <img src="/hig/icon-bookmark-remove.png" width="76px">    |

Prefer universal icons where possible, as their simplicity makes them faster to visually parse and understand. But in some cases, specific ones are more appropriate. Here are the rules for when to use each type:

Usage                                                                                                         | Type of icon to use
--------------------------------------------------------------------------------------------------------------|--------------------
Icon is accompanied by a text label explaining its function                                                   | Universal
Even without a label, surrounding context or container makes the target or meaning of the icon obvious        | Universal
Sharing a toolbar or menu with any other items that would have the same icon if they all used Universal icons | Specific

Examples:

{{< figure src="/hig/icons-universal-in-list-items.png" class="text-center" caption="Icons-only buttons located inline on list items use universal icons because their target is obvious." width="761px">}}

{{< figure src="/hig/icons-in-parent-menu-button-and-child-menu-items.png" class="text-center" caption="“Add New” button has a universal icon that applies to all child menu items, which then also use universal icons." width="400px">}}

{{< figure src="/hig/icons-specific-icons-in-menu.png" class="text-center" caption="Multiple “New [thing]” menu items visually disambiguated with specific icons." width="328px">}}

## Icons for destructive actions
Actions that destroy content must be consistently indicated as such using icons that are are red or have red elements (in the Breeze icon theme, at least):

- Use a red trash can via the `edit-delete` icon for actions that delete files or destroy content the user has created.
- Use a red X via the `edit-delete-remove` icon for actions that remove abstract or standard items in a way that's possible to restore later.
- Use one of the more specific deletion-style icons (e.g. `delete-comment`) only when appropriate according to the rules for universal vs specific icons.

Avoid the use of icons with red elements or X symbols for non-destructive actions.

“Move to trash” style actions are not destructive in and of themselves, so don't use a red icon for them. Instead, use a black trash can via the `trash-empty` icon. Give its button or menu item a label that includes the “move to trash” phrasing.


## Icons-only buttons
Most buttons should also include text. Only use an icons-only button in the following situations:

- Where it's critical to save horizontal space for user content, text, or other actions.
- For actions not relevant to the app's core workflow where it's not a disaster if the user ignores it, or where groups of related icons reveal each other's meaning by proximity (e.g. icons-only buttons to choose text justification in a word processing app).

<!-- TODO: this needs a picture as evidence that it's true -->

In both cases, only proceed with the plan to omit text if an icon can be found that uses instantly recognizable imagery common across all operating systems and apps. Examples include:

<center>

&nbsp;                                                           |                        |                                                                  |
-----------------------------------------------------------------|------------------------|------------------------------------------------------------------|-
<img src="/hig/icon-only-list-add.png" width="57px">             | `list-add`             | <img src="/hig/icon-only-configure.png" width="57px">            | `configure`
<img src="/hig/icon-only-go-previous.png" width="57px">          | `go-previous`          | <img src="/hig/icon-only-print.png" width="57px">                | `print`
<img src="/hig/icon-only-go-home.png" width="57px">              | `go-home`              | <img src="/hig/icon-only-player-volume-muted.png" width="57px">  | `player-volume-muted`
<img src="/hig/icon-only-search.png" width="57px">               | `search`               | <img src="/hig/icon-only-media-playback-start.png" width="57px"> | `media-playback-start`
<img src="/hig/icon-only-edit-delete.png" width="57px">          | `edit-delete`          | <img src="/hig/icon-only-documentinfo.png" width="57px">         | `documentinfo`
<img src="/hig/icon-only-edit-delete-remove.png" width="57px">   | `edit-delete-remove`   | <img src="/hig/icon-only-open-menu.png" width="57px">            | `open-menu`

</center>
<br/>
<br/>

If in doubt, show the button's text. If the app has so many buttons visible at once that this looks overwhelming, rethink the UI. For example:

- Only show buttons relevant to the current context.
- Place buttons in a Contextual Toolview that can be hidden when not relevant.
- Group buttons by function in the tabs of a [Kirigami.NavigationTabBar](https://api.kde.org/frameworks/kirigami/html/classNavigationTabBar.html).
- Put the buttons on a [Kirigami.ActionToolBar](https://develop.kde.org/docs/getting-started/kirigami/components-actiontoolbar/) so that buttons without sufficient space get moved into an overflow menu.
- Reduce the length of the buttons' labels.
- Condense related buttons into a single one that opens a menu of actions.

To make a button icons-only, hide the text using the [display](https://doc.qt.io/qt-6/qml-qtquick-controls-abstractbutton.html#display-prop) property. Always set the [text](https://doc.qt.io/qt-6/qml-qtquick-controls-abstractbutton.html#text-prop) property.


## Icons for menu items and buttons with text
Set an icon on every button and menu item, making sure not to use the same icon for multiple visible buttons or menu items. Choose different icons, or use more specific ones to disambiguate.

For icons on parent menu items or buttons that open menus, use symbolism relevant to all child menu items.


## Icons for list items
For icons in the leading position, vary the icons between list items; don't use the same one for every item. If this is impossible, don't show any icons.

For inline action buttons in the trailing position, use icons-only buttons with simple universal icons for obvious actions (delete, edit, etc.). Keep the number of buttons to two at most, and prefer zero to one. If this is impossible because each list item has many possible actions or complex actions that cannot be expressed with simple icons, don't use inline actions. Instead, push a sub-page with a rich UI when the user clicks on the list item.


## Symbolic or full-color icons?
Once you've chosen an icon, determine whether it should be *symbolic* or *full-color*. At small sizes (especially `small` and `smallMedium`), full-color icons can become visual smudges or contribute to a “heavy” appearance when many are shown in a row or column. Prefer symbolic ones by appending `-symbolic` to the name of the icon you're asking the icon theme to provide. This causes the icon loader to provide a symbolic monochrome icon if the theme has one. Full-color icons are better at `medium` size and larger.

Always use symbolic icons for menu items and standard-sized buttons.

Always use symbolic icons for the `small` icon size in list items, and *generally* at the `smallMedium` size too. Context dictates whether this makes sense or not: with only a small number of list items, full-color icons may look better. For large or dense lists, prefer symbolic icons.


## Overlaying emblems on top of content
When overlaying icons on top of user content or on top of other icons, only use overlay icons whose names begin with `emblem-`, as they are designed for this purpose.


## Implementation details
- Don't bundle custom icons with your app or specify pixmaps for your icons. Instead get them from the system's icon theme using [QIcon::IconFromTheme()](https://doc.qt.io/qt-6/qicon.html#fromTheme-1) in C++ code, or using the `icon.name` property for QML components that accept icons.
- Make the KIconThemes framework a build dependency for your application and call `KIconTheme::initTheme` before creating the `QApplication`. See [more information here]({{< relref "advanced-maincpp" >}}).
- For standard actions, use [KStandardActions](https://api.kde.org/frameworks/kconfig/html/namespaceKStandardActions.html) so that it gets a standard icon, too.
- Use [standard icon sizes](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1Units.html#a7e729a19d3cdd6107828dcfc14950706) in any context where the icon size is not automatically chosen for you.


## Designing your own icons
Every app needs a great icon. Learn how to make one [here]({{< relref "colorful" >}}).

Learn how to create symbolic action icons [here]({{< relref "monochrome" >}}).
