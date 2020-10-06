System Tray Icon
================

The system tray provides quick access to functionality integrated into
the workspace that's both highly visible to the user and frequently
changed, like enabling/disabling WiFi and Bluetooth, or whether or not
to show notifications. See
`architecture </introduction/architecture>`{.interpreted-text
role="doc"} for an overview of plasma workspace components.

Examples
--------

![Tray icons with an open volume control panel.](/img/TrayWithPanel.png)

Guidelines
----------

### Is this the right control?

An application should only add an icon to the System Tray if the user
needs to frequently access the application, or if the user is intrested
in status changes within the application.

### Behavior

-   On left click, open the application itself, or a panel that allows
    quick access to common features.
-   On right click, open a
    `context menu </components/navigation/contextmenu>`{.interpreted-text
    role="doc"}.
-   For application like media players, enable the user to change the
    volume while scrolling over the icon.

### Appearance

Use a
`monochrome, shade black icon </style/icons/index>`{.interpreted-text
role="doc"} and use color only to communicate state.
