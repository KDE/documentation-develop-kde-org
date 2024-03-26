---
title: Understanding Plasma Styles
weight: 2
description: Essentials of making a Plasma Style
---

[Plasma Framework](docs:plasma-framework) provides the [Plasma::Theme](docs:plasma-framework;Plasma::Theme) class so Plasma elements and other
applications, such as KRunner, can graphically hint or theme
interface elements. This is not a replacement for [QStyle](https://doc.qt.io/qt-6/qstyle.html), but rather
provides standard elements for things such as box backgrounds.

This allows for easy re-theming of the desktop while also keeping elements
on the desktop more consistent with each other.

## Theme Location, Structure and Definition {#structure}

Themes are stored in:

* **System/Default:** `/usr/share/plasma/desktoptheme/`
* **User Installed:** `~/.local/share/plasma/desktoptheme/` ([KDE Store Category](https://store.kde.org/browse/cat/104/order/latest/))

Each theme is stored in its own sub-folder following the name of the theme.

Example: `~/.local/share/plasma/desktoptheme/electrostorm/`

A theme is described by a `metadata.json` file in the top-level directory of
the theme folder (so `electrostorm/metadata.json` in this case). Additional properties are defined in a separate `plasmarc` file.

Beneath this directory you will find the following file structure:

* [dialogs/]({{< ref "theme-elements#dialogs-folder" >}}): images for dialogs.
* [icons/]({{< ref "theme-elements#icons-folder" >}}): optional directory images for icons.
* [widgets/]({{< ref "theme-elements#widgets-folder" >}}): images for widgets.
* [opaque/]({{< ref "theme-elements#opaque-folder" >}}): optional directory containing images appropriate for non-compositing environments.
* [translucent/]({{< ref "theme-elements#translucent-folder" >}}): optional directory containing images appropriate for when
background contrast and blur effect is supported.
* [wallpapers/]({{< ref "theme-details#default-theme-wallpaper" >}}): wallpaper image packages.
* [metadata.json]({{< ref "theme-details#theme-metadata" >}}): theme name, version, and credits.
* [plasmarc]({{< ref "theme-details#theme-metadata" >}}): optional theme properties.
* [colors]({{< ref "theme-details#colors" >}}): optional configuration file defining a color scheme that blends well with images.

All SVG images are optional. If a theme is missing an SVG file, it will fall back to the default Breeze theme.

## Theme Metadata

The contents of the `metadata.json` file might look like this:

`~/.local/share/plasma/desktoptheme/electrostorm/metadata.json`

```json
{
    "KPlugin": {
        "Authors": [
            {
                "Name": "A Plasma Style Designer",
                "Email": "my@mail.address",
            }
        ],
        "Name": "Electrostorm",
        "Description": "Brings a very dynamic electrical energy atmosphere to the desktop",
        "Id": "electrostorm",
        "Version": "0.1",
        "Category": "",
        "EnabledByDefault": true,
        "License": "GPL",
        "Website": ""
    },
    "X-Plasma-API": "5.0"
}
```

The `Id` entry should match the name of the theme folder name.

If you do changes to SVG files in your theme, make sure to update the "Version" so Plasma can properly refresh its cache.

Additional properties like setting a fallback theme can be done by writing in [INI format](https://en.wikipedia.org/wiki/INI_file) inside the `plasmarc` file:

```ini
[Settings]
FallbackTheme=oxygen
```

If your theme is not fully opaque, to improve readability of text or other
elements, there are two options to ask the window manager to apply some effect:

1. Adding some contrast to what is behind windows, panels or tooltips
(this is the Background Contrast effect, **disabled by default**):

```ini
[ContrastEffect]
enabled=true
contrast=0.3
intensity=1.9
saturation=1.9
```

{{< alert title="Tip" color="success" >}}

There is an online tool available to get a general idea of how these values interact with each other: https://niccolo.venerandi.com/backstage/files/ownopacity/main.html

{{< /alert >}}

2. Blurring what is behind windows, panels or tooltips.
This is **enabled by default**. Since Plasma Frameworks 5.57, this can be disabled like so:

```ini
[BlurBehindEffect]
enabled=false
```

{{< alert title="Deprecation Note" color="warning" >}}

Prior to KDE Frameworks 6, themes used a `metadata.desktop` file instead of `metadata.json` + `plasmarc`.

For porting reasons, here is how the old `metadata.desktop` would look like:

<details><summary>metadata.desktop</summary>

```ini
[Desktop Entry]
Name=Electrostorm
Comment=Brings a very dynamic electrical energy atmosphere to the desktop

X-KDE-PluginInfo-Author=A Plasma Style Designer
X-KDE-PluginInfo-Email=my@mail.address
X-KDE-PluginInfo-Name=electrostorm
X-KDE-PluginInfo-Version=0.1
X-KDE-PluginInfo-Website=
X-KDE-PluginInfo-License=GPL
X-Plasma-API=5.0

[Settings]
FallbackTheme=oxygen

[ContrastEffect]
enabled=true
contrast=0.3
intensity=1.9
saturation=1.9

[BlurBehindEffect]
enabled=false
```

</details>

{{< /alert >}}

## Default Theme Wallpaper

Themes may optionally provide wallpaper image packages to be used with the theme.
These wallpaper image packages must appear in the `wallpapers/` directory within the theme.

A theme may also define a default wallpaper image, image size and image file extension
to be used in conjunction with the theme. It will then be automatically used as wallpaper
image, if the current wallpaper type supports the settings (like the "Image" wallpaper type) and the
user has not yet chosen a custom image.

The default wallpaper image may either be
installed in the standard location for wallpaper image packages or may be shipped with the
theme itself. The default wallpaper image settings should appear in the theme's
`plasmarc` file and contain the following entries:

```ini
[Wallpaper]
defaultWallpaperTheme=<name of default wallpaper package>
defaultFileSuffix=<wallpaper file suffix, e.g. .jpg>
defaultWidth=<width in pixels of default wallpaper file>
defaultHeight=<height in pixels of default wallpaper file>
```

##  Colors

The `colors` file follows the standard Plasma color scheme file format and
allows a theme to define what colors work best with its theme elements.
The colors in this file can be edited with the color scheme editor available in System Settings.

* Make a new color scheme using the editor in System Settings -> Appearance -> Colors.
* Save it with a unique name.
* You will see the new color scheme in `~/.local/share/color-schemes/[theme-name].colors`.
* Copy everything to your Plasma Style `colors` file except the **[ColorEffects:Disabled]**
and **[ColorEffects:Inactive]** sections.

The most common use of the `colors` file is to ensure that text is readable on various backgrounds.

Here is a non-comprehensive list of the main color entries in the `colors` file that are currently actively used in a Plasma Style:

* **[Colors:Window]**
  * **ForegroundNormal**: the text color applied to text on the standard background elements; maps to [Theme::TextColor](docs:plasma-framework;Plasma::Theme::TextColor)
  * **BackgroundNormal**: the default background color used for items that paint a background themselves, allowing them to blend in with the theme; maps to [Theme::BackgroundColor](docs:plasma-framework;Plasma::Theme::BackgroundColor)
  * **DecorationHover**: the color used for text highlighting; maps to [Theme::HighlightColor](docs:plasma-framework;Plasma::Theme::HighlightColor)

* **[Colors:Button]**
  * **ForegroundNormal**: the text color to use on push buttons
  * **ForegroundActive**: the color used to tint `BackgroundNormal` for final button hinting color
  * **BackgroundNormal**: the background color used for hinting buttons

* **[Colors:View]**
  * **ForegroundLink**: the text color used for clickable links
  * **ForegroundVisited**: the text color used for visited links
  * **ForegroundNormal**: the text color used most non-title text in applications
  * **ForegroundInactive**: the text color used for secondary text, like placeholders in text fields ("Search…")
  * **DecorationFocus**: the color used for outlines revolving content panes (like Dolphin or Kate), outlines for checkboxes, and the background tint of hovered menu options.
  * **DecorationHover**: the color used in the outline of text fields or checkboxes, or to highlight the background of tabs and menu buttons when hovered.

* **[Colors:Header]**
  * **ForegroundNormal**: the text color used for the titlebar and headerbar
  * **BackgroundNormal**: the background color used for the titlebar and headerbar

* **[ColorsSelection]**
  * **ForegroundNormal**: the text color used in text fields
  * **BackgroundNormal**: the background color used in text fields

* **[Colors:Tooltip]**
  * **ForegroundNormal**: the primary text color used for tooltips from Plasma
  * **ForegroundInactive**: the color used for secondary text in tooltips, such as the "Press Shift for More" text
  * **BackgroundNormal**: the color used for the background of tooltips

Other colors in the file may be used by individual widgets or used in the future, so you are encouraged to provide a complete color scheme file.

The following colors are currently also used by individual plasmoids, which should give a good idea of additional usage patterns:

* **[Colors:View]**
  * **BackgroundNormal**: used as a background color for the digital clock and the dictionary plasmoid search field.
  * **ForegroundNormal**: used by the digital clock for most of its minute indicators and arrows, as well as the text color used in the search field of the dictionary plasmoid.
  * **DecorationFocus**: used to outline the dictionary plasmoid search field.
  * **DecorationHover**: used when hovering the dictionary plasmoid search field.

* **[Colors:Complementary]**
  * Same roles as **Colors:Window**, those are used in areas such as the logout screen, the screen locker, and other areas in order for them to have independent colors compared to normal plasmoids.

Note that some of these may end up folded back into [Plasma::Theme](docs:plasma-framework;Plasma::Theme) properly at some point.

## Image Access from C++

Theme elements can be accessed from C++ code by path. Whether this maps to literal paths on disk
or not is not guaranteed and considered an implementation detail of
[Plasma::Theme](docs:plasma-framework;Plasma::Theme).

For example, to access the dialog background, one might create an SVG in this manner:

```c++
Plasma::Theme theme;
Plasma::Svg svg("dialogs/background");
svg.resize(size());
```

<!-- TODO change to KSvg::Svg -->

By using [Plasma::Svg](docs:plasma-framework;Plasma::Svg), changes to the theme are automatically picked up.
