---
title: "Plasma Themes and Plugins"
description: >
  How to customize plasma with widgets, themes and icons
---

The KDE wiki also has a [few tutorials](https://techbase.kde.org/Development/Tutorials/Plasma5) which haven't been ported to develop.kde.org yet.

Plasma is very modular. Plasma is shipped with preinstalled modules in your root directory `/usr/share/plasma/`, however you can also download themes/widgets to the user's home directory `~/.local/share/plasma/`.

* **Plasma Style** (formerly called Desktop Theme) controls the Panel/Widget look.
    * System/Default `/usr/share/plasma/desktoptheme/`
    * User Installed `~/.local/share/plasma/desktoptheme/`
* **Color Theme** (misc colors for Qt5 apps)
    * Usually set in the `colors` file in a desktop theme.
    * When a color theme is applied, it's values are copied to `~/.config/kdeglobals`
* **Icon Theme**
    * System/Default `/usr/share/icons/`
    * User Installed `~/.local/share/icons/`
* **Task Switcher** (Alt+Tab)
    * System/Default `/usr/share/kwin/tabbox/`
    * User Installed `~/.local/share/kwin/tabbox/`
    * Can also be bundled in a Global Theme [like Breeze does](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/lookandfeel/contents/windowswitcher/WindowSwitcher.qml).
* **Global Theme** (formerly called Look and Feel) can switch a panel layout, Icon Theme, Plasma Style, etc.
    * System/Default `/usr/share/plasma/look-and-feel/`
    * User Installed `~/.local/share/plasma/look-and-feel/`
