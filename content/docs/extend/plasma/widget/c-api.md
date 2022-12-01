---
title: "C++ API"
weight: 9
description: >
  Compiling advanced C++ widgets with CMake
---

## Compiling With CMake

{{< sections >}}
{{< section-left >}}

A template can be found in `plasma-framework`:
<https://invent.kde.org/frameworks/plasma-framework/-/tree/master/templates/qml-plasmoid>

{{< alert color="warning" >}}
Do not reuse the same `Id`/namespace you used with a widget installed with `kpackagetool5`. If a user installed it to their home directory, the code in the home directory will be loaded instead of the code in the root directory.
{{< /alert >}}

```bash
mkdir -p ~/Code/plasmoid-helloworld2
cd ~/Code/plasmoid-helloworld2
mkdir -p ./build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make
sudo make install
```

{{< /section-left >}}
{{< section-right >}}
```txt
└── ~/Code/plasmoid-helloworld2/
    ├── package
    │   ├── contents
    │   │   └── ...
    │   └── metadata.json
    └── CMakeLists.txt
```

<div class="filepath">CMakeLists.txt</div>

```cmake
cmake_minimum_required(VERSION 3.16)

project(plasma-helloworld2)
 
find_package(ECM 1.4.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

find_package(KF5Plasma REQUIRED)

plasma_install_package(package com.github.zren.helloworld2)
```
{{< /section-right >}}
{{< /sections >}}






## Private C++ QML Module

{{< sections >}}
{{< section-left >}}

Examples:

* [`plasma-framework` / `template/qml-plasmoid-with-qml-extension`](https://invent.kde.org/frameworks/plasma-framework/-/tree/master/templates/qml-plasmoid-with-qml-extension)
* [`kdeplasma-addons` / `applets/mediaframe`](https://invent.kde.org/plasma/kdeplasma-addons/-/tree/master/applets/mediaframe/plugin)

{{< /section-left >}}
{{< section-right >}}

{{< /section-right >}}
{{< /sections >}}


## plasmoid.nativeInterface

{{< sections >}}
{{< section-left >}}

The `plasmoid.nativeInterface` property allows you to directly access C++ objects or functions in the `Plasma::Applet` instance. You need to extend the `Plasma::Applet` class first however. See the SystemTray container for an example.

* [`plasma-workspace`/applets/systemtray/container](https://invent.kde.org/plasma/plasma-workspace/-/tree/master/applets/systemtray/container)
* [`plasma-workspace`/.../container/CMakeLists.txt](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/applets/systemtray/container/CMakeLists.txt)
* [`plasma-workspace`/.../container/systemtraycontainer.h](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/applets/systemtray/container/systemtraycontainer.h)
* [`plasma-workspace`/.../container/systemtraycontainer.cpp](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/applets/systemtray/container/systemtraycontainer.cpp)
* [`plasma-workspace`/.../container/package/contents/ui/main.qml](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/applets/systemtray/container/package/contents/ui/main.qml)


{{< /section-left >}}
{{< section-right >}}
<div class="filepath">CMakeLists.txt</div>

```cmake
plasma_install_package(package org.kde.plasma.systemtray)

set(systemtraycontainer_SRCS
    systemtraycontainer.cpp
    systemtraycontainer.h
)

ecm_qt_declare_logging_category(systemtraycontainer_SRCS
    HEADER debug.h
    IDENTIFIER SYSTEM_TRAY_CONTAINER
    CATEGORY_NAME kde.systemtraycontainer
    DEFAULT_SEVERITY Info
)

kcoreaddons_add_plugin(org.kde.plasma.systemtray
    SOURCES ${systemtraycontainer_SRCS}
    INSTALL_NAMESPACE "plasma/applets"
)

target_link_libraries(org.kde.plasma.systemtray
    Qt::Gui
    Qt::Quick
    KF5::Plasma
    KF5::XmlGui
    KF5::I18n
)
```

<div class="filepath">systemtraycontainer.cpp</div>

```cpp
#pragma once

#include <QQuickItem>
#include <Plasma/Applet>

class SystemTrayContainer : public Plasma::Applet
{
    Q_OBJECT
    Q_PROPERTY(QQuickItem *internalSystray READ internalSystray NOTIFY internalSystrayChanged)

public:
    SystemTrayContainer(QObject *parent, const KPluginMetaData &data, const QVariantList &args);
    ~SystemTrayContainer() override;

    void init() override;
    QQuickItem *internalSystray();

protected:
    void constraintsEvent(Plasma::Types::Constraints constraints) override;
    void ensureSystrayExists();

Q_SIGNALS:
    void internalSystrayChanged();

private:
    QPointer<Plasma::Containment> m_innerContainment;
    QPointer<QQuickItem> m_internalSystray;
};
```
{{< /section-right >}}
{{< /sections >}}

## Containment (SystemTray, Panel, Grouping)

Note:

* The Grouping widget only displays one child widget (aka Applet) at a time.
* The SystemTray can display multiple CompactRepresentations at a time, but only one FullRepresentation in the main popup.
* The Panel can display Compact or Full representations next to each other but is the most complicated codebase to read.

Examples:

* [`kdeplasma-addons` / `applets/grouping`](https://invent.kde.org/plasma/kdeplasma-addons/-/tree/master/applets/grouping)
* [`plasma-workspace` / `applets/systemtray`](https://invent.kde.org/plasma/plasma-workspace/-/tree/master/applets/systemtray/)
* Panel
  * [`plasma-desktop` / `containments/panel`](https://invent.kde.org/plasma/plasma-desktop/-/tree/master/containments/panel)
  * [`plasma-desktop` / `desktoppackage/contents/views/Panel.qml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/desktoppackage/contents/views/Panel.qml)




{{< readfile file="/content/docs/extend/plasma/widget/snippet/code-filepath.html" >}}
