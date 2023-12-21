---
title: Color
weight: 1
---

Purpose
-------

Color is a distinguishing quality of human perception. Color can be used
to communicate and draw attention efficiently. Color can assign
significance to an object. However, color is a historical and cultural
phenomenon and is subject to continuous aesthetical changes. It should
also be noted that a large part of the population cannot perceive color
in the same way that most people will.

A consistent color set helps create a familiar visual language
throughout the user interface.

{{< compare md="true">}}
![System settings with Breeze color theme](/hig/Systemsettings.png)
![System settings with Breeze Dark color theme](/hig/Systemsettings-dark.png)
{{< /compare >}}

Guidelines
----------

-   While the system color theme can be selected by the user, the
    [Breeze color palette]({{< relref "default" >}}) is
    used for the reference visual design of KDE Applications and
    Workspaces, and make up the default system color theme.
    -   Primary colors are used throughout the main interface of the
        applications and workspaces. **Plasma Blue** is used as the
        primary highlight color.
    -   Secondary colors are used sparingly as accents throughout the
        visual design.
    -   Whenever transparency is used (e.g. shadows) consider using the
        opacities listed.
-   Avoid using color as a primary method of communication. Color is
    best used as a secondary method to reinforce meaning visually. You
    should not only rely on color to convey meaning but also typography,
    layout, sizes, etc.
-   Ensure sufficient contrast between foreground and background colors.
-   Keep in mind accessibility for users with color vision deficiency
    (\~5% population). Use one of the many available online color
    blindness simulators to ensure colors intended to be distinguishable
    remain distinguishable for color-blind users.

Implementation
--------------

### Qt Widgets

-   When implementing colors in your application, select the appropriate
    theme color or system color from the palette provided by the Qt or
    KDE Platform/Frameworks library. You can use the
    [CheckColorRoles](https://store.kde.org/p/1001640/) theme to detect
    bugs regarding the use of system colors in your application.
-   [KColorScheme](http://api.kde.org/frameworks-api/frameworks5-apidocs/kconfigwidgets/html/classKColorScheme.html)
    provides methods to pick the colors from the system color scheme to
    avoid hardcoding colors where possible.

### Kirigami

{{< readfile file="/content/hig//examples/kirigami/UseTheme.qml" highlight="qml" >}}

### Plasma components

In Plasmoids use
[PlasmaCore.Theme](https://api.kde.org/frameworks/plasma-plasma-framework/html/classPlasma_1_1QuickTheme.html)
to pick theme colors.

Color Mapping
-------------

The Breeze color palettes maps to the KColorScheme color roles as shown
as follow:

