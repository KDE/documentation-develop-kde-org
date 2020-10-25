---
title: Introduction To KConfig
description: >
  An overview of the KConfig classes and how to use them in your application code
weight: 1
---

## Abstract

This tutorial looks at the KDE configuration data system, starting with an overview of the design fundamentals from an application developer's point of view. It then looks at the classes relevant to application development one by one before moving on to kiosk (user and group profiles) integration.

## Design Essentials

KConfig is designed to abstract away the concept of actual storage and retrieval of configuration settings behind an API that allows easy fetching and setting of information. Where and in what format the data is stored is not relevant to an application using KConfig. This keeps all KDE applications consistent in their handling of configurations while alleviating each and every application author to build such a system on their own from scratch, which can be a highly error prone exercise. 

A KConfig object represents a single configuration object. Each configuration object is referenced by its unique name and may be actually read from multiple local or remote files or services. Each application has a default configuration object associated with it and there is also a global configuration object. 

These configuration objects are broken down into a two level hierarchy: groups and keys. A configuration object can have any number of groups and each group can have one or more keys with associated values. 

Values stored may be of any number of data types. They are stored and retrieved as the objects themselves. For example, a QColor object is passed to a config object directly when storing a color value and when retrieved a QColor object is returned. Applications themselves therefore generally do not have to perform serialization and deserialization of objects themselves. 

### The KConfig Class

The [KConfig](docs:kconfig;KConfig) object is used to access a given configuration object. There are a number of ways to create a config object:

{{< highlight cpp >}}
// a plain old read/write config object
KConfig config("myapprc");

// a specific file in the filesystem
// currently must be an INI style file
KConfig fullPath("/etc/kderc");

// not merged with global values
KConfig globalFree("localsrc", KConfig::NoGlobals);

// not merged with globals or the $KDEDIRS hierarchy
KConfig simpleConfig("simplerc", KConfig::SimpleConfig);

// outside the standard config resource
KConfig dataResource("data", KConfig::SimpleConfig, QStandardPaths::AppDataLocation);
{{< /highlight >}}

