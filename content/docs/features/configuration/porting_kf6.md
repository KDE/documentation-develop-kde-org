---
title: "KDE Frameworks 6 porting guide"
weight: 3
group: "features"
description: "Porting guide for KDE Config Modules to Qt6/KF6"
authors:
  - SPDX-FileCopyrightText: Alexander Lohnau <alexander.lohnau@gmx.de>
SPDX-License-Identifier: CC-BY-SA-4.0
categories: [Porting Guide]
---

KDE Config Modules ("KCMs") underwent significant changes during the KF6 transition.
This is a guide on how to port your KCMs to KF6!
Note that KF6 is still a work in progress and will be subject to breaking changes.
This guide will be updated accordingly, but can be expected to change before the
initial release of KF6.

### Build system and class name changes
In KF5, the code for QML KCMs was in KDeclarative, the code for QWidgets KCMs was in KConfigWidgets.
In KF6, all relevant classes are in KCMUtils.
The `KCModule` class is contained in the `KF6::KCMUtils` CMake library, and the `ConfigModule`/`ManagedConfigModule` classes for QML KCMs are in the
`KF6::KCMUtilsQuick` library. `KCModuleData` is now part of `KF6::KCMUtilsCore`,
but both the QWidgets and QML libraries publicly link against it.

Since the QML classes are no longer in KDeclarative, the `KQuickAddons` namespace is no longer suitable.
Because of this, `KDeclarative::ConfigModule` has been renamed to `KQuickConfigModule` and `KQuickAddons::ManagedConfigModule` is now `KQuickManagedConfigModule`.

### Class-hierarchy changes
In KF5, the APIs of the QML and QWidgets KCMs were very different. This causes mental burden when working with different UI technologies.
In KF6, we have the `KAbstractConfigModule` class, which contains all the APIs that are not specific to a specific UI technology.
Since the QML KCMs are more widely used in KDE nowadays and the API is cleaner, most API was copied from those classes.

### Changes to `ConfigModule` and `ManagedConfigModule`
The QQmlComponent::Status getter was removed for lack of usage. `showPassiveNotification`/`passiveNotificationRequested` were also removed.
The attached `quickHelp` property was also removed because it is not used when displaying KCMs.
Setting a `rootOnlyMessage` was also removed due to it being unused.

We no longer use KPackage to install QML files and instead bundle them as QRC.
This way all needed files are embedded in the plugin. This simplifies testing and installation.
All QML files should be put in a folder called "ui". Using `kcmutils_add_qml_kcm(my_kcm)` a plugin target will be created and the files in the "ui" folder will be bundled.
This macro also takes care of installing the plugin in the "plasma/kcms/systemsettings" namespace. You can override it using the `INSTALL_NAMESPACE` parameter.
You can also specify source files using the optional `SOURCES` parameter. All arguments work just like the `kcoreaddons_add_plugin` macro.
This macro also takes care of generating a desktop file for the KCM. This is for example needed if you want to pin a KCM to the taskmanager.
If it isn't needed, it can be turned off using the `DISABLE_DESKTOP_FILE_GENERATION` option.

All parameters are used in the following example. But in most cases, providing only the first parameter (target name) is enough.
```cmake
kcmutils_add_qml_kcm(my_kcm DISABLE_DESKTOP_FILE_GENERATION SOURCES kcm.coo INSTALL_NAMESPACE plasma/kcms/kinfocenter)
target_link_libraries(my_kcm ...)
```

#### Changes to QML modules
The `org.kde.kcm` QML module from KDeclarative has been moved to KCMUtils under the name `org.kde.kcmutils`.
All versions of registered files are 1.0. For consistency, `KPluginSelector` and `KPluginDelegate` were renamed to `PluginSelector` and `PluginDelegate`.
It is recommended to use a "namespaced" imports, e.g. `import org.kde.kcmutils as KCMUtils`.

The `KCMShell` class from `org.kde.kquickcontrolsaddons` has been moved to the mentioned KCMUtils QML module and is now called `KCMLauncher`.
The `open`, `openSystemSettings` and `openInfoCenter` methods are identical.
For checking whether a KCM is allowed to be displayed, use `KAuthorized` from the `org.kde.config` QML module.

```qml
import org.kde.config
if (KAuthorized.authorizeControlModule("kcm_clock")) {
    // Launch the KCM or do other logic
}
const allowedKCMs = KAuthorized.authorizeControlModules(["kcm_clock", "kcm_icons"])
// Do something with the allowed KCMs
```

### Changes to KCModule class
Due to the class hierarchy changes, `KCModule` is no longer a subclass of QWidget. To get access to a KCModule's QWidget, call the `widget()` method.
This should be used when you need the parent widget.
Due to the class no longer being a QWidget subclass, [KPluginFactory](docs:kcoreaddons;KPluginFactory) passes in a QObject * instead of QWidget* for the parent.
We internally cast this to a QWidget, but for the constructor it should be changed to QObject.

API using [KAboutData](docs:kcoreaddons;KAboutData) was removed, because metadata should be set using [KPluginMetaData](docs:kcoreaddons;KPluginMetaData) instead.
In the constructor, take the `const KPluginMetaData &data` argument and pass it to the `KCModule` baseclass.
For plugins embedded in e.g. a [KPluginWidget](docs:kcmutils;KPluginWidget), this can be omitted.

The `setAuthAction` and `authAction` methods where removed, because you should take care of creating the `KAuth::Action` manually.
In the relevant methods you should execute the action.
To signal that the KCM requires administrative privileges when saving changes, use the `setNeedsAuthorization` method or set the `setAuthActionName`.
The latter value can be retrieved using the `authActionName` getter, which internally calls `setNeedsAuthorization`.

Instead of `Q_SIGNAL void changed(bool hasChanged)`, use `setNeedsSave(bool needsSave)`. For connections, use `void markAsChanged()`.
Instead of `Q_SIGNAL void defaulted(bool state)`, use `void setRepresentsDefault(bool defaults)`

#### Compatibility API in KConfigWidgets 5.105
This release of KDE Frameworks introduced compatibility compatibility logic to ease the transition.
This includes the methods `QWidget *widget()` and `void setNeedsSave(bool needsSave)`, so you can port to them while still using KF5..
Also, the `KCModule(QObject *parent, const KPluginMetaData & data = {}, const QVariantList &args = QVariantList())` constructor was added.

### Changes to other KCMUtils API
The `KCModuleProxy` class has been removed. Instead, use `KCModuleLoader` to get a `KCModule` instance and embed the result of `KCModule::widget` in it.
In case your app already has a `QQmlEngine` instance or needs one in other places, explicitly pass in the engine in for loading QML based KCMs.
For loading `KQuickConfigModule`/`KQuickManagedConfigModule` instances, use `KQuickModuleLoader`.
Use the `QQmlEngine` parameter as explained for the `KCModuleLoader`.
