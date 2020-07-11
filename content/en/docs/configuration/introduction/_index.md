---
title: Introduction To KConfig
description: >
  An overview of the KConfig classes and how to use them in your application code
---

## Abstract

This tutorial looks at the KDE configuration data system, starting with an overview of the design fundamentals from an application developer's point of view. It then looks at the classes relevant to application development one by one before moving on to kiosk (user and group profiles) integration.

## Design Essentials

KConfig is designed to abstract away the concept of actual storage and retrieval of configuration settings behind an API that allows easy fetching and setting of information. Where and in what format the data is stored is not relevant to an application using KConfig. This keeps all KDE applications consistent in their handling of configurations while alleviating each and every application author to build such a system on their own from scratch, which can be a highly error prone exercise. 

A KConfig object represents a single configuration object. Each configuration object is referenced by its unique name and may be actually read from multiple local or remote files or services. Each application has a default configuration object associated with it and there is also a global configuration object. 

These configuration objects are broken down into a two level hierarchy: groups and keys. A configuration object can have any number of groups and each group can have one or more keys with associated values. 

Values stored may be of any number of data types. They are stored and retrieved as the objects themselves. For example, a QColor object is passed to a config object directly when storing a color value and when retrieved a QColor object is returned. Applications themselves therefore generally do not have to perform serialization and deserialization of objects themselves. 

## The KConfig Class

The [KConfig](https://api.kde.org/frameworks/kconfig/html/classKConfig.html) object is used to access a given configuration object. There are a number of ways to create a config object: 

{{< highlight cpp >}}
// a plain old read/write config object
KConfig config("myapprc");

// a specific file in the filesystem
// currently must be an INI style file
KConfig fullPath("/etc/kderc");

// not merged with global values
KConfig globalFree( "localsrc", KConfig::NoGlobals );

// not merged with globals or the $KDEDIRS hierarchy
KConfig simpleConfig( "simplerc", KConfig::SimpleConfig );

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

## Special Configuration Objects

Each application has its own configuration object that uses the name provided to [KAboutData](https://api.kde.org/frameworks/kcoreaddons/html/classKAboutData.html) appended with "rc" as its name. So an app named "myapp" would have the default configuration object of "myapprc" (located in $HOME/.local/config/). This configuration file can be retrieved in this way: 

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

## Commonly Useful Methods

To save the current state of the configuration object we call the `sync()` method. This method is also called when the object is destroyed. If no changes have been made or the resource reports itself as non-writable (such as in the case of the user not having write permissions to the file) then no disk activity occurs. `sync()` merges changes performed concurrently by other processes - local changes have priority, though. 





