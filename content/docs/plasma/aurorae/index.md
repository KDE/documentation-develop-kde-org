---
title: "Aurorae window decorations"
linkTitle: "Aurorae window decorations"
weight: 4
description: How to create window decorations with SVGs
aliases:
  - /docs/aurorae/
---

Aurorae is a theme engine for KWin window decorations, i.e. the frames around windows that typically contain the window title and buttons for closing, minimizing, etc. the window. Aurorae uses either SVG or QML to render the decoration and buttons, and there is a simple config file for configuring the theme details. Alternatively, it is possible to write window decorations in C++ using the [KDecoration2 API](https://api.kde.org/plasma/kdecoration/html/index.html). This article describes how to create a theme with SVGs.

A simple way to start creating your own theme is by modifying an existing one. You can find many existing themes in the [KDE Store](https://store.kde.org/browse?cat=114&ord=latest). One example is [Breeze Active Accent](https://github.com/nclarius/Plasma-window-decorations).

## Package structure

An Aurorae theme consists of one folder containing

- SVG files for decoration and buttons
- one KConfig rc file for the theme details
- one metadata.desktop file for information about the theme.

```plaintext
🗀 ExampleDecoration
├── 🗎 metadata.desktop
├── 🗎 ExampleDecorationrc
├── 🗎 decoration.SVG
├── 🗎 close.SVG
├── 🗎 maximize.SVG
├── 🗎 minimize.SVG
├── ...
```

Each SVG file needs to include certain custom [attributes](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute) for it to be managed correctly as part of a window decoration. With a vector graphics editor like [Inkscape](https://inkscape.org/), these attributes can be edited by selecting an object, opening the Object Properties pane and changing the ID and Label fields. It is also possible to make use of colors from the [system color scheme]({{< ref "/docs/plasma/theme/theme-colors" >}}).

System-wide installed Aurorae themes are located in `/usr/share/aurorae/themes/` and user-specific themes are located in `~/.local/share/aurorae/themes/`. If you copy your folder into the user folder, it will be available for selection in System Settings. Just make sure you have the matching theme name for the folder, the configuration file and the metadata file, as described in the sections below.

## Window frame

The window frame has to be provided in a file `decoration.svg` ([example](https://github.com/nclarius/Plasma-window-decorations/blob/main/ActiveAccentLight/decoration.svg?short_path=f052936)). This SVG has to contain all the elements required for a Plasma theme background. Different styles for special states (such as active or inactive) can optionally be provided in the same SVG file.

Each decoration state element is composed of one element for each window side which have the name of the side as a suffix in the ID: `left`, `right`, `top`, `bottom`, `topleft`, `topright`, `bottomleft`, `bottomright`, `center`.

### Basic decoration

The base decoration element has to use the prefix `decoration`, like in the case of `decoration-inactive` or `decoration-top`.

### Inactive windows

A different style for inactive windows can be provided in the same SVG. The inactive elements must have the element prefix `decoration-inactive`. If not provided, inactive windows will be rendered with the same style as active windows. 

### Opacity

A special decoration for opaque mode, that is when compositing is not active, can be provided. The element prefix is `decoration-opaque` for active and `decoration-opaque-inactive` for inactive windows. If not provided, the engine falls back to the translucent version.

### Blur

If transparent decorations should receive a blur effect, an element named `mask` must be provided which specifies the region to apply blur to. The mask element should use the same padding as for active and inactive decorations.  An example can be found in [this demonstration theme](https://invent.kde.org/plasma/kwin/uploads/082f60ad4311e3e296b7faeeb7c97dac/ROUNDED-DARK.tar.gz). If no mask element is provided, blur will be disabled for the theme.

### Inner borders 

Aurorae supports inner borders, that is a border at the margin to the window. While it would be possible to add inner borders directly in the decoration element, the inner borders are to be preferred as those support the configurable border sizes.

For inner borders, the decoration SVG file can include two additional FrameSvgs: `innerborder` and `innerborder-inactive`.  If the inactive element is not present the active element is used for inactive windows. 

These frames must include the border elements. Only the border elements will be visible, the center element is not visible. For performance reasons, the center element should be a simple rectangle and for support of decoration behind windows it should be completely translucent.

Inner borders are not shown for maximized windows. If a maximized window should show an inner border it is recommended to directly add it to the `maximized` element.

### Maximized windows

In order to better support maximized windows there exists a special frame SVG called `decoration-maximized`. In the same way as for the general decoration a version for inactive, opaque, and inactive-opaque can be specified: `decoration-maximized`, `decoration-maximized-inactive`, `decoration-maximized-opaque` and `decoration-maximized-opaque-inactive`. If not provided, the engine falls back to the normal decoration.

In all cases, only the center element will be used. There is no need to specify borders. Please note that in the case of a window with translucent widgets, the center element will be stretched to the size of the complete window. In order to support Fitts' Law all TitleEdge Settings are set to 0. So the buttons will be directly next to the screen edges.

## Buttons

An SVG file has to be provided for each button ([example](https://github.com/nclarius/Plasma-window-decorations/blob/main/ActiveAccentLight/close.svg?short_path=c5cfc22)). If the theme does not provide a file for a button type the engine will not include that button, so the decoration will miss it. There is no fallback to a default theme. The buttons are rendered using Plasma's FrameSvg just like the decoration. 

Each button has to provide the `center` element. 

Borders are not supported.

### Button types

The following buttons are supported:
- `close` (`X`): closes the window
- `minimize` (`I`): minimizes the window
- `maximize` (`A`): maximizes the window; replaces the ''restore'' button when not maximized
- `restore`: restores the window from maximized state; replaces the `maximize` button when maximized
- `alldesktops` (`S`): show window on all desktops (also known as "sticky")
- `keepabove` (`F`): keep window above other windows
- `keepbelow` (`B`): keep window below other windows
- `shade` (`L`): shade the window
- `help` (`H`): show help information
- (`M`): window menu ("Move to Desktop", "Move to Screen", etc.). This button is not to be provided as an SVG file, but is available for use in the configuration.
- (`N`): application menu ("File", "Edit", "View" etc.). This button is not to be provided as an SVG file, but is available for use in the configuration.

Each button SVG file needs to be named after the button type; e.g. the close button has to be named `close.svg`. The letter in brackets is the button name to be used in the configuration (see below).

### Button states

Each button can have different states. It could be hovered, pressed, or deactivated and the theme might want to provide different styles for active and inactive windows. The following element prefixes can be used to provide styles for the buttons: 

- `active`: normal button for active windows
- `inactive`: normal button for inactive window s
- `hover`: hover state for active windows
- `hover-inactive`: hover state for inactive windows 
- `pressed`: button is pressed 
- `pressed-inactive`: button is pressed for inactive windows 
- `deactivated`: button cannot be clicked, e.g. window cannot be closed 
- `deactivated-inactive`: button cannot be clicked for inactive windows

At least the active element has to be provided. All other elements are optional and the `active` element is always used as a fallback. If the theme provides the `inactive` element, this is used as a fallback for the inactive states. That is if the theme provides a `hover` element, but none for `inactive`, the inactive window will not have a hover effect. The same is true for `pressed` and `deactivated`.

The buttons `alldesktops`, `keepabove`, `keepbelow` and `shade` are toggle buttons. When clicking on them they will stay in `pressed(-inactive)` state. By clicking them again they will change back to `(in)active`.

All of those elements have to be put into one SVG file for a button type.

## Configuration

The configuration file must have as its name the plugin name provided in the metadata file followed by the suffix `rc` ([example](https://github.com/nclarius/Plasma-window-decorations/blob/main/ActiveAccentLight/ActiveAccentLightrc)). The configuration file is a KConfig file following the [Desktop Entry Specification](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html).

In a configuration group with the heading `[General]` the following options can be set:

- `TitleAlignment`: horizontal alignment of the window title (default: `Left`) 
- `TitleVerticalAlignment`: vertical alignment of the window title (default: `Center`) 
- `Animation`: animation duration in msec when hovering a button and on active/inactive change (default: `0`) 
- `ActiveTextColor`: title text color of active windows (default: `0,0,0,255`)
- `InactiveTextColor`: title text color of inactive windows (default: `0,0,0,255`)
- `UseTextShadow`: draw a shadow behind the title text (default: `false`)
- `ActiveTextShadowColor`: shadow text color of active windows (default: `255,255,255,255`)
- `InactiveTextShadowColor`: shadow text color of active windows (default: `255,255,255,255`)
- `TextShadowOffsetX`: offset of shadow in x direction (default: `0`)
- `TextShadowOffsetY`: offset of shadow in y direction (default: `0`)
- `HaloActive`: draw a halo behind the title of active windows (default: `false`)
- `HaloInactive`: draw a halo behind the title of inactive windows (default: `false`) 
- `LeftButtons`: buttons in the left button group (default: `MS`)
- `RightButtons`: buttons in the right button group (default: `HIAX`)
- `Shadow`: decoration provides shadows  (default: `true`)
- `DecorationPositon`: decoration on top (`0`), left (`1`), right (`2`), or bottom (`3`) (default: `0`) 

If `Shadow` is enabled, `Padding` values have to be added to the layout configuration (see below).


## Layout

The following diagrams illustrate which configuration value influences which part of the decoration:

Window:
```plaintext
 ___________________________________________________________________
|                 PaddingTop                                        |
|  _______________________________________________________________  |
| |              TitleEdgeTop                                     | |
| |_______________________________________________________________| |
| | TitleEdgeLeft |   [title]                    | TitleEdgeRight | |
| |_______________|______________________________|________________| |
| |              TitleEdgeBottom                                  | |
| |_______________________________________________________________| |
| | |                                                           | | |
|PaddingLeft                                            PaddingRight|
| | |                                                           | | |
| |BorderLeft                                          BorderRight| |
| |_|___________________________________________________________|_| |
| |              BorderBottom                                     | |
| |_______________________________________________________________| |
|                PaddingBottom                                      |
|___________________________________________________________________|
```

Title:
```plaintext
 __________________________________________________________________________
| ButtonMarginTop             |             |              ButtonMarginTop |
|_____________________________|             |______________________________|
| [Buttons] | TitleBorderLeft | TitleHeight | TitleBorderRight | [Buttons] |
|___________|_________________|_____________|__________________|___________|
```

Buttons:
```plaintext
 _____________________________________________________________________________________________
| button | spacing | button | spacing | explicit spacer | spacing | ...    | spacing | button |
|________|_________|________|_________|_________________|_________|________|_________|________|
```


The layout can be configured in a configuration group named `[Layout]` with the following options and values:

- `BorderLeft` (default: `5`)
- `BorderRight` (default: `5`) 
- `BorderBottom` (default: `5`)
- `BorderTop` (default: `0`)
- `TitleEdgeTop` (default: `5`)
- `TitleEdgeBottom` (default: `5`)
- `TitleEdgeLeft` (default: `5`)
- `TitleEdgeRight` (default: `5`)
- `TitleEdgeTopMaximized`: (default: `0`)
- `TitleEdgeBottomMaximized`: (default: `0`)
- `TitleEdgeLeftMaximized`: (default: `0`)
- `TitleEdgeRightMaximized`: (default: `0`)
- `TitleBorderLeft` (default: `5`)
- `TitleBorderRight` (default: `5`)
- `TitleHeight` (default: `20`)
- `ButtonWidth` (default: `20`)
- `ButtonWidthMinimize` (default: `20`) 
- `ButtonWidthMaximizeRestore` (default: `20`) 
- `ButtonWidthClose` (default: `20`) 
- `ButtonWidthAlldesktops` (default: `20`) 
- `ButtonWidthKeepabove` (default: `20`) 
- `ButtonWidthKeepbelow` (default: `20`) 
- `ButtonWidthShade` (default: `20`) 
- `ButtonWidthHelp` (default: `20`) 
- `ButtonWidthMenu` (default: `20`) 
- `ButtonHeight` (default: `20`)
- `ButtonSpacing` (default: `5`)
- `ButtonMarginTop` (default: `0`)
- `ExplicitButtonSpacer` (default: `10`)
- `PaddingTop` (default: `0`)
- `PaddingBottom` (default: `0`)
- `PaddingRight` (default: `0`)
- `PaddingLeft` (default: `0`)

`Border<Direction>` is only required if the decoration is not in that direction; e.g. `BorderTop` is only required for decorations on the left, right, or bottom. `Padding<Direction>` values can be used to provide shadows. The `ButtonWidth<Action>` values are optional, falling back to `ButtonWidth` if not specified.

If the decoration handles are on a side other than the top, layout options that only exist in a version for the top change their meaning to that side; e.g. with `DecorationPosition=1` (where `1` means left), `ButtonMarginTop` will mean `ButtonMarginLeft`, whereas e.g. the `TitleEdge` options remain unchanged as they are defined for all four sides. A shaded window will always have the decoration on the top, so the layout is transformed to be painted on the top again.

The user can change the border and button sizes in the settings dialog. The defaults are the settings specified in the configuration file. The configurable border size influences the right, left, and bottom borders, and the button size influences both the size of all buttons and the title height.

It is important to remember that the buttons have to be scalable to correctly support this feature and that the borders may extend into the center element if the border size is changed.

## Metadata

The theme must contain a `metadata.desktop` file for information about the theme such as name, author, license, etc ([example](https://github.com/nclarius/Plasma-window-decorations/blob/main/ActiveAccentLight/metadata.desktop)). The format follows the [Desktop Entry Specification](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html), starting with a group heading `[DesktopEntry]` and supporting the following entries:

- `Name`: the name of the theme displayed in theme selection
- `Comment`: a comment for the theme, e.g. "Aurorae theme inspired by Oxygen decoration"
- `X-KDE-PluginInfo-Name`: an ID name for the theme, which should be identical to the folder name
- `X-KDE-PluginInfo-Author`: the name of the author used in the about dialog
- `X-KDE-PluginInfo-Email`: the author's email address used in the about dialog
- `X-KDE-PluginInfo-Website`: the webseite of the theme
- `X-KDE-PluginInfo-Version`: version of the theme, e.g. 1.0
- `X-KDE-PluginInfo-License`: the license of the theme, e.g. GPLv3


## Publishing
Once you have created something nice, consider sharing it with other Plasma users! Create a zip file of the package folder and upload it to the [KDE Store](https://store.kde.org/browse/) under the category Linux/Unix Desktops > Desktop Themes > KDE > KDE Plasma > Plasma Window Decorations. Users will then be able to find and install your theme with [Discover](https://apps.kde.org/discover/) or via “Get New Window Decorations…” in System Settings.
