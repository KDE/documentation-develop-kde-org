---
title: Creating a Plasma Theme Quickstart
weight: 1
description: A quick guide to creating your first Plasma theme
aliases:
  - /docs/plasma/theme/quickstart/
---

A feature of Plasma is the ability to theme desktop elements using Scalable
Vector Graphics (SVGs). This means there is no need for theme authors to know
C++ or any other programming language to create a great looking theme. They
need only use common graphics tools many are already familiar with (e.g. Krita,
Inkscape, The GIMP, etc.). Depending on your prowess with such tools, a great
looking Plasma theme can be created in under an hour.

If you prefer video explanation, an alternative
[video tutorial](https://www.youtube.com/playlist?list=PLX3_anRd8Mp7ibLDlSEJHNzSBaTslFp-x) is also available.

See also [Plasma Theme Details](../theme-details).

## Creating a Plasma Theme in 7 Easy Steps

1. Copy and rename an existing Plasma theme folder. The new folder name should
be the name of the theme. Installed themes are stored in `share/plasma/desktoptheme/`
in either your user's `.local` directory or your Plasma installation directory.
You can also find [Plasma Themes on the KDE Store](https://store.kde.org/browse/cat/104/order/latest/). Edit the `metadata.desktop` file
in the theme folder to match your theme name. See [Theme Details](../theme-details)
if you need help.

```bash
# Create theme directory in home if it doesn't exist
mkdir -p ~/.local/share/plasma/desktoptheme
# Copy default theme to home directory so we can modify it
cp -r /usr/share/plasma/desktoptheme/default ~/.local/share/plasma/desktoptheme/
# Rename theme
cd ~/.local/share/plasma/desktoptheme
mv ./default ./mytheme
# Edit metadata.desktop with new name
cd ./mytheme
kwriteconfig5 --file="$PWD/metadata.desktop" --group="Desktop Entry" --key="X-KDE-PluginInfo-Name" "mytheme"
kwriteconfig5 --file="$PWD/metadata.desktop" --group="Desktop Entry" --key="Name" "My Theme"
# Remove wrong translations (Name[fr]=Breeze)
sed -i '/^Name\[/ d' ./metadata.desktop
sed -i '/^Comment\[/ d' ./metadata.desktop
```

{{< alert color="info" title="Note" >}}
The `default` theme is the base `Breeze` theme with all the default SVGs. `breeze-dark` only has a `colors` file and inherits everything else from the `default` theme.
{{< /alert >}}

2. Open the SVG file associated with the Plasma element you would like to theme
(panel background, clock, etc.) in an SVG editor (e.g. Inkscape). See
[Current Theme Elements](../theme-details#current-theme-elements) if you need
help understand what each SVG file does.

3. Each SVG file may have several elements (e.g. objects with element id = `left`,
`right`, `top`, `topright`, `center`, `ClockFace`, etc.). Modify existing elements OR delete
and create replacement elements. Elements can be any SVG primitive or object group.

{{< alert color="info" title="Hint" >}}
You can embed raster images as SVG elements if you creatively prefer raster editors
like Krita, the GIMP, etc. Remember to embed, instead of link, each image (inkscape:
effects->images->embed all images).
{{< /alert >}}

4. To make renaming of the theme elements easier is possible to use an Inkscape
extension located at this
[address](https://websvn.kde.org/trunk/playground/artwork/Oxygen/notmart/inkscapeextensions/).

5. Check to make sure that the element id for each new element is correctly set.

{{< alert color="info" title="Hint" >}}
In Inkscape you can check the element id for each object by right-clicking on the
object and choosing Object Properties.
{{< /alert >}}

6. Add or remove any hint element you desire. It doesn't matter how these look,
just that objects with the element ids matching the hint elements either exist or
don't exist. See [Backgrounds format](../theme-details#background-svg-format) for a
description of available hint elements.

7. Save the SVG file.

8. Repeat steps 3 - 6 for any other Plasma element for which you would like to
create a new theme.

## Testing the Theme

* If you have not already done so, copy your new theme folder to the
`share/plasma/desktoptheme` directory in either your user's `.local` folder or your
Plasma install folder.

* Choose the theme from the System Settings > Workspace Theme > Plasma Theme dialog
(may require Plasma restart) or edit your `~/.config/plasmarc` to point to the new theme.

* Carefully check the appearance of all new theme elements.

* If you created separate non-composite themes (SVGs in the `opaque/` folder), remember
to test your theme with compositing (Desktop Effects) turned off (with KWin toggle
with `Alt+Shift+F12`).

When you update the theme, you need to battle with Plasma's caching. So to make sure
to run the latest version of your theme code, after updating it first clear the cache,
by calling on a console:

```
rm .cache/plasma* -R
```

Then restart the Plasma Shell by calling e.g. in krunner

```
plasmashell --replace
```

## Theme Colors

* You can provide a Plasma color scheme that will allow text, selected backgrounds and
other items to blend well with your theme by supplying a colors file in your theme folder.
See the colors file in the default theme for an example.

* If the colors file is omitted, Plasma will take on the current Plasma system colors.
Note: Theme SVGs will not be colorized unless they contain the `hint-apply-color-scheme`
element.)

## Hints and Tips

* Even a **pixel or two out of place** can make a difference over hours of use. It may not
be obvious at first glance but the user may intuitively pick up that something is just
'not right' and give up using your theme.

* In Inkscape, turn off **stroke scaling** when objects are resized. Inkscape may default
to scaling the stroke of an object when changing its size. This may show up in the rendered
Plasma theme as thin, barely-there, lines you can't seem to get rid of.

* If you prefer raster editors like Krita and GIMP, create your particular theme in these
programs first, then import them into Inkscape (drag and drop of the files works fine). If
you're working on a background with multiple elements, like `widgets/panel-background.svg` or `widgets/background.svg`, crop the raster image into the different elements (top, bottom, right,
etc.) and save as separate files before importing into Inkscape.

* Don't forget to **embed imported raster images**. By default Inkscape will import these
as linked images which will not show up in Plasma (to embed the images, go to Effects >
Images > Embed All Images).

* Remember that the border elements of backgrounds (`top`, `right`, `bottom`, `left`) are tiled if the
`hint-stretch-borders` element is not present in the SVG.

* Remember that the center element of backgrounds are stretched if the hint-tile center
element is not present in the SVG.

* To control how much colorization will be applied by Plasma when using the
`hint-apply-color-scheme` element, make sure the color (HSV) Value/Intensity is closer to `0`
or `255` for less colorization, and closer to `127` for more colorization. So, for example, to
keep shadows from being colorized, use color (HSV) Value/Intesity of `0`.

* When testing the theme, if it looks like portions of a multi-element SVG is missing
(missing borders, etc.) check the SVG again to **make sure the element ids are correct**.

* Do not use more advanced SVG features since they will not be rendered properly. If you
want to add blur or something similar, consider pre-rendering to PNG, and then import the
PNG into the final SVG file.

* Perform this quick sanity check for background SVGs to help troubleshoot annoying lines
and gaps between elements:

  * `topleft`, `top` and `topright` elements should have the same height
  * `topright`, `right` and `bottomright` elements should have the same width
  * `bottomleft`, `bottom` and `bottomright` elements should have the same height
  * `topleft`, `left` and `bottomleft` elements should have the same width

