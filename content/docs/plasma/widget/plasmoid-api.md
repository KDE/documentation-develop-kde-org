---
title: "Using the Plasma API"
weight: 3
description: >
  Extending your plasmoid
aliases:
  - /docs/plasma/widget/plasma-qml-api/
---

In [Plasmoid setup]({{< ref "plasmoid-setup" >}}) you have learned how to make a simple Hello World plasmoid using a PlasmoidItem and multiple representations, but the Plasma API for making plasmoids is much more extensive and effectively allows you to make a full-blown application inside a plasmoid.

This page explains where to find more useful APIs for plasmoids and when to use them.

## Libplasma, Kirigami, and QtQuick Controls

Plasmoids mostly consist of a mix of Libplasma, Kirigami, and QtQuick. Prefer using Libplasma over Kirigami, and Kirigami over QtQuick.

[Libplasma](https://api.kde.org/plasma-index.html) provides essential QML API for plasmoids. In particular:

* [Plasmoid](https://api.kde.org/org-kde-plasma-plasmoid-qmlmodule.html) provides root-like types such as [PlasmoidItem](https://api.kde.org/qml-org-kde-plasma-plasmoid-plasmoiditem.html) and [Containment](https://api.kde.org/qml-org-kde-plasma-plasmoid-containment.html)
* [Plasmoid Configuration](https://api.kde.org/org-kde-plasma-configuration-qmlmodule.html) provides the essential components for configuration dialogs
* [Plasma Core](https://api.kde.org/org-kde-plasma-core-qmlmodule.html) provides windows and popups, but styled specifically for plasmoids
* [Plasma Components](https://api.kde.org/org-kde-plasma-components-qmlmodule.html) provides traditional QtQuick controls, but styled specifically for plasmoids
* [Plasma Extras](https://api.kde.org/org-kde-plasma-extras-qmlmodule.html) provides additional controls like Kirigami, but styled specifically for plasmoids

[Kirigami](https://api.kde.org/kirigami-index.html) provides QML API that is traditionally useful for KDE-styled applications, but its APIs that are most used in plasmoids are [Kirigami.Units](https://api.kde.org/qml-org-kde-kirigami-platform-units.html). Check out our [Kirigami Tutorial]({{< ref "/docs/getting-started/kirigami" >}}).

[QtQuick](https://doc.qt.io/qt-6/qtquick-index.html) provides generic QML API, but its APIs that are most used in plasmoids are [Layouts](https://doc.qt.io/qt-6/qtquicklayouts-index.html).

## Other QML APIs

Any other QML APIs present in the [KDE API](https://api.kde.org/) website can be used for your plasmoids. The most notable are:

* [Kirigami](https://api.kde.org/kirigami-index.html) (prefer Libplasma controls)
* [Kirigami Addons](https://api.kde.org/kirigami-addons-index.html) (prefer Libplasma controls)
* [KI18n](https://api.kde.org/ki18n-index.html)
* [KSvg](https://api.kde.org/ksvg-index.html)
* [KDeclarative](https://api.kde.org/kdeclarative-index.html)
* [KWindowSystem](https://api.kde.org/qml-org-kde-kwindowsystem-kwindowsystem.html)
* [SyntaxHighlighter](https://api.kde.org/qml-org-kde-syntaxhighlighting-syntaxhighlighter.html)
* [KIconThemes.IconDialog](https://api.kde.org/kicondialog.html)
* [KGuiAddons.SystemInhibitor](https://api.kde.org/qml-org-kde-guiaddons-systeminhibitor.html)
* [KItemModels.KSortFilterProxyModel](https://api.kde.org/qml-org-kde-kitemmodels-ksortfilterproxymodel.html)

## C++ and QML components in libplasma

Libplasma-specific QML types are made with C++ in order to provide their more powerful features. In these cases, the API present in QML types is also present in C++ classes. A few examples are particularly notable:

* QML [Plasmoid](https://api.kde.org/qml-org-kde-plasma-plasmoid-plasmoid.html) and C++ [Plasma::Applet](https://api.kde.org/plasma-applet.html)
* QML [PlasmoidItem](https://api.kde.org/qml-org-kde-plasma-plasmoid-plasmoiditem.html) and C++ Plasma::AppletQuickItem
* QML [Containment](https://api.kde.org/qml-org-kde-plasma-plasmoid-containment.html) and C++ [Plasma::Containment](https://api.kde.org/plasma-containment.html)

Navigating the respective pairs of APIs may assist in understanding their roles.

Controls provided in Plasma Components and Plasma Extras are only available in QML. Only visual QML types provided in Plasma Core are available in QML.
