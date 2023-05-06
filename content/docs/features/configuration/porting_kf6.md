---
title: "Porting guide to KF6"
weight: 3
group: "features"
description: "Porting guide for KDE Config Modules to Qt6/KF6"
---

The config modules had a lot of significant changes during the KF6 transition.
This is a porting-guide to get your KCMs ready for KF6!

### Build system and class name changes
In KF5, the code for QML KCMs was in KDeclarative and for QWidgets KCMs in KConfigWidgets.
In KF6, all relevant classes are in KCMUtils.
The `KCModule` class is contained in the `KF6::KCMUtils` CMake library and the `ConfigModule`/`ManagedConfigModule` classes
for QML KCMs are in the `KF6::KCMUtilsQuick` library.
`KCModuleData` is now part of `KF6::KCMUtilsCore`, but both the QWidgets and QML libraries link public against it.

Since the QML classes are no longer in KDeclarative, the `KQuickAddons` namespace is no longer suitable.
Because of this, `KDeclarative::ConfigModule` to renamed to `KQuickConfigModule` and `KQuickAddons::ManagedConfigModule` to `KQuickManagedConfigModule`.

### Changes to `ConfigModule` and `ManagedConfigModule`
The QQmlComponent::Status getter was removed for lack of usage. `showPassiveNotification`/`passiveNotificationRequested` were also removed.
The attached `quickHelp` property was also removed, because it is not used when displaying KCMs.

Also, we no longer use KPackage to install QML files, instead we bundle them as QRC.
This way all needed files are embedded in the plugin. This simplifies testing and installation.
All QML files should be put in a folder called "ui". Using `kcmutils_add_qml_kcm(my_kcm)` a plugin target will be created and the files in the "ui" folder will be bundled.
This macro also takes care of installing the plugin in the "plasma/kcms/systemsettings" namespace. You can override it using the `INSTALL_NAMESPACE` parameter.
Also, you can specify source files using the optional `SOURCES` parameter. All arguments work just like the `kcoreaddons_add_plugin` macro.
This macro also takes care of generating a desktop file for the KCM. This is for example needed if you want to pin a KCM to the taskmanager.
In case you do not need it, it can be turned off using the `DISABLE_DESKTOP_FILE_GENERATION` option.

In the following, you can see an example where all parameters are used. But in most cases, providing only the target name is enough.
```cmake
kcmutils_add_qml_kcm(my_kcm DISABLE_DESKTOP_FILE_GENERATION SOURCES kcm.coo INSTALL_NAMESPACE plasma/kcms/kinfocenter)
target_link_libraries(my_kcm ...)
```
