---
title: Colorful Icons
weight: 10
aliases:
- /hig/style/icons/colorful
---


![Colorful icons](/hig/Sample_color_icons.png)

Colorful icons make full use of the Breeze color palette. Colorful icons are not
flat and incorporate elevation, shadows, and lighting.

{{< compare >}}
{{< do src="/hig/anjuta-deep.png" >}}
Use a variety of techniques to give your icon depth.
{{< /do >}}

{{< dont src="/hig/anjuta-flat.png" >}}
Don't make your icon flat - this makes it visually bland.
{{< /dont >}}
{{< /compare >}}

There are a variety of colorful icon types:

-   32px: [Category, Preferences,]({{< relref "category_preferences" >}})
    [MIME type]({{< relref "mimetype" >}}), and [Places]({{< relref "places" >}}) icons
-   48px: [Application]({{< relref "application" >}}) icons
-   64px: [MIME type,]({{< relref "mimetype" >}}) [Places,]({{< relref "places" >}}) Devices,
    and a few Status icons

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

![Anjuta icon with 4px left and right margins. The circle's edges
extend into the margin.](/hig/anjuta-margin-vert.png)

### 32px Colorful Icons

32px colorful icons have a 2px margin instead of 4px margins.

{{< compare >}}
{{< do src="/hig/small-margin-do.png" >}}
Use 2px margins on 32px colorful icons.
{{< /do >}}

{{< dont src="/hig/small-margin-dont.png" >}}
Don't use 4px margins on 32px colorful icons; this reduces the canvas
size too much
{{< /dont >}}
{{< /compare >}}

Anatomy
-------

All colorful icons share the same basic anatomy.

![](/hig/anjuta-anatomy.png)

1.  Foreground
2.  Foreground Shadow
3.  Base
4.  Base Shadow

{{< compare >}}
{{< figure class="col-12 col-md-6" src="/hig/anjuta-foreground.png" caption="The foreground of an icon is the distinctive part that conveys the most branding." >}}
{{< figure class="col-12 col-md-6" src="/hig/anjuta-foreground-shadow.png" caption="Foregrounds on a background have a 45° shadow to the bottom right that spans the entire background." >}}
{{< figure class="col-12 col-md-6" src="/hig/anjuta-background.png" caption="Icons can have a background to serve as a base for their foreground." >}}
{{< figure class="col-12 col-md-6" src="/hig/anjuta-background-shadow.png" caption="The foreground, or the background if there is one, has a 1px hard  shadow on the bottom." >}}
{{< /compare >}}


Elements
--------

### Color

Icons can have a variety of shapes, which when combined with color,
produce numerous unique arrangements.

{{< compare >}}
{{< do src="/hig/color-do.png" >}}
Color can be used to add variety to an otherwise bland surface.
{{< /do >}}
{{< dont src="/hig/color-dont.png" >}}
Don't give color shadows; color is not shape and should not be treated as
such.
{{< /dont >}}
{{< /compare >}}

### Layers

Icons are composed of layers that cast shadows.

{{< compare >}}
{{< do src="/hig/layer-do.png" >}}
Give icons at most two or three major layers.
{{< /do >}}
{{< dont src="/hig/layer-dont.png" >}}
Don't give icons too many layers.
{{< /dont >}}
{{< /compare >}}

### Lighting and Shadows

#### Ambient Lighting

Icon fills should reflect ambient lighting — go from a lighter top to a
darker bottom.

{{< compare >}}
{{< do src="/hig/lighting-gradient-do.png" >}}
Do have gradients behave like light is coming from above the icon.
{{< /do >}}
{{< dont src="/hig/lighting-gradient-dont.png" >}}
Don't have gradients behave like light is coming from below the icon.
{{< /dont >}}
{{< /compare >}}

#### Hard Shadow

Every icon should have a 1px solid hard shadow. A good baseline color to
overlay is 10% black (#000000).

{{< compare >}}
{{< do src="/hig/hardshadow-do.png" >}}
Add a 1px hard shadow to give your icon depth.
{{< /do >}}
{{< dont src="/hig/hardshadow-dont.png" >}}
Don't forget to add a hard shadow; this makes your icon seem flat.
{{< /dont >}}
{{< /compare >}}

#### 45° Shadows

Foregrounds should have a 45° shadow to the bottom right.

{{< compare >}}
{{< do src="/hig/45shadow-do.png" >}}
Objects are solid, and block shadows from passing through.
{{< /do >}}
{{< dont src="/hig/45shadow-dont.png" >}}
Don't have shadows pass through objects; they are not glass.
{{< /dont >}}
{{< /compare >}}

{{< compare >}}
{{< do src="/hig/bound-do.png" >}}
45° shadows are bounded to their parent elements.
{{< /do >}}
{{< dont src="/hig/bound-dont.png" >}}
45° shadows should not exceed the bounds of their parents.
{{< /dont >}}
{{< /compare >}}

{{< compare >}}
{{< do src="/hig/gradient-do.png" >}}
45° shadows have a gradient that fades out before they hit an edge.
{{< /do >}}
{{< dont src="/hig/gradient-dont.png" >}}
45° shadows are not solid and do not extend to the edge of their parents.
{{< /dont >}}
{{< /compare >}}
