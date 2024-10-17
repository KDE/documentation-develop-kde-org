---
title: "Making applications run well on Android"
linkTitle: "Making Applications run well on Android"
weight: 2
description: >
  Learn how to make sure that apps work well on android
---

Most functionality should work without large changes. Some topics, for example writing to and reading from files, requires a bit more care.

## Using the org.kde.breeze Style

While Qt includes a QtQuickControls style that is similar to the native style of Android, we do not use that for our apps since it doesn't fit well into Android. Instead, we use the `org.kde.breeze` style. You can force the app to use it by adding

```cpp
#ifdef Q_OS_ANDROID
    QQuickStyle::setStyle(QStringLiteral("org.kde.breeze"));
#else
```

to the main function and including `QQuickStyle`.

## Not using Qt Widgets

Even if the app does not use qt widgets for its UI, it may use a `QApplication` internally, since that enables a few things on the desktop.
On Android, this not necessary and we should make sure not to link against Qt Widgets, since that would increase the APK's size.

The first step towards not using Qt Widgets is thus to replace the `QApplication` with a `QGuiApplication`, but only on Android. This can be done using `#ifdef` and replacing the old variable with

```cpp
#ifdef Q_OS_ANDROID
    QGuiApplication app(argc, argv);
#else
    QApplication app(argc, argv);
#endif
```

It's also important to also make sure that the include for `QApplication` is not added:

```cpp
#ifdef Q_OS_ANDROID
#include <QGuiApplication>
#else
#include <QApplication>
#endif
```

Then, we can modify the cmake config in order to not link against Qt Widgets. In the `CMakeLists.txt` that links the libraries to the app (most likely in `src/CMakeLists.txt`), remove `Qt6::Widgets` from `target_link_libraries` and add it in a new line:

```cmake
if(ANDROID)
else()
    target_link_libraries(appname PRIVATE Qt::Widgets)
endif()
```

This code might look unnecessarily complicated, but we will add more to it later.

Now that we don't need Qt Widgets, we can also stop trying to find it at all. In `CMakeLists.txt`, remove the `find_package` call for Widgets, and put it inside a block that is not run when the target platform is Android.

## Removing unnecessary dependencies

Your app probably has some dependencies that are not required or will not work on Android, for example everything related to D-Bus, system tray icons or plasmoids. To make the app compile, make sure not to find and link against those dependencies and remove the necessary code using `#ifndef Q_OS_ANDROID`. If there are whole files that are not required on android, you can change the CMake configuration to not compile those files at all on Android.

## Linking against Kirigami, QtSvg and OpenSSL

Since Android behaves differently than a normal linux platform, the app needs to link against a few dependencies that normally don't need to be linked against.
To do this, add the following lines in the `if(ANDROID)` block that was previously added:

```cmake
target_link_libraries(alligator PRIVATE
    KF6::Kirigami
    Qt6::Svg
    OpenSSL::SSL
)
```

For this to work, cmake needs to find those packages first. Add the following `find_package` calls to where the other `find_package` calls are:

```cmake
if (ANDROID)
    find_package(Qt${QT_MAJOR_VERSION} ${QT_MIN_VERSION} REQUIRED COMPONENTS Svg)
    find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS Kirigami)
    find_package(OpenSSL REQUIRED)
endif()
```

## Bundling Icons

Android does not have the icon system that linux has. This means that every app needs to bundle the icons it needs. There is a CMake function that takes care of this, if you give it a list of icons the app needs.
Add the following code in the `if(ANDROID)` block:

```cmake
kirigami_package_breeze_icons(ICONS
    "help-about"
    "im-user"
    "document-edit"
)
```

Make sure to add new icons to this list! If you notice an icon missing in the user interface, this is most likely the cause.

## App icon

The app's icon should be visible in the "About" Page. If it is not, there are a few things you need to do.

If the icon is in breeze-icons, make sure to include it in the `kirigami_package_breeze_icons` call.

If the icon is not in breeze-icons, add it as a resource in the `.qrc` file and add a line like the following to your `KAboutData` object:

```cpp
about.setProgramLogo(QVariant(QIcon(QStringLiteral(":/logo.svg"))));
```

## Optimizing APK size

Ideally, APKs should be as small as possible. There are several ways this can be achieved:

First, the APK should be inspected to show the contained files and their sizes. The Android SDK contains two tools that can be used for this:

- `apkanalyzer` is a command line tool that lists APK contents and its size
- Android Studio contains a graphical tool for this under `Build > Analyze APK`.

Since APK files are just zip files internally, they can also be opened using normal archive tools like Ark.

Due to the way craft builds APKs, they contain many files that are not actually needed for the app to function. This can be improved by not installing those files when the target platform is Android - for example desktop or appstream files. Many libraries also build large documentation suites or plugins that are not required. If possible, those files should not be installed at all while building. This can be achieved by, depending on the project and build system, adding build flags like `-DBUILD_DOCS=false` or patching the build scripts.

When this is not possible, there is a way of excluding files via Craft before they get bundled by `androiddeployqt`. This works by adding a `.craftignore` file to the root directory of
the application repository.

```
# we use the Breeze style, so anything related to Material is unnecessary
qml/QtQuick/Controls/Material/.*
lib/qml/org/kde/kirigami/styles/Material/.*

# unused KConfigWidgets assets pulled in via KIconThemes
share/locale/.*/kf6_entry.desktop
share/locale/.*/LC_MESSAGES/kconfigwidgets6\.mo
share/locale/.*/LC_MESSAGES/(kitemviews6|kwidgetsaddons6)_qt\.qm
```

Each line is a regular expression that is matched against the path of installed files, matching ones are excluded.
