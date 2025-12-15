---
title: Plasma menu favorites
group: administration
description: Customize your system menu for Plasma deployments
---

Plasma menus can be customized for use by distributions or companies seeking to deploy Plasma in their workstations. One common customization is to set a default favorites list to include some branding software, like custom Linux distribution extensions or hardware manufacturer software.

The favorites menu can be prepended or appended with additional applications. If the default favorite applications provided by Plasma do not match your needs, you may ignore the defaults and use only the applications that were prepended or appended to the menu.

This change should apply to all Plasma menus for new users.

Add a new file `/etc/xdg/kicker-extra-favoritesrc`:

```ini
[General]
Prepend=org.kde.filelight.desktop;org.kde.drkonqi.coredump.gui.desktop
Append=org.kde.dragonplayer.desktop
IgnoreDefaults=false
```


