---
title: "Plasma Themes and Plugins"
group: "getting-started"
description: >
  How to customize plasma with widgets, themes and icons
---

The KDE wiki also has a [few tutorials](https://techbase.kde.org/Development/Tutorials/Plasma5) which haven't been ported to develop.kde.org yet.

Plasma is very modular. Plasma is shipped with preinstalled modules in your root directory `/usr/share/plasma/`, however you can also download themes/widgets to the user's home directory `~/.local/share/plasma/`.

* **Plasma Style** (formerly called Desktop Theme) controls the panel/widget look.
    * System/Default `/usr/share/plasma/desktoptheme/`
    * User Installed `~/.local/share/plasma/desktoptheme/` ([KDE Store Category](https://store.kde.org/browse/cat/104/order/latest/))
* **Color Theme** (misc colors for Qt5 apps)
    * Usually set in the `colors` file in a plasma style (desktop theme).
    * When a color theme is applied, it's values are copied to `~/.config/kdeglobals`
* **Icon Theme**
    * System/Default `/usr/share/icons/`
    * User Installed `~/.local/share/icons/` ([KDE Store Category](https://store.kde.org/browse/cat/132/order/latest/))
* **Task Switcher** (Alt+Tab)
    * System/Default `/usr/share/kwin/tabbox/`
    * User Installed `~/.local/share/kwin/tabbox/` ([KDE Store Category](https://store.kde.org/browse/cat/211/order/latest/))
    * Can also be bundled in a Global Theme [like Breeze does](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/lookandfeel/contents/windowswitcher/WindowSwitcher.qml).
    * Tutorial: [techbase.kde.org/Development/Tutorials/KWin/WindowSwitcher](https://techbase.kde.org/Development/Tutorials/KWin/WindowSwitcher)
* **Plasma Widget** (aka Plasmoid) is a small visual plugin in the panel or desktop. 
    * System/Default `/usr/share/plasma/plasmoids/`
    * User Installed `~/.local/share/plasma/plasmoids/` ([KDE Store Category](https://store.kde.org/browse/cat/418/order/latest/))
* **Panel Layout Template** is a [Plasma Script](https://userbase.kde.org/KDE_System_Administration/PlasmaDesktopScripting) that generate a panel like "Add Panel > Default Panel".
    * System/Default `/usr/share/plasma/layout-templates/`
    * User Installed `~/.local/share/plasma/layout-templates/`
* **Wallpaper Plugin** is a plugin that draws the desktop wallpaper.
    * System/Default `/usr/share/plasma/wallpapers/`
    * User Installed `~/.local/share/plasma/wallpapers/`
* **KWin Effect** applies an animation during window events (eg: minimize).
    * System/Default `/usr/share/kwin/effects/`
    * User Installed `~/.local/share/kwin/effects/` ([KDE Store Category](https://store.kde.org/browse/cat/209/order/latest/))
* **KWin Script** manages windows using [KWin Scripting](https://techbase.kde.org/Development/Tutorials/KWin/Scripting) to [arrange windows in a grid](https://store.kde.org/p/1281790/), or [display all windows at a glance](https://store.kde.org/p/1370195/).
    * System/Default `/usr/share/kwin/scripts/`
    * User Installed `~/.local/share/kwin/scripts/` ([KDE Store Category](https://store.kde.org/browse/cat/210/order/latest/))
    * API: [techbase.kde.org/Development/Tutorials/KWin/Scripting/API_4.9](https://techbase.kde.org/Development/Tutorials/KWin/Scripting/API_4.9)
* **Global Theme** (formerly called Look and Feel) can switch a panel layout, Icon Theme, Plasma Style, etc.
    * System/Default `/usr/share/plasma/look-and-feel/`
    * User Installed `~/.local/share/plasma/look-and-feel/` ([KDE Store Category](https://store.kde.org/browse/cat/121/order/latest/))
