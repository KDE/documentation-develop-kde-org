Emblem Icons
============

Emblem icons are used to indicate state. They come in three sizes: 8px,
16px, and 22px, and always use the [monochrome style](index.html). They
are typically overlaid on icons. Unlike most monochromatic icons, emblem
icons use bright colours to remain recognisable, even at small sizes.

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

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} Pixel-align your icon and use
the entire canvas.](/img/8px-emblem-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t misalign your icon
or use margins.](/img/8px-emblem-dont.png){.dont}
:::
:::

16px and 22px emblem icons get a 60% text colour outline to ensure
contrast against various backgrounds. 8px emblems do not recieve an
outline because of their limited canvas size.

::: {.container .flex}
::: {.container}
![16px and 22px emblem icons get an outline to increase visiblity on
various backgrounds.](/img/22-emblem-outline.png)
:::

::: {.container}
![8px emblem icons need to rely on bold shapes and bright colours for
visiblity, as they don\'t have room for an
outline.](/img/8-emblem-outline.png)
:::
:::
