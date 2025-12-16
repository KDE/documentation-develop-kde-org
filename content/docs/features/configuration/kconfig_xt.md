---
SPDX-FileCopyrightText: 2006 Zack Rusin <zack@kde.org>
SPDX-LicenseRef: CC-BY-SA-4.0
title: Using KConfig XT
description: >
  This tutorial introduces the main concepts of the KConfigXT configuration framework and shows how to efficiently use it in applications.
weight: 2
aliases:
  - /docs/features/configuration/kconfig_xt/
---

KConfigXT generates a C++ class for your configuration based on an XML description of the config schema.
This allows to have a single source of truth for the configuration structure and helps avoiding common issues such as misspelled configuration keys.

## The .kcfg file

A `.kcfg` file is an XML file describing the configuration keys for your
application. Let's create a `.kcfg` file with a single group and a few entries.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<kcfg xmlns="http://www.kde.org/standards/kcfg/1.0"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.kde.org/standards/kcfg/1.0
                          http://www.kde.org/standards/kcfg/1.0/kcfg.xsd" >
  <group name="General">
    <entry name="SplitterSizes" type="IntList">
      <label>How the main window is divided.</label>
    </entry>
    <entry name="Width" type="Int">
      <label>Width of the main window.</label>
      <default>600</default>
    </entry>
    <entry name="Platform" type="Enum">
      <label>Last operating system used.</label>
      <choices>
        <choice name="Linux">
          <label>Linux</label>
        </choice>
        <choice name="FreeBSD">
          <label>FreeBSD</label>
        </choice>
        <choice name="Windows">
          <label>Windows</label>
        </choice>
      </choices>
      <default>0</default> <!-- Linux -->
    </entry>
  </group>
</kcfg>
```

The first entry, `SplitterSizes`, will store the sizes of the
application's QSplitter widgets. The second entry, `Width`, will store the width of the
main window. The last entry, `Platform`, will store the last operating system used, this
is an enum, and the value can be either Linux, FreeBSD or Windows.

The individual entries must have at least a name or a key attribute. The key is used
as the key in the config file. The name is used to create accessor and modifier
functions.  If `key` is not given, the name is used as the key in the config file. If `key` is
given, but not `name`, the name is constructed by removing all spaces from the `key`.

All entries have a type. The supported basic types are: `String`, `Url`,
`StringList`, `Font`, `Rect`, `Size`, `Color`, `Point`, `Int`, `UInt`, `Bool`, `Double`,
`DateTime`, `Int64`, `UInt64` and `Password`. Besides those basic types the following
special types are supported: 

+ **Path:** This is a string that is specially treated as a file-path. In particular
paths in the home directory are prefixed with `$HOME` when being stored in the
configuration file.
+ **Enum:** This indicates an enumeration. The possible enum values should be provided
via the `<choices>` tag. Enum values are accessed as integers by the application but
stored as literal strings in the configuration file. This makes it possible to add more values
at a later date without breaking compatibility. The `value` attribute is used to control
the string representation of the `choice` tag.
+ **IntList:** This indicates a list of integers. This information is provided to the
application as `QList<int>`. Useful for storing `QSplitter` geometries for example.
* **PathList:** List of Path elements.
+ **Color:** isn't a special type but has special input. It is generated as `QColor`.
Any valid input to `QColor(QString)` can be used (hex or SVG keyword notation) as well
as the special format "r,g,b,a" (where "a" denotes the alpha channel and may be omitted).

It is recommended to always add `<label>` and `<tooltip>` tags to your entries in
which you describe the configuration options. The `<label>` tag is used for short
descriptions of the entry, while `<tooltip>` contains more verbose documentation. It's
important for tools like `KConfigEditor` (now unmaintained) which can be used by
systems administrators to setup machines over remotely. Note that these tags
will be ignored unless you provide `SetUserTexts=true` option in your `.kcfgc` file
(see section on it below).

The `<min>` and `<max>` tags can be used to set the lower and upper limits (inclusive) to the value of integral type options, respectively.

You can also add an `<emit>` tag, if you want to specify the signal to emit when the
property changes.

An entry can optionally have a default value which is used when the value
isn't specified in any config file. Default values are interpreted as literal constant
values.  A default value can be either an enum value or the index of an enum.

### Compute the default value

Sometimes it is useful to dynamically compute a default value from a C++ expression. This can be done by adding the `code="true"` attribute to the `<default>` tag. Please be aware that that any default value set this way will be not be persisted by the configuration system and is recomputed each time the generated settings class is instantiated (even if a different configuration value has been set).

In addition, the code inside of a `default` tag will be used as parameter of a function call, so this is a valid code for the `default` tag:

`<default code="true"> true </default>`

while this is not:

`<default code="true"> return true </default>`

If you need to do calculations on the default, you can use the fact that a lambda in C++ will can be defined and evaluated at the same time, you should also keep in mind that this code is running on the constructor, so you can’t rely on other default values.

```xml
<default code="true">
      [this] {
         int someValue = OtherLibrary::precalculate();
         if (someValue % 2 == 0) {
           return "Even";
         }
           return "Odd";
      } ()
   </default>
