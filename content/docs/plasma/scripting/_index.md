---
title: Plasma Desktop scripting
weight: 3
aliases:
  - /docs/plasma/scripting/
---

## Javascript Interaction With Plasma Shells

It is possible to control and interact with a Plasma user interface shell such
as a plasma-desktop, plasma-mobile or plasma-bigscreen using ECMA Script (a.k.a
JavaScript). This scripting mechanism exposes containments (Desktop Activities and
Panels), widgets and various other aspects of plasma-desktop configuration using
the widely known and used Javascript language. The QJSEngine is used for the
runtime environment.

This document describes the API that is provided along with how to run such scripts
in plasma-desktop.

## Examples

Visit [the examples page](examples) for more examples. Here's a highlight:

### Advanced example: Adding a widget to the System Tray

```js
const widgetName = "org.kde.plasma.printmanager";

panelIds.forEach((panel) => { //search through the panels
    panel = panelById(panel);
    if (!panel) {
        return;
    }
    panel.widgetIds.forEach((appletWidget) => {
        appletWidget = panel.widgetById(appletWidget);

        if (appletWidget.type === "org.kde.plasma.systemtray") {
            systemtrayId = appletWidget.readConfig("SystrayContainmentId");
            if (systemtrayId) {
               print("systemtray id: " + systemtrayId)
               const systray = desktopById(systemtrayId);
               systray.currentConfigGroup = ["General"];
               const extraItems = systray.readConfig("extraItems").split(",");
               if (extraItems.indexOf(widgetName) === -1) {
                   extraItems.push(widgetName)
                   systray.writeConfig("extraItems", extraItems);
                   systray.reloadConfig();
               }
            }
        }
    });
});
```

## Running Scripts

There are four ways that scripts can be executed in plasma-desktop:

- **on first run**: when `plasmashell` is started without any
  pre-existing configuration, the script called `layout.js` in the shell
  package will be executed. By default the following script is used:
  ```
  /usr/share/plasma/shells/org.kde.plasma.desktop/contents/layout.js
  ```

  {{< alert color="info" title="Note" >}}
  For security reasons, scripts located in the user's home directory will **not** be run during this phase.
  {{< /alert >}}

- **on update**: when `plasmashell` is started, it will check for scripts
  with a `.js` suffix in the current shell package under the `updates` directory.
  ```bash
  /usr/share/plasma/shells/org.kde.plasma.desktop/contents/updates/digitalclock_rename_timezonedisplay_key.js
  /usr/share/plasma/shells/org.kde.plasma.desktop/contents/updates/unlock_widgets.js
  ```
  If there is more than one script which has not been run yet they will be executed
  serially in the alphabetical order of the file names.

  Some examples can be found in [`plasma-desktop` under `desktoppackage/contents/updates/`](https://invent.kde.org/plasma/plasma-desktop/-/tree/master/desktoppackage/contents/updates).

  A record of which update scripts have been run is kept in the
  application's config file in the `[Updates]` group. This means that if the
  `~/.config/plasmashellrc` file is removed, all the update scripts
  will be run again.

  ```ini
  # ~/.config/plasmashellrc
  [Updates]
  performed=/usr/share/plasma/shells/org.kde.plasma.desktop/contents/updates/obsolete_kickoffrc.js,/usr/share/plasma/shells/org.kde.plasma.desktop/contents/updates/unlock_widgets.js
  ```


  {{< alert color="info" title="Note" >}}
  For security reasons, scripts located in the user's home directory will **not** be run during this phase.
  {{< /alert >}}

- **interactively**: an interactive scripting dialog can be requested
  either via the KRunner window (`Alt+F2`, by default, or via the "Run
  Command" entry in various desktop menus) by entering "desktop
  console" as the search term.
  In Plasma versions earlier than 5.23 it can be triggered directly via dbus with:

  ```bash
  qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.showInteractiveKWinConsole
  ```

  With 5.23 or later the console can be opened using the following command:
  ```bash
  plasma-interactiveconsole
  ```

  ECMA Script may be entered directly into this window for execution
  and output appears in the lower half of the window. Ctrl+E is a
  shortcut to run scripts, and scripts can be saved to and loaded from
  disk.

  Scripts from files can also be loaded using KRunner with
  `desktop console /path/to/file` or via dbus with:
  ```bash
  qdbus org.kde.plasma-desktop /MainApplication loadScriptInInteractiveConsole /path/to/file
  ```
- **programmatically:** run a script file directly from the terminal with:
  ```bash
  qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "$(cat /path/to/file.js)"
  ```

## Global theme dependent default setup for applets

The global theme (also know as look and feel package) can contain JavaScript
files to override the default configuration for applets, if distributions or system
integrators want to have a different default setup.

The API available is the same as the `layout.js` script, with the addition
of these global variables:

* `applet`: instance of the applet. In the case of a containment plasmoid, `applet == containment`.
* `containment`: instance of the containment the applet is in.


The file is located in the `plasmoidsetupscripts` subfolder of the Global Theme package.
The file name of the setup script for the plasmoid is the same as the plugin name,
so, for instance, the file for the analog clock will be called `org.kde.plasma.analogclock.js`.
If we wanted to setup the clock to have the seconds hand by default, the script will located at:

```
/usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/plasmoidsetupscripts/org.kde.plasma.analogclock.js
```

and the script contents will be:

```js
applet.currentConfigGroup = new Array("General");
applet.writeConfig("showSecondHand", true);
applet.reloadConfig();
```

Another example can be found in the [`plasma-phone-components` repository for the `org.kde.phone.homescreen` plasmoid](https://invent.kde.org/plasma/plasma-phone-components/-/blob/master/look-and-feel/contents/plasmoidsetupscripts/org.kde.phone.homescreen.js).
