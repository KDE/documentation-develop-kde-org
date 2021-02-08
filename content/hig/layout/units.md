---
title: Units and Measurements
weight: 1
---

Purpose
-------

This pages gives an overview about different units used in Plasma and
applications using KDE frameworks.

Pixel
-----

A physical pixel or dot is a physical point in a raster image. It is the
smallest permissible size for anything displayed by the device.

{{< alert color="warning" title="Caution" >}} 

Be careful not to confuse physical pixels with DPI independent pixels.

{{< /alert >}}

DPI - Pixels per Inch
---------------------

Pixel density is the number of physical pixels or dots that fit into one
square inch on the screen. Different screens have different DPIs. Screen
density = screen width (or height) in pixels / screen width (or height)
in inches.

![Different DPIs on desktop and mobile.](/hig/Pixel.qml.png)

DPI is often used interchangeably with PPI, pixels per inch.

{{< alert title="Hint" color="info" >}}

Don't confuse this with the DPI setting in Photoshop, Krita, etc. For
mockups you can just ignore this setting.

{{< /alert >}}

PPI / DPI Independent Pixels
----------------------------

A DPI independet pixel is scaled to look uniform on any screen
regardless of its DPI. A lot of platforms, eg iOS, Android, the web,
replaced the old physical px with a DPI px. So most of the time you read
about pixel/px they're most likely talking about DPI independent
pixels. Qt (and QML) support DPI independent pixels in newer versions,
but because KDE and software supports older versions of Qt as well, one
can not assume that pixels used in Qt or QML apps are DPI independent.

![Different DPIs on desktop and mobile](/hig/DPI.qml.png)

A rectangle defined with {{< dont >}}physical pixels{{< /dont >}} and {{< do >}}
DPI independent pixels{{< /do >}}.

{{< alert title="Hint" color="info" >}}

Unless explicitly stated otherwise, all HIG pages, draft, mockups, etc.
use DPI independent pixels/px.

{{< /alert >}}

### DPI Independent Pixels in KDE

As a developer, if you want to use DPI independent pixels in Plasma use
`units.devicePixelRatio` or `Units.devicePixelRatio` in Kirigami.

{{< alert color="warning" title="Caution" >}} 

The use of devicePixelRatio should be avoided, but if you must, check
the [documentation](http://doc.qt.io/qt-5/highdpi.html) and ask for more
information in [Plasma](https://telegram.me/vdgmainroom) or
[Kirigami](https://telegram.me/joinchat/BbOuVj6l7b5aZ_WbupyFFw) channel.

{{< /alert >}}

### Fonts

Since Plasma allows the user to change the font settings, any objects
with dimensions defined with px (DPI independent or not) can have issues
with text.

![Using DPI independet pixels with
different font settings](/hig/Font.qml.png)

Base Units in Plasma and Kirigami
---------------------------------

There are two types of DPI independent base units in Kirigami:

-   `Units.gridUnit` is the height needed to display one line of text.
    Use this for defining height and width of an element.
-   `Units.smallSpacing` and `Units.largeSpacing` are used to define
    paddings and margins.

These base units are not only DPI independent, but scale according to
the font settings too. While designing, be careful not to rely on the
ratio between `Units.gridUnit` and
`Units.smallSpacing`/`Units.largeSpacing` because these change depending
on the user's font settings.

![A rectangle defined with `Units.gridUnit`.](/hig/Units.qml.png)

{{< alert color="warning" title="Attention" >}}
These px values are only for design and mockup purposes. Don't use them
for development.
{{< /alert >}}

These are the base units in Kirigami:

Units                 | Value
----------------------|--------
`Units.smallSpacing`  | 4px
`Units.largeSpacing`  | 8px
`Units.gridUnit`      | 18px

And in Plasma:

Units                 | Value
----------------------|--------
`units.smallSpacing`  | 4px
`units.largeSpacing`  | 18px
`units.gridUnit`      | 18px

Icon sizes in Plasma and Kirigami
---------------------------------

There are several predefined icon sizes in Plasma and Kirigami. You
should always use these icon sizes.

{{< alert color="warning" title="Attention" >}}
These px values are only for design and mockup purposes. Don't use them
for development.
{{< /alert >}}

Kirigami:

Units                          | Value
-------------------------------|--------
`Units.iconSizes.small`        | 16px
`Units.iconSizes.smallMedium`  | 22px
`Units.iconSizes.medium`       | 32px
`Units.iconSizes.large`        | 48px
`Units.iconSizes.huge`         | 64px
`Units.iconSizes.enormous`     | 128px

Plasma:

Units                          | Value
-------------------------------|--------
`units.iconSizes.tiny`         | 8px
`units.iconSizes.small`        | 16px
`units.iconSizes.smallMedium`  | 22px
`units.iconSizes.medium`       | 32px
`units.iconSizes.large`        | 48px
`units.iconSizes.huge`         | 64px
`units.iconSizes.enormous`     | 128px

From Design to Code
-------------------

For any mockup, help the developers by specifying all measurements,
either in the mockup itself or in an extra guide to the mockup. It is a
lot of work and it is error prone for developers trying to measure
everything from a mockup. Even if the mockup is in a file format that
would allow exact measurements, don't expect the developer to know how
to measure it.

{{< compare >}}
{{< dont src="/hig/Design.qml.png" >}}
Don't create mockups without measurements.
{{< /dont >}}
{{< do src="/hig/Design_Good.qml.png" >}}
Create mockups with detailed measurements.
{{< /do >}}
{{< /compare >}}

You don't have to provide measurement for objects that can be easily
calculated. For example the size of the dark rectangle in the above
example can be easily obtained.

### Recomended Spacings

When you design, try to use the recomended values for margin and
paddings, to ensure a uniform appearance. See
[Metrics and Placement](../metrics) for more details.

![Use of base units](/hig/Margin.qml.png)

```qml
Row {
    spacing: Units.largeSpacing
    Rectangle {
        ...
    }
    Rectangle {
        ...
    }
}
```

```qml
Row {
    spacing: 2 * Units.smallSpacing
    Rectangle {
        ...
    }
    Rectangle {
        ...
    }
}
```

### Ratio

Sometimes the ratio between dimensions is more important then the
actually values.

![](/hig/Ratio.qml.png)

```qml
Grid {
    columns: 3
    ...
    Repeater {
        model: 9
        ...
        Rectangle {
            width: grid.width / 3
            height: grid.height / 3
            ...
        }
    }
}
```
