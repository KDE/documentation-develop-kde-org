---
title: SVG elements and Inkscape
weight: 3
description: Understanding how to manipulate Plasma Style SVG files
---

Every Plasma Style that provides its own background or icons uses Scalable Vector Graphics (SVG) files (ending in `.svg`) or compressed SVG files (ending in `.svgz`). While any vector graphics software can be used to manipulate SVG files, we will be using [Inkscape](https://inkscape.org/) here.

SVG files are, in fact, XML files. For example, a blue rectangle would be written in plain XML like so:

```xml
<svg width="300" height="200">
  <rect id="myrectangle" inkscape:label="#myrectangle" width="200" height="100" style="fill:rgb(0,0,255);stroke-width:3;stroke:rgb(0,0,0)" />
</svg>
```

Which when opened in Inkscape looks like this:

{{< figure src="rect.webp" >}}

You can easily edit the contents of SVG files by opening them with a plain text editor or an XML editor as well. This will be needed to apply custom colors later on, like accent colors.

The `<svg>` tag contains the contents of the file, while `<rect>` represents the rectangle and is called an _element_ or an _object_. Every element may contain _attributes_, and the ones that matter most to Plasma Style designers will be `id`, `label`, and `style`.

{{< alert title="Tip - SVG Formatting" color="success" >}}

<details>
<summary>Click to toggle tip</summary>

XML files, and by extension SVG files, do not care about spaces or newlines between elements or attributes. The above example could also be written as:

```xml
<svg width="400" height="110">
  <rect
    id="myrectangle"
    inkscape:label="#myrectangle"
    width="200"
    height="100"
    style="fill:rgb(0,0,255);stroke-width:3;stroke:rgb(0,0,0)"
  />
</svg>
```

Which can be a useful technique whenever you end up needing to edit large SVG files directly whose attributes are hard to find.

</details>

{{< /alert >}}

In the above image, the blue rectangle attributes can be seen by clicking on it while having the "Object Properties" pane open. You can open the "Object Properties" pane by pressing `Ctrl+Shift+O`, going to the menu `Object -> Object Properties...`, or by right clicking the element you'd like to inspect and cliking on "Object Properties".

Once you have more than one element in the same SVG file, you will want to have the "Layers and Objects" pane open as well for easy navigation and for ensuring the element IDs are correct later on.

Plasma effectively does not care about the placement of elements in an SVG. You may place them anywhere in the _page_ (the space inside the rectangle with a white outline in the figure) or outside the page. Plasma simply checks whether an element _exists_ in a _file with a certain filename_ and has the _right attributes_, including its _size in pixels_. If the element does not match the attributes that Plasma searches for, it will simply be ignored. This means that you may create additional SVG elements, for instance with the Text tool in Inkscape, to write some helpful notes in the SVG file.

Despite Plasma not caring about element placement, it is a good idea to place elements neatly next to each other where it makes sense to make the life of the designer (and any future contributor) easier. For example:

{{< figure src="elements.webp" >}}

## Position and meaning of element IDs in Plasma SVG files {#element-id-positions}

As mentioned above, Plasma does not care about the position of the elements in an SVG file, only whether they exist and have the right attributes. The most important attributes when creating or editing a Plasma theme are the element's ID and label.

An element ID can have multiple parts to it, separated by a hifen (-). Each part may be a prefix, a suffix, or an affix (in the middle). Although most IDs have only one to four parts, there can be at most six parts to an ID.

For example:

1. `bottomleft`
2. `shadow-bottomleft`
3. `mask-bottomleft`
4. `hint-bottom-margin`
5. `shadow-hint-bottom-margin`
6. `hint-hands-shadow-offset-to-south`
7. `hint-hands-shadow-offset-to-west`
8. `toolbutton-pressed-hint-left-margin`

Each part can have some sort of semantics attributed to it that makes it easy to remember.

For example, if you inspect the file `widgets/background.svg`, you will see that the main element IDs use `top`, `bottom`, `left`, `right`, together with `center` and their respective diagonal versions `topright`, `topleft`, `bottomright` and `bottomleft`, as can be seen in (1). In the same file, you should see a second and a third set of elements that have the `shadow-` prefix and the `mask-` prefix, respectively, like (2) and (3).

You should also see an element with the same length as the four directions of the set of elements (`top`, `bottom`, `left`, `right`), that serves as a hint for element margin sizes, like in (4), `hint-bottom-margin`. You can also apply the `shadow-` and `mask-` prefixes here, like in (5), `shadow-hint-bottom-margin`.

You may also see unique IDs where you need all parts together with only small differences, like (6) and (7), `hint-hands-shadow-offset-to-south` and `hint-hands-shadow-offset-to-west`, used in `widgets/clock.svg`.

This semantics is useful for contrasting different characteristics of the same part of Plasma being themed, like in (8), `toolbutton-pressed-hint-left-margin`, where you first have `toolbutton-` in opposition to the default kind of button (which would be simply `pressed-hint-left-margin`); `-pressed-`, as opposed to `-normal-`, `-hover-`, and so on, namely the button state; and `-hint-left-margin`, as opposed to `-hint-right-margin`, `-hint-top-margin` and `-hint-bottom-margin`.

The full list of valid element IDs for each SVG searched by Plasma can be seen in the [Theme Elements Reference]({{< ref "theme-details.md" >}}).

When setting an element ID in Inkscape, you will also need to set its label, which is effectively just the element ID preceded by a number sign (#, also called a hash). In other words, if you have an ID `center`, its label should be `#center`.

## Configuring Inkscape to edit Plasma SVG files

### Document Properties and Snapping

In order for sizes to be detected correctly for Plasma Style SVGs, we need to use pixels for each [user unit](https://wiki.inkscape.org/wiki/Units_In_Inkscape) with an SVG scale factor of 1. This can done in `File -> Document Properties`, in the "Display" tab.

{{< figure src="document-properties-display.webp" class="text-center" >}}

To make editing the SVG files easier, we will need to use a grid and make it so our cursor will snap to the grid. To do so, first go to the Grids tab in Document Properties, select "Rectangular Grid", then click on "New".

{{< figure src="document-properties-grids.webp" class="text-center" >}}

Then, toggle snapping on by going to the small Snap Controls Bar on the top right of Inkscape and clicking on the magnet button. If you do not see this bar, make sure it is enabled under `View -> Show/Hide -> Snap Controls Bar`.

{{< figure src="snap-controls.webp" class="text-center" >}}

### Inkscape Extensions

Defining element IDs can be somewhat tedious. There is an Inkscape extension in [KSvg](https://invent.kde.org/frameworks/ksvg) that can be used to edit SVG files for Plasma SVGs, more specifically those containing positions (`top`, `left`, `topleft`, `center` etc.) or hints (`hint-left-margin`, etc.).

The extension is contextual, that is, if you select 9 elements, it will default to the positions, and if you select 4 elements, it will default to the hints.

* download the two files at https://invent.kde.org/frameworks/ksvg/-/tree/master/src/tools/inkscape%20extensions
* copy them to `~/.config/inkscape/extensions`
* restart Inkscape
* select the 9 elements of a frame (or the 4 elements of a hint)
* go to `Extension -> Plasma`
* put the optional prefix in the dialog

If you have an initial frame of 9 elements with `top`, `bottom`, `topleft` etc. and duplicate the whole frame, you may select all 9 elements and use the extension to, for example, add the `shadow` prefix to them, obtaining `shadow-top`, `shadow-bottom`, `shadow-topleft`, most notably in `dialogs/background.svg` and `widgets/background.svg`. Likewise, if you select all 4 hints `hint-top-margin`, `hint-bottom-margin`, hint-left-margin and `hint-right-margin`, you may add the `pressed` prefix to them, or even something like `toolbutton-pressed`, obtaining, for example, `pressed-hint-right-margin` or `toolbutton-pressed-hint-right-margin`.


### Disable Stroke Scaling

The stroke is the line used for the contour of an element. As SVG elements can be scaled, so can the stroke surrounding them.

As mentioned in the [Hints and Tips]({{< ref "quickstart.md#hints-and-tips" >}}) section of the Plasma Style Quickstart, Stroke Scaling may cause thin, barely visible lines to appear in your Plasma Style, disrupting the harmony of your theme.

To avoid this from happening whenever you need to resize an SVG element with the Inkscape Selection tool, you should disable Stroke Scaling. This can be done by clicking the left button of the Tool Controls Bar at the top right of the Inkscape window. If you do not see this bar, make sure it is enabled under `View -> Show/Hide -> Tool Controls Bar`.

{{< figure src="stroke-button.webp" class="text-center" >}}
