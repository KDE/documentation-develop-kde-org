---
title: "Colors and themes in Kirigami"
linkTitle: "Colors "
weight: 101
group: style
description: >
  Make your app follow your user color scheme
aliases:
  - /docs/getting-started/kirigami/style-colors/
---

Kirigami has a color palette that follows the system colors to better integrate
with the platform it is running on (i.e. Plasma Desktop, Plasma Mobile,
GNOME, Android, etc.).

All of the QML components of Kirigami and QtQuick Controls should already
follow this palette by default, so usually no custom coloring should be needed 
for these controls.

Primitive components such as [Rectangle](docs:qtquick;QtQuick.Rectangle) should always be colored with the
color palette provided by Kirigami via the [Kirigami.Theme](docs:kirigami2;Kirigami::PlatformTheme) attached property.

Hardcoded colors in QML, such as `#32b2fa` or `red`, should usually be
avoided; if it is really necessary to have elements with custom colors, it should be an area where only custom colors are used (usually in the content area of the app, and never in chrome areas such as toolbars or dialogs). For instance, a hardcoded `black` foreground cannot be used over a
[Kirigami.Theme.backgroundColor](docs:kirigami2;Kirigami::PlatformTheme::backgroundColor) background, because if the platform uses a
dark color scheme the result will have poor contrast with black over almost black. This is an accessibility issue and should be avoided.

{{< alert title="Note" color="info" >}}

If you really need to use custom colors, check out [Kontrast](https://apps.kde.org/kontrast/) to ensure that the colors you choose have good contrast and are [WCAG compliant](https://en.wikipedia.org/wiki/Web_Content_Accessibility_Guidelines).

{{< /alert >}}

## Theme

[Kirigami.Theme](docs:kirigami2;Kirigami::PlatformTheme) is an attached property, and therefore it is available to use for any QML item. Its properties include all the colors available in the
palette, and what palette to use, such as the [colorSet](docs:kirigami2;Kirigami::PlatformTheme::colorSet) property.

Example:

```qml
import QtQuick 2.15
import org.kde.kirigami 2.20 as Kirigami

Rectangle {
    color: Kirigami.Theme.backgroundColor
}
```

[Kirigami Gallery](../introduction-kirigami-gallery) provides a code example showcasing [all colors available for Kirigami](https://invent.kde.org/sdk/kirigami-gallery/-/blob/master/src/data/contents/ui/gallery/ColorsGallery.qml) through [Kirigami.Theme](docs:kirigami2;Kirigami::PlatformTheme). This includes all their states: if you click outside the window, the colors change to their inactive state, and if you switch your system to a dark theme, the dark variants of the colors should show up in real time.

{{< figure class="text-center" caption="The Colors component in Kirigami Gallery" src="colors-gallery.webp"  >}}

## Color Set

Depending on where a control is located, it should use a different color set: for instance, when the Breeze Light color scheme is used in [Views](https://doc.qt.io/qt-6/qtquick-modelviewsdata-modelview.html), the normal background is almost white, while in other regions, such as toolbars or
dialogs, the normal background color is gray.

If you define a color set for an item, all of its child items will recursively inherit it automatically (unless the property [inherit](docs:kirigami2;Kirigami::PlatformTheme::inherit) has
explicitly been set to `false`, which should always be done when the developer 
wants to force a specific color set) so it is easy to change colors for an 
entire hierarchy of items without touching any of the items themselves.

[Kirigami.Theme](docs:kirigami2;Kirigami::PlatformTheme) supports 5 different color sets:

* View: Color set for item views, usually the lightest of all
  (in light color themes)
* Window: Color set for windows and chrome areas (this is also the default color set)
* Button: Color set used by buttons
* Selection: Color set used by selected areas
* Tooltip: Color set used by tooltips
* Complementary: Color set meant to be complementary to Window: usually
  dark even in light themes. May be used for emphasis in small
  areas of the application

Here is an example showcasing how color sets are inherited and can be used to distinguish different components. A large border has been added to contrast colors.

{{< readfile file="/content/docs/getting-started/kirigami/style-colors/ColorSet.qml" highlight="qml" >}}

{{< sections >}}

{{< section-left >}}

{{< figure class="text-center" caption="How color sets differ in Breeze" src="colorset.webp" >}}

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="How color sets differ in Breeze Dark" src="colorset-dark.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Using Custom Colors

Although it's discouraged to use hardcoded colors, Kirigami offers a more 
maintainable way to assign a custom hardcoded palette to an item and all its 
children, which allows to define such custom colors in one place and one
only:

{{< sections >}}

{{< section-left >}}

{{< readfile file="/content/docs/getting-started/kirigami/style-colors/CustomColors.qml" highlight="qml" >}}

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="Example with custom colors" src="customcolors.webp" >}}

{{< /section-right >}}

{{< /sections >}}


