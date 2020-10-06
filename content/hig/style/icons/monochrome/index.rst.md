---
title: Monochromatic Icons
---
===================

::: {.toctree caption="Contents:" titlesonly="" hidden=""}
action emblem mimetype places status
:::

-   `action`{.interpreted-text role="doc"}
-   `emblem`{.interpreted-text role="doc"}
-   `mimetype`{.interpreted-text role="doc"}
-   `places`{.interpreted-text role="doc"}
-   `status`{.interpreted-text role="doc"}

![Monochrome icons](/hig/HIGMonoIcons.png)

Monochrome icons come in two sizes: 16px and 22px. 16px monochrome icons
are commonly seen in menu items, tabs, and push buttons that have a
raised, buttonlike appearance. 22px monochrome icons are used in
ToolButtons. Monochrome icons at both sizes are used to represent small
file types and entries in the Places panel in Dolphin and file dialogs.

Don\'t use the monochrome style for larger icon sizes.

The Monochrome style is used for [Action](action.html), Status, small
[Places,](places.html) and small [MIME type](mimetype.html) icons.

Colors
------

The monochrome style relies on distinct shapes and outlines instead of
fine details and vibrant colors, and employs an intentionally limited
color palette:

::: {.container .flex}
::: {.container}
![Color for non-destructive actions and states: navigation, acceptance,
etc.](/hig/Shade-Black.png)
:::

::: {.container}
![Color for destructive actions and states: delete, remove, error,
etc.](/hig/Icon-Red.png)
:::
:::

::: {.container .flex}
::: {.container}
![Color for warning actions and states: warning, unsure, user
interaction, etc.](/hig/Beware-Orange.png)
:::

::: {.container}
![Color for manipulative actions and states: selection, insertion, focus
feedback, etc.](/hig/Plasma-Blue.png)
:::
:::

::: {.container .flex}
::: {.container}
![Color for successful actions and states: completion, connection,
security, etc.](/hig/Noble-Fir.png)
:::
:::

Margins and alignment
---------------------

16px monochrome icons should not use the top or bottom 2 pixels, and
22px monochrome icons should not use the top or bottom 3 pixels:

::: {.container .flex}
::: {.container}
![2px margins for a 16px icon.](/hig/margins-16.png)
:::

::: {.container}
![3px margins for a 22px icon.](/hig/margins-22.png)
:::
:::

It is recommended to keep monochrome icons perfectly square. For some
types of icons described later (e.g. Places icons) this is a hard
requirement.

Because monochrome icons are so small and simple, it is important that
they be pixel-perfect, with their lines and objects aligned to a regular
grid:

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} Make sure your icon is
aligned to the pixel grid---use grids and guides to assist you when
designing it.](/hig/pixel-align-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t misalign your icon
to the pixel grid---this makes it look blurry when scaled and can make
it look wonky.](/hig/pixel-align-dont.png){.dont}
:::
:::

Adding Emblems to monochrome icons
----------------------------------

Because monochrome icons usually depict actions, many include status or
action emblems. These are always located in the bottom-right corner. The
emblem should be a minimum of 5px wide and tall, and there must be 1px
of blank space between the emblem and the rest of the icon.

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} Clear out some space for your
icon\'s emblem.](/hig/emblem-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t overlay your icon\'s
emblem on its corner.](/hig/emblem-dont.png){.dont}
:::
:::