```

In case you need to import a C++ header to compute the default value, you can add an
`<include>` tag to the .kcfg file which contains the header file that is needed.
Note that more than one `<include>` tag can be used as needed. 

Additional code for computing default values can be provided via the `<code>` tag.
The content of the `<code>` tag is inserted as-is. A typical use for this, is to
compute a common default value which can then be referenced by subsequent entries.

## Using variables inside of the Configuration Definition

Sometimes you want to create logic that's reusable inside of different groups,
supergroups, or to handle defaults. You can define variables that are passed via the
constructor of the Configuration.

```xml
<kcfg>
    <kcfgfile name="rc_file_for_the_setting">
        <parameter name="masterGroup"/>
    </kcfgfile>

    <group name="Global" parentGroupName="$(masterGroup)">
      <entry> ... </entry>
    </group>
</kcfg>
```

This will generate a code that can be used like this:

```c++
auto *settings = new Settings("MyMasterGroup");
```

And the stored file on disk will have the MyMasterGroup 
## The .kcfgc files

While the `.kcfg` file lists the configuration keys in the application, KConfigXT can generate the necessary code for your application to make use of these configuration keys in a `.kcfgc` file. The way this code is generated is controlled via a CMake call [kconfig_target_kcfg_file()](https://invent.kde.org/frameworks/kconfig/-/blob/master/KF6ConfigMacros.cmake#L9):

```cmake
kconfig_target_kcfg_file(myapp
  FILE config.kcfg
  CLASS_NAME Config
  MUTATORS
  DEFAULT_VALUE_GETTERS
  SINGLETON
)
```

`FILE` and `CLASS_NAME` are mandatory and any other arguments are optional. For keywords like `MUTATORS` that appear standalone, the presence of the keyword implies a boolean value of `true`. All available keywords can be seen in the [KConfig CMake documentation](https://invent.kde.org/frameworks/kconfig/-/blob/master/KF6ConfigMacros.cmake#L9) and the full list of file options can be seen in the [kconfig_compiler documentation](https://api.kde.org/kconfigcompiler.html).

The first argument `FILE config.kcfg` specifies where the configuration options for your
application are stored.

The second line `CLASS_NAME Config` specifies the name of the class
that will be generated from the .kcfg file.

With this CMake call, compiling the project will result in the `config.{h,cpp}` files being generated based on the class name. They can then be included in other source code files.

## Reading and setting values

### C++

To access our kcfg file, we must instantiate the generated class.

```cpp
#include "config.h"

...

auto config = Config::self();
```

Each entry in our kcfg file automatically gets matching getter and setter functions. These functions use the names of the entries that we have created, according to their `name` or `key` attributes in their `<entry>` tags.

Using these functions is as simple as you might expect:

```cpp
auto config = Config::self();

