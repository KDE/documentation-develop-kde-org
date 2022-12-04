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
[`plasma-framework` / `template/qml-plasmoid`](https://invent.kde.org/frameworks/plasma-framework/-/tree/master/templates/qml-plasmoid)

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

{{< alert color="warning" >}}
You cannot ship a widget that needs to be compiled on the [KDE Store](https://store.kde.org). You will need to publish it in an [Ubuntu PPA](https://help.ubuntu.com/community/PPA), on the [Arch AUR](https://aur.archlinux.org/), or with [OpenSUSE OBS](https://build.opensuse.org/).
{{< /alert >}}
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

project(plasmoid-helloworld2)

find_package(ECM 1.4.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

find_package(KF5 REQUIRED COMPONENTS
    Plasma # Required for plasma_install_package()
)

plasma_install_package(package com.github.zren.helloworld2)
```
{{< /section-right >}}
{{< /sections >}}






## Private C++ QML Plugin

Plasma ships with a number of useful QML plugins like [PlasmaCore]({{< ref "plasma-qml-api.md#plasmacore" >}}), [PlasmaComponents]({{< ref "plasma-qml-api.md#plasmacomponents-controls" >}}), [PlasmaExtras]({{< ref "plasma-qml-api.md#plasmaextras" >}}). Your widget might need more complicated models that interact with C++ libraries or File I/O requiring you to create a QML plugin.

### Example Plugins

{{< sections >}}
{{< section-left >}}
You can find a template in `plasma-framework`:  
[`plasma-framework` / `template/qml-plasmoid-with-qml-extension`](https://invent.kde.org/frameworks/plasma-framework/-/tree/master/templates/qml-plasmoid-with-qml-extension)
{{< /section-left >}}
{{< section-right >}}
<a type="button" class="btn btn-primary" href="https://invent.kde.org/frameworks/plasma-framework/-/archive/master/plasma-framework-master.zip?path=templates/qml-plasmoid-with-qml-extension" download>Download KDevelop Template</a>
{{< /section-right >}}
{{< /sections >}}

{{< sections >}}
{{< section-left >}}
The mediaframe widget in `kdeplasma-addons` is a fairly simple example. The plugin has one C++ class to define the plugin, and only defines a single QML Item type.

[`kdeplasma-addons` / `applets/mediaframe`](https://invent.kde.org/plasma/kdeplasma-addons/-/tree/master/applets/mediaframe/plugin)

```qml
import org.kde.plasma.private.mediaframe 2.0
```

{{< alert color="info" >}}
While KDE puts `.private` in the namespace of these plugins, they can be accessed by any QML widget / application. If you plan on using someone else's "private" plugin, your widget may experience bugs when Plasma updates.
{{< /alert >}}

Another example is the "Kicker" plugin for the "Application Menu" widget which is reused by the kickoff "Application Launcher" widget.

```qml
import org.kde.plasma.private.kicker 0.1 as Kicker
```

* [`plasma-workspace` / `applets/kicker/plugin`](https://invent.kde.org/plasma/plasma-workspace/-/tree/master/applets/kicker/plugin)
* [`plasma-desktop` / `applets/kicker/package/contents/ui/main.qml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/applets/kicker/package/contents/ui/main.qml#L14)
* [`plasma-desktop` / `applets/kickoff/package/contents/ui/Kickoff.qml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/applets/kickoff/package/contents/ui/Kickoff.qml)
{{< /section-left >}}
{{< section-right >}}
```txt
└── ~/Code/plasmoid-mediaframe/
    ├── package
    │   ├── contents
    │   │   └── ui
    │   │       └── main.qml
    │   └── metadata.json
    ├── plugin
    │   ├── mediaframe.cpp
    │   ├── mediaframe.h
    │   ├── mediaframeplugin.cpp
    │   ├── mediaframeplugin.h
    │   └── qmldir
    └── CMakeLists.txt
```
{{< /section-right >}}
{{< /sections >}}

### Writing a Plugin

{{< sections >}}
{{< section-left >}}
Lets use mediaframe as an example and create our own widget with a plugin.

A full copy of this example can be downloaded as a ZIP or cloned from GitHub.
{{< /section-left >}}
{{< section-right >}}
<a type="button" class="btn btn-primary"  href="https://github.com/Zren/plasmoid-helloworldplugin/archive/refs/heads/master.zip" download>Download ZIP</a> or Git Clone

```bash
mkdir -p ~/Code
cd ~/Code
git clone https://github.com/Zren/plasmoid-helloworldplugin plasmoid-widgetname
cd ~/Code/plasmoid-widgetname
```
{{< /section-right >}}
{{< /sections >}}


{{< sections >}}
{{< section-left >}}
To start off, let's work out what we want in the QML code. For this simple example, we will import a new `WidgetItem` type, which has a property named `number` and has an [invokable function](https://doc.qt.io/qt-6/qtqml-cppintegration-exposecppattributes.html) called `randomize()` which will set the `number` property to a random number.
{{< /section-left >}}
{{< section-right >}}
<div class="filepath">package/contents/ui/main.qml</div>

```qml
import QtQuick 2.4
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.plasmoid 2.0

import com.github.zren.widgetname 1.0 as WidgetName

Item {
    id: widget

    WidgetName.WidgetItem {
        id: widgetItem
        number: 123
    }
    Plasmoid.fullRepresentation: PlasmaComponents3.Button {
        text: widgetItem.number
        onClicked: widgetItem.randomize()
    }
}
```
{{< /section-right >}}
{{< /sections >}}


{{< sections >}}
{{< section-left >}}
Before moving on to the C++ code, don't forget to create the `metadata.json`.
{{< /section-left >}}
{{< section-right >}}
<div class="filepath">package/metadata.json</div>

```json
{
    "KPlugin": {
        "Id": "com.github.zren.widgetname",
        "Name": "widgetname",
        "Version": "1.0",
        "Website": "https://github.com/Zren/plasmoid-helloworldplugin",
        "ServiceTypes": [
            "Plasma/Applet"
        ]
    },
    "X-Plasma-API": "declarativeappletscript",
    "X-Plasma-MainScript": "ui/main.qml"
}
```
{{< /section-right >}}
{{< /sections >}}


{{< sections >}}
{{< section-left >}}
First new things added to our `CMakeLists.txt` is listing all our `.cpp` files that we need to compile. We also define the plugin library name used in the binary filename.

```cmake
set(widgetnameplugin_SRCS
    plugin/widgetitem.cpp
    plugin/widgetnameplugin.cpp
)

add_library(widgetnameplugin SHARED ${widgetnameplugin_SRCS})
```

In our `CMakeLists.txt`, we need to include a few KDE variables so that we compile and install files to the right location. Make sure the folder names match the plugin namespace.

```cmake
include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
# ...
install(TARGETS widgetnameplugin DESTINATION ${KDE_INSTALL_QMLDIR}/com/github/zren/widgetname)
install(FILES plugin/qmldir DESTINATION ${KDE_INSTALL_QMLDIR}/com/github/zren/widgetname)
```

In OpenSUSE, we'll end up installing the following files. Other distros might not use `/usr/lib64/qt5` so just use 
`locate qmldir` if you are curious where the files are installed to.

```txt
/usr/lib64/qt5/qml/com/github/zren/widgetname/libwidgetnameplugin.so
/usr/lib64/qt5/qml/com/github/zren/widgetname/qmldir
```

Since we're now compiling Qt C++ code, we need to use `find_package()` to indicate that it's required for compilation. We will need `Qt5::Qml` to import [`QQmlExtensionPlugin`](https://github.com/qt/qtdeclarative/blob/dev/src/qml/qml/qqmlextensionplugin.h) and use [`qmlRegisterType()`](https://doc.qt.io/qt-5/qqmlengine.html#qmlRegisterType). Since we are sticking to a simple `QObject` in our new type, we will only need `Qt5::Core`.

Don't forget to link the components as well.

```cmake
find_package(Qt5 REQUIRED COMPONENTS
    Core
    Qml
)
# ...
target_link_libraries(widgetnameplugin
    Qt::Core
    Qt::Qml
)
```

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">CMakeLists.txt</div>

```cmake
cmake_minimum_required(VERSION 3.16)

project(plasmoid-widgetname)

find_package(ECM 1.4.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)

find_package(Qt5 REQUIRED COMPONENTS
    Core
    Qml
)

find_package(KF5 REQUIRED COMPONENTS
    Plasma # Required for cmake plasma_install_package()
    # I18n
)

plasma_install_package(package com.github.zren.widgetname)

add_definitions(-DTRANSLATION_DOMAIN=\"plasma_applet_com.github.zren.widgetname\")

set(widgetnameplugin_SRCS
    plugin/widgetitem.cpp
    plugin/widgetnameplugin.cpp
)

add_library(widgetnameplugin SHARED ${widgetnameplugin_SRCS})

target_link_libraries(widgetnameplugin
    Qt::Core
    Qt::Qml
    # KF5::Plasma
    # KF5::I18n
)

install(TARGETS widgetnameplugin DESTINATION ${KDE_INSTALL_QMLDIR}/com/github/zren/widgetname)
install(FILES plugin/qmldir DESTINATION ${KDE_INSTALL_QMLDIR}/com/github/zren/widgetname)
```
{{< /section-right >}}
{{< /sections >}}

{{< sections >}}
{{< section-left >}}
The `qmldir` file is basically the qml plugin metadata file. Since we don't bundle any `.qml` files in the plugin itself [like PlasmaComponents](https://invent.kde.org/frameworks/plasma-framework/-/blob/master/src/declarativeimports/plasmacomponents3/qmldir) does, this will just define the namespace of the plugin and the plugin library name.

Inside `widgetnameplugin.h` we extend [`QQmlExtensionPlugin`](https://github.com/qt/qtdeclarative/blob/dev/src/qml/qml/qqmlextensionplugin.h) and indicate we implement the `QQmlExtensionInterface` which somehow tells it to call `registerTypes()`.

In the `.cpp` file we register the new QML type. Don't forget to edit the namespace in the assert.
{{< /section-left >}}
{{< section-right >}}
<div class="filepath">plugin/qmldir</div>

```txt
module com.github.zren.widgetname
plugin widgetnameplugin
```

<div class="filepath">plugin/widgetnameplugin.h</div>

```cpp
#pragma once

#include <QQmlEngine>
#include <QQmlExtensionPlugin>

class WidgetNamePlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri) override;
};
```

<div class="filepath">plugin/widgetnameplugin.cpp</div>

```cpp
#include "widgetnameplugin.h"
#include "widgetitem.h"

void WidgetNamePlugin::registerTypes(const char *uri)
{
    Q_ASSERT(QLatin1String(uri) == QLatin1String("com.github.zren.widgetname"));

    qmlRegisterType<WidgetItem>(uri, 1, 0, "WidgetItem");
}
```
{{< /section-right >}}
{{< /sections >}}


{{< sections >}}
{{< section-left >}}
Finally we write our new `WidgetItem` type. In the header file we extend `QObject` and define the `number` property. Since we want do not want the `number` property to be readonly, we define `WRITE` and a setter function. We also define the `numberChanged` signal to `NOTIFY` the GUI when it's modified.

The `randomize()` method needs `Q_INVOKABLE` otherwise it [cannot be called from QML](https://doc.qt.io/qt-6/qtqml-cppintegration-exposecppattributes.html).
{{< /section-left >}}
{{< section-right >}}
<div class="filepath">plugin/widgetitem.h</div>

```cpp
#pragma once

#include <QObject>

class WidgetItem : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int number READ number WRITE setNumber NOTIFY numberChanged)

public:
    explicit WidgetItem(QObject *parent = nullptr);
    ~WidgetItem() override;

    int number() const;
    void setNumber(int number);

    Q_INVOKABLE void randomize();

Q_SIGNALS:
    void numberChanged();

private:
    int m_number;
};
```
{{< /section-right >}}
{{< /sections >}}


{{< sections >}}
{{< section-left >}}
To make development easier, we've imported [`qDebug()`](https://doc.qt.io/qt-6/qdebug.html#basic-use) which lets us log to the terminal.

In the setter, we do not emit the signal if the property does not actually change.
{{< /section-left >}}
{{< section-right >}}
<div class="filepath">plugin/widgetitem.cpp</div>

```cpp
#include "widgetitem.h"

#include <QDebug>
#include <QObject>
#include <QRandomGenerator>

WidgetItem::WidgetItem(QObject *parent)
    : QObject(parent)
    , m_number(0)
{
    qDebug() << "WidgetItem() constructor";
}

WidgetItem::~WidgetItem() = default;

int WidgetItem::number() const
{
    return m_number;
}

void WidgetItem::setNumber(int number)
{
    if (number != m_number) {
        m_number = number;
        qDebug() << "setNumber" << m_number;
        Q_EMIT numberChanged();
    }
}

void WidgetItem::randomize()
{
    const int min = 0;
    const int max = 10000;
    int val = (QRandomGenerator::global()->bounded((max - min + 1)) + min);
    qDebug() << "randomize(" << min << "," << max << ") =" << val;
    setNumber(val);
}
```
{{< /section-right >}}
{{< /sections >}}


{{< sections >}}
{{< section-left >}}
To compile, install and test this plugin follow the instructions from the previous [Compiling With CMake](#compiling-with-cmake) section and the [Widget Testing]({{< ref "testing.md" >}}) page.

When writing your widget's `README.md`, you'll want to add uninstall instructions as well.
{{< /section-left >}}
{{< section-right >}}
```bash
cd ~/Code/plasmoid-widgetname
mkdir -p ./build
(cd ./build && cmake .. -DCMAKE_INSTALL_PREFIX=/usr && make && sudo make install)
plasmoidviewer -a com.github.zren.widgetname
```

```bash
(cd ./build && sudo make uninstall)
```
{{< /section-right >}}
{{< /sections >}}


## plasmoid.nativeInterface

{{< sections >}}
{{< section-left >}}

The `plasmoid.nativeInterface` property allows you to directly access C++ objects or functions in the `Plasma::Applet` instance. You need to extend the `Plasma::Applet` class first however. The `plasmoid.nativeInterface` cannot be accessed by another widget namespace, so this code is private.

See the SystemTray container for an example.

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



## Translate C++ Strings

If you want to messages translated in your C++ code, you will need to import `KF5::I18n` and define the translation domain in your `CMakeLists.txt`.

```cmake
find_package(KF5 REQUIRED COMPONENTS
    I18n
)

add_definitions(-DTRANSLATION_DOMAIN=\"plasma_applet_com.github.zren.widgetname\")

target_link_libraries(widgetnameplugin
    KF5::I18n
)
```




{{< readfile file="/content/docs/extend/plasma/widget/snippet/plasma-doc-style.html" >}}
