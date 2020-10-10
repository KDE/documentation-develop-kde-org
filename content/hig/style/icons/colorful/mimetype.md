---
title: MIME Type Icons
---
===============

MIME type icons are used to depict documents and files. They come in
four sizes: 16px, 22px, 32px, and 64px. MIME type icons use the
[monochrome style](../monochrome/index.html) for 16px and 22px sizes,
and the [colorful style](index.html) for 32px and 64px sizes.

Purpose
-------

MIME type icons allow a user to quickly recognize the types of their
files without needing to look at a file\'s extension or contents. They
primarily appear in file listings in large amounts, and their design
reflects a sense of unity among files in a user\'s system.

Design
------

### Margins

64px MIME type icons have a top and bottom margin of 3 pixels, and 32px
MIME type icons have a top and bottom margin of 2 pixels.

::: {.container .flex}
::: {.container}
![64px icons should have a top and bottom margin of 3
pixels.](/hig/mime-margin-64.png)
:::

::: {.container}
![32px icons should have a top and bottom margin of 2
pixels.](/hig/mime-margin-32.png)
:::
:::

### Anatomy

Colorful MIME type icons consist of two elements---the monochromatic
counterpart of the colorful MIME type icon overlaid on a background
relating to the icon\'s type.

![](/hig/mime-anatomy.png)

1.  Monochromatic Foreground
2.  Base

::: {.container .flex}
::: {.container}
![The foreground of a MIME type icon indicates the specific type of file
it is.](/hig/mime-monochromatic-layer.png)
:::

::: {.container}
![The background of a MIME type icon indicates the general type of file
it is.](/hig/mime-base-layer.png)
:::
:::

### Base

The base of a MIME type icon serves to give files of a general type a
shared and recognisable silhouette

#### Archives

Archives, packages, compressed files, and disk images use a square with
a zipper going halfway down.

::: {.container .flex}
::: {.container}
![For archive icons without a foreground, the zipper goes through the
center.](/hig/mime-archive.png)
:::

::: {.container}
![For archive icons with a foreground, the zipper is offset to give the
foreground some space.](/hig/mime-archive-symbol.png)
:::
:::

#### Images

Images use a horizontal rectangle with the top right corner folded and
casting a shadow.

![The base for image type icons.](/hig/mime-image.png)

#### Videos

Videos use a horizontal rectangle styled to look like a filmstrip.

![The base for video type icons.](/hig/mime-video.png)

#### Audio

Audio files use a CD sleeve with a partially visible CD sticking out.

![The base for audio type icons.](/hig/mime-audio.png)

#### Books

Book files use a vertical rectangle with a book spine.

![The base for book type icons.](/hig/mime-book.png)

#### Other

Documents and other icons use a rectangle with a fold in the top right
corner casting a shadow.

![The base for document and other type icons.](/hig/mime-document.png)

### Foreground

The foreground of a MIME type icon serves to inform the user about the
specific type of file an icon represents. The foreground should be the
monochromatic icon of the MIME type.

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} The foreground decoration of
a MIME type icon does not cast a shadow.](/hig/mime-fg-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t have the foreground
decoration of a MIME type icon cast a
shadow.](/hig/mime-fg-dont.png){.dont}
:::
:::

### Color

The color of a MIME type icon helps inform the user what kind of icon it
is. Icons for MIME types associated with a brand identity should use the
colors of that brand identity.

::: {.container .flex}
::: {.container}
![`Do.`{.interpreted-text role="noblefir"} The usage of Android brand
colors helps users identify the icon as that of an Android
package.](/hig/mime-color-do.png){.do}
:::

::: {.container}
![`Don't.`{.interpreted-text role="iconred"} Don\'t use radically
different brand colors---users will not recognise the icon as one of a
filetype from that brand.](/hig/mime-color-dont.png){.dont}
:::
:::
