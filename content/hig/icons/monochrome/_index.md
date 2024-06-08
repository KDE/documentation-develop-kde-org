---
title: Monochromatic Icons
weight: 2
aliases:
- /hig/style/icons/monochrome
---

![Monochrome icons](/hig/HIGMonoIcons.png)

Monochrome icons come in two sizes: 16px and 22px. 16px monochrome icons
are commonly seen in menu items, tabs, and push buttons that have a
raised, buttonlike appearance. 22px monochrome icons are used in
ToolButtons. Monochrome icons at both sizes are used to represent small
file types and entries in the Places panel in Dolphin and file dialogs.

Don't use the monochrome style for larger icon sizes.

The Monochrome style is used for [Action](action), Status, small
[Places,](places) and small [MIME type](mimetype) icons.

Colors
------

The monochrome style relies on distinct shapes and outlines instead of
fine details and vibrant colors, and employs an intentionally limited
color palette:

{{< compare >}}
{{< figure class="col-12 col-sm-6" src="/hig/Shade-Black.png" caption="Color for non-destructive actions and states: navigation, acceptance, etc." >}}
{{< img class="col-12 col-sm-6" src="/hig/Icon-Red.png" caption="Color for destructive actions and states: delete, remove, error, etc." >}}
{{< /compare >}}

{{< compare >}}
{{< img class="col-12 col-sm-6" src="/hig/Beware-Orange.png" caption="Color for warning actions and states: warning, unsure, user interaction, etc." >}}
{{< img class="col-12 col-sm-6" src="/hig/Plasma-Blue.png" caption="Color for manipulative actions and states: selection, insertion, focus feedback, etc." >}}
{{< /compare >}}

{{< compare >}}
{{< figure class="col-sm-6 col-12" src="/hig/Noble-Fir.png" caption="Color for successful actions and states: completion, connection, security, etc." >}}
{{< /compare >}}

Margins and alignment
---------------------

16px monochrome icons should not use the top or bottom 2 pixels, and
22px monochrome icons should not use the top or bottom 3 pixels:

{{< compare >}}
{{< figure class="col-12 col-sm-6" src="/hig/margins-16.png" caption="2px margins for a 16px icon." >}}
{{< img class="col-12 col-sm-6" src="/hig/margins-22.png" caption="3px margins for a 22px icon." >}}
{{< /compare >}}

It is recommended to keep monochrome icons perfectly square. For some
types of icons described later (e.g. Places icons) this is a hard
requirement.

Because monochrome icons are so small and simple, it is important that
they be pixel-perfect, with their lines and objects aligned to a regular
grid:

{{< compare >}}
{{< do src="/hig/pixel-align-do.png" >}}
Make sure your icon is aligned to the pixel grid---use grids and guides to assist you when designing it.
{{< /do >}}
{{< dont src="/hig/pixel-align-dont.png" >}}
Don't misalign your icon to the pixel grid---this makes it look blurry when scaled and can make it look wonky.
{{< /dont >}}
{{< /compare >}}

Adding Emblems to monochrome icons
----------------------------------

Because monochrome icons usually depict actions, many include status or
action emblems. These are always located in the bottom-right corner. The
emblem should be a minimum of 5px wide and tall, and there must be 1px
of blank space between the emblem and the rest of the icon.

{{< compare >}}
{{< do src="/hig/emblem-do.png" >}}
Clear out some space for your icon's emblem.
{{< /do >}}
{{< dont src="/hig/emblem-dont.png" >}}
Don't overlay your icon's emblem on its corner.
{{< /dont >}}
{{< /compare >}}
