---
title: "Plasmoids compiled to C++"
weight: 22
description: >
  For more advanced plasmoids
---

In [Plasmoid setup](#) you were introduced to plasmoids that consist only of QML files. This kind of plasmoid is easy to package and distribute because its files are installed as QML files in `/usr/share/plasma/plasmoids/` or `~/.local/share/plasma/plasmoids/`, which is read by default by Plasma. 

When set up to build with CMake, the QML files are instead compiled to C++ and turned into libraries, which is more performant. This tutorial explains how to do so.

## Differences to QML-only projects

While you can make a QML only project compile to C++, this is usually not desirable because it is less ergonomic to test a compiled project and to distribute it to users. So this is only typically done for projects that require C++ or that are going to become a part of Plasma itself.

Unlike with [Plasmoid setup](#), the file structure of the project doesn't matter as long as the CMake code is correct and pointing to the right places since it will generate a single library `.so` file in the end.

Because CMake already specifies the URI of the plasmoid, the `Id` key in `metadata.json` is not needed. The presence of the key will trigger a warning when running the plasmoid.

The only path that Plasma accepts to load the generated library file is in `/usr/lib64/plugins/plasma/applets/`, which has three consequences:

* Local testing requires overriding `QT_PLUGIN_PATH`
* Users need it to be installed to root
* It cannot be shipped to users on the [KDE Store](https://store.kde.org/)

## Project structure

Because the file structure isn't strict for projects that will be compiled, we will simply use a `src/` based project structure:

```tree
org.kde.plasma.plasmoid_cpp/
├── CMakeLists.txt
└── src/
    ├── CMakeLists.txt
    ├── helloworld.cpp
    ├── helloworld.h
    ├── metadata.json
    └── qml/
        └── main.qml
```

The project will be called `org.kde.plasma.plasmoid_cpp` and will load a "Hello World" in QML that comes from C++.

This tutorial will be loosely based on the default [KAppTemplate](https://apps.kde.org/kapptemplate/) for [mixed C++/QML plasmoids](https://invent.kde.org/plasma/libplasma/-/tree/master/templates/cpp-plasmoid6).

{{< alert color="success" title="💡 Tip" >}}

You can create this file structure quickly with:

```bash
mkdir --parents org.kde.plasma.plasmoid_cpp/src/qml/
touch org.kde.plasma.plasmoid_cpp/CMakeLists.txt
touch org.kde.plasma.plasmoid_cpp/src/{CMakeLists.txt,helloworld.cpp,helloworld.h,metadata.json}
touch org.kde.plasma.plasmoid_cpp/src/qml/main.qml
```

{{< /alert >}}

## CMakeLists.txt {#cmakelists-root}

```cmake
cmake_minimum_required(VERSION 3.16)

project(plasmoid_cpp)

find_package(ECM 6.0.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)

find_package(Qt6 ${QT_MIN_VERSION} CONFIG REQUIRED COMPONENTS
    Quick
    Core
)

find_package(KF6 ${KF6_MIN_VERSION} REQUIRED COMPONENTS
    I18n
    Config
)

find_package(Plasma REQUIRED)

add_subdirectory(src)
```

## src/CMakeLists.txt {#cmakelists-src }

```cmake
add_definitions(-DTRANSLATION_DOMAIN=\"plasma_applet_org.kde.plasma.%{APPNAMELC}\")

plasma_add_applet(org.kde.plasma.plasmoid_cpp
    QML_SOURCES
        qml/main.qml
    CPP_SOURCES
        helloworld.cpp
    GENERATE_APPLET_CLASS
)

target_link_libraries(org.kde.plasma.plasmoid_cpp PRIVATE
    Qt6::Gui
    Plasma::Plasma
    KF6::I18n
)
```

## src/metadata.json {#metadata}

The `metadata.json` file is kept mostly the same as in [Plasmoid setup](#) except for the lack of the `Id` key, which is not necessary for projects compiled to C++ and will trigger a warning at runtime if present:

```json
{
    "KPackageStructure": "Plasma/Applet",
    "KPlugin": {
        "Authors": [
            {
                "Email": "youremail@example.com",
                "Name": "Konqi the Konqueror"
            }
        ],
        "Category": "Miscellaneous",
        "Description": "Hello World",
        "Icon": "kde",
        "License": "GPL",
        "Name": "Plasma Tutorial",
        "Version": "0.1",
        "Website": "https://www.kde.org/"
    },
    "X-Plasma-API-Minimum-Version": "6.0"
}
```

## src/qml/main.qml {#main-qml}

The example used in [Plasmoid setup](#) that has only a simple `fullRepresentation` will be reused here to showcase how a string message from C++ can be accessed in the QML side of the plasmoid:

```qml
import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root
    switchWidth: Kirigami.Units.gridUnit * 10
    switchHeight: Kirigami.Units.gridUnit * 10

    fullRepresentation: Item {
        Layout.preferredWidth: root.switchWidth
        Layout.preferredHeight: root.switchHeight

        ColumnLayout {
            anchors.fill: parent
            PlasmaComponents.Label {
                id: label
                Layout.alignment: Qt.AlignCenter
                text: HelloWorld.message // Needs emphasize
            }
        }
    }
}
```

We will be making a `HelloWorld` *singleton* in C++ that will expose a single property called `message`.

A singleton is an object that is instantiated only once for our plasmoid, so it does not need to be instantiated (like the `PlasmaComponents.Label` was).

## src/helloworld.h {#helloworld-header}

Create the following header `src/helloworld.h`:

```cpp
#pragma once

#include <QObject>
#include <QString>
#include <QQmlEngine>

class HelloWorld : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    Q_PROPERTY(QString message READ message CONSTANT)

public:
    static HelloWorld *create(QQmlEngine *, QJSEngine *);

    QString message() const;

private:
    HelloWorld();
};
```

As explained in Getting started with [Kirigami: Connect logic to your QML user interface](#), you need the `QML_ELEMENT` macro to expose the C++ class to QML as an object of the same name as the class, namely `HelloWorld`.

The `QML_SINGLETON` macro is what turns the class into a singleton that will only ever have one instance in QML, and `Q_PROPERTY()` is the macro that exposes a specific class member (`message()`) to QML under the `HelloWorld` QML object, which is only marked as `CONSTANT` here because it won't be changed while the plasmoid is running.

The `message()` funtion is the getter (specified after READ) that returns the value for the `message` QML property.

The only complexity added to the header is the presence of a static `create` function. In [Singletons in QML](https://doc.qt.io/qt-6/qml-singleton.html) it is stated that QML singletons are created at most once *per QML engine*. For normal applications this would typically be fine, but Plasma uses more than one QML engine, so plasmoids that implement singletons need to ensure that their singletons only exist as one instance *across all QML engines involved*, which is done with this function.

## src/helloworld.cpp {#helloworld-cpp}

Create the following implementation `src/helloworld.cpp`:

```cpp
#include "helloworld.h"

#include <KLocalizedString>

QString HelloWorld::message() const
{
    return i18nc("@info", "Hello World");
}

HelloWorld *HelloWorld::create(QQmlEngine *, QJSEngine *)
{
    static HelloWorld instance;
    QQmlEngine::setObjectOwnership(&instance, QQmlEngine::CppOwnership);
    return &instance;
}

HelloWorld::HelloWorld()
    : QObject(nullptr)
{}
```

The implementation is straightforward: the function `message()` returns "Hello World", the `create()` function is essentially boilerplate that ensures only one `HelloWorld` instance is ever created (when it is instantiated for the first time), and the private constructor does nothing.

## Local testing

Compiling the project leads to the creation of a library file `org.kde.plasma.plasmoid_cpp.so`.
Because the only available path for Plasma to load the plasmoid is in `/usr/lib64/plugins/plasma/applets/`, installing it locally to another directory and then running requires overriding the `QT_PLUGIN_PATH` environment variable for that new path to be found.

With this it's possible to load the plasmoid in `plasmawindowed` or `plasmoidviewer`:

```bash
cd /where/your/applet/is/generated
cmake -B build/ --install-prefix ~/.local
cmake --build build/
cmake --install build/
QT_PLUGIN_PATH=~/.local/lib64/plugins/ plasmawindowed org.kde.plasma.plasmoid_cpp
# or
QT_PLUGIN_PATH=~/.local/lib64/plugins/ plasmoidviewer --applet org.kde.plasma.plasmoid_cpp
```

Overriding this variable for the whole session is also possible. Create the directory `~/.config/plasma-workspace/env/` if it doesn't exist, and then add a short script exporting the variable:

```bash
#!/usr/bin/env bash

export QT_PLUGIN_PATH=/home/youruser/.local/lib64/plugins/:$QT_PLUGIN_PATH
```

Then log out and back in. The plasmoid should now be visible in the desktop list.

TODO add image

## Deployment

Deployment to users *must* be done by installing to root with a `/usr` prefix, as this is the only path where the library will be read by default for Plasma:

```bash
cmake -B build/ --install-prefix /usr
cmake --build build/
sudo cmake --install build/
```

The only recommended way for users to deploy a plasmoid compiled to C++ is by installing it to the root path that is read by Plasma by default, namely `/usr/lib64/plugins/plasma/applets/` (or equivalent in their distribution):

```bash
cmake -B build/ --install-prefix /usr
cmake --build build/
sudo cmake --install build/
```

You cannot ship a widget that needs to be compiled on the [KDE Store](https://store.kde.org). It is convenient to publish it in an [Ubuntu PPA](https://help.ubuntu.com/community/PPA), on the [Arch AUR](https://aur.archlinux.org/), with [OpenSUSE OBS](https://build.opensuse.org/), or [Fedora COPR](https://copr.fedorainfracloud.org/).
