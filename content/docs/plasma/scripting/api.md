---
title: API documentation
weight: 3
description: API documentation for Plasma scripting API
---

In addition to the normal Javascript API and the Qt-specific extensions
(such as signal/slot support) provided by QtJSEngine, the following API is
provided for use by scripts.

All of the API below, unless otherwise noted with a version noticed,
appear as below in the KDE Software Compilation v4.4.0 and later. API
that is not noted as being part of a given class or object is part of
the global namespace.

## Version Numbers

Starting with KDE SC 4.5, the version number of both the scripting API
and the application is available to the script via the following
read-only properties:

-  `string applicationVersion`: the version of the application, e.g. 5.20.3
-  `number scriptingVersion`: the version of the scripting API; e.g.
   for Plasma 5.20 it is 20.

## Activities

**Activities** are similar to virtual desktops, except that in Plasma, activities can have different desktop wallpapers and desktop widgets. All activities share the same panels. Individual activities can have many other settings like energy profiles. [Read this](https://userbase.kde.org/Plasma#Activities) for more info on Plasma Activities.

For plasma scripting purposes, we only need worry about how each activity has a different `Desktop` containment for each screen. Each `Desktop` instance can have a custom wallpaper and widgets.

Consider the following example. We have two activities. The first activity named `Default` has a desktop widget, while the 2nd activity named `Gaming` only has a solid black color fill. The `Default` activity has a weather desktop widget, while the `Gaming` activity does not.

* `plasmashell`
   * All Activities
      * `Panel(id=0)` for `Screen(id=0)`
         * `Widget(id=0)`
         * `Widget(id=1)`
         * ...
   * `Activity(name="Default", id="80cddcc9-cf02-4e23-af0b-dc569f24a2b4")`
      ![](activity1-default.jpg)
      * `Desktop(id=0, wallpaperPlugin="org.kde.image")` for `Screen(id=0)`
         * `Widget(id=2)` for the weather desktop widget
         * `[Wallpaper][org.kde.image][General] Image=wallpaper.png`
      * `Desktop(id=1, ...)` for the 2nd monitor `Screen(id=1)`
      
   * `Activity(name="Gaming", id="3683ebee-8869-4d60-9db1-8e92cfebc0cf")`
     ![](activity2-gaming.jpg)
      * `Desktop(id=2, wallpaperPlugin="org.kde.color")` for `Screen(id=0)`
         * `[Wallpaper][org.kde.color][General] Color=#000000`
      * `Desktop(id=3, ...)` for the 2nd monitor `Screen(id=1)`

New Activities can be created using the
[`createActivity(name, pluginId="")`](https://invent.kde.org/plasma/plasma-workspace/blob/master/shell/scripting/scriptengine_v1.cpp#L223)
function, like this:

```js
let activityId = createActivity("Activity Name")
let activityDesktops = desktopsForActivity(activityId)
let desktop = activityDesktops[0]
desktop.wallpaperPlugin = "org.kde.image"
desktop.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General")
desktop.writeConfig("Image", "file:///usr/share/wallpapers/Next/contents/images/1920x1080.png")
```

Note, `createActivity()` returns a string id. There is no `Activity` type in Plasma Scripting.

The `pluginId` string passed into the `createActivity()` function should
select the desktop "layout", however [due to a bug](https://invent.kde.org/documentation/develop-kde-org/-/issues/52)
it always creates an activity with a folder view layout. Should the bug
be fixed, you can pass a `pluginId` of:

* The `X-KDE-PluginInfo-Name` of plasmoid with `X-KDE-ServiceTypes=Plasma/Containment` and `X-Plasma-ContainmentType=Desktop`.
* `org.kde.desktopcontainment` for a desktop without icons
* `org.kde.plasma.folder` for a desktop with icons

Read-only properties:

- `array[number] activityIds`: returns a list of integer ids of all
  existing Plasma activities
- `array[string] knownActivityTypes`: a list of types of activities
  that can be created. This is useful to
  check if an Activity type is available on the system before trying to
  construct one.

Functions:

- `array<string> activities()`: Returns an array of all activity
  ids of the activities that currently exist
- `string activityName(string activityId)`: Get the name of an activity
  by its id.
- `void setActivityName(string activityId)`: Set the name of an activity
  by its id.
- `string currentActivity()`: Get the id of the current activity.
- `void setCurrentActivity(string activityId)`: Set the current activity
using its id.
- `string createActivity(string name[, string plugin])`: Returns the new
  activity id with the supplied name argument. The plugin argument is
  ignored [due to a bug](https://invent.kde.org/documentation/develop-kde-org/-/issues/52)
  so you can call this function with just `createActivity("Name")`.

## Desktops

Every screen will have a Desktop instance. Desktops are containments
which can have widgets and a wallpaper plugin.

The actual data type for a Desktop is
[`WorkspaceScripting::Containment`](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/shell/scripting/containment.h) which [Panels](#panels) inherit.

```js
let desktop = desktops()[0]
desktop.wallpaperPlugin = "org.kde.image"
desktop.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General")
desktop.writeConfig("Image", "file:///usr/share/wallpapers/Next/contents/images/1920x1080.png")
```

Desktops also inherit all the [**Containment properties**](#containments-desktops-and-panels).

Read-only properties:

- `string wallpaperPlugin`: the wallpaper plugin to use with the Desktop.
  ```bash
  kpackagetool5 --global --type=Plasma/Wallpaper --list
  kpackagetool5 --type=Plasma/Wallpaper --list
  ```
  ```
  Listing service types: Plasma/Wallpaper in /usr/share/plasma/wallpapers/
  org.kde.color
  org.kde.haenau
  org.kde.hunyango
  org.kde.image
  org.kde.potd
  org.kde.slideshow
  Listing service types: Plasma/Wallpaper in ~/.local/share/plasma/wallpapers/
  ...
  ```
- `string wallpaperMode`: the wallpaper plugin mode to use with the Desktop. Does nothing in Plasma 5.

Functions:

- `array<Desktop> desktopsForActivity(string id)`: return all the
  desktops associated to a specific activity id (one per physical
  screen).
- `array<Desktop> desktops()`: returns an array of all desktops
  that currently exist.
- `Desktop desktopById(int id)`: return an object representing
  the activity with the given id
- `Desktop desktopForScreen(number screen[, number desktop])`:
  returns an object representing the activity currently associated with
  the given screen and, optionally, the given desktop.

## Panels

Panels can be created, enumerated, modified and destroyed. A [panel
object](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/shell/scripting/panel.h) combines both a containment as well as the container itself,
allowing for full control of things such as where it appears on the
screen and the hiding features associated with them.

New Panels can be created using the Panel constructor, like this:

```js
let panel = new Panel
```

Panels also inherit all the [**Containment properties**](#containments-desktops-and-panels).

Read-only properties:

- `array<int> panelIds`: returns a list of integer ids of all
  existing Plasma panels
- `array<string> knownPanelTypes`: a list of types of panels that can
  be created. This is useful to check if a Panel type is available on
  the system before trying to construct one.

Read-write properties:

- `number length`: the number of pixels along the screen edge used
- `number minimumLength`: (scriptingVersion >= 7) the minimum
  number of pixels along the screen edge used (auto-resize panels)
- `number maximumLength`: (scriptingVersion >= 7) the maximum
  number of pixels along the screen edge used (auto-resize panels)
- `number height`: the height (or for vertical panels, the width)
  of the panel
- `string hiding`: the hiding mode of the panel, one of `none` (for
  no hiding), `autohide`, `windowscover` or `windowsbelow`
- `string alignment`: `right`, `left` or `center` alignment of the panel
  (for vertical panels, `right` corresponds to top and `left` to bottom)
- `number offset`: how much the panel is moved from the
  left/right/center anchor point
- `string location`: returns the location of the Panel; valid
  values include `top`, `bottom`, `left`, `right` and `floating`.

Functions:

- `Panel panelById(int id)`: returns an object representing the
  Panel that matches the given id
- `array<Panel> panels()`: returns an array of all panels that
  currently exist

## Containments (Desktops and Panels)

Desktop and Panel objects are both Containments.

Containments also inherit all the [**Applet properties**](#applets-containments-and-widgets).

Read-only properties:

- `string version`:  the version of the containment
- `int id`: the integer id of this containment
- `int screen`: the screen this activity is associated with, or
  -1 for none
- `string formFactor`: returns [the form factor](https://api.kde.org/frameworks/plasma-framework/html/classPlasma_1_1Types.html#afd0761e107f9b0ff888b0fabdc53f188) of the containment.
  `planar` for desktop widgets, `mediacenter` for media
  centers like TVs, and either `horizontal` or `vertical` for panels.
- `array<int> widgetIds`: a list of integer ids of all the
  widgets in this containment

Read-write properties:

Functions:

- Inherits `Applet.remove()`: deletes this containment and all widgets inside of it
- Inherits `Applet.showConfigurationInteface()`
- Inherits `Applet.readConfig(...)`
- Inherits `Applet.writeConfig(...)`
- Inherits `Applet.readGlobalConfig(...)`
- Inherits `Applet.writeGlobalConfig(...)`
- Inherits `Applet.reloadConfig()`: causes the Containment (Desktop or Panel)
  to reload its configuration; reaction to configuration changes
  made using `readConfig()` are usually activated on script exit, but this
  can be triggered earlier on a per-widget basis using this method

-  `Widget widgetById(int id)`: returns an object representing
   the widget with the given id
-  `Widget addWidget(string name)`: adds a new widget to the
   containment; the name maps to the `X-KDE-PluginInfo-Name=` entry in
   the widget's .desktop file
-  `Widget addWidget(string name, number x, y, w, h)`: adds a new widget to the
   containment at the specified position.
-  `Widget addWidget(Widget widget)`: adds an existing widget to
   this activity; useful for moving widgets between Activities and
   Panels
-  `array[Widget] widgets([string type])`: (scriptingVersion >= 2)
   returns all the widgets in the Panel or Activity. If the optional
   type is specified, only widgets matching that type will be returned.

## Widgets

Widgets may be enumerated by calling the `widgetIds` property on an
`Desktop` or `Panel` object. With a widget id in hand, a `Widget` object can
be retrieved by calling `widgetById(id)` on a `Containment` (`Desktop` or `Panel`) object.
New Widgets can be created with add `addWidget(string)` function provided
by `Containment` objects.

### Checking if a widget is installed

A list of all installed widget types can be retrieved the following
read-only property:

-  `array[string] knownWidgetTypes` (scripting version >= 2)

This can be used most conveniently with the indexOf() method, like this:

```js
if (knownWidgetTypes.indexOf('someWidgetPluginName') > -1) {
    print("It is installed on this system!");
} else {
    print("It is not installed :(");
}
```

### Widget Object API

Widgets also inherit all the [**Applet properties**](#applets-containments-and-widgets).

Read-only properties:

- Inherits `Applet.id`: the numerical instance id of the widget
- Inherits `Applet.type`: the `X-KDE-PluginInfo-Name` of the widget
- Inherits `Applet.version`
- Inherits `Applet.configKeys`
- Inherits `Applet.configGroups`
- Inherits `Applet.globalConfigKeys`
- Inherits `Applet.globalConfigGroups`

Read-write properties:

- `QRectF geometry`: the geometry of the widget
- `string globalShortcut`: the shortcut sequence (in the format
  used by QKeySequence, e.g. `Alt+F1`) associated with this widget
- `number index`: the layout index of the widget; in a Panel this
  corresponds to the order the widget appears in. Changing the value of
  the index will change the position of the widget in Panels and may do
  so in some Activities as well.
- Inherits `Applet.currentConfigGroup`
- Inherits `Applet.currentGlobalConfigGroup`

Functions:

- Inherits `Applet.remove()`
- Inherits `Applet.showConfigurationInteface()`
- Inherits `Applet.readConfig(...)`
- Inherits `Applet.writeConfig(...)`
- Inherits `Applet.readGlobalConfig(...)`
- Inherits `Applet.writeGlobalConfig(...)`
- Inherits `Applet.reloadConfig()`


## Applets (Containments and Widgets)

The base class of Widgets and Containments (Desktops and Panels).

Most of these functions and properties are redefined in both
[`containment.h`](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/shell/scripting/containment.h)
and [`widget.h`](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/shell/scripting/widget.h)
instead of [`applet.h`](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/shell/scripting/applet.h)
for some reason.

Read-only properties:

- `number id`: the numerical instance id of the applet
- `string type`: the plugin type of this applet, same value as
  `X-KDE-PluginInfo-Name` in the metadata
- `string version`: the version of the applet specified in it's metadata
- `array<string> configKeys`: a list of all keys that are set in the
  current configuration group
- `array<string> configGroups`: a list of all the groups in the current
  configuration group
- `array<string> globalConfigKeys`: a list of all keys that are set in
  the current global configuration group
- `array<string> globalConfigGroups`: a list of all the groups in the
  current global configuration group

Read-write properties:

- `array<string> currentConfigGroup`: the current configuration
  group path, with each entry in the array representing a sub-group.
  This allows one to access trees of groups with code such as:
  ```js
  widget.currentConfigGroup = new array('topGroup', 'subGroupOfTopGroup')
  ```
  An empty array means the default (top-level) configuration group
  for the applet
- `array<string> currentGlobalConfigGroup`: the current global
  configuration group path, with each entry in the array representing
  a sub-group, similar to `currentConfigGroup`. However, global
  configuration is shared by all instances of applets of the same type.

Functions:

- `remove()`: deletes this applet
- `showConfigurationInteface()`: shows the configuration user
  interface for this widget on the screen
- `readConfig(string key, any default)`: reads the value of key in
  the config with default for the default value
- `writeConfig(string key, any value)`: sets key to value in the
  config
- `readGlobalConfig(string key, any default)`: reads the value of key
  in the global config with default for the default value
- `writeGlobalConfig(string key, any value)`: sets key to value in
  the global config
- `reloadConfig()`: causes the widget to reload its configuration;
  reaction to configuration changes made using readConfig are usually
  activated on script exit, but this can be triggered earlier on a
  per-widget basis using this method

## Screen Geometry

Read-only properties:

-  `number screenCount`: returns the number of screens connected to
   the computer

Functions:

-  `QRectF screenGeometry(number screen)`: returns a rect object
   representing the geometry of a screen

## Wallpaper Plugins

-  `array[string => array[string]] knownWallpaperPlugins()`:
   (scripting version >= 4) returns a list of all installed wallpaper
   plugins. The keys of the array are the wallpaper plugin names. The
   values are arrays containing the modes available for that wallpaper
   plugin. The mode array may be empty, as most wallpaper plugins only
   offer one mode.

## Locating Applications and Paths

-  `boolean applicationExists(string name)`: (scripting version >=
   4) searches $PATH first, then tries in the application menu system by
   application storage name (aka the .desktop file name), then Name=
   entries for apps with installed .desktop files, then GenericName=
   entries for same
-  *mixed* `defaultApplication(string kind [, boolean storageId =
   false])`: (scripting version >= 4) returns the executable (or if
   `storageId` is `true`, then the app menu system id, e.g. its `.desktop`
   file name) of the default app. The `kind` parameter may be a
   well-known application type including `"browser"`, `"mailer"`,
   `"filemanager"`, `"terminal"`, `"imClient"` and `"windowmanager"` (or any
   other entry in `share/apps/kcm_componentchooser/kcm_*.desktop`); it may
   also be a mimetype (e.g. `"application/pdf"`). On failure, it returns
   `false`.
-  `string applicationPath(string name)`: (scripting version >= 4)
   returns the full local path to a given application or .desktop file
   if it exists. Example:

```js
const desktopfile = "firefox.desktop"
const executable  = "firefox"
if (applicationExists(executable)) {  
    print(`${executable} exists with this path: ${applicationPath(executable)}`)
    print(`${executable} .desktop file is located here : ${applicationPath(desktopfile)}`)
} else{
    print(`${executable} does not exist`)
}
```

- `string userDataPath([string type, string path])`: (scripting
  version >= 4) returns the default path for user data. Called with no
  parameters, it returns the user's home directory. If only one string
  is passed in, the standard directory for that type of data in the
  user's home directory will be located; the following values are
  recognized:

  -  documents
  -  music
  -  video
  -  downloads
  -  pictures
  -  autostart
  -  desktop (should be considered deprecated for Plasma workspaces)

If a second string is passed in, it is considered a request for a
specific path and the following types are recognized:

-  
   -  apps - Applications menu (.desktop files).
   -  autostart - Autostart directories (both XDG and kde-specific)
   -  cache - Cached information (e.g. favicons, web-pages)
   -  cgi - CGIs to run from kdehelp.
   -  config - Configuration files.
   -  data - Where applications store data.
   -  emoticons - Emoticons themes
   -  exe - Executables in $prefix/bin. findExe() for a function that
      takes $PATH into account.
   -  html - HTML documentation.
   -  icon - Icons, see KIconLoader.
   -  kcfg - KConfigXT config files.
   -  lib - Libraries.
   -  locale - Translation files for KLocale.
   -  mime - Mime types defined by KDE-specific .desktop files.
   -  module - Module (dynamically loaded library).
   -  qtplugins - Qt plugins (dynamically loaded objects for Qt)
   -  services - Services.
   -  servicetypes - Service types.
   -  sound - Application sounds.
   -  templates - Templates for the "Create new file" functionality.
   -  wallpaper - Wallpapers.
   -  tmp - Temporary files (specific for both current host and current
      user)
   -  socket - UNIX Sockets (specific for both current host and current
      user)
   -  xdgconf-menu - Freedesktop.org standard location for menu layout
      (.menu) files.
   -  xdgdata-apps - Freedesktop.org standard location for application
      desktop files.
   -  xdgdata-dirs - Freedesktop.org standard location for menu
      descriptions (.directory files).
   -  xdgdata-mime - Freedesktop.org standard location for MIME type
      definitions.
   -  xdgdata-icon - Freedesktop.org standard location for icons.
   -  xdgdata-pixmap - Gnome-compatibility location for pixmaps.

The second parameter should be a specific resource to find the path to.
An example might be userDataPath("data", "plasma-desktop").

## External Configuration Files

Scripting version >=6

Access to configuration files outside of the application's appletsrc
file is provided by the ConfigFile object which has the following
constructors:

-  `ConfigFile(ConfigFile other)`: creates a new ConfigFile object with
   the first as its parent, which automatically makes all groups of this
   object child groups of that parent
-  `ConfigFile(string file[, string group])`: creates a new ConfigFile
   object for file and optionally set to group group

ConfigFile has the following functions:

-  `writeEntry(string key, any value)`: writes value for key in the
   current group
-  `readEntry(string key)`: returns the value of key in the current
   group
-  `deleteEntry(key)`: deletes key in the current group

ConfigFile has the following read/write properties:

-  `file`: the name of the configuration file. Maybe an absolute path or
   just a file name to be located automatically in the system's
   configuration repository.
-  `group`: the name of the current group. To get to child groups,
   create a new ConfigFile with another ConfigFile as its parent.

ConfigFile has the follow read-only properties:

-  `entryList`: all the keys in the current group
-  `groupList`: all the child groups in the current group

Example usage:

```js
// open the kickoffrc file
const config = ConfigFile('kickoffrc');
// switch to the RecentlyUsed group
config.group = 'RecentlyUsed';
// write an entry into it
config.writeEntry('MaxApplications', 25);

// now put Yes=20 into RecentlyUsed/Test
const config2 = ConfigFile(config, 'Test');
config2.writeEntry('Yes', 20);
```

## Misc. Global Properties and Functions

Read-write properties:

-  `boolean locked`: whether the desktop shell and widgets are
   locked or not
-  `string theme`: (scripting version >= 3) the name of the desktop
   theme to use for the interface, e.g. default, Air, Oxygen, etc.

Read-only properties:

-  `boolean hasBattery`: whether or not the system has the ability
   to run on battery power, e.g. a laptop or mobile device
-  `boolean multihead`: (scripting version >= 3) true if the system
   is running with multiple screens in a "Xaphod" multiple display
   server configuration
-  `int multiheadScreen`: (scripting version >= 3) if multihead is
   true, contains the (real) screen id of the current screen

Functions:

-  `sleep(number ms)`: sleeps the script for the specified number of
   milliseconds

## QRectF

A rectangle class is also provided for use with Widget, Panel and screen
geometry properties and functions.

Read-only properties:

-  `boolean empty`: true if the rectangle's width or height is less
   than, or equal to, 0; an empty rectangle is also invalid
-  `boolean null`: true if the rectangle has both the width and the
   height set to 0; a null rectangle is also empty and not valid
-  `boolean valid`: true if the rectangle has a width > 0 and height
   0.

Read-write properties:

-  `number left`
-  `number top`
-  `number bottom`
-  `number right`
-  `number height`
-  `number width`
-  `number x`
-  `number y`

Constructors:

- `QRectF`
- `QRectF(number x, number y, number width, number height)`: Sets the
  coordinates of the rectangle's top-left corner to (x, y), and its
  size to the given width and height.

Functions:

- `adjust(number dx1, number dy1, number dx2, number dy2)`: adds dx1,
  dy1, dx2 and dy2 respectively to the existing coordinates of the
  rectangle
- `QRectF adjusted(number dx1, number dy1, number dx2, number dy2)`:
  returns a new QRectF with dx1, dy1, dx2 and dy2 added
  respectively to the existing coordinates of the rectangle
- `translate(number dx, number dy)`: translates the rect by dx, dy
- `setCoords(number x1, number y1, number x2, number y2)`: sets the
  coordinates of the rectangle's top-left corner to (x1, y1), and the
  coordinates of its bottom-right corner to (x2, y2).
- `setRect(number x, number y, number width, number height)`: sets
  the coordinates of the rectangle's top-left corner to (x, y), and its
  size to the given width and height.
- `boolean contains(number x, number y)`: returns true if the rect
  contains the point (x, y)
- `moveBottom(number delta)`: moves the bottom by delta pixels
- `moveLeft(number delta)`: moves the left by delta pixels
- `moveRight(number delta)`: moves the right by delta pixels
- `moveTo(number x, number y)`: moves the top left of the rect to
  point (x, y)
- `moveTop(number delta)`: moves the top by delta pixels
