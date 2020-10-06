---
title: Colorful Icons
---
==============

::: {.toctree caption="Contents:" titlesonly="" hidden=""}
application mimetype places category_preferences
:::

![Colorful icons](/hig/Sample_color_icons.png)

Colorful icons make full use of the
`Breeze color palette <../../color/index>`{.interpreted-text
role="doc"}. Colorful icons are not flat and incorporate elevation,
shadows, and lighting.

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} Use a variety of techniques
to give your icon depth.](/hig/anjuta-deep.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t make your icon flat
- this makes it visually bland.](/hig/anjuta-flat.png){.dont}
:::
:::

There are a variety of colorful icon types:

-   32px: [Category, Preferences,](category_preferences.html) [MIME
    type,](mimetype.html) and [Places](places.html) icons
-   48px: [Application](application.html) icons
-   64px: [MIME type,](mimetype.html) [Places,](places.html) Devices,
    and a few [Status](action.html) icons

Margins
-------

### Vertical

Colorful icons have a top and bottom margin of 4 pixels. Icons should
not put any details here whatsoever.

![Anjuta icon with 4px top and bottom margins. The icon does not enter
the margins.](/hig/anjuta-margin-horiz.png)

### Horizontal

Colorful icons also have a left and right margin of 4 pixels. Minor
details can extend here as necessary.

![Anjuta icon with 4px left and right margins. The circle\'s edges
extend into the margin.](/hig/anjuta-margin-vert.png)

### 32px Colorful Icons

32px colorful icons have a 2px margin instead of 4px margins.

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} Use 2px margins on 32px
colorful icons.](/hig/small-margin-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t use 4px margins on
32px colorful icons; this reduces the canvas size too
much.](/hig/small-margin-dont.png){.dont}
:::
:::

Anatomy
-------

All colorful icons share the same basic anatomy.

![](/hig/anjuta-anatomy.png)

1.  Foreground
2.  Foreground Shadow
3.  Base
4.  Base Shadow

::: {.container .flex}
::: {.container}
![The foreground of an icon is the distinctive part that conveys the
most branding.](/hig/anjuta-foreground.png)
:::

::: {.container}
![Foregrounds on a background have a 45° shadow to the bottom right that
spans the entire background.](/hig/anjuta-foreground-shadow.png)
:::
:::

::: {.container .flex}
::: {.container}
![Icons can have a background to serve as a base for their
foreground.](/hig/anjuta-background.png)
:::

::: {.container}
![The foreground, or the background if there is one, has a 1px hard
shadow on the bottom.](/hig/anjuta-background-shadow.png)
:::
:::

Elements
--------

### Color

Icons can have a variety of shapes, which when combined with color,
produce numerous unique arrangements.

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} Color can be used to add
variety to an otherwise bland surface.](/hig/color-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t give color shadows;
color is not shape and should not be treated as
such.](/hig/color-dont.png){.dont}
:::
:::

### Layers

Icons are composed of layers that cast shadows.

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} Give icons at most two or
three major layers.](/hig/layer-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t give icons too many
layers.](/hig/layer-dont.png){.dont}
:::
:::

### Lighting and Shadows

#### Ambient Lighting

Icon fills should reflect ambient lighting---go from a lighter top to a
darker bottom.

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} Do have gradients behave like
light is coming from above the
icon.](/hig/lighting-gradient-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t have gradients
behave like light is coming from below the
icon.](/hig/lighting-gradient-dont.png){.dont}
:::
:::

#### Hard Shadow

Every icon should have a 1px solid hard shadow. A good baseline color to
overlay is 10% black (\#000000).

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} Add a 1px hard shadow to give
your icon depth.](/hig/hardshadow-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t forego a hard
shadow; this makes your icon seem
flat.](/hig/hardshadow-dont.png){.dont}
:::
:::

#### 45° Shadows

Foregrounds should have a 45° shadow to the bottom right.

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} Objects are solid, and block
shadows from passing through.](/hig/45shadow-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t have shadows pass
through objects; they are not glass.](/hig/45shadow-dont.png){.dont}
:::
:::

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} 45° shadows are bounded to
their parent elements.](/hig/bound-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} 45° shadows should not
exceed the bounds of their parents.](/hig/bound-dont.png){.dont}
:::
:::

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} 45° shadows have a gradient
that fades out before they hit an edge.](/hig/gradient-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} 45° shadows are not solid
and do not extend to the edge of their
parents.](/hig/gradient-dont.png){.dont}
:::
:::
