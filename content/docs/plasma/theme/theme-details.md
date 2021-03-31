---
title: Theme details
weight: 2
description: Details about the internal of Plasma theme
---

libKF5Plasma provides the Theme class so Plasma elements and other
applications, such as KRunner, that need to graphically hint or theme
interface elements. This is not a replacement for QStyle, but rather
provides standard elements for things such as box backgrounds.

This allows for easy re-theming of the desktop while also keeping elements
on the desktop more consistent with each other.

See also [Creating a Plasma Theme](../quickstart).

## Theme Location, Structure and Definition

Themes are stored in:

* **System/Default:** `/usr/share/plasma/desktoptheme/`
* **User Installed:** `~/.local/share/plasma/desktoptheme/` ([KDE Store Category](https://store.kde.org/browse/cat/104/order/latest/))

Each theme is stored in an own sub-folder by the name of the theme.  
Eg: `~/.local/share/plasma/desktoptheme/electrostorm/`

A theme is described by a `metadata.desktop` file in the top-level directory of
such a subfolder.

Beneath this directory one will find the following file structure:

* **`dialogs/`**: images for dialogs.
* **`icons/`**: optional directory images for icons.
* **`widgets/`:** images for widgets.
* **`opaque/`:** optional directory containing images appropriate for non-compositing environments.
* **`translucent/`:** optional directory containing images appropriate for when
background contrast and blur effect is supported.
* **`wallpapers/`:** wallpaper image packages.
* **`colors`**: optional a configuration file defining a color scheme that blends
* **`metadata.desktop`**: theme name, version, and properties

All `.svg` images are optional. If a theme is missing an svg file, it will fallback to the default Breeze theme.

## Theme Metadata

The contents of the `metadata.desktop` file might look like this:

```ini
[Desktop Entry]
Name=Electrostorm
Comment=Brings a very dynamic electrical energy atmosphere to the desktop

X-KDE-PluginInfo-Author=A Plasma Theme Designer
X-KDE-PluginInfo-Email=my@mail.address
X-KDE-PluginInfo-Name=electrostorm
X-KDE-PluginInfo-Version=0.1
X-KDE-PluginInfo-Website=
X-KDE-PluginInfo-License=GPL
X-Plasma-API=5.0
```

The `X-KDE-PluginInfo-Name` entry should match the name of the sub-folder
in `share/plasma/desktoptheme` where the SVG files for this theme exist.

Eg: `~/.local/share/plasma/desktoptheme/electrostorm/metadata.desktop`

If the theme should inherit from another theme than the "default" one, this
can be defined by a section like this (where the folder name resp. the
`X-KDE-PluginInfo-Name` would be passed as value):

```ini
[Settings]
FallbackTheme=oxygen
```

If you do changes to SVG files in your theme, make sure to **update the version
number in `X-KDE-PluginInfo-Version`** so Plasma can properly refresh its cache.

If your theme is not fully opaque, to improve readability of text or other
elements, there are two options to ask the window manager to apply some effect
for (KWin supports those):

a. One is adding some contrast to what is behind windows, panels or tooltips
(disabled by default), which is done by a section like this:

```ini
[ContrastEffect]
enabled=true
contrast=0.3
intensity=1.9
saturation=1.9
```

b. The other option is blurring what is behind windows, panels or tool tips.
This is enabled by default. Since Plasma Frameworks 5.57, this can be disabled
by a section like this (ignored otherwise):

```ini
[BlurBehindEffect]
enabled=false
```

## Image Access

Theme elements are accessed by path. Whether this maps to literal paths on disk
or not is not guaranteed and considered an implementation detail of
[`Plasma::Theme`](docs:plasma;Plasma::Theme).

Therefore, to access the dialog background, one might create an SVG in this
manner:

```c++
Plasma::Theme theme;
QSvgRenderer svg(theme.image("dialogs/background"));
```

It is **generally recommended** to use [`Plasma::Svg`](docs:plasma;Plasma::Svg) instead
of `QSvgRenderer` directly, however. This is because `Plasma::Svg` uses caching where it
can. Remember to call `resize()` on the `Plasma::Svg` before painting with it!

```cpp
Plasma::Svg svg("dialogs/background");
svg.resize(size());
```

## Wallpaper Access

Themes may optionally provide wallpaper image packages to be used with the theme.
These wallpaper image packages must appear in the `wallpapers/` directory within the theme.

A theme may also define a default wallpaper image, image size and image file extension
to be used in conjunction with the theme. It will then be automatically used as wallpaper
image, if the current wallpaper type supports the settings (like the "Image") and the
user has not yet chosen a custom image. The default wallpaper image may either be
installed in the standard location for wallpaper image packages or may be shipped with the
theme itself. The default wallpaper image settings should appear in the theme's
`metadata.desktop` file and contain the following entries:

```ini
[Wallpaper]
defaultWallpaperTheme=<name of default wallpaper package>
defaultFileSuffix=<wallpaper file suffix, e.g. .jpg>
defaultWidth=<width in pixels of default wallpaper file>
defaultHeight=<height in pixels of default wallpaper file>
```

##  Reaction to Theme Changes

If you use `Plasma::Svg`, changes to the theme are automatically picked up.
Otherwise, you can connect to the `changed()` signal in the
`Plasma::Theme` class. This signal is emitted whenever the theme is changed,
which may be triggered by the user switching the theme used or system changes
such as a composite manager becoming available.

##  Colors

The colors file follows the standard Plasma colorscheme file format and
allows a theme to define what colors work best with its theme elements.
The colors in this file can be edited with the default color scheme module.

* Make a new colorscheme using the editor in System Settings > Appearance > Colors.
* Save it with a unique name.
* Open the colorscheme in a text editor, like Kate.
  * Saved at `/home/[user]/.local/share/color-schemes/[unique name].colors`
* Copy everything to your Plasma theme colors file except the **[ColorEffects:Disabled]**
and **[ColorEffects:Inactive]** sections.


The most common use of the colors file is to ensure that text is readable on various backgrounds.

Here is a list of color entries in the colors file that are currently actively used in a Plasma theme:

* **[Colors:Window]**
  * **ForegroundNormal** the text color applied to text on the standard background elements; maps to `Theme::TextColor`
  * **DecorationHover** the color used for text highlighting; maps to `Theme::HighlightColor`
  * **BackgroundNormal** the default background color, for items that paint a background themselves, allowing them to blend in with the theme; maps to `Theme::BackgroundColor`
* **[Colors:Button]**
  * **ForegroundNormal** the text color to use on push buttons; maps to `Theme::ButtonTextColor`
  * **BackgroundNormal** used for hinting buttons; maps to `Theme::ButtonBackgroundColor`
  * **ForegroundActive** color used to tint `BackgroundNormal` for final button hinting color
* **[Colors:View]**
  * **ForegroundLink** clickable text link font color
  * **ForegroundVisited** visited clickable text link font color

Other colors in the file may be used by individual widgets or used in the future, so it doesn't hurt to provide a complete colorscheme file and is probably a safer strategy.

Currently also used by individual widgets, which should give a good idea of additional usage patterns:

* **[Colors:View]**
  * **ForegroundActive** used by the digital and fuzzy clocks for the default text color, dictionary widget for results text, microblog for status update text
  * **ForegroundInactive** used by the pager to draw non-active windows and frames, microblog for user names
  * **ForegroundNormal** used by microblog for status update entry area background

* **[Colors:Complementary]**
Same roles as Colors:Window, those are used in areas such as the logout screen, the screen locker etc, in order for them to have independent colors compared to normal plasmoids.

Note that some of these may end up folded back into `Plasma::Theme` properly at some point.

##  Backgrounds format

All background SVG's (except for wallpaper images) must have the following named elements, all of which will be painted at the *native* size (and can therefore be bitmaps), except for the center which will be scaled:

* **topleft**: the top left corner
* **topright**: the top right corner
* **bottomleft**: the bottom left corner
* **bottomright**: the bottom right corner
* **top**: the top bar between the two top corners
* **left**: the left bar between the two left corners
* **right**: the right bar between the two right corners
* **bottom**: the bottom bar between the two bottom corners
* **center**: the center fill; will be scaled so should be an actual SVG element

Some Plasma components may use the above named elements with prefixes.  For example the panel placed on the left side of the screen uses the "west" prefix (**west-topleft**, **west-topright**, etc.).

Additionally, the following elements can be used to control the rendering of the backgrounds:

* **hint-stretch-borders**: if it exists, the borders will not be tiled but rather will be stretched to fit
* **hint-tile-center**: if it exists, the center will not be scaled but rather will be tiled to fit. (Optional, from 4.1 and later)
* **hint-no-border-padding**:  If this element exists, padding will not be added for the borders, and content will therefore be able to use the entire area (inclusive borders).
* **hint-apply-color-scheme**:  If this element exists, the SVG will be colorized using the color scheme colors.  Colorization is applied at 100%, and tapers off on either side, of an HSV color value/intensity of 127.
* **current-color-scheme**: If a style element with this id exists it is replaced by a css-style with colors of the current colorscheme. See below for details.
* **[prefix]-hint-[direction]-margin**: Use this optional hints if you want different margins than the borders size. The [prefix]- part is optional and identifies the prefix of the panel you want to specify the margins. [direction] can be either top, bottom, left or right and indicates the border you want to configure. For top and bottom margins the height of these hints are used, for left and right margins the width.
* **[prefix]-hint-compose-over-border**: if this element is resent, the center element will be drawn with the same size as the total image, composed under the borders and shaped with the alpha mask frame, that has to be present in order to make work this hint(Optional).

Next there can be optionally another element called **overlay** (or **[prefix]-overlay** if to be appled to a frame with a different prefix) it will be rendered over the frame as a filigrane effects, with the rules given from the following mutually exclusive hints:
* **hint-overlay-random-pos** it will be put at a random position, this works just for applet backgrounds
* **hint-overlay-tile** tile the overlay
* **hint-overlay-stretch** the overlay will be stretched
* **hint-overlay-pos-right** align the overlay at right of the background rather than to the left
* **hint-overlay-pos-bottom** align the overlay at bottom of the background rather than to the top

### Inkscape extension
An Inkscape extension exists to automatically rename SVG elements with the above naming spec.
* download the two files at https://websvn.kde.org/trunk/playground/artwork/Oxygen/notmart/inkscapeextensions/
* copy them to `$HOME/.config/inkscape/extensions`
* restart inkscape
* select the 9 items of a frame (or the 4 items of an hint) and go to Extension->Plasma menu entry.
* put the optional prefix in the dialog

###  Using system colors

It is possible to apply colors from the color scheme to a graphic. A very easy way to reach this is by adding an element with the id **hint-apply-color-scheme** to the SVG, In this case the rendered graphic gets converted to monochrome and colorized by the window background color.

![Editing xml directly](EditingSvgIcon.png)

A more flexible solution is available by using CSS-styling. For this to work the SVG must have a style-element with the id **current-color-scheme**. Before the graphic is rendered this element gets replaced by a style containing classes where the color attribute is set to the corresponding system color. Currently the following classes are defined:
* ColorScheme-Text
* ColorScheme-Background
* ColorScheme-Highlight
* ColorScheme-ViewText
* ColorScheme-ViewBackground
* ColorScheme-ViewHover
* ColorScheme-ViewFocus
* ColorScheme-ButtonText
* ColorScheme-ButtonBackground
* ColorScheme-ButtonHover
* ColorScheme-ButtonFocus

In order to apply a color from a class to an element, its fill or stroke attribute must be **currentColor** and of course the name of the wanted class has to be in the class-attribute. Special attention is needed on gradients, as neither the gradient-tags themselves nor the stop-tags accept classes. To still get the wanted result one can put a g-tag around them and apply the class to this.

In the Plasma-framework source repository, two useful tools are present:
* `currentColorFix.sh`: fixes an error in the file format that inkscape often does that would break the coorect application of the stylesheet
* `apply-stylesheet.sh`: looks in the SVG file for certain colors (by default from the Breeze palette) and replaces them with the corresponfing stylesheet class, automating a potential long and tedious job

##  Current Theme Elements

Themes get installed to:

* **System/Default:** `/usr/share/plasma/desktoptheme/`
* **User Installed:** `~/.local/share/plasma/desktoptheme/` ([KDE Store Category](https://store.kde.org/browse/cat/104/order/latest/))

Each theme is stored in an own sub-folder by the name of the theme.  
Eg: `~/.local/share/plasma/desktoptheme/electrostorm/`

Each theme contains following file structure. All files can be in either `.svg` or `.svgz` format.

* **/dialogs**: elements for dialogs
  * **/background.svg**: generic dialog background used by the screensaver password dialog, etc. See the section on backgrounds above for information on the required elements in this file.
    * `hint-left-shadow`: optional hints that say how big the shadow is
    * `hint-top-shadow`
    * `hint-right-shadow`
    * `hint-bottom-shadow`
* **/widgets**: generic desktop widget background
  * **/action-overlays.svg**: overlays for icons to indicate actions
    * `add-normal`: icon used to add the parent icon to a selection of elements (used for instance in folderview), normal state, there are also `add-hover` and `add-pressed`
    * `remove-normal`: icon used to remove the parent icon to a selection of elements, normal state, there are also `remove-hover` and `remove-pressed`
    * `open-normal`: icon used to initialize tooltip on folderview widget, there are also `open-hover` and `open-pressed`
  * **/analog_meter.svg**: an analog gauge widget.
    * `background`: the body of the analog instrument
    * `foreground`: the pin where the hand rotates
    * `pointer`: the hand of the instrument
    * `rotateminmax`: how much the hand can rotate, the width is the maximum angle in degrees the height the minimum angle
    * `label0`: the rect for the first label
    * `label1`: the rect for the second label
  * **/arrows.svg**: arrows that match the theme. Four elements should exist in this SVG: up-arrow, down-arrow, left-arrow, right-arrow.
  * **/background.svg**: a background image for plasmoids. See the section on backgrounds above for information on the required elements in this file.
    * `hint-left-shadow`: optional hints that say how big the shadow is
    * `hint-top-shadow`
    * `hint-right-shadow`
    * `hint-bottom-shadow`
  * **/bar_meter_horizontal.svg**: an horizontal meter like a progressbar
    * `background`: background of the progressbar
    * `foreground`: overlay in the foreground of the progressbar
    * `bar`: the progressbar itself
    * `background`: a 9 pieces SVG with the `background` prefix, it replaces the background element if available
     <!--****hint-stretched-bar*: make the progressbar background element stretched rather than tiled-->
    * `bar-active` and `bar-inactive`: 9 pieces SVGs with the `bar-active` and `bar-inactive` prefixes, they replace the bar element when available, they will be drawn tiled
    * `label0`, `label1` and `label2`: rects for 3 labels to be placed around
    * `hint-bar-size`: default height of the bar, if not present the default is taken from sum of heights of `bar-inactive-top` & `bar-inactive-bottom`
  * **/bar_meter_vertical.svg**: a vertical meter like a vertical progressbar. It has the same format of **/bar_meter_horizontal.svg**.
  * **/branding.svg**: a little Plasma logo that can be customized by distributors as a branding element. Contains a single element called `brilliant`
  * **/busywidget.svg**: Used to indicate a busy state, it's a circular image that will be animated with a rotation.
    * `busywidget`: the main spinner
    * `paused`: the paused state
  * **/button.svg**: graphics elements for a button widget, it needs the following prefixes:
    * `normal` normal button
    * `pressed` pressed button
    * `active` button under mouse. Active can have ticker borders that would be rendered outside the widget. It's useful to do a glowing effect **DEPRECATED:** use `hover` instead
    * `hover` element that will be in the background of the widget, will act as a border (useful for glow effects)
    * `shadow` a shadow for the button, can be bigger than the button itself
    * `focus` keyboard focus rectangle superimposed to the button graphics
  * **/calendar.svg**: graphics for a calendar widget
    * `weeksColumn`: background for the vertical column with week numbers in it.
    * `weekDayHeader`: background for the row with week day names in it.
    * `active`: background for the day numbers of the current month.
    * `inactive`: background for the day numbers of the next and previous months.
    * `hoverHighlight`: background for the day under the mouse cursor.
    * `today`: border for the current day cell.
    * `selected`: border for the selected day cell.
    * `red`: border for holidays on sundays
    * `green`: border for holidays during week days
  * **/clock.svg**: an analog clock face. it must have the following named elements:
    * `ClockFace`: the background of the clock, usually containing the numbers, etc
    * `HourHand`: the hour hand, pointing down in the SVG
    * `MinuteHand`: the minute hand, pointing down in the SVG
    * `SecondHand`: the second hand, pointing down in the SVG
    * `HourHandShadow`, `MinuteHandShadow` and `SecondHandShadow`: drop shadows for the hands (optional)
    * `HandCenterScrew`: the "pin" that holds the hands together in the center
    * `Glass`: a final overlay which allows for things such as the appearance of glass
    * `hint-square-clock`: if present the shape of the clock will be square rather than round
    * `hint-[hand(shadow)]-rotation-center-offset`: the point of a hand (shadow) where it is "pinned" to the clock center, defined by the center of the hint, relative to the element position (can be outside the element), with `[hand(shadow)]` being `hourhand`, `hourhandshadow`, `minutehand`, `minutehandshadow`, `secondhand`, `secondhandshadow`, default is "(width/2, width/2)" from top-left of the hand (shadow) element  (since Plasma 5.16)
    * `hint-hands-shadow-offset-to-west` or `hint-hands-shadows-offset-to-east`: horizontal offset of the hands shadows, default is 0 offset (since Plasma 5.16)
    * `hint-hands-shadow-offset-to-north` or `hint-hands-shadow-offset-to-south`: vertical offset of the hands shadows, default is 0 offset (since Plasma 5.16)
    * Note: In the SVG, the Hand elements as well as their optional Shadow counterparts must be oriented in a direction as the one indicating the time 6:30:30. The relative position of the Hand elements as well as their optional Shadow counterparts with respect to the center of ClockFace does not matter.
  * **/configuration-icons.svg**: it's a set of simple icons that are meant to be shortcuts for configuration actions. Must contain the following elements:
    * `close`: a close icon
    * `configure`: a setup action
    * `move`
    * `resize-vertical`: resize in the y axis
    * `resize-horizontal`: resize in the x axis
    * `size-diagonal-tl2br`: resize diagonal, usually an arrow from top-left to bottom-right
    * `size-diagonal-tr2bl`: resize diagonal, usually an arrow from top-right to bottom-left
    * `rotate`
    * `help`
    * `maximize`
    * `unmaximize`
    * `collapse`: set something in a minimized, collapsed status
    * `restore`: restore from *collapse* status
    * `status`: refers to a status of something, logging or system monitoring in general
    * `retourn-to-source`: make detached extender items return to their owner applet
    * `add` and `remove`: specular actions, adding and removing for instance an item from a list
    * `delete`: the (potentially dangerous) action of deleting something
  * **/containment-controls.svg**: handles for the control used to resize the panel.   The following elements are required.
    * `maxslider` maximum size slider, south position
    * `minslider` minimum size slider, south position
    * `offsetslider` positioning slider, south position
    * Each of the above elements must be present with `north`, `south`, `east` and `west` prefixes for each panel position.
    * There are also four backgrounds (north, south, east and west orientations) for the ruler widget itself in the "Backgrounds format", since the width of the widget is 100% the elements of left and right (or north and bottom if vertical) are not needed
  * **/dragger.svg**: meant to be a generic drag handle (not currently used but available). It needs to contain the same elements as other backgrounds, see the section about backgrounds above. In addition it needs the following element:
    * `hint-preferred-icon-size`: the size icons within the drag handle should get. The vertical size of the dragger is also derived from this: this size hint + the dragger's margins.
  * **/frame.svg** : a generic frame, used mostly for widget containers, to visually group widgets together. It must contain the following prefixes, for different 3d looks:
    * `sunken`
    * `plain`
    * `raised`
  * **/glowbar.svg** : a frame without a prefix, it represents a glow, it's used for instance in Plasma Desktop for the panel autohide unhide hint.
  * **/line.svg** : a simple line use to separate items in layouts, containe `vertical-line` and `horizontal-line` elements
  * **/lineedit.svg**: it's a framesvg, used to style line edits, spinboxes and other similar fields, it must have the following prefixes
    * `base`: the background of the line edit
    * `focus`: will be drawn outside base, when the line edit has input focus
    * `hover`: will be drawn outside base, when the line edit is under the mouse
  * **/listitem.svg**: used for "opened"/clicked notifications
  * **/monitor.svg** : represents a screen, it's used in places such as the wallpaper config dialog. It contains a frame without prefixes and the following extra elements:
    * `glass` : glass reflection effect over the screen
    * `base` : a stand for the monitor
  * **/notes.svg** : design of note stickers, with 10 different color variants:
    * `[color]-notes` : colored note sticker with `[color]` one of: `white`, `black`, `red`, `orange`, `yellow`, `green`, `blue`, `pink`, `translucent`, `translucent-light`
  * **/pager.svg** : graphic elements for the little screens of the pager, it must have 3 frames with the following prefixes:
    * `normal` : all virtual desktops
    * `active` : active virtual desktop
    * `hover` : virtual desktop under mouse
  * **/panel-background.svg**: the background image for panels.
    * If you want to create different background for panels located at the top, bottom, left or right, then also create sets of background elements with the following prefixes: `north`, `south`, `west` and `east` respectively. For example the center element of the left positioned panel's background should be named `west-center`.
    <!--*** When the panel is not 100% wide/tall the north, south etc. prefixes becomes *north-mini*, *south-mini* etc. . Please note that if KRunner <menuchoice>Positioning</menuchoice> is set to <menuchoice>Top edge of screen</menuchoice> (which is default), then Plasma treats it as not 100% wide north panel.-->
    * All prefixes fallback to a no prefix version when not available
    * if a prefix called `shadow` is available, it will be used as a drop shadow for the panel when compositing is available.
  * **/plasmoidheading.svg**: The header or footer of a widget/notification popup. It has 2 frames with the following prefixeds:
    * `header`: most widgets have the heading at the top
    * `footer`: popups originating from a top panel usually
  * **/plot-background.svg**: a background for plotter (graph) widgets, such as the plots in ksysguard
  * **/scrollbar.svg** : the classical `elevator` scrollbar, must have the following elemens : `arrow-up`, `mouseover-arrow-up`, `sunken-arrow-up`, same 3 elements for `arrow-left`, `arrow-right` and `arrow-bottom`. It can have an element called `hint-scrollbar-size` that says at what size the scrollbar should be rendered (width if vertical, height if horizontal). It must also have frames with the following prefixes:
    * `slider`
    * `mouseover-slider`
    * `sunken-slider`
    * `background-vertical`
    * `background-horizontal`
  * **/scrollwidget.svg**: used by Plasma::ScrollWidget, it has a single prefix
    * `border`: a border used when the scrollbar is enabled
  * **/slider.svg**: used to theme sliders, it must have the following elements:
    * `vertical-slider-line`: the background for vertical sliders, it indicates how much the indicator can scroll
    * `vertical-slider-handle`: the handle for vertical sliders
    * `vertical-slider-focus`: background for the handle when it has input focus
    * `vertical-slider-hover`: background for the handle when it is under the mouse
    * `groove`: groove for the slider (since Plasma 4.8 replaces `*-slider-line`)
    * `groove-highlight`: highlight part of the groove (since Plasma 4.8 replaces `*-slider-line`)
    * `horizontal-slider-line`: the background for horizontal sliders
    * `horizontal-slider-handle`: the handle for horizontal sliders
    * `horizontal-slider-focus`: background for the handle when it has input focus
    * `horizontal-slider-hover`: background for the handle when it is under the mouse
  * **/tabbar.svg**: graphics elements for tabbars: contains 4 frames, each one for tabs in the possible orientations a tabbar can be relative to its contents, with the prefixes:
    * `north`
    * `west`
    * `south`
    * `east`
  * **/tasks.svg**: task item backgrounds for tasks. See the section on backgrounds above for information on the required elements in this file.  The following element prefixes are required:
    * `focus`: background of focused task item
    * `hover`: background when the pointer hovers the task item. Focus and hover can have ticker borders that will be painted outside the task button, useful to make a glow effect.
    * `attention`: background when tasks item is trying to get attention
    * `normal`: background of normal, unfocused task item
    * `minimized`: background for minimized tasks
    * All the frames can be prefixed with `north-`, `west-`, `south-` or `east-` if the taskbar should have a different look at the 4 sides of the screen
    * The svg should contain elements of all five prefixes, if a prefix is missing that element will be not be drawn.
    * `panel-north`, `panel-south`, `panel-west`, `panel-east` : elements for the panel toolbox.
  * **/toolbar.svg**: used in the ToolBar QML component, can be used in custom applications in a similar way, contains a single frame without prefix.
  * **/tooltip.svg**: background for tooltips used for instance in the taskbar and with icons. See the section on backgrounds above for information on the required elements in this file.
  * **/translucentbackground.svg**: a standard background image for plasmoids that for their nature are bigger and with not much text. In this case a translucent background looks better. It needs the same elements of background.svg in it. If this file is not present, the plasmoids that uses this will use background.svg instead.
  * **/media-delegate.svg**: intended to be used as delegate for media types: it contains a single prefix: picture.
  * **/viewitem.svg**: controls the background look of selections (results in KRunner, networks in network applet), it can have 4 elements of 9 parts each with prefix `normal`, `hover`, `selected`, `selected+hover`.

## "Opaque" folder

In the special subfolder `opaque/` the same hierarchy can be found again: when compositing is disabled files in this folder are preferred over the corresponding ones listed above. Only background for top level windows are appropriate to go in this folder.

Since top-level windows will be shaped according to the transparency of the SVG and window shapes don't support alpha-blending, if the SVG has rounded borders they should have a shape that don't require anti-aliasing, like the following example.

![This is how a border of the plasma "opaque" background svgs should appear when they have a rounded border: since the window shape won't have antialiasing the outer contour must not have rounded lines.](No_composite_plasma_svg.jpg)

## "translucent" folder

In the special folder `translucent/` the same hierarchy is used as well: when the KWin *Background Contrast* effect is enabled the file under this folder will be used if found. As the opaque folder, only elements that will be rendered as window backgrounds should be present in this folder, so the dialogs folder, plus the panel and tooltip backgrounds. When is possible to blur the background of the window, the graphics can be more transparent, keeping the window text readable.

## "icons" folder

In the folder `icons/`, SVG files that contain scalable icons for use with application status items (e.g. icons in the system tray) are contained.

Some of the common icons:

* audio.svg
* battery.svg
* computer.svg
* configure.svg
* device.svg
* input.svg
* media.svg
* network.svg
* notification.svg
* preferences.svg
* start.svg
* system.svg

The files are named the same as the icon theme name or their prefix, e.g. "audio.svg" or "audio-volume-high.svg". Multiple icons can be contained within a single file whose name must match the full icon name, e.g. "audio.svg" can contain elements named "audio-volume-muted", "audio-volume-low", "audio-volume-medium", and "audio-volume-high".

##  Theming Application Icons in the System Tray

Applications that use a function called `setIconByName` can have their icon in the system tray themed. Applications can have more than one icon (for example Konversation flashes between two different icons to highlight when your username is mentioned and Kpackagekit changes it's icon depending on the status of it's upgrade / installs). Theming these icons requires firstly that an application has been coded to use `setIconByName`, and secondly that you call your SVG object by the same name (use `Ctrl+Shift-O` in Inkscape). Then you can just put your .svg in `share/plasma/desktoptheme/[themename]/icons`.

The following is an attempt to list known icon names that may be themed by this method. Please add any other known icon names and the object ID here to help other people making themes:

* Amarok
  * filename: **amarok.svg**
    * ID: **amarok**
* audio (for kmix, veromix, a.o.)
  * filename: **audio.svg**
    * volume muted ID: **audio-volume-muted**
    * volume low ID: **audio-volume-low**
    * volume medium ID: **audio-volume-medium**
    * volume high ID: **audio-volume-high**
* battery
  * filename: **battery.svg**
    * battery (always shown object) ID: **Battery**
    * on powerline ID: **AcAdapter**
    * no battery found ID: **Unavailable**
    * battery on 10% ID: **Fill10**
    * battery on 20% ID: **Fill20**
    * battery on 30% ID: **Fill30**
    * […]
    * battery on 90% ID: **Fill90**
    * battery on 100% ID: **Fill100**
* device (the device-notifier)
  * filename: **device.svg**
    * ID: **device-notifier**
* juk
  * filename: **juk.svg**
    * ID: **juk**
* KGet
  * filename: **kget.svg**
    * ID: **kget**
* Klipper
  * filename: **klipper.svg**
    * ID: **klipper**
* Konversation
  * filename: **konversation**
    * ID: **konversation**
  * filename: **konv_message.svg** (new incomming message)
    * ID: **konv_message**
* Kopete
  * filename: **kopete.svg**
    * öffline ID: **kopete-offline**
    * online ID: **kopete**
    * other statuses are not supported atm
* Korgac
  * filename: **korgac.svg**
    * ID: **korgac**
* Ktorrent
  * filename: **ktorrent.svg**
    * ID: **ktorrent**
* message-indicator
  * filename: **message-indicator.svg**
    * standard ID: **normal**
    * new message ID: **new**
* Nepomuk
  * filename: **nepomuk.svg**
    * ID: **nepomuk**
* Network-management-plasmoid
  * filename: **network.svg**
    * wired online ID: **network-wired-activated**
    * wired offline ID: **network-wired**
    * wless offline ID: **network-wireless-0**
    * wless on 20% ID: **network-wireless-20**
    * wless on 25% ID: **network-wireless-25**
    * wless on 40% ID: **network-wireless-40**
    * wless on 50% ID: **network-wireless-50**
    * wless on 60% ID: **network-wireless-60**
    * wless on 75% ID: **network-wireless-75**
    * wless on 80% ID: **network-wireless-80**
    * wless on 100% ID: **network-wireless-100**
    * mobile broadband on 0% ID: **network-mobile-0**
    * mobile broadband on 20% ID: **network-mobile-20**
    * mobile broadband on 40% ID: **network-mobile-40**
    * mobile broadband on 60% ID: **network-mobile-60**
    * mobile broadband on 80% ID: **network-mobile-80**
    * mobile broadband on 100% ID: **network-mobile-100**
    * mobile broadband with access technology on 0%  
      ID: **network-mobile-0-[technology]**  
      (The optional `[technology]` suffix can be: `gprs`, `edge`, `umts`, `hsdpa`, `hsupa`, `hspa`, `lte`)
* preferences (some apps like bluedevil, krandrtray, text-to-speech)
  * filename: **preferences.svg**
    * bluedevil online ID: **preferences-system-bluetooth**
    * bluedevil offline ID: **preferences-system-bluetooth-inactive**
    * text-to-speech ID: **preferences-desktop-text-to-speech**
    * krandrtray ID: **preferences-desktop-display-randr**
    * activity manager ID: **preferences-activities**
* Printer applet
  * filename: **printer.svg**
    * ID: **printer**
* Quassel IRC
  * filename: **quassel.svg**
    * quassel öffline ID: **quassel-inactive**
    * quassel online ID: **quassel**
    * quassel new message ID: **quassel-message**
* KWallet
  * filename: **wallet.svg**
    * open ID: **wallet-open**
    * closed ID: **wallet-closed**
