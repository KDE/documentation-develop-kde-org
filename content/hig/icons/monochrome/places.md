---
title: Places Icons
weight: 5
aliases:
- /hig/style/icons/monochrome/places
---

Places icons are used to depict folders, network locations, and other
places. They come in four sizes: 16px, 22px, 32px, and 64px. Places
icons use the [monochrome style]({{< relref "monochrome" >}}) for 16px and 22px sizes,
and the [colorful style]({{< relref "colorful" >}}) for 32px and 64px
sizes.

Purpose
-------

Places icons allow a user to quickly identify landmarks in their
filesystems. They indicate places that a user will visit frequently,
such as home, root, downloads, etc.

Design
------

### Iconography

Places icons use bold and recognizable symbols that allow a user to
determine the icon\'s corresponding location at a glance.

{{< compare >}}
{{< do src="/hig/mono-places-do.png" >}}
Use a bold, descriptive, and metaphorically recognizable icon to identify
a user's landmark and guide the user to their desired destination — international
icons are used instead of regional icons to better serve the diverse array of
users that use KDE software.
{{< /do >}}
{{< dont src="/hig/mono-places-dont.png" >}}
Don't use places icons based off of real locations or brands unless the
landmark filesystem location is directly tied to that location or brand — more
generic icons are meaningful for more users in more use cases.
{{< /dont >}}
{{< /compare >}}
