---
title: MIME Type Icons
weight: 4
aliases:
- /hig/style/icons/monochrome/mimetype
---

MIME type icons are used to depict documents and files. They come in
four sizes: 16px, 22px, 32px, and 64px. MIME type icons use the
[monochrome style]({{< relref "monochrome" >}}) for 16px and 22px sizes,
and the [colorful style]({{< relref "colorful" >}}) for 32px and 64px sizes.

Unlike most monochromatic icons, MIME type icons use the primary color
of their colourful counterpart.

Purpose
-------

MIME type icons allow a user to quickly recognize the types of their
files without needing to look at a file\'s extension or contents. They
primarily appear in file listings in large amounts, and their design
reflects a sense of unity among files in a user\'s system.

Design
------

### Iconography

MIME type icons use bold and recognizable symbols that allow a user to
determine the filetype at a glance.

{{< compare >}}
{{< do src="/hig/mono-mime-do.png" >}}
Use a bold and recognizable icon.
{{< /do >}}
{{< dont src="/hig/mono-mime-dont.png" >}}
Don't use an overly generic icon — this makes it hard for users to determine
filetype.
{{< /dont >}}
{{< /compare >}}

MIME types associated with a brand identity use elements of their brand
to make it easier for users to connect the icon to its filetype.

{{< compare >}}
{{< figure src="/hig/mono-mimebrand-rss.png" caption="The usage of the RSS icon allows users to recognize the RSS feed MIME type." >}}
{{< figure src="/hig/mono-mimebrand-deb.png" caption="The usage of the Debian logo allows users to recognize the deb package MIME type." >}}
{{< /compare >}}
