---
title: Android Setup
weight: 92
group: platforms
description: > 
  Preparing your C++ application for Android
---

## Introduction

Qt has great Android support, but applications require a substantial amount of modifications to work properly on Android.

A few things are needed:

* [A Craft blueprint](#craft)
* [Setting qqc2-breeze-style](#qqc2-breeze-style)
* [Icons bundled with the app](#icons)
* [An Android manifest](#android-manifest)
* [Optionally a Gradle build file](#gradle-build)
* [Optionally a splash screen XML file](#splash)
* [CMake function to package for Android](#build-apk)

The Craft blueprint is needed to bundle all the dependencies together with the application to generate an Android APK package.

The qqc2-breeze-style is an alternative to qqc2-desktop-style that is especially geared for mobile platforms like Android and Plasma Mobile.

The application's Craft blueprint needs conditional code to not mix desktop and mobile styling, while the C++ code will need special care not to use the wrong configuration for desktop and mobile. The CMake code might optionally also need conditional code, although it can be avoided.

Bundling the necessary icons for the app to work is done with the help of KDE's extra-cmake-modules, Qt resource bundling tools, as well as Kirigami and Kirigami Addons CMake functions.

The Android manifest declares the metadata and additional files that need to be bundled with the Android application.

The Gradle build file is needed in case you use extra-cmake-modules integration to apply existing metadata from your application into the Android build, such as the application version, or in case you want special build options.

The Splash screen XML file is needed in case you want to add a splash screen with custom icon, background and positioning.

## Craft blueprint {#craft}

## Setting the qqc2-breeze-style {#qqc2-breeze-style}

To start using qqc2-breeze-style, you will need to add it to Craft. Because it is only used for Android, it will require a conditional clause, especially if the application is already set up to build on Windows and/or Linux using qqc2-desktop style. This requires importing the `CraftCore` module:

```python
from CraftCore import CraftCore

# ...

def setDependencies(self):
  # ...
  if not CraftCore.compiler.isAndroid:
      self.runtimeDependencies["kde/frameworks/tier1/breeze-icons"] = None
      self.runtimeDependencies["kde/frameworks/tier3/qqc2-desktop-style"] = None
  else:
      self.runtimeDependencies["kde/plasma/qqc2-breeze-style"] = None
```

A similar "if not Android, use qqc2-desktop-style, else use qqc2-breeze-style" logic needs to be applied to CMake as well, in case either method of finding qqc2-desktop-style is used:

```cmake
if (NOT ANDROID)
    find_package(KF6QQC2DesktopStyle REQUIRED)
    ecm_find_qmlmodule(org.kde.desktop REQUIRED)
endif()
```

Conditional code is also required in C++.

On Android, KDE applications do not use QApplication, but rather QGuiApplication. In addition to setting qqc2-breeze-style only for Android, the initialization order needs to be dealt with in the very likely case that your application is already compatible with the desktop. This can be achieved like so:

```c++
int main(int argc, char* argv[])
{
    KIconTheme::initTheme();
#ifdef Q_OS_ANDROID
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("org.kde.breeze");
#else
    QIcon::setFallbackThemeName("breeze");
    if (qEnvironmentVariableIsEmpty("QT_QUICK_CONTROLS_STYLE"))
    {
        QQuickStyle::setStyle("org.kde.desktop");
    }
    QApplication app(argc, argv);
    // ...
}
```

## Shipping icons {#icons}

The first thing that is needed to make the application use Breeze icons is to include KIconThemes in your project.

Some CMake commands are needed to bundle your application icon with the app.

Lastly, an extra CMake command coming from Kirigami can be used to bundle Kirigami icons into your application (and optionally Kirigami Addons icons).

### KIconThemes

This can be done by:

* Adding it as a dependency in Craft:

```python
def setDependencies(self):
    self.runtimeDependencies["kde/frameworks/tier3/kiconthemes"] = None
```

* Adding it as a dependency in CMake:

```cmake
find_package(KF6 REQUIRED COMPONENTS IconThemes)

# ...

target_link_libraries(kirigami-hello
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

If your application has an icon, it needs to be added to your project both as a QML resource and as a part of icon installation.

Ordinarily on Linux the application icon can simply be installed to the correct directory, and the icon will be fetched by the application when needed. Usually the application icon consists of a primary SVG icon, paired with multiple PNG icon sizes.

Installing the SVG icon is done like this in CMake:

```cmake
install(FILES ${CMAKE_SOURCE_DIR}/icons/org.kde.myapp.svg DESTINATION ${KDE_INSTALL_FULL_ICONDIR}/hicolor/scalable/apps)
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

Once the icon is installed in this way, in QML code, it can be called simply with `myapp` or `org.kde.myapp`, as would be called from `QIcon::fromTheme()`. This can be used with any QML control that has an `icon.name` property.

Android has no such standard directory, and installing the icon has no effect; it has to be bundled with the application. To do so, the PNG can be sent to its own installation directory `ecm_add_app_icon()` and a PNG or SVG file can be embedded into the app as a Qt resource file in `ecm_add_qml_module()` or `ecm_target_qml_sources()`.

The PNG application icon is installed with:

```cmake
ecm_add_app_icon(myapp ICONS ${PROJECT_SOURCE_DIR}/icons/256-apps-myapp.png)
```

And the main application icon is bundled as a Qt resource with:

```cmake
ecm_add_qml_module(myapp URI org.kde.myapp)
ecm_target_qml_sources(myapp SOURCES Main.qml RESOURCES ../icons/org.kde.myapp.svg)
```

This will make the application icon available as a Qt resource under `qrc:/qt/qml/org/kde/myapp/org.kde.myapp.svg`. This can be used with any QML control that has an `icon.source` property.

The RESOURCES path depends on the place where the icons are installed. Traditionally, an `icons/` folder is created at the root of the project for storing all icons, as they don't really count as source files.

After the icons are installed (for Linux) and bundled (for Windows and Android), you can set it in code. In QML code, for compatibility with both Windows and Android, you should use the bundled icon; in C++ code, notably when setting the window icon, you can use the theme icon by default and the bundled icon as a fallback for `QGuiApplication::setWindowIcon()`:

```c++
QGuiApplication::setWindowIcon(QIcon::fromTheme("org.kde.myapp", QIcon(":/qt/qml/org/kde/myapp/org.kde.myapp.svg")));
```

### Kirigami icons

While Android does not have a standard directory where to install icons from an icon theme, it is possible to bundle the necessary Kirigami icons together with your Android application.

Two things are necessary for this to be done:

* Prepare the project with KIconThemes
* Include breeze-icons in your Craft blueprint
* kirigami_package_breeze_icons()

To set up KIconThemes, see the above section [KIconThemes](#kiconthemes).

To add breeze-icons as a dependency for your project, add this to your Craft blueprint:

```python
def setDependencies(self):
    # ...
    self.runtimeDependencies["kde/frameworks/tier1/breeze-icons"] = None
```

Because of the way the Android build is done, it is not possible for Craft to automatically do the icon bundling. Kirigami thus provides a CMake function [kirigami_package_breeze_icons()](https://invent.kde.org/frameworks/kirigami/-/blob/master/KF6KirigamiMacros.cmake) which, at build time, clones and prepares the icons for bundling. This command needs to come before the step detailed in [CMake function to package for Android](#build-apk).

The CMake command `kirigami_package_breeze_icons()` does not need to be wrapped behind a conditional, as it only ever runs when on Android.

Additionally, if you are using Kirigami Addons in your application, you may pass the [${KIRIGAMI_ADDONS_ICONS} variable](https://invent.kde.org/libraries/kirigami-addons/-/blob/master/KirigamiAddonsMacros.cmake) to also ship the necessary icons for components such as [FormCard.AboutPage](https://api-staging.kde.org/qml-org-kde-kirigamiaddons-formcard-aboutpage.html) and similar.

```cmake
kirigami_package_breeze_icons(ICONS
        org.kde.myapp insert-image-symbolic kde application-exit-symbolic
        edit-clear-all-symbolic edit-undo-symbolic document-save-symbolic
        applications-development-symbolic system-user-list donate-symbolic
        ${KIRIGAMI_ADDONS_ICONS}
)
```

## Android manifest {#android-manifest}

An [Android manifest](https://developer.android.com/guide/topics/manifest/manifest-intro) is an XML file describing the application to the Android build tools, operating system, and stores. The file *must* be called `AndroidManifest.xml`.

Qt uses the Android manifest and supports [additional configuration](https://doc.qt.io/qt-6/android-manifest-file-configuration.html) to call the necessary tools to build an APK that can be installed on Android.

KDE apps keep the manifest stored in an `android/` directory at the root of the project.

An Android manifest might look like this:

```xml
<?xml version='1.0' encoding='utf-8'?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
          package="org.kde.myapp"
          android:installLocation="auto">
    <application android:name="org.qtproject.qt.android.bindings.QtApplication" android:label="MyApp" android:usesCleartextTraffic="true" android:icon="@drawable/myapp">
        <activity android:configChanges="orientation|uiMode|screenLayout|screenSize|smallestScreenSize|layoutDirection|locale|fontScale|keyboard|keyboardHidden|navigation"
                  android:name="org.qtproject.qt.android.bindings.QtActivity"
                  android:label="MyApp"
                  android:windowSoftInputMode="adjustResize"
                  android:launchMode="singleTop"
                  android:exported="true">

            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>

            <meta-data android:name="android.app.lib_name" android:value="myapp"/>
        </activity>
    </application>

    <uses-permission android:name="android.permission.INTERNET" />
    
    <supports-screens android:largeScreens="true" android:normalScreens="true" android:anyDensity="true" android:smallScreens="true"/>
</manifest>
```

It is mostly boilerplate and can be copied and modified to an existing project, but it is worth learning what parts need to be accounted for.

In the `<manifest>` tag, the `package` corresponds to the name that identifies the application internally by Android. It needs to use [reverse DNS notation](https://en.wikipedia.org/wiki/Reverse_domain_name_notation). It should match the application ID specified in code.

In the `<application>` and `<activity>` tags, the `android:label` should be the user-facing name of the application. In the tag `<meta-data>`, `android:value` should match the target name as specified in CMake.

In the `<application>` tag, the `android:icon="@drawable/myapp"` should be an icon stored in `android/res/drawable/`, without the file extension. In this example, the file would be `android/res/drawable/myapp.png`. The `res` folder stands for "resources". If not specified, the default Android placeholder icon will be shown in the app menu and on the installation prompt instead.

An [Activity](https://developer.android.com/reference/android/app/Activity) stands for what the application will do in different states. For example, it might perform certain actions while on the foreground and other actions while on the background. Typically a Qt/KDE application has only one activity.

Each Activity can have one or more [Intent Filters](https://developer.android.com/guide/components/intents-filters). An Intent is something the activity is able to do, which in the case of a KDE application is usually an *action*, but can also be a *service*. For example, if the application *intends* to launch, then it needs to signal to Android that this Activity is the entrypoint for the app ([android.intent.action.MAIN](https://developer.android.com/reference/android/content/Intent#ACTION_MAIN)) and that the intent is of type [LAUNCHER](https://developer.android.com/reference/android/content/Intent#CATEGORY_LAUNCHER) to show up on the app menu screen and be able to launch. This should generally be sufficient for most KDE applications.

The `<meta-data>` tag can be repeated multiple times and have multiple purposes, and special [Qt-specific configurations](https://doc.qt.io/qt-6/android-manifest-file-configuration.html#qt-specific-meta-data) can be used. The `android.app.lib_name` metadata is required.

The `<uses-permission>` tag is straightforward and allows the application to request permission to perform a specific action. A Permission is different from an Intent in that the Intent requests another component to perform an action related to the activity, while a permission is a request for access to functionality that is by default not available.

The `<supports-screens>` tag specifies which form factors (screen sizes and pixel densities, phones or tablets) the application supports. Because QML applications are convergent, "any size" should be a reasonable default.

The only parts of the above example that are not required are `android:icon="@drawable/myapp"` (used only if your application already has an icon) and `<uses-permissions>` (which should only be added when actually needed).

## Gradle build file {#gradle-build}

## Splash screen {#splash}

A Splash Screen is an optional screen containing a static image or animation that shows up when launching an application to allow a few seconds for the app to initialize. When no splash screen is specified, the application will be shown as soon as it is opened, even if not ready.

To add it to your application, you will need to specify it in the AndroidManifest.xml metadata:

```xml
<meta-data android:name="android.app.splash_screen_drawable" android:resource="@drawable/splash"/>
```

In turn, an `android/res/drawable/splash.xml` file must exist:

```xml
<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:width="128dp" android:height="128dp" android:gravity="center">
        <bitmap
            android:layout_width="fill_parent"
            android:layout_height="fill_parent"
            android:scaleType="fitXY"
            android:src="@drawable/myapp"/>
    </item>
</layer-list>
```

This simple example commonly used in KDE applications centers the application icon in an empty background, and so an application icon residing in `android/res/drawable/` is required.

## Preparing an APK {#build-apk}

The last step needed to actually allow building an APK for Android is a simple CMake function that uses the files in the `android/` directory:

```cmake
ecm_add_android_apk(myapp
    ANDROID_DIR ${PROJECT_SOURCE_DIR}/android
)
```

## Building

To build your application on Android, follow [Building applications for Android](/docs/packaging/android/building_applications/).

## CI builds

If the project has been properly configured to build on Windows and is using KDE infrastructure for its code hosting (KDE Invent), it is possible to configure Android CI/CD jobs.

To do this, you will need to add the relevant CI templates for Windows with a `.gitlab-ci.yaml` file and list your dependencies in a `.kde-ci.yaml` file as mentioned in [Continuous Integration System](https://community.kde.org/Infrastructure/Continuous_Integration_System).

## Troubleshooting
