---
title: "Porting guide to KF6"
weight: 3
group: "features"
description: "Porting guide for KDE Config Modules to Qt6/KF6"
---

The config modules had a lot of significant changes during the KF6 transition.
This is a porting-guide to get your KCMs ready for KF6!
Note that KF6 is still a work in progress and will be subject to breaking changes.

### Build system and class name changes
In KF5, the code for QML KCMs was in KDeclarative and for QWidgets KCMs in KConfigWidgets.
In KF6, all relevant classes are in KCMUtils.
The `KCModule` class is contained in the `KF6::KCMUtils` CMake library and the `ConfigModule`/`ManagedConfigModule` classes
for QML KCMs are in the `KF6::KCMUtilsQuick` library.
`KCModuleData` is now part of `KF6::KCMUtilsCore`, but both the QWidgets and QML libraries link public against it.

Since the QML classes are no longer in KDeclarative, the `KQuickAddons` namespace is no longer suitable.
Because of this, `KDeclarative::ConfigModule` to renamed to `KQuickConfigModule` and `KQuickAddons::ManagedConfigModule` to `KQuickManagedConfigModule`.

### Class-hierarchy changes
In KF5, the APIs of the QML and QWidgets KCMs were very different. This causes a mental burden when working with different UI-technologies.
In KF6, we have the `KAbstractConfigModule` class, which contains all the APIs that are not specific to to any of UI-technology.
Since the QML KCMs are more widely used in KDE nowadays and the API is cleaner, most API was copied from those classes.

### Changes to `ConfigModule` and `ManagedConfigModule`
The QQmlComponent::Status getter was removed for lack of usage. `showPassiveNotification`/`passiveNotificationRequested` were also removed.
The attached `quickHelp` property was also removed, because it is not used when displaying KCMs.
Setting a `rootOnlyMessage` was also removed due to it being unused.

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

#### Changes to QML modules
The `org.kde.kcm` QML module from KDeclarative has been moved to KCMUtils under the name `org.kde.kcmutils`.
All versions of registered files are 1.0. For consistency, `KPluginSelector` and `KPluginDelegate` were renamed to `PluginSelector` and `PluginDelegate`.
It is recommended to use a "namespaced" imports, like `import org.kde.kcmutils as KCMUtils`.

The `KCMShell` class from `org.kde.kquickcontrolsaddons` has been moved to the mentioned KCMutils QML module and is not called `KCMLauncher`.
The `open`, `openSystemSettings` and `openInfoCenter` methods are identical.
For checking of a KCM is authorized, you should use `KAuthorized` from the `org.kde.config` QML module.

```qml
import org.kde.config
if (KAuthorized.authorizeControlModule("kcm_clock")) {
    // Launch the KCM or do other logic
}
const allowedKCMs = KAuthorized.authorizeControlModules(["kcm_clock", "kcm_icons"])
// Do sth. with the allowed KCMs
```

### Changes to KCModule class
Due to the class hierarchy changes, `KCModule` can no longer extend from QWidget. To get access to a KCModule's QWidget, you can call the `widget()` method.
This should be used when you need the parent widget.
Due to the class no longer extending from a QWidget, [KPluginFactory](docs:kcoreaddons;KPluginFactory) passes in a QObject * instead of QWidget* for the parent.
We internally cast this to a QWidget, but for the constructor it should be changed to QObject.

API using [KAboutData](docs:kcoreaddons;KAboutData) was removed, because metadata should be set using [KPluginMetaData](docs:kcoreaddons;KPluginMetaData) instead.
In the constructor, you should take the `const KPluginMetaData &data` argument and pass it to the `KCModule` baseclass.
For plugins that embedded in for example a [KPluginWidget](docs:kcmutils;KPluginWidget), this can be omitted.

The `setAuthAction` and `authAction` methods where removed, because you should take care of creating the `KAuth::Action` manually.
In the relevant methods you should execute the action.
To signal that the KCM needs authorization, you can use the `setNeedsAuthorization` method or set the `setAuthActionName`.
The latter value can be retrieved using the `authActionName` getter and internally calls `setNeedsAuthorization`.

Instead of `Q_SIGNAL void changed(bool hasChanged)`, you can use `setNeedsSave(bool needsSave)`. For connects, can use `void markAsChanged()`.
Instead of `Q_SIGNAL void defaulted(bool state)`, `void setRepresentsDefault(bool defaults)` should be used.

#### Compatibility API in KConfigWidgets 5.105
This release of KDE Frameworks introduced compatibility compatibility logic to easy the transition.
This includes `QWidget *widget()` and `void setNeedsSave(bool needsSave)`.
Also, the `KCModule(QObject *parent, const KPluginMetaData & data = {}, const QVariantList &args = QVariantList())` constructor was added.

### Changes to other KCMUtils API
The `KCModuleProxy` class has been removed. Instead, you should use `KCModuleLoader` to get a `KCModule` instance and embed the result of `KCModule::widget`.
In case your app has already a  `QQmlEngine` instance or needs one in other places, you should explicitly pass in the engine in for loading QML based KCMs.
For loading `KQuickConfigModule`/`KQuickManagedConfigModule` instances you should use `KQuickModuleLoader`.
You should use the `QQmlEngine` parameter as explained for the `KCModuleLoader`.
