---
title: Grid
---
====

Like a table, a grid is a structure to distribute items into rows and
columns. Unlike a table, a grid doesn\'t have a fixed structure; rather,
the rows and columns are determent by the available space.

![Choose a new wallpaper](/hig/Wallpaper-dark.png)

Guidelines
----------

### Is this the right control?

Like `lists <list>`, Grids are used to
display a sorted or unsorted set of items. All items should be of the
same kind.

### Behavior

Grids adjust the number of columns dynamically to distribute the items
according to the available horizontal space without making the grid
horizontally scrollable. Grids can be vertically scrollable though.

```{=html}
<video autoplay controls 
src="https://cdn.kde.org/hig/video/20180620-1/CardLayout2.webm" loop="true"
playsinline="true" width="536" onended="this.play()" class="border"></video>
```
-   Don\'t have blank grid items; use meta-options, e.g. (None) instead.
-   Place options that represent general options (e.g. All, None) at the
    beginning of the grid.
-   Sort grid items in a logical order. Make sure sorting fits
    translation.

::: {.attention}
::: {.title}
Attention
:::

For `accessibility </accessibility/index>`
make sure to test keyboard navigation with the grid.
:::

#### On-Demand Actions

Grid items can use the
`on-demand pattern </patterns/command/ondemand>`{.interpreted-text
role="doc"} for inline actions.

#### Picker

Grids can be used for the
`picker pattern </patterns/content/picker>`{.interpreted-text
role="doc"}. Place a button below the grid to add items to the grid. To
remove items from the grid, either add a remove action on the item, or
give the user the possibility to select items and add a global remove
button at the bottom of the grid.

#### Ordering

If the the order of the items can be changed by the user, permit
re-ordering via drag-and-drop.

### Appearance

-   All items must be the same size. Item can change their size, either
    through user input or as a response to changes of the available
    space for the grid.
-   All rows, except the last one, must have the same number of items.
-   Use
    `sentence style capitalization </style/writing/capitalization>`{.interpreted-text
    role="doc"} for grid view items.

#### Cards

See `cards <card>` for more information on
how to use cards in a grid view.

#### KCM

Use the `KCMGrid </platform/kcmgrid>` for
grids in KCMs.

Code
----

### Kirigami

> -   [QML: GridView](https://doc.qt.io/qt-5/qml-qtquick-gridview.html)
