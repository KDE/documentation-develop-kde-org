---
title: Emblem Icons
weight: 3
aliases:
- /hig/style/icons/monochrome/emblem
---

Emblem icons are used to indicate state. They come in three sizes: 8px,
16px, and 22px, and always use the [monochrome style]({{< relref "monochrome" >}}). They
are typically overlaid on icons. Unlike most monochromatic icons, emblem
icons use bright colours to remain recognizable, even at small sizes.

Purpose
-------

Emblem icons are used alongside a base icon to form compound icons that
convey additional information on top of the base icon, indicating its
status, such as missing, deleted, etc.

Design
------

### Anatomy

Emblem icons always use the entire canvas area. Pixel alignment is
especially important for emblem icons as they are rendered at very small
sizes, making the consequences of pixel misalignment more noticeable
than at other sizes.

{{< compare >}}
{{< do src="/hig/8px-emblem-do.png" >}}
Pixel-align your icon and use the entire canvas.
{{< /do >}}
{{< dont src="/hig/8px-emblem-dont.png" >}}
Don't misalign your icon or use margins.
{{< /dont >}}
{{< /compare >}}

16px and 22px emblem icons get a 60% text colour outline to ensure
contrast against various backgrounds. 8px emblems do not recieve an
outline because of their limited canvas size.

{{< compare >}}
{{< do src="/hig/22-emblem-outline.png" >}}
16px and 22px emblem icons get an outline to increase visibility on
various backgrounds.
{{< /do >}}
{{< dont src="/hig/8-emblem-outline.png" >}}
8px emblem icons need to rely on bold shapes and bright colours for
visiblity, as they don't have room for an
outline.
{{< /dont >}}
{{< /compare >}}