The KConfig object create on line 2 is a regular config object. We can read values from it, write new entries and ask for various properties of the object. This object will be loaded from the config resource as determined by [QStandardPaths](https://doc.qt.io/qt-5/qstandardpaths.html), meaning that every instance of the myapprc object in each of the directories in the config resource hierarchy will be merged to create the values seen in this object. This is how system wide and per-user/group profiles are generated and supported and it all happens transparently to the application itself. 

{{< alert title="Tip" color="success" >}}
For more information on how the merging works, see the [KDE Filesystem Hierarchy](https://userbase.kde.org/KDE_System_Administration/KDE_Filesystem_Hierarchy) article.
{{< /alert >}}

On line 6 we open a specific local file, this case `/etc/kderc`. This performs no merging of values and expects an INI style file. 

Line 9 sees the creation of a configuration object that is not merged with the global kdeglobals configuration object, while the configuration file on line 12 is additionally not merged with any files in the XDG directories hierarchy. This can noticeably improve performance in the case where one is simply reading values out of a simple configuration for which global values are not meaningful. 

Finally on line 18 we see the creation of a configuration object that does not exist in the config resource but rather in the application data resource. You may use any StandardLocation that QStandardPaths contains.

### Special Configuration Objects

Each application has its own configuration object that uses the name provided to [KAboutData](docs:kcoreaddons;KAboutData) appended with "rc" as its name. So an app named "myapp" would have the default configuration object of "myapprc" (located in $HOME/.config/). This configuration file can be retrieved in this way:

```cpp
#include <KComponentData>
#include <KConfig>
#include <KGlobal>

MyClass::MyClass()
{
    // note that this is actually a KSharedConfig
    // more on that class in a bit!
    KConfig *config = KGlobal::config();
}
```

The default configuration object for the application is accessed when no name is specified when creating a `KConfig` object. So we could also do this instead - but it would be slower because it would have to parse the whole file again: 

```cpp
#include <KConfig>

MyClass::MyClass()
{
    KConfig config;
}
```

Finally there is a global configuration object, `kdeglobals`, that is shared by every application. It holds such information as the default application shortcuts for various actions. It is "blended" into the configuration object if the `KConfig::IncludeGlobals` flag is passed to the KConfig constructor, which is the default. 

### Commonly Useful Methods

To save the current state of the configuration object we call the `sync()` method. This method is also called when the object is destroyed. If no changes have been made or the resource reports itself as non-writable (such as in the case of the user not having write permissions to the file) then no disk activity occurs. `sync()` merges changes performed concurrently by other processes - local changes have priority, though. 

If we want to make sure that we have the latest values from disk we can call `reparseConfiguration()` which calls `sync()` and then reloads the data from disk. 

If we need to prevent the config object from saving already made modifications to disk we need to call `markAsClean()`. A particular use case for this is rolling back the configuration to the on-disk state by calling `markAsClean()` followed by `reparseConfiguration()`. 

Listing all groups in a configuration object is as simple as calling `groupList()` as in this code snippet: 

```cpp
const KSharedConfigPtr config = KGlobal::mainComponent().config();

for (const QString &group: config->groupList()) {
    qDebug() << "next group:" << group;
}
```

## KSharedConfig

The [KSharedConfig](docs:kconfig;KSharedConfig) class is a reference counted pointer to a [KConfig](docs:kconfig;KConfig). It thus provides a way to reference the same configuration object from multiple places in your application without the extra overhead of separate objects or concerns about synchronizing writes to disk even if the configuration object is updated from multiple code paths.

Accessing a [KSharedConfig](docs:kconfig;KSharedConfig) object is as easy as this:

```cpp
KSharedConfigPtr config = KSharedConfig::openConfig("ksomefilerc");
```

`openConfig()` take the same parameters as `KConfig`'s constructors do, allowing one to define which configuration file to open, flags to control merging and non-config resources. 

`KSharedConfig` is generally recommended over using `KConfig` itself.

## KConfigGroup

Now that we have a configuration object, the next step is to actually use it. The first thing we must do is to define which group of key/value pairs we wish to access in the object. We do this by creating a `KConfigGroup` object: 

```cpp
KConfig config;
KConfigGroup generalGroup(&config, "General");
KConfigGroup colorsGroup = config.group("Colors"); // ... or a bit differently ...
```

You can pass [KConfig](docs:kconfig;KConfig) or [KSharedConfig](docs:kconfig;KSharedConfig) objects to [KConfigGroup](docs:kconfig;KConfigGroup).

Config groups can be nested as well: 

```cpp
KConfigGroup subGroup1(&generalGroup, "LessGeneral");
KConfigGroup subGroup2 = colorsGroup.group("Dialogs");
```

## Reading Entries

With a [KConfigGroup](docs:kconfig;KConfigGroup) object in hand reading entries is now quite straight forward:

```cpp
QString accountName = generalGroup.readEntry("Account", QString());
QColor color = colorsGroup.readEntry("background", QColor(Qt::white));
QStringList list = generalGroup.readEntry("List", QStringList());
QString path = generalGroup.readPathEntry("SaveTo", defaultPath);
```

As can be seen from the above, you can mix reads from different `KConfigGroup` objects created on the same `KConfig` object. The read methods take the key, which is case sensitive, as the first argument and the default value as the second argument. This argument controls what kind of data, e.g. a color in line 3 above, is to be expected as well as the type of object returned. The returned object is wrapped in a `QVariant` to make this magic happen. 

There are a couple of special read methods, including `readPathEntry` which returns a file system path. It is vital that one uses `readPathEntry` if it is a path as this enables such features as roaming profiles to work properly. 

If no such key currently exists in the configuration object, the default value is returned instead. If there is a localized (e.g. translated into another language) entry for the key that matches the current locale, that is returned. 

## Writing Entries

Setting new values is similarly straightforward: 

```cpp
generalGroup.writeEntry("Account", accountName);
generalGroup.writePathEntry("SaveTo", savePath);
colorGroup.writeEntry("background", color);
generalGroup.config()->sync();
```

Note the use of `writePathEntry` and how the type of object we use, such as [QColor](https://doc.qt.io/qt-5/qcolor.html) on line 3, dictates how the data is serialized. Additionally, once we are done writing entries, `sync()` must be called on the config object for it to be saved to disk. We can also simply wait for the object to be destroyed, which triggers an automatic `sync()` if necessary. 

## KDesktopFile: A Special Case

When is a configuration file not a configuration file? When it is a [desktop](http://freedesktop.org/wiki/Specifications/desktop-entry-spec) file. These files, which are essentially configuration files at their heart, are used to describe entries for application menus, mimetypes, plugins and various services. 

When accessing a .desktop file, one should instead use the [KDesktopFile](docs:kconfig;KDesktopFile) class which, while a [KConfig](docs:kconfig;KConfig) class offering all the capabilities described above, offers a set of methods designed to make accessing standard attributes of these files consistent and reliable.

## Kiosk: Lockdown and User/Group Profiles

KConfig provides a powerful set of lockdown and configuration definition capabilities, collectively known as "Kiosk", that many system administrators and system integrators rely on. While most of this framework is provided transparently to the application, there is occassion when an application will want to check on the read/write status of a configuration object. 

Entries in configuration objects that are locked down using the kiosk facilities are said to be immutable. An application can check for immutability of entire configuration objects, groups or keys as shown in this example: 

```cpp
KSharedConfigPtr config = KGlobal::config();

if (config->isImmutable()) {
    qDebug() << "configuration object is immutable";
}

KConfigGroup group(config, "General");
if (group.isImmutable()) {
    qDebug() << "group General is immutable";
}

if (group.isEntryImmutable("URL")) {
    qDebug() << "URL entry in group General is immutable";
}
```

This can be useful in particular situations where an action should be taken when an item is immutable. For instance, the KDE panels will not offer configuration options to the user or allow them to otherwise change the order of applets and icons when the panel's configuration object is marked as immutable. 

## KConfig XT

There is a way to make certain use cases of KConfig easier, faster and more reliable: KConfig XT. In particular, for main application or plugin configuration objects and when syncing configuration dialogs and other interfaces with these values, KConfig XT can help immensely. It also simultaneously documents the configuration options available, which makes every sys admin and system integrator that uses KDE that much more happy. 

[The next tutorial in the KConfig series covers what KConfig XT is and how to use it.](../kconfig_xt)
