---
title: Plasma Desktop Scripting
weight: 3
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

There are three ways that scripts can be executed in plasma-desktop:

- **on first run**: when plasma-desktop is started without any
  pre-existing configuration, any scripts in
  `$APPDATA/plasma-desktop/init/` with a ".js" suffix are run. If there
  is more than one script, they are run sequentially in the
  alphabetical order of the file names.

  {{< alert color="info" title="Note" >}}
  For security reasons, scripts located in the user's home directory will **not** be run during this phase.
  {{< /alert >}}

- **on update**: when plasma-desktop is started, it will check in `` bash $(kf5-config --path data)/plasma-desktop/updates/ ``
  with a ".js" suffix for scripts that have not yet been run. If there is
  more than one script which has not been run yet they will be executed
  serially in the alphabetical order of the file names.

  A record of which update scripts have been run is kept in the
  application's config file in the [Updates] group. This means that if the
  plasma-desktop configuration file is removed, all the update scripts
  will be run again.

  {{< alert color="info" title="Note" >}}
  For security reasons, scripts located in the user's home directory will **not** be run during this phase.
  {{< /alert >}}

- **interactively**: an interactive scripting dialog can be requested
  either via the KRunner window (Alt+F2, by default, or via the "Run
  Command" entry in various desktop menus) by entering "desktop
  console" as the search term. It can also be triggered directly via
  dbus with `qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.showInteractiveConsole`

  ECMA Script may be entered directly into this window for execution
  and output appears in the lower half of the window. Ctrl+E is a
  shortcut to run scripts, and scripts can be saved to and loaded from
  disk.

  Scripts from files can also be loaded using KRunner with "desktop
  console /path/to/file" or via dbus with `qdbus-qt5 org.kde.plasma-desktop /MainApplication loadScriptInInteractiveConsole /path/to/file`

## Update scripts

Update javascript scripts can be added per-shell at the location
`share/plasma/shells/org.kde.plasma.desktop/updates/`.

The API available from those config files is the same available from the
normal init.js file. from there is possible to add or remove applets or
modify config values.

## Global theme dependent default setup for applets

The globale theme (also know as look and feel package) can contain JavaScript
files to override the default configuration for applets, if distributions or system
integrators want to have a different default setup. The JS files are
located under the  package folder, for instance
`/opt/kde5/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/plasmoidsetupscripts/org.kde.plasma.analogclock.js`

The API available is the same as the init.js script, with the addition
of the global variables **applet** and **containment** that point to the
instance of the applet and the instance of the containment the applet is
in. In the case of a containment, the variables **applet** and
**containment** will be the same.