int currentWidth = config->width();

if(currentWidth != 720)
  config->setWidth(720);
```

### QML

To access our configuration files in QML, add the keyword `GENERATE_PROPERTIES` to the CMake call, and register the `Config` class as a singleton on `main.cpp`.

```cpp
auto config = Config::self();
qmlRegisterSingletonInstance("org.kde.myapp.private", 1, 0, "Config", config);
```

Our config class will now be instance throughout our QML as `Config`. All of our entries in our kcfg are accessible as members of this instance. From the QML side options are exposed as properties (no setters and getters).

```qml
import org.kde.myapp.private 1.0

Kirigami.ApplicationWindow {
  width: Config.width

  onWidthChanged {
    Config.width = applicationWindow().width
  }
}
```

### Managed Config Module (KCM)

If you want to [develop a KCM]({{< ref "kcm" >}}) that uses KConfigXT, you
shouldn't use a singleton config instance. Instead, you should make it a part of
your `ManagedConfigModule` class and make it accept `parent` argument.

To do this, you need to add the `PARENT_IN_CONSTRUCTOR` keyword.
This option allows generating a
`Config` class that takes an optional `QObject *parent` argument. This allows
your `ManagedConfigModule` to watch for changes in the KCM: once you change
something using controls on the QML side, the KCM will indicate that the changes
were made and will offer you to save or reset them.

Do not forget that to make changes you need setters and properties in `Config`
class, which are generated using `MUTATORS` and `GENERATE_PROPERTIES`.

To expose your config to QML side of the KCM you need to make it a constant
`Q_PROPERTY` with read access.

```cpp
// mykcm.h

#pragma once

#include <KQuickAddons/ManagedConfigModule>

// This should be a class generated by kcfgc
#include "my_config.h"

class MyKcm : public KQuickAddons::ManagedConfigModule {
  Q_OBJECT

  Q_PROPERTY(My::Config *config READ config CONSTANT)

public:
  MyKcm(QObject *parent, const QVariantList &args);

  My::Config *config() const;

private:
  My::Config *m_config;
};
```

Instead of registering a singleton, you must use
[qmlRegisterAnonymousType()](https://doc.qt.io/qt-6/qqml-h.html#qmlRegisterAnonymousType)
here.

```cpp
// mykcm.cpp

#include "mykcm.h"
#include "my_config.h"

// ...

K_PLUGIN_CLASS_WITH_JSON(MyKcm, "metadata.json")

MyKcm::MyKcm(QObject *parent, const QVariantList &args)
    : KQuickAddons::ManagedConfigModule(parent, args),
      m_config(new My::Config(this)) {
  // ...
  qmlRegisterAnonymousType<My::Config>("org.kde.mykcm.private", 1);
  // ...
}

My::Config *MyKcm::config() const { return m_config; }

#include "mykcm.moc"
```

Now you can access all your defined configurations using the anonymous `kcm` property, that inherits from
[AbstractKCM](docs:kcmutilsqml;org.kde.kcmutils.AbstractKCM).

```qml
import org.kde.kcm 1.5 as KCM
import QtQuick.Controls 2.12 as QQC2

KCM.SimpleKCM {
  // ...
  QQC2.SpinBox {
    value: kcm.config.width
    onValueModified: kcm.config.width = value
  }
  // ...
}
```

Additionally, you can use [SettingStateBinding](docs:kcmutilsqml;org.kde.kcmutils.SettingStateBinding)
in your QML code to display correctly if your setting is immutable or isn't using the default value 
anymore.

```qml
import org.kde.kcm 1.5 as KCM
import QtQuick.Controls 2.12 as QQC2

KCM.SimpleKCM {
    // ...
    QQC2.SpinBox {
        value: kcm.config.width
        onValueModified: kcm.config.width = value

        KCM.SettingStateBinding {
            configObject: kcm.config
            settingName: "width"
        }
    }
    // ...
}
```

