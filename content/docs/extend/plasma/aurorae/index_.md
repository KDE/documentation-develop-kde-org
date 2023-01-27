---
title: "Aurorae Window Decorations Tutorial"
description: How to create window decorations with SVGs
aliases:
  - /docs/aurorae/
---

Aurorae is a theme engine for KWin window decorations. It uses SVG to render the decoration and buttons and there is a simple config file for configuring the theme details.

A simple way to start creating your own theme is by modifying an existing one. You can find many existing themes in the [KDE Store](https://store.kde.org/browse?cat=114&ord=latest).

## Package structure

An Aurorae theme consists of one folder containing

- svg files for decoration and buttons
- one KConfig file for the theme details
- one metadata.desktop file for information about the theme.

```plaintext
ExampleDecoration
├── metadata.desktop
├── ExampleDecorationrc
├── decoration.svg
├── close.svg
├── maximize.svg
├── minimize.svg
├── ...
```

Each svg file needs to include certain custom [attributes](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute) for it to be managed correctly as part of a window decoration. With a vector graphics editor like [Inkscape](https://inkscape.org/), these attributes can be edited by selecting an object, opening the Object Properties pane and changing the ID and Label fields.

System-wide installed Aurorae themes are located in `/usr/share/aurorae/themes/` and user-specific themes are located in `~/.local/share/aurorae/themes/`. If you copy your folder into the user folder, it will be available for selection in System Settings. Just make sure you change the theme name in the KConfig rc file and in metadata.desktop.

## Window decoration

The window decoration has to be provided in a file `decoration.svg` . This svg has to contain all the elements required for a Plasma theme background. 

### Basic decoration

The base decoration element has to use the prefix `decoration`, like in the case of `decoration-inactive` or `decoration-top`. Different styles for special modes can optionally be provided in the same svg file.

### Inactive windows

A different style for inactive windows can be provided in the same svg. The inactive elements must have the element prefix `decoration-inactive`. If not provided, inactive windows will be rendered with the same style as active windows. 

### Maximized windows

In order to better support maximized windows there exists a special frame svg called `decoration-maximized`. In the same way as for the general decoration a version for inactive, opaque and inactive-opaque can be specified: `decoration-maximized`, `decoration-maximized-inactive`, `decoration-maximized-opaque` and `decoration-maximized-opaque-inactive`. If not provided, the engine falls back to the normal decoration.

In all cases only the center element will be used. There is no need to specify borders. Please note that in case of a window with translucent widgets the center element will be stretched to the size of the complete window. In order to support Fitts' Law all TitleEdge Settings are set to 0. So the buttons will be directly next to the screen edges.

### Opacity

A special decoration for opaque mode, that is when compositing is not active, can be provided. The element prefix is `decoration-opaque` for active and `decoration-opaque-inactive` for inactive windows. If not provded, the engine falls back to the translucent version.

### Blur

If transparent decorations should receive a blur effect, an element named `mask` must be provided which specifies the region to apply blur to. The mask element should use the same padding as for active and inactive decorations.  An example can be found in [this demonstration theme](https://invent.kde.org/plasma/kwin/uploads/082f60ad4311e3e296b7faeeb7c97dac/ROUNDED-DARK.tar.gz). If no mask element is provided, blur will be disabled for the theme.

### Inner borders 

Aurorae supports inner borders, that is a border at the margin to the window. While it would be possible to add inner borders directly in the decoration element, the inner borders are to be preferred as those support the configurable border sizes.

For inner borders the decoration svg file can include two additional FrameSvgs: `innerborder` and `innerborder-inactive`.  If the inactive element is not present the active element is used for inactive windows. 

These frames must include the border elements. Only the border elements will be visible, the center element is not visible. For performance reasons the center element should be a simple rect and for support of decoration behind windows it should be completely translucent.

Inner borders are not shown for maximized windows. If a maximized window should show an inner border it is recommeded to directly add it to the maximized element.

### Button Groups
An Aurorae decoration may include elements to be painted behind the button groups. This is intended for cases when the buttons share a common background. it should be preferred over custom editing of each button as this will result in a bad visual experience for explicit spacers or if the user changes the order of buttons.

The following elements are supported: `buttongroup-left`, `buttongroup-left-inactive`, `buttongroup-right`, `buttongroup-right-inactive`. If the inactive element is not provided, the element for active is used for the inactive decoration, too. Left and right are independent and there is no fallback to the other element.

## Buttons

An svg file has to be provided for each button. If the theme does not provide a file for a button type the engine will not include that button, so the decoration will miss it. There is no fallback to a default theme. The buttons are rendered using Plasma's FrameSvg just like the decoration. 

Each button has to provide the `center` element. 

Borders are not supported.

### Button types

The following buttons are supported:
- `close` (`X`): closes the window
- `minimize` (`I`): minimizes the window
- `maximize` (`A`): maximizes the window; replaces the ''restore'' button when not maximized
- `restore`: restores the window from maximized state; replaces the `maximize` button when maximized
- `alldesktops` (`S`): window on all desktops (also known as "sticky")
- `keepabove` (`F`): keep window above other windows
- `keepbelow` (`B`): keep window below other windows
- `shade` (`L`): shade the window
- `help` (`H`): show help information
- (`M`): window menu ("Move to Desktop", "Move to Screen", etc.). This button is not to be provided as an svg file, but available for use in the configuration.
- (`N`): application menu ("File", "Edit", "View" etc.). This button is not to be provided as an svg file, but available for use in the configuration.

The name is the name of the svg file; e.g. the close button has to be named `close.svg`. The letter in brackets is the button name to be used in the configuration (see below).

### Button states

Each button can have different states. So a button could be hovered, pressed, deactivated and the theme might want to provide different styles for active and inactive windows. The following element prefixes can be used to provide styles for the buttons: 

- `active`: normal button for active window 
- `inactive`: normal button for inactive window 
- `hover`: hover state for active window 
- `hover-inactive`: hover state for inactive window 
- `pressed`: button is pressed 
- `pressed-inactive`: pressed inactive button 
- `deactivated`: button cannot be clicked, e.g. window cannot be closed 
- `deactivated-inactive`: same for inactive windows

At least the active element has to be provided. All other elements are optional and the active element is always used as a fallback. If the theme provides the inactive element, this is used as a fallback for the inactive states. That is, if the theme provides a hover element, but none for inactive, the inactive window will not have a hover effect. Same is true for pressed and deactivated.

The buttons `alldesktops`, `keepabove`, `keepbelow` and `shade` are toggle buttons. When clicking on them they will stay in state `pressed(-inactive)`. By clicking them again they will change back to `(in)active`.

All of those elements have to be put into one svg file for a button type.

## Configuration

The configuration file must have as its name the name provided in the metadata file followed by the suffix `rc`. The configuration file is a KConfig file following the [Desktop Entry Specification](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html).

In a configuration group with the heading `[General]` the following options can be set:

- `TitleAlignment`: horizontal alignment of window title (default: `Left`) 
- `TitleVerticalAlignment`: vertical alignment of window title (default: `Center`) 
- `Animation`: animation duration in msec when hovering a button and on active/inactive change (default: `0`) 
- `ActiveTextColor`: title text color of active window (default: `0,0,0,255`)
- `InactiveTextColor`: title text color of inactive window (default: `0,0,0,255`)
- `UseTextShadow`: draw shadow behind title text (default: `false`)
- `ActiveTextShadowColor`: shadow text color of active window (default: `255,255,255,255`)
- `InactiveTextShadowColor`: shadow text color of active window (default: `255,255,255,255`)
- `TextShadowOffsetX`: offset of shadow in x direction (default: `0`)
- `TextShadowOffsetY`: offset of shadow in y direction (default: `0`)
- `HaloActive`: draw halo behind title of active window (default: `false`; since 4.5)
- `HaloInactive`: draw halo behind title of inactive window (default: `false`, since 4.5) 
- `LeftButtons`: buttons in left button group (default: `MS`)
- `RightButtons`: buttons in right button group (default: `HIAX`)
- `Shadow`: decoration provides shadows  (default: `true`)
- `DecorationPositon`: decoration on top (`0`), left (`1`), right (`2`), or bottom (`3`) (default: `0`) 

If `Shadow` is enabled, `Padding` values have to be added in the layout configuration (see below).

If the decoration handles are on a side other than the top, some of the layout options change their meaning. E.g. `ButtonMarginTop` becomes a `ButtonMarginLeft`, in general layout settings were only a top exists are changed, if all exists like `TitleEdge` the meaning is unchanged. A shaded window will always have the decoration on the top, so the layout is transformed to be painted on the top again.


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


The layout can be configured in aconfiguration group named `[Layout]` with the following options and values:

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

`Border<Direction>` is only required if the decoration is not in that direction; e.g. `BorderTop` is only required for decorations on the left, right or bottom. `Padding<Direction>` values can be used to provide shadows. The `ButtonWidth<Action>` values are optional, falling back to `ButtonWidth` if not specified.

The user can change border and button sizes in the settings dialog. The defaults are the settings specified in the configuration file. The configurable border size influences the right, left and bottom borders, the button size influences both the size of all buttons and the title height.

It is important to remember that the buttons have to be scalable to correctly support this feature and that the borders may extend into the center element if the border size is changed.

## Metadata

The theme must contain a file `metadata.desktop` for information about the theme such as name, author, licence, etc. The format follows the [Desktop Entry Specification](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html), staring with a group heading `[DesktopEntry]` and supporting the following entries:

- `Name`: the name of the theme used in theme selection
- `Comment`: a comment for the theme, e.g. "Aurorae theme inspired by Oxygen decoration"
- `X-KDE-PluginInfo-Author`: the name of the author used in the about dialog
- `X-KDE-PluginInfo-Email`: the author's email address used in the about dialog
- `X-KDE-PluginInfo-Website`: the webseite of the theme
- `X-KDE-PluginInfo-Version`: version of the theme, e.g. 1.0
- `X-KDE-PluginInfo-License`: the license of the theme, e.g. GPLv3


## Publishing
Once you have created something nice, consider sharing it with other Plasma users! Create a zip file of the package folder, and upload it to the [KDE Store](https://store.kde.org/browse/) under the category Linux/Unix Desktops > Desktop Themse > KDE > KDE Plasma > Plasma Windoe Decorations. Users will then be able to find and install your script with Discover or via “Get New Windoe Decorations…” in System Settings.
