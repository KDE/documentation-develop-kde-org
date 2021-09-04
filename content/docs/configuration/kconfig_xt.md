---
SPDX-FileCopyrightText: 2006 Zack Rusin <zack@kde.org>
SPDX-LicenseRef: CC-BY-SA-4.0
title: Using KConfig XT
description: >
  This tutorial introduces the main concepts of the KConfigXT configuration framework and shows how to efficiently use it in applications.
weight: 2
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
        <default>Linux</default>
      </choices>
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
values. 

### Compute the default value

Sometimes it is useful to dynamically compute a default value from a C++ expression.
This can be done by adding the `code=true` attribute to the `<default>` tag. Please be
aware that the code inside of a `default` tag will be used as parameter of a function call.
This is a valid code for the `default` tag:

`<default> true </default>`

this is not:

`<default> return true </default>`

If you need to do calculations on the default, you can use the fact that a lambda in c++
will can be defined and evaluated at the same time, you should also keep in mind that this code
is running on the constructor, so you can't rely on other default values.

```xml
<default type="code">
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

The behavior of KConfigXT is controlled by a `.kcfgc` file.

```ini
File=config.kcfg
ClassName=Config
Mutators=true
DefaultValueGetters=true
Singleton=true
```

The first line `File=config.kcfg` specifies where the configuration options for your
application are stored.

The second line `ClassName=YourConfigClassName` specifies the name of the class
that will be generated from the .kcfg file. Save this file under yourconfigclassname.kcfgc.
This will result in the yourconfigclassname.{h,cpp} files being generated.

{{< alert title="Note" color="info" >}}
KConfigXT offers a variety of options. The full list can be seen in the [kconfig_compiler documentation](docs:kconfig;kconfig_compiler.html).
{{< /alert >}}

## Adjusting the CMakeLists.txt file

To use KConfigXT in a CMake project use the kconfig_add_kcfg_files function.

```cmake
add_executable(<target name> [source files])
kconfig_add_kcfg_files(<target name> settings.kcfgc)
```
or

```cmake
kconfig_add_kcfg_files(<project name>_SRCS settings.kcfgc)
```

Since version 5.67 a target based variant is available:

Use the `GENERATE_MOC` option when using signals in your `kcfg` files.
This is the case for example you want to have your setting exposed to QML and setting
`GenerateProperties` to true.

```cmake
kconfig_add_kcfg_files(<project name>_SRCS GENERATE_MOC settings.kcfgc)
```

## Reading and setting values

### C++

To access our kcfg file, we must instantiate the class generated by the kcfgc file. Remember to do this with the classname provided in the kcfgc file.

```cpp
#include "config.h"

...

auto config = Config::self();
```

Our kcfgc file automatically generates getter and setter functions for each entry in our kcfg file. These functions use the names of the entries that we have created, according to their `name` or `key` attributes in their `<entry>` tags. These functions are in camelCase.

Using these functions is as simple as you might expect:

```cpp
auto config = Config::self();

int currentWidth = config->width();

if(currentWidth != 720)
  config->setWidth(720);
```

### QML

To access our configuration files in QML we must first register our `Config` class as a singleton in our application's QML engine.

```cpp
auto config = Config::self();
qmlRegisterSingletonInstance("org.kde.myapp.private", 1, 0, "Config", config);
```

Our config class will now be instance throughout our QML as `Config`. All of our entries in our kcfg are accessible as members of this instance. Setting them and getting them is as you would expect with any other object (again, these members are in camelCase).

```qml
import org.kde.myapp.private 1.0

Kirigami.ApplicationWindow {
  width: Config.width

  onWidthChanged {
    Config.width = applicationWindow().width
  }
}
```
