---
title: System Tray Icon
weight: 5
---

The system tray provides quick access to functionality integrated into
the workspace that's both highly visible to the user and frequently
changed, like enabling/disabling WiFi and Bluetooth, or whether or not
to show notifications. See
[architecture](/introduction/architecture) for an overview of plasma
workspace components.

Examples
--------

![Tray icons with an open volume control panel.](/hig/TrayWithPanel.png)

Guidelines
----------

### Is this the right control?

An application should only add an icon to the System Tray if the user
needs to frequently access the application, or if the user is interested
in status changes within the application.

### Behavior

-   On left click, open the application itself, or a panel that allows
    quick access to common features.
-   On right click, open a [context menu](/hig/components/navigation/contextmenu).
-   For application like media players, enable the user to change the
    volume while scrolling over the icon.

### Appearance

Use a [monochrome, shade black icon](/hig/style/icons/) and use color only
to communicate state.
