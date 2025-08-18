---
title: Windows Setup
weight: 91
group: platforms
description: > 
  Preparing your C++ application for Windows
---

## Introduction

Qt has great Windows support, and so applications making use of Qt and KDE's [extra-cmake-modules](https://api.kde.org/ecm/) will not require many modifications to work properly on Windows.

Three things are needed:

* [A Craft blueprint](#craft)
* [Setting the Breeze style](#breeze)
* [Icons bundled with the app](#icons)

The Craft blueprint is needed to bundle all the dependencies together with the application to generate an executable.

The preprocessor directive `#ifdef Q_OS_WIN` can be used to write code that will only apply when the application is built on Windows. This is needed at least once for forcing the Breeze style to the application so that it looks good on Windows, but depending on the application it might require more.

Bundling the necessary icons for the app to work on Windows is the most complex step, but both KDE's extra-cmake-modules (ECM) and Qt provide means to make this job easier.

## Craft blueprint {#craft}

To get started you must first follow [Building KDE software on Windows with Craft](/docs/getting-started/building/craft) so that you get a functional Craft blueprint and can at least build your application on Windows.

Once you are able to build the project you will get compilation and runtime errors that will help you fix any Windows compatibility issues.

## Breeze style {#breeze}

The Kirigami tutorial should already be mostly compliant with Windows, but the steps needed to achieve this need to be made explicit.

The two modifications that should be done to ensure the Breeze style is used is to set the QStyle to `breeze` and to set the Qt Quick Controls style to `org.kde.desktop`.

A [QStyle](https://doc.qt.io/qt-6/qstyle.html) is what controls the majority of the appearance of a QtWidgets application. This is needed in our QtQuick application because we initialize the application with [QApplication](https://doc.qt.io/qt-6/qapplication.html) (traditionally used with QtWidgets).

A [Qt Quick Controls style](https://doc.qt.io/qt-6/qtquickcontrols-styles.html) on the other hand controls the majority of the appearance of a QtQuick application. This affects how QML controls will look like. KDE's `org.kde.desktop` style (otherwise known as [qqc2-desktop-style](https://invent.kde.org/frameworks/qqc2-desktop-style)) is special and attempts to remove duplication by deriving styling elements from the application's QStyle (hence why a QApplication is used). This way, QtWidgets and QtQuick applications can mostly look the same and reuse style components.

QtQuick / Kirigami applications need to set both in C++ code. To set the QStyle, it needs to be added in two places.

In Craft:

```python
def setDependencies(self):
    self.runtimeDependencies["kde/plasma/breeze"] = None
```

And in C++:

```c++
QApplication::setStyle("breeze");
```

This is what is used in the Kirigami tutorial. You may otherwise load the Breeze style only on Windows where this is most relevant using an ifdef:

```c++
#ifdef Q_OS_WIN
    QApplication::setStyle("breeze");
#endif
```

The Qt Quick Controls style needs to be added in three places.

In Craft:

```python
def setDependencies(self):
    self.runtimeDependencies["kde/frameworks/tier3/qqc2-desktop-style"] = None
```

In C++, where it needs to be conditional:

```c++
if (qEnvironmentVariableIsEmpty("QT_QUICK_CONTROLS_STYLE"))
{
    QQuickStyle::setStyle("org.kde.desktop");
}
```

And optionally in CMake, in one of two ways:

```cmake
find_package(KF6 REQUIRED COMPONENTS QQC2DesktopStyle)
# or
ecm_find_qmlmodule(org.kde.desktop REQUIRED)
```

Since it is a runtime dependency, it is not required to be set in CMake which is used at compile time. However, this can signal to yourself and to others whether the environment is correct and will be able to run the resulting application, allowing you to find missing packages or misconfigurations more easily.

The command `find_package()` specifically searches for the CMake configuration files for `qqc2-desktop-style`, whereas `ecm_find_qmlmodule()` is less strict and only searches for the QML module. The latter requires that you include ECMFindQmlModule:

```cmake
include(ECMFindQmlModule)
```

## Shipping icons {#icons}

The first thing that is needed to make the application use Breeze icons is to include [KIconThemes](https://invent.kde.org/frameworks/kiconthemes) in your project.

After this, some CMake commands are needed to bundle your application icon with the app.

### KIconThemes

This can be done with the following three steps:

* Adding it as a dependency in Craft:

```python
def setDependencies(self):
    self.runtimeDependencies["kde/frameworks/tier3/kiconthemes"] = None
```

* Adding it as a dependency in CMake:

```cmake
find_package(KF6 REQUIRED COMPONENTS IconThemes)

# ...

target_link_libraries(myapp
    PRIVATE
    # ...
    KF6::IconThemes
)
```

* Using it in C++ code, in the `main.cpp` file:

```c++
#include <KIconTheme>

// ...

int main(int argc, char* argv[])
{
    KIconTheme::initTheme();
    QApplication app(argc, argv);
    // ...
}
```

Note that although the project name and CMake call uses plural (KIconThemes, KF6IconThemes), the C++ call uses singular (KIconTheme).

KIconThemes needs to be initialized before the application.

### Application icon

If your application has an icon, it needs to be added to your project both as a [QML resource](https://doc.qt.io/qt-6/resources.html) and as a part of icon installation.

Ordinarily on Linux the application icon can simply be installed to the correct directory, and the icon will be fetched by the application when needed. Usually the application icon consists of a primary SVG icon, paired with multiple PNG icon sizes.

Installing the SVG icon is done like this in CMake:

```cmake
install(FILES ${PROJECT_SOURCE_DIR}/icons/org.kde.myapp.svg DESTINATION ${KDE_INSTALL_FULL_ICONDIR}/hicolor/scalable/apps)
```

And installing the PNG icons is done like this:

```cmake
ecm_install_icons(ICONS
    16-apps-myapp.png
    24-apps-myapp.png
    32-apps-myapp.png
    48-apps-myapp.png
    64-apps-myapp.png
    128-apps-myapp.png
    256-apps-myapp.png
    512-apps-myapp.png    
    DESTINATION share/icons)
```

When the application icon is installed on Linux, a PNG icon such as `48-apps-myapp.png` goes to `${INSTALL_PREFIX}/share/icons/hicolor/48x48/apps/myapp.png`, and an SVG icon goes to `${INSTALL_PREFIX}/share/icons/hicolor/scalable/apps/org.kde.myapp.svg`, where `${INSTALL_PREFIX}` usually stands for `/usr`, `/usr/local` or `~/.local`. Note how in the PNGs' case the icon name translates into the path it will have in the filesystem.

You can read more about installing files in [Building KDE software manually: The install step](/docs/getting-started/building/cmake-build/#install).

Once the icon is installed in this way, in QML code, it can be called simply with `myapp` or `org.kde.myapp`, as would be called from [QIcon::fromTheme()](doc.qt.io/qt-6/qicon.html#fromTheme). This can be used with any QML control that has an [icon.name](https://doc.qt.io/qt-6/qtquickcontrols-icons.html) property.

Windows has no such standard directory, and installing the icon has no effect; it has to be bundled with the application. To do so, the PNG can be sent to its own installation directory using `ecm_add_app_icon()` and a PNG or SVG file can be embedded into the app as a Qt resource file in `ecm_add_qml_module()` or `ecm_target_qml_sources()`.

The PNG application icon is installed with:

```cmake
ecm_add_app_icon(myapp ICONS ${PROJECT_SOURCE_DIR}/icons/256-apps-myapp.png)
```

And the main application icon is bundled as a Qt resource with:

```cmake
ecm_add_qml_module(myapp URI org.kde.myapp)
ecm_target_qml_sources(myapp SOURCES Main.qml RESOURCES ../icons/org.kde.myapp.svg)
```

This will make the application icon available as a Qt resource under `qrc:/qt/qml/org/kde/myapp/org.kde.myapp.svg`. This can be used with any QML control that has an [icon.source](https://doc.qt.io/qt-6/qtquickcontrols-icons.html) property.

The `RESOURCES` path depends on the place where the icons are located. Traditionally, an `icons/` folder is created at the root of the project for storing all icons, as they don't really count as source files.

After the icons are installed (for Linux) and bundled (for Windows and Android), you can set it in code. In QML code, for compatibility with both Windows and Android, you should use the bundled icon; in C++ code, notably when setting the window icon, you can use the theme icon by default and the bundled icon as a fallback with [QIcon::fromTheme()](https://doc.qt.io/qt-6/qicon.html#fromTheme) in the call to [QGuiApplication::setWindowIcon()](https://doc.qt.io/qt-6/qguiapplication.html#windowIcon-prop):

```c++
QGuiApplication::setWindowIcon(QIcon::fromTheme("org.kde.myapp", QIcon(":/qt/qml/org/kde/myapp/org.kde.myapp.svg")));
```

### Kirigami icons

While Windows does not have a standard directory where to install icons from an icon theme, it is possible to bundle the necessary Breeze icons together with your Windows application.

This is performed by Craft automatically when KIconThemes is correctly set up for the project and Breeze icons are included as a dependency in your project.

To set up KIconThemes, see the above section [KIconThemes](#kiconthemes).

To add Breeze icons as a dependency for your project, add this to your Craft blueprint:

```python
def setDependencies(self):
    # ...
    self.runtimeDependencies["kde/frameworks/tier1/breeze-icons"] = None
```

This way, you won't need to manually bundle any Breeze icons into your application as a resource: you can just use a `QIcon::fromTheme()` name, such as `kde` or `application-exit-symbolic`.

## Building

To build your application on Windows, follow [Building KDE software on Windows with Craft: Building your own projects on Windows](/docs/getting-started/building/craft#custom-projects).

## CI builds

If the project has been properly configured to build on Windows and is using KDE infrastructure for its code hosting (KDE Invent), it is possible to configure Windows CI/CD jobs.

To do this, you will need to add the relevant CI templates for Windows with a `.gitlab-ci.yaml` file and list your dependencies in a `.kde-ci.yaml` file as mentioned in [Continuous Integration System](https://community.kde.org/Infrastructure/Continuous_Integration_System).

## Troubleshooting

If you have problems adapting your application to Windows, you can visit the following rooms on [Matrix](https://community.kde.org/Matrix):

* [#kde-devel:kde.org](https://go.kde.org/matrix/#/#kde-devel:kde.org)
* [#new-contributors:kde.org](https://go.kde.org/matrix/#/#new-contributors:kde.org)
* [#kde-windows:kde.org](https://go.kde.org/matrix/#/#kde-windows:kde.org)
* [#kde-craft:kde.org](https://go.kde.org/matrix/#/##kde-craft:kde.org)
