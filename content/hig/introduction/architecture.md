---
title: Architecture
weight: 1
description: All KDE software is built using the Qt Toolkit. 
---


You will use different components depending on whether you
are developing an [application](https://apps.kde.org/) or
[Plasma](https://kde.org/plasma-desktop), and the nature of your
application. The HIG interaction patterns apply regardless of the
components you use.

KDE Applications
----------------

Qt offers two ways of defining the application user interface (UI). Which one to choose
depends on the nature of your application. The application logic is
written in C++ (or other supported languages) regardless of the kind of application created.

### Qt Widgets

[Qt Widgets](http://doc.qt.io/qt-5/qtwidgets-index.html) is the
traditional way of writing Qt applications. It is best suited for
traditional desktop applications with complex interfaces, e.g. KDevelop.

### QML/QtQuick/Kirigami

QML/QtQuick is the modern way of developing Qt applications. It features
a declarative approach to writing touch and mobile friendly UIs with
fluent gestures. QML/QtQuick is best suited for mobile and convergent
applications.

[Kirigami](https://www.kde.org/products/kirigami/) builds on top of
QtQuick and helps you write convergent applications. It features
controls that adapt their presentation according to the device\'s form
factor.

![Discover, a convergent application built using
Kirigami](/frameworks/kirigami/kirigami-adapt.png)

{{< alert title="Hint" color="info" >}}

To test qml scenes use

-   `QT_QUICK_CONTROLS_MOBILE=1` and `QT_QUICK_CONTROLS_STYLE=Plasma`
    for mobile
-   `QT_QUICK_CONTROLS_MOBILE=0` and
    `QT_QUICK_CONTROLS_STYLE=org.kde.desktop` for desktop
{{< /alert >}}

Plasma
------

Plasma is built using widgets (also called Plasmoids), allowing you to
move, mix, add, and remove to fit the user's workflow. These widgets are built with [Plasma Components](https://api.kde.org/frameworks/plasma-plasma-framework/html/plasmacomponents.html) and [Kirigami](https://www.kde.org/products/kirigami/).

![Plasma desktop and mobile.](/hig/plasma-workspace.jpg)

Common Components
-----------------

The KDE HIG defines a set of common components independent of
any [device type]({{< relref "devicetypes" >}}).

![](/hig/Desktop_UX.png)

-   **Workspace**: The top-level container of the whole user interface.
    Often called "desktop", "home screen", or "shell", it shows
    the wallpaper and allows users to add widgets, app launchers, files
    and folders.

-   **Application Launcher**: Provides an overview of installed
    applications and allows the user to launch applications.

-   **Application Shortcuts**: Provides quick access to frequently-used
    applications.

-   **Active Application Overview**: Gives the user a window arrangement for active applications allowing the user to search, select, and close said application.

-   **Workspace Tools**: Provides quick access to functionality
    integrated into the workspace that is both highly visible to the
    user and frequently changed. For example, enabling/disabling WiFi, or
    Bluetooth, or show notifications.

-   **Application-Workspace Interaction**: Displays information about
    each application's windows, and provides ways to move or close them
    and change how they run within the workspace.

-   **Application**: The top-level container of a single application.

-   **Application Tools**: Provides access to an application\'s
    commonly-used functionality in an always-accessible toolbar or
    menubar. These tools should not change based on what the
    application shows.

-   **Application Content**: The actual content of an application. This
    depends on the application itself, but conformance to the KDE HIG
    should make it easier to allow
    [convergence]({{< relref "convergence" >}}) for this
    component. This part of the application can also contain
    contextually-appropriate tools that operate directly on the active
    or selected content.

![](/hig/Mobile-UX.png)

Theme
-----

There are three different kinds of themes influencing the the
look-and-feel of KDE applications and the Plasma workspace.

-   Workspace
-   Application
-   Window decoration

The default for all three is the *Breeze* theme.

{{< alert title="Note" color="info" >}}
Only *Breeze* is
covered by the HIG; other 3rd-party themes are not covered.
{{< /alert >}}

![Overview of breeze controls](/hig/breeze.jpeg)
