---
title: "Plasma themes and plugins"
group: "plasma"
description: >
  How to customize plasma with widgets, themes and icons
aliases:
  - /docs/use/plasma/
weight: 3
---

The KDE wiki has a [few tutorials](https://techbase.kde.org/Development/Tutorials/Plasma5) that haven't been ported to https://develop.kde.org yet.

Plasma is very modular, made up of themable widgets that can be added, removed, re-arranged, and customized. Pre-installed widgets and themes are stored at `/usr/share/plasma/`, while third-party widgets and themes are stored in the user's home directory at `~/.local/share/plasma/`.

## **Global Theme**

Formerly called a "Look and Feel", it bundles a [Panel Layout Template]({{< ref "#panel-layout-template" >}}), an [Icon Theme]({{< ref "#icon-theme" >}}), a [Plasma Style]({{< ref "#plasma-style" >}}) (and its [Color Scheme]({{< ref "#color-scheme" >}})), a [Task Switcher]({{< ref "#task-switcher" >}}), a [Splash Screen]({{< ref "#splash-screen" >}}), a lock screen theme, or any combination thereof.

* System/Default: `/usr/share/plasma/look-and-feel/` ([GitLab](https://invent.kde.org/plasma/plasma-workspace/-/tree/master/lookandfeel))
* User Installed: `~/.local/share/plasma/look-and-feel/` ([KDE Store Category](https://store.kde.org/browse/cat/121/order/latest/))
* [Tutorial](https://userbase.kde.org/Plasma/Create_a_Global_Theme_Package)

## **Plasma Style**

Also called a Desktop Theme or a Plasma Theme, it controls the visual styling of panels, widgets, OSD popups, the lock screen, and the logout screen. Plasma Styles can also include their own color scheme that overrides the systemwide color scheme for Plasma UI elements.

* System/Default: `/usr/share/plasma/desktoptheme/` ([GitLab](https://invent.kde.org/plasma/libplasma/-/tree/master/src/desktoptheme))
* User Installed: `~/.local/share/plasma/desktoptheme/` ([KDE Store Category](https://store.kde.org/browse/cat/104/order/latest/))
* [Tutorial]({{< ref theme >}})

## **Color Scheme**

A list of colors in plain INI format that define the colors to be used for UI elements that follow the systemwide color scheme. These typically consist of KDE/Qt apps, GTK apps themed with the Breeze GTK theme, and Plasma UI elements when using a Plasma style that respects the systemwide color scheme.

* Usually set in the `colors` file in a Plasma Style.
* System/Default: `/usr/share/color-schemes/` ([GitLab](https://invent.kde.org/plasma/breeze/-/tree/master/colors))
* User Installed: `~/.local/share/color-schemes/` ([KDE Store Category](https://store.kde.org/browse/cat/112/order/latest/))
* When a color scheme is applied, its values are copied to `~/.config/kdeglobals` and [`kde-gtk-config`](https://invent.kde.org/plasma/kde-gtk-config) will automatically sync colors to the Breeze GTK Theme in `~/.config/gtk-3.0/colors.css`
* [Documentation](https://docs.kde.org/stable5/en/plasma-workspace/kcontrol/colors/index.html)

## **Icon Theme**

A collection of icon files in different sizes that follows the [Freedesktop specification](https://specifications.freedesktop.org/icon-theme-spec).

* System/Default: `/usr/share/icons/` ([GitLab](https://invent.kde.org/frameworks/breeze-icons))
* User Installed: `~/.local/share/icons/` ([KDE Store Category](https://store.kde.org/browse/cat/132/order/latest/))

## **Panel Layout Template**

A [Plasma Script]({{< ref "scripting" >}}) written in JavaScript that defines a specific panel layout, accessed when right-clicking the desktop and selecting "Add Panel".

* System/Default: `/usr/share/plasma/layout-templates/` ([GitLab](https://invent.kde.org/plasma/plasma-desktop/-/tree/master/layout-templates))
* User Installed: `~/.local/share/plasma/layout-templates/`

## **Task Switcher**

A visual representation of the windows you can switch to with Alt+Tab, written in QML.

* System/Default: `/usr/share/kwin/tabbox/` ([GitLab](https://invent.kde.org/plasma/kdeplasma-addons/-/tree/master/kwin/windowswitchers))
* User Installed: `~/.local/share/kwin/tabbox/` ([KDE Store Category](https://store.kde.org/browse/cat/211/order/latest/))
* Can also be bundled in a Global Theme [like Breeze does](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/lookandfeel/contents/windowswitcher/WindowSwitcher.qml).
* [Tutorial]({{< ref windowswitcher >}})

## **Plasma Widget**

Also known as a Plasmoid, it is an interactive and self-contained piece of functionality. A Widget is essentially a small app that can be embedded within the current Plasma layout, either on the desktop or a panel. Widgets are written in QML.

* System/Default: `/usr/share/plasma/plasmoids/`
* User Installed: `~/.local/share/plasma/plasmoids/` ([KDE Store Category](https://store.kde.org/browse/cat/418/order/latest/))
* [Tutorial]({{< ref widget >}})

## **Wallpaper Plugin**

A plugin written in QML that draws the desktop wallpaper. It can be chosen and configured in the wallpaper settings window using the "Wallpaper Type" combobox.

* System/Default: `/usr/share/plasma/wallpapers/` ([GitLab](https://invent.kde.org/plasma/plasma-workspace/-/tree/master/wallpapers))
* User Installed: `~/.local/share/plasma/wallpapers/`

## **Window Decoration**

Handles the theme and button style of the window titlebar. A window decoration can be created by editing SVG files (Aurorae) or by writing a C++ plugin ([KDecoration](docs:kdecoration2)).

* System/Default: `/usr/share/aurorae/themes/` (usually empty)
* User Installed: `~/.local/share/aurorae/themes/` ([KDE Store Category](https://store.kde.org/browse/cat/114/order/latest/))
* The default [Breeze decoration](https://invent.kde.org/plasma/breeze/-/tree/master/kdecoration) is a C++ plugin implementing the [KDecoration2 API](docs:kdecoration2).
* Aurorae is a theming engine which allows to create window decorations based on SVGs. [Tutorial]({{< ref aurorae >}})
* Aurorae can also load QML-based themes.

## **KWin Effect**

Also known as a Desktop Effect, it applies visual changes to any area of the screen. KWin effects can be purely visual (e.g. an animation during window events, like "minimize") or they can be interactive with their own rich UI (e.g. the "Overview" effect).

* System/Default: `/usr/share/kwin/effects/` ([GitLab](https://invent.kde.org/plasma/kwin/-/tree/master/src/effects))
* User Installed: `~/.local/share/kwin/effects/` ([KDE Store Category](https://store.kde.org/browse/cat/209/order/latest/))

## **KWin Script**

A script written in JavaScript or QML that manages windows, allowing to [automatically arrange them in a grid](https://store.kde.org/p/1281790/) for example.

* System/Default: `/usr/share/kwin/scripts/` ([GitLab](https://invent.kde.org/plasma/kwin/-/tree/master/src/plugins))
* User Installed: `~/.local/share/kwin/scripts/` ([KDE Store Category](https://store.kde.org/browse/cat/210/order/latest/))
* [Tutorial]({{< ref kwin >}})
* [KWin Scripting API]({{< ref "kwin/api" >}})

## **Login Screen (SDDM)**

The theme used for the screen you see before you log into Plasma in most KDE distros. Despite the visual similarity of their Breeze themes, [SDDM](https://github.com/sddm/sddm) is not the lock screen. Lock screen themes are included within Plasma Styles.

* System/Default: `/usr/share/sddm/themes/` ([Breeze example on GitLab](https://invent.kde.org/plasma/plasma-desktop/-/tree/master/sddm-theme)) ([KDE Store Category](https://store.kde.org/browse?cat=101&ord=latest))
* Testing: `sddm-greeter --test-mode --theme /usr/share/sddm/themes/breeze`

## **Splash Screen**

The animated screen you see after you log into Plasma in most KDE distros. It is written in QML and can use images like PNGs, SVGs or GIFs.

* System/Default: `/usr/share/plasma/lookandfeel/<theme_name>/contents/splash/` ([Breeze example on Gitlab](https://invent.kde.org/plasma/plasma-workspace/-/tree/master/lookandfeel/org.kde.breeze/contents/splash))
* User Installed: `~/.local/share/plasma/look-and-feel/<theme_name>/contents/splash/` ([KDE Store Category](https://store.kde.org/browse?cat=488&ord=latest))
