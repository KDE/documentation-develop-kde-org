Places Icons
============

Places icons are used to depict folders, network locations, and other
places. They come in four sizes: 16px, 22px, 32px, and 64px. Places
icons use the [monochrome style](index.html#monochrome-icon-style) for
16px and 22px sizes, and the [colorful
style](index.html#colorful-icon-style) for 32px and 64px sizes.

Purpose
-------

Places icons allow a user to quickly identify landmarks in their
filesystems. They indicate places that a user will visit frequently,
such as home, root, downloads, etc.

Design
------

### Anatomy

Colorful places icons consist of two elements---the monochromatic
counterpart of the colorful places icon overlaid on a folder background.

![](/img/place-anatomy.png)

1.  Folder
2.  Monochromatic Foreground

::: {.container .flex}
::: {.container}
![The base of a places icon indicates that it\'s a folder that can be
navigated to.](/img/place-anatomy-base.png)
:::

::: {.container}
![The foreground of a places icon indicates the folder\'s landmark
location.](/img/place-anatomy-fg.png)
:::
:::

### Base

The base of a places icon is always a blue folder.

![](/img/place-blank.png)

### Foreground

The foreground of a places icon indicates the landmark location an icon
represents. Its color is a darker variant of the base\'s color. For 32px
icons, its size is 10×10px. For 64px icons, its size is 20×20px. It is
always centered within the folder, and does not cast a shadow.

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} The foreground of a places
icon does not cast a shadow.](/img/place-fg-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t have the foreground
of a places icon cast a shadow.](/img/place-fg-dont.png){.dont}
:::
:::

### Margins

64px places icons have a top and bottom margin of 6 pixels, and 32px
places icons have a top and bottom margin of 3 pixels.

::: {.container .flex}
::: {.container}
![64px icons should have a top and bottom margin of 6
pixels.](/img/place-margin-64.png)
:::

::: {.container}
![32px icons should have a top and bottom margin of 3
pixels.](/img/place-margin-32.png)
:::
:::
