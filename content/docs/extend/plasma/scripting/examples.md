---
title: Examples
weight: 2
description: Some examples of using Plasma scripting capability
aliases:
  - /docs/plasma/scripting/examples/
---

## Iterate all widgets and print their config values

```js
var allDesktops = desktops();
for (var desktopIndex = 0; desktopIndex < allDesktops.length; desktopIndex++) {
    var d = allDesktops[desktopIndex];
    print(d);

    var widgets = d.widgets();
    for (var widgetIndex = 0; widgetIndex < widgets.length; widgetIndex++) {
        var w = widgets[widgetIndex];
        print("\t" + w.type + ": ");

        var configGroups = w.configGroups.concat([]); // concat is used to clone the array
        for (var groupIndex = 0; groupIndex < configGroups.length; groupIndex++) {
            var g = configGroups[groupIndex];
            print("\t\t" + g + ": ");
            w.currentConfigGroup = [g];

            for (var keyIndex = 0; keyIndex < w.configKeys.length; keyIndex++) {
                var configKey = w.configKeys[keyIndex];
                print("\t\t\t" + configKey + ": " + w.readConfig(configKey));
            }
        }
    }
}

var allPanels = panels();
for (var panelIndex = 0; panelIndex < allPanels.length; panelIndex++) {
    var p = allPanels[panelIndex];
    print(p);

    var widgets = p.widgets();
    for (var widgetIndex = 0; widgetIndex < widgets.length; widgetIndex++) {
        var w = widgets[widgetIndex];
        print("\t" + w.type + ": ");

        var configGroups = w.configGroups.concat([]); // concat is used to clone the array
        for (var groupIndex = 0; groupIndex < configGroups.length; groupIndex++) {
            var g = configGroups[groupIndex];
            print("\t\t" + g + ": ");
            w.currentConfigGroup = [g];

            for (var keyIndex = 0; keyIndex < w.configKeys.length; keyIndex++) {
                var configKey = w.configKeys[keyIndex];
                print("\t\t\t" + configKey + ": " + w.readConfig(configKey));
            }
        }
    }
}
```


## Print config values for each instance of a specific widget

```js
function forEachWidgetInContainmentList(containmentList, callback) {
    for (var containmentIndex = 0; containmentIndex < containmentList.length; containmentIndex++) {
        var containment = containmentList[containmentIndex];

        var widgets = containment.widgets();
        for (var widgetIndex = 0; widgetIndex < widgets.length; widgetIndex++) {
            var widget = widgets[widgetIndex];
            callback(widget, containment);
            if (widget.type === "org.kde.plasma.systemtray") {
                systemtrayId = widget.readConfig("SystrayContainmentId");
                if (systemtrayId) {
                    forEachWidgetInContainmentList([desktopById(systemtrayId)], callback)
                }
            }
        }
    }
}

function forEachWidget(callback) {
    forEachWidgetInContainmentList(desktops(), callback);
    forEachWidgetInContainmentList(panels(), callback);
}

function forEachWidgetByType(type, callback) {
    forEachWidget(function(widget, containment) {
        if (widget.type == type) {
            callback(widget, containment);
        }
    });
}

function logWidget(widget) {
    print("" + widget.type + ": ");

    var configGroups = widget.configGroups.slice(); // slice is used to clone the array
    for (var groupIndex = 0; groupIndex < configGroups.length; groupIndex++) {
        var configGroup = configGroups[groupIndex];
        print("\t" + configGroup + ": ");
        widget.currentConfigGroup = [configGroup];

        for (var keyIndex = 0; keyIndex < widget.configKeys.length; keyIndex++) {
            var configKey = widget.configKeys[keyIndex];
            var configValue = widget.readConfig(configKey);
            print("\t\t" + configKey + ": " + configValue);
        }
    }
}

//--- Log all widgets
// forEachWidget(function(widget){
//     logWidget(widget);
// });

//--- Log only keyboardlayout widgets
forEachWidgetByType("org.kde.plasma.keyboardlayout", function(widget){
    logWidget(widget);
});
```


## Adding a widget to the System Tray

```js
var widgetName = "org.kde.plasma.printmanager";

for (i = 0; i < panelIds.length; ++i) { //search through the panels
    panel = panelById(pids[i]);
    if (!panel) continue;

    for (tmpIndex = 0; tmpIndex < panel.widgetIds.length; tmpIndex ++) {
        appletWidget = panel.widgetById(panel.widgetIds[tmpIndex]);

        if (appletWidget.type == "org.kde.plasma.systemtray") {
            systemtrayId = appletWidget.readConfig("SystrayContainmentId");
            if (systemtrayId) {
               print("systemtray id: " + systemtrayId)
               var systray = desktopById(systemtrayId);
               systray.currentConfigGroup = ["General"];
               var extraItems = systray.readConfig("extraItems").split(",");
               if (extraItems.indexOf(widgetName) === -1) {
                   extraItems.push(widgetName)
                   systray.writeConfig("extraItems", extraItems);
                   systray.reloadConfig();
               }
            }
        }
    }
}
```

## Changing a config value for each instance of a specific widget

```js
// See previous examples for these functions.
function forEachWidgetInContainmentList(containmentList, callback) { ... }
function forEachWidget(callback) { ... }
function forEachWidgetByType(type, callback) { ... }

function widgetSetProperty(args) {
    if (!(args.widgetType && args.configGroup && args.configKey)) {
        return;
    }

    forEachWidgetByType(args.widgetType, function(widget){
        widget.currentConfigGroup = [args.configGroup];

        //--- Delete when done debugging
        const oldValue = widget.readConfig(args.configKey);
        print("" + widget.type + " (id: " + widget.id + "):");
        print("\t[" + args.configGroup + "] " + args.configKey + ": " + oldValue + " => " + args.configValue);
        //--- End Debug

        widget.writeConfig(args.configKey, args.configValue);
    });
}

widgetSetProperty({
    widgetType: "org.kde.plasma.digitalclock",
    configGroup: "Appearance",
    configKey: "showDate",
    configValue: "true",
});
```

## Panel Creation / Manipulation

The items in Plasma's "New Panel" submenu will run a Plasma Script. They can be found at:

* `/usr/share/plasma/layout-templates/`
* `/usr/share/plasma/layout-templates/org.kde.plasma.desktop.defaultPanel/contents/layout.js`

Here's `org.kde.plasma.desktop.appmenubar/contents/layout.js` as a simple example.

```js
const panel = new Panel
panel.location = "top";
panel.height = Math.round(gridUnit * 1.5);

panel.addWidget("org.kde.plasma.appmenu");

```
