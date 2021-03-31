---
title: "Colors and Themes in Kirigami"
linkTitle: "Colors "
weight: 101
group: style
description: >
  Make your app follow you user color scheme
---

Kirigami has a color palette that follow the system colors, to better integrate 
on the platform it is running on (i.e. Plasma Desktop, Plasma Mobile, 
GNOME, Android, etc.).

All of Kirigami's QML components and
all the Qt Quick Controls 2 QML components will already 
follow this palette by default, so usually no custom coloring should be needed 
at all for those controls.

Primitive components such as `Rectangle` should always be colored with the 
color palette provided by Kirigami via the [`Theme`](docs:kirigami2;Theme) attached property.

Hardcoded colors in QML, such as `#32b2fa` or `red` should usually be 
avoided; if it is really necessary to have elements with custom colors, it should 
be an area where only custom colors are used (usually in the content area 
of the app, and never in the chrome such as toolbars or dialogs), for instance 
a hardcoded `black` foreground cannot be used over a 
`Kirigami.Theme.backgroundColor` background, because if the platform uses a 
dark color scheme the result will look poor contrasting black over almost black.

## Theme

For more information about the Kirigami Theme class, see the [API docs](docs:kirigami2;Kirigami::PlatformTheme)

`Kirigami.Theme` is an attached property, therefore is available to use in 
any QML item. It contains as properties all the colors available in the 
palette, and what 
palette to use, as the `colorSet` property.

Example:

```qml
import QtQuick 2.11
import org.kde.kirigami 2.9 as Kirigami

Rectangle {
    color: Kirigami.Theme.backgroundColor
}
```

<!-- TODO
screenshot of a qml file with an annotated UI showing all the 
available color
-->

## Color Set

Depending on where a control is located, it should use a different color set: for 
instance, (with the Breeze light color theme) in itemviews, the normal 
background is almost white, while in other regions, such as toolbars or 
dialogs, the normal background color is gray.

If you set a color set for an item, all of its child items (recursively)
 will inherit it automatically (unless the property `inherit` has 
explicitly been set to `false`, which should always be done when the developer 
wants to force a specific color set) so it is easy to change colors for an 
entire hierarchy of items without touching any of the items themselves.

`Kirigami.Theme` supports 5 different color sets:

* View: Color set for item views, usually the lightest of all
  (in light color themes)
* Window: **Default** Color set for windows and "chrome" areas
* Button: Color set used by buttons
* Selection: Color set used by selected areas
* Tooltip: Color set used by tooltips
* Complementary: Color set meant to be complementary to Window: usually
  is dark even in light themes. May be used for "emphasis" in small
  areas of the application

Example:

```qml
import QtQuick 2.11
import QtQuick.Controls 2.2 as Controls
import org.kde.kirigami 2.9 as Kirigami

// The comments assume the system uses the Breeze Light color theme 
...
Rectangle {
    // A gray color will be used, as the default color set is Window
    color: Kirigami.Theme.backgroundColor

    Controls.Label {
        // The text will be near-black, as is defined in the Window 
        // color set
        text: i18n("hello")
    }

    Rectangle {
        ...
        // Use the set for ItemViews
        Kirigami.Theme.colorSet: Kirigami.Theme.View  

        // Do not inherit from the parent
        Kirigami.Theme.inherit: false

        // This will be a near-white color
        color: Kirigami.Theme.backgroundColor

        Rectangle {
            ...
            // This will be a near-white color too, as the colorSet 
            // is inherited from the parent and will be View
            color: Kirigami.Theme.backgroundColor

            Controls.Label {
                // The text will be near-black, as is defined in the View 
                // color set
                text: i18n("hello")
            }
        }
        Rectangle {
            ...
            // Use the Complementary set
            Kirigami.Theme.colorSet: Kirigami.Theme.Complementary  

            // Do not inherit from the parent
            Kirigami.Theme.inherit: false

            // This will be near-black as in the Complementary color set 
            // the background color is dark.
            color: Kirigami.Theme.backgroundColor  

            Controls.Label {
                // The text will be near-white, as is defined in the 
                // Complementary color set
                text: i18n("hello")
            }
        }
    }
}
```

Some components such as Labels will automatically inherit by default the color 
set, some other components have a fixed color set, for instance Buttons 
are fixed to the `Button` color set. If it's desired for the button to inherit 
the parent color set, the `inherit` property should be explicitly set to `true`:

```qml
import QtQuick 2.11
import QtQuick.Controls 2.2 as Controls
import org.kde.kirigami 2.9 as Kirigami

Controls.Button {
    Kirigami.Theme.inherit: true
    text: i18n("ok")
}
```

![Screenshot of a comparison between a button that inherits and one that does not](buttonsinherit.png)

## Using Custom Colors

Altough it's discouraged to use hardcoded colors, Kirigami offers a more 
maintainable way to assign a custom hardcoded palette to an item and all its 
children, that will allow to define such custom colors in one place and one 
only:

{{< readfile file="/content/docs/kirigami/style-colors/CustomColors.qml" highlight="qml" >}}

![Screenshot showing the code above with qmlscene, we can see two rectangles with two different colors](customcolors.png)
