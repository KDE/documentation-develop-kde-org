---
Title: "Layout and navigation"
weight: 5
aliases:
- /hig/introduction/responsive/
- /hig/layout/
- /hig/layout/units/
- /hig/layout/metrics/
- /hig/layout/alignment/
- /hig/layout/onehand/
- /hig/layout/gestures/
- /hig/components/navigation/
- /hig/components/navigation/commandlink/
- /hig/components/navigation/contextdrawer/
- /hig/components/navigation/contextmenu/
- /hig/components/navigation/globaldrawer/
- /hig/components/navigation/pushbutton/
- /hig/components/navigation/toolbar/
- /hig/components/assistance/statusbar/
- /hig/patterns-command/drawer/
- /hig/patterns-command/menubar/
- /hig/patterns-command/toolbar/
- /hig/patterns-navigation/
- /hig/patterns-navigation/single/
- /hig/patterns-navigation/tab/
- /hig/patterns-navigation/breadcrumb/
- /hig/patterns-navigation/column/
---

## Positioning
Convey importance and grouping by placing items strategically.

People read layouts in the order they read words in their language; users will pay more attention to items near the top-leading position (i.e. top-left in a language like English, and top-right in a language like Arabic). By the same token, users will perceive items in the bottom-trailing position as being the logically last or final thing to do before moving on.

One exception is on a mobile phone, where the most commonly used tools live in a bottom toolbar. This improves acquisition speed by making them thumb-reachable without re-positioning the hand.

Group related items together by reducing the spacing between them, and increasing the spacing between groups. Make sure items that _look_ grouped are in fact logically related.


## Spacings and sizes
Use the Kirigami [standard units](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1Units.html) consistently:

Item                                                                                  | Value to use
--------------------------------------------------------------------------------------|--------------------------
Spacing between title and subtitle text                                               | 0
Spacing between title/subtitle groups and other content below them                    | `smallSpacing`
Spacing between other directly related items, or controls sharing a logical group     | `smallSpacing`
Spacing between groups of controls or text                                            | `largeSpacing`
Spacing between items in a toolbar (e.g. buttons and text fields)                     | `mediumSpacing`
Padding between window/page edges and “frameless" container views                     | 0
Padding between window/page edges and all other UI elements                           | `largeSpacing`
Corner radius for rounded UI elements                                                 | `cornerRadius`
Fixed-size UI elements, including default and minimum window sizes                    | `gridUnit` multiplied as needed
Size of icons in menu items and raised buttons                                        | `IconSizes.small`
Size of icons in flat/toolbar buttons and list items without subtitles                | `IconSizes.smallMedium`
Size of icons in list items with subtitles                                            | `IconSizes.medium`


## Common layouts and responsiveness
KDE apps commonly consist of layout elements such a main content area, a sidebar used for navigation, a toolbar displaying actions contextually relevant to what's shown in the content view, a menu of globally-scoped actions, and more.

These layout elements must adapt fluidly to diverse screen sizes and window shapes. Even on the desktop, users may resize your app's window to be small and narrow. Adapt the app's window content in sane and sensible ways when maximized, tiled, or otherwise used at a different size or shape than how it was originally designed.

Here are the ways that common layout elements, when present, should move or change in different circumstances:

Item                         | Desktop/widescreen        | Mobile/narrow
-----------------------------|---------------------------|--------------
Toolbar                      | Above the content area    | Below the content area
Sidebar                      | Leading the content area  | Visible on demand in the leading position, or the first page in a page stack
Contextual preview/tool view | Trailing the content area | Visible on demand in the trailing position
Menubar                      | Above the toolbar         | Hamburger menu button on the toolbar
Navigation tab bar           | Above the content area    | Below the content area
Status Bar                   | Below the content area    | Omitted

[Kirigami.GlobalDrawer](https://develop.kde.org/docs/getting-started/kirigami/components-drawers/#global-drawer) is a useful component for convergent apps. It looks like a standard sidebar, and can be made always visible in widescreen/desktop mode by setting `modal: false`. In narrow/mobile mode, users pull it out on demand. [Kirigami.ContextDrawer](https://develop.kde.org/docs/getting-started/kirigami/components-drawers/#context-drawers) is the same but for contextual actions relevant only for individual pages.

Desktop/laptop apps can be adapted to work on tablets and 2-in-1 laptops in tablet mode by enlarging small UI elements and hiding menubars. Phones (even large ones) need an optimized mobile UI; do not just scale down a desktop UI.

{{< alert title="Note" color="info" >}}
Detect that the app is running in tablet mode  by reading the value of [Kirigami.Settings.tabletMode](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1Settings.html#ad0e5d3914e8a36983e44a3bd35a9528f). Enable this mode for testing purposes on System Settings' General Behavior page.

Detect that the app is running on a mobile phone by reading the value of [Kirigami.Settings.isMobile](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1Settings.html#abae81b4f287d9a96a44e1953f9833596). Set the `QT_QUICK_CONTROLS_MOBILE=1` environment variable to run your app in a simulated mobile mode.
{{< /alert >}}

In addition, offer a good experience for laptop users by keeping these points in mind:

- Implement “pixel-by-pixel” scrolling for touchpad two-finger scroll gestures, instead of jumping a certain number of rows.
- Set shortcuts using modifier and alphanumeric keys; never just a function key, as these can be hard to access on laptops.

{{< alert title="" color="info" >}}
<details>
<summary>Click here to learn about relevant QtWidgets technologies</summary>
<br/>

In a QtWidgets app, KDE's basic GUI layout library in [KXmlGui](https://develop.kde.org/docs/getting-started/kxmlgui/) is recommended. Sidebars can be implemented using [QDockWidget](https://doc.qt.io/qt-6/qdockwidget.html).

</details>
{{< /alert >}}


## Menus
Menus are drop-down lists of actions the user can perform.

Small or focused apps often need no menu structures at all, because all of their actions are visible on demand in contextual toolbars or inline on content items.

<!--TODO: Picture of a focused app like Spectacle -->

In small- and medium-sized apps, it's common for a curated set of globally-scoped actions to be visible in a “hamburger menu:” a menu that appears when clicking on a button located on the app's toolbar with the `application-menu-symbolic` icon. Its contents are static and globally-scoped, with contextually irrelevant items disabled rather than being hidden.

Don't put standard app and window management actions like “Quit” and “Minimize” in a hamburger menu.

<!-- TODO: Picture of medium-sized app with hamburger menu like Dolphin -->

Only show a hamburger menu by default if its contents can be kept to about 15 items or fewer. If you are tempted to add more than this, a hamburger menu is the wrong UI element for your app; instead place a real menubar between the titlebar and toolbar. Like the hamburger menu, its contents are static and disabled when not relevant, rather than hidden. The major difference is that the menubar shows all possible actions in the app, so users can access any of them at any time.

<!--TODO: Picture of large app with big menu like Okular or Merkuro -->

{{< alert title="" color="info" >}}
<details>
<summary>Click here to learn about relevant QtWidgets technologies</summary>
<br/>

In a QtWidgets app, use [KHamburgerMenu](https://api.kde.org/frameworks/kconfigwidgets/html/classKHamburgerMenu.html) to give a medium-to-large app both a menu bar and a hamburger menu. Choose a curated list of the most important actions for the hamburger menu, which will appear when the menubar is hidden.

</details>
{{< /alert >}}


## Navigation
Strive to minimize navigation as a chore for users to succeed at before they can get to what they want. The best navigational flow is nonexistent, because everything is provided to the user as they need it.

Linear navigation work works well for apps that have a step-by-step workflow with clear starting and ending points. Use the standard [PageStack](https://develop.kde.org/docs/getting-started/kirigami/components-pagerow_pagestack/) mechanism built into Kirigami for this navigation model, with breadcrumbs and back/forward buttons in the toolbar for navigation.

For apps with multiple destinations not arranged in a linear flow, implement a dedicated navigational control to let the user jump from one destination to another. With 5 or fewer destinations, use a [Kirigami.NavigationTabBar](https://api.kde.org/frameworks/kirigami/html/classNavigationTabBar.html).

<!-- TODO: Picture of KClock -->

Otherwise, use a [Kirigami.GlobalDrawer](https://api.kde.org/frameworks/kirigami/html/classGlobalDrawer.html) to display the navigation destinations.

<!-- TODO: Picture of Discover or Elisa -->

<!-- TODO: picture of some PlaMo compatible app with a navigation sidebar or something -->

Regardless of which navigational control is used, on the desktop place the most important or commonly-accessed destinations in the top/leading position. On mobile, place them on the bottom to maintain optimal thumb-reachability.


## Tools and functionality
When a content view needs controls specific to it that for some reason cannot be provided by the main toolbar, place them in a secondary toolbar in the page header:

<!-- TODO: Picture of Elisa -->

Many KDE apps also feature auxiliary “Contextual Toolviews.” These can show previews or information about what's displayed or selected in the main content area, or extra tools to interact with it.

<!-- TODO: Picture of Kate, Dolphin, or Partition Manager -->

Show these views in addition to the global-scope navigation UI; don't replace it. The only exception is when the navigation view is itself already contextual (e.g. a thumbnail view for the open document in a PDF reader app); in this case the contextual navigation can be integrated into a tabbed/multi-view sidebar that shows different contextual views for the visible content.

<!-- TODO: Picture of Gwenview or Okular's tabbed sidebar -->


## Right-to-left languages
People using the software in right-to-left languages like Arabic and Hebrew expect for layouts to reverse direction.

This works automatically for items using anchor-based positioning or Qt Layout objects such as RowLayout and ColumnLayout, but it's important to check things yourself. For example you can test your app in right-to-left mode by running it in Arabic with `LANGUAGE=ar_AR [app_executable]`. Even if you can't read the words, you can check the layout.

In addition to layout objects reversing their horizontal positioning, make sure text alignment has reversed too.

Manually reverse any custom controls that show progress of directionality—for example star-rating widgets or sliders with custom visual styling.

When using icons that indicate directionality or depict layouts or textual elements, use the reversed versions have `-rtl` suffixes. Examples include back and forward icons, undo/revert icons, volume icons, and icons depicting things like “close the left sidebar.”

Don't mirror images.

For more information, see the [Qt documentation on right-to-left user interfaces](https://doc.qt.io/qt-6/qtquick-positioning-righttoleft.html).
