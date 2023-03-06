---
title: "Plasma Themes and Plugins"
group: "plasma"
description: >
  How to customize plasma with widgets, themes and icons
aliases:
  - /docs/use/plasma/
---

The KDE wiki also has a [few tutorials](https://techbase.kde.org/Development/Tutorials/Plasma5) which haven't been ported to develop.kde.org yet.

Plasma is very modular. Plasma is shipped with preinstalled modules in your root directory `/usr/share/plasma/`, however you can also download themes/widgets to the user's home directory `~/.local/share/plasma/`.

* **Plasma Style** (formerly called Desktop Theme) controls the panel/widget look.
    * System/Default `/usr/share/plasma/desktoptheme/` ([GitLab](https://invent.kde.org/frameworks/plasma-framework/-/tree/master/src/desktoptheme))
    * User Installed `~/.local/share/plasma/desktoptheme/` ([KDE Store Category](https://store.kde.org/browse/cat/104/order/latest/))
    * [Tutorial]({{< ref theme >}})
* **Color Scheme** (misc colors for Qt5 apps)
    * Usually set in the `colors` file in a plasma style (desktop theme).
    * System/Default `/usr/share/color-schemes/` ([GitLab](https://invent.kde.org/plasma/breeze/-/tree/master/colors))
    * User Installed `~/.local/share/color-schemes/` ([KDE Store Category](https://store.kde.org/browse/cat/112/order/latest/))
    * When a color theme is applied, its values are copied to `~/.config/kdeglobals` and [`kde-gtk-config`](https://invent.kde.org/plasma/kde-gtk-config) will automatically sync colors to the Breeze GTK Theme in `~/.config/gtk-3.0/colors.css`
    * [Documentation](https://docs.kde.org/trunk5/en/plasma-workspace/kcontrol/colors/index.html)
* **Icon Theme**
    * System/Default `/usr/share/icons/` ([GitLab](https://invent.kde.org/frameworks/breeze-icons))
    * User Installed `~/.local/share/icons/` ([KDE Store Category](https://store.kde.org/browse/cat/132/order/latest/))
* **Mouse Cursor Theme**
    * [Tutorial](https://userbase.kde.org/Create_your_own_mouse_cursor_theme)
* **Task Switcher** (Alt+Tab)
    * System/Default `/usr/share/kwin/tabbox/` ([GitLab](https://invent.kde.org/plasma/kdeplasma-addons/-/tree/master/windowswitchers))
    * User Installed `~/.local/share/kwin/tabbox/` ([KDE Store Category](https://store.kde.org/browse/cat/211/order/latest/))
    * Can also be bundled in a Global Theme [like Breeze does](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/lookandfeel/contents/windowswitcher/WindowSwitcher.qml).
    * [Tutorial]({{< ref windowswitcher >}})
* **Plasma Widget** (a.k.a. Plasmoid) is a small visual plugin in the panel or desktop. 
    * System/Default `/usr/share/plasma/plasmoids/`
    * User Installed `~/.local/share/plasma/plasmoids/` ([KDE Store Category](https://store.kde.org/browse/cat/418/order/latest/))
    * [Tutorial]({{< ref widget >}})
* **Panel Layout Template** is a [Plasma Script](https://userbase.kde.org/KDE_System_Administration/PlasmaDesktopScripting) that generate a panel like "Add Panel > Default Panel".
    * System/Default `/usr/share/plasma/layout-templates/` ([GitLab](https://invent.kde.org/plasma/plasma-desktop/-/tree/master/layout-templates))
    * User Installed `~/.local/share/plasma/layout-templates/`
* **Wallpaper Plugin** is a plugin that draws the desktop wallpaper.
    * System/Default `/usr/share/plasma/wallpapers/` ([GitLab](https://invent.kde.org/plasma/plasma-workspace/-/tree/master/wallpapers))
    * User Installed `~/.local/share/plasma/wallpapers/`
* **Window Decoration** is the window titlebar.
    * System/Default `/usr/share/aurorae/themes/` (empty usually)
    * User Installed `~/.local/share/aurorae/themes/` ([KDE Store Category](https://store.kde.org/browse/cat/114/order/latest/))
    * The default [Breeze decoration](https://invent.kde.org/plasma/breeze/-/tree/master/kdecoration) is a C++ plugin implementing the [KDecoration2 API](docs:kdecoration2). 
    * Aurorae is a theming engine which allows to create window decorations based on SVGs. [Tutorial]({{< ref aurorae >}})
    * Aurorae can also load QML-based themes.
* **KWin Effect** applies an animation during window events (e.g. minimize).
    * System/Default `/usr/share/kwin/effects/` ([GitLab](https://invent.kde.org/plasma/kwin/-/tree/master/src/effects))
    * User Installed `~/.local/share/kwin/effects/` ([KDE Store Category](https://store.kde.org/browse/cat/209/order/latest/))
* **KWin Script** manages windows to, for example, [automatically arrange them in a grid](https://store.kde.org/p/1281790/).
    * System/Default `/usr/share/kwin/scripts/` ([GitLab](https://invent.kde.org/plasma/kwin/-/tree/master/src/scripts))
    * User Installed `~/.local/share/kwin/scripts/` ([KDE Store Category](https://store.kde.org/browse/cat/210/order/latest/))
    * [Tutorial]({{< ref kwin >}})
    * [API]({{< ref "kwin/api" >}})
* **Global Theme** (formerly called Look and Feel) can switch a panel layout, Icon Theme, Plasma Style, etc. It also contains the splash screen on login, and the lock screen.
    * System/Default `/usr/share/plasma/look-and-feel/` ([GitLab](https://invent.kde.org/plasma/plasma-workspace/-/tree/master/lookandfeel))
    * User Installed `~/.local/share/plasma/look-and-feel/` ([KDE Store Category](https://store.kde.org/browse/cat/121/order/latest/))
    * [Tutorial](https://userbase.kde.org/Plasma/Create_a_Global_Theme_Package)
* **Login Screen (SDDM)** is the screen you see before you login to Plasma in most KDE distros. [SDDM](https://github.com/sddm/sddm) is not the lock screen.
    * System/Default `/usr/share/sddm/themes/`
    * Breeze Theme ([GitLab](https://invent.kde.org/plasma/plasma-workspace/-/tree/master/sddm-theme))
    * Testing: `sddm-greeter --test-mode --theme /usr/share/sddm/themes/breeze`
