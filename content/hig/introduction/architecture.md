---
title: Architecture
weight: 1
description: All KDE software is built using the Qt toolkit. 
---


You will be using different components depending on whether you
are developing an [application](https://apps.kde.org/) or
[Plasma](https://kde.org/plasma-desktop) and the nature of your
application. The interaction patterns of the HIG apply regardless of the
components you use.

KDE Applications
----------------

Qt offers two ways of defining the application UI. Which one to choose
depends on the nature of your application. The application logic is
written in C++ (or other supported languages) regardless of that.

### Qt Widgets

[Qt Widgets](http://doc.qt.io/qt-5/qtwidgets-index.html) is the
traditional way of writing Qt applications. It is best suited for
traditional desktop applications with complex UI, e.g. KDevelop.

### QML/QtQuick/Kirigami

QML/QtQuick is the modern way of developing Qt applications. It features
a declarative approach to writing touch and mobile friendly UIs with
fluent gestures. It is best suited for mobile and convergent
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

Plasma is built out of widgets (also called Plasmoids), allowing you to
move, mix, add, and remove just about everything to perfect your
personal workflow. [Those are built using Plasma Components 3](https://api.kde.org/frameworks/plasma-framework/html/plasmacomponents.html), which are based on Qt Quick Controls 2.

![Plasma desktop and mobile.](/hig/plasma-workspace.jpg)

Common Components
-----------------

The KDE HIG defines a set of common components which are independent of
any [device type]({{< relref "devicetypes" >}}).

![](/hig/Desktop_UX.png)

-   **Workspace**: The top-level container of the whole user interface.
    Often called "desktop", "home screen", or "shell", it shows
    the wallpaper and allows users to add widgets, app launchers, files
    or folders.
-   **Application Launcher**: Provides an overview of installed
    applications and allows the user to launch one of them.
-   **Application Shortcuts**: Provides quick access to frequently-used
    applications.
-   **Active Application Overview**: Provides an overview of the active
    applications that are directly used by the user.
-   **Workspace Tools**: Provides quick access to functionality
    integrated into the workspace that is both highly visible to the
    user and frequently changed, like enabling/disabling WiFi and
    Bluetooth, or whether or not to show notifications.
-   **Application-Workspace Interaction**: Displays information about
    each application's windows, and provides ways to move or close them
    and change how they run within the workspace.
-   **Application**: The top-level container of a single application.
-   **Application Tools**: Provides access to an application\'s
    commonly-used functionality in an always-accessible toolbar or
    menubar. These tools should not change depending on what the
    application is displaying.
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

The default for all there of them is *Breeze*.

{{< alert title="Note" color="info" >}}
Only *Breeze*, *Breeze dark*, *Breeze Light*, *Breeze Highcontrast* are
covered by the HIG, all other themes are not covered.
{{< /alert >}}

![Overview of breeze controls](/hig/breeze.jpeg)
