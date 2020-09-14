---
SPDX-FileCopyrightText: 2006 Zack Rusin <zack@kde.org>
SPDX-LicenseRef: CC-BY-SA-4.0
title: Using KConfig XT
description: >
  This tutorial introduces the main concepts of the KConfigXT configuration framework and shows how to efficiently use it in applications.
weight: 2
---

The main idea behind KConfigXT is to provide a more convenient way to manage
your application's configurations for both for developers and system
administrators who manage large KDE installations.

KConfigXT generates a ready-to-use C++ class from an XML definition file
with state management and all the other features that you would expect from any
good configuration management system.

## The .kcfg file

A `.kcfg` file is an XML file describing the configuration keys for your
application. Let's create a simple `.kcfg` file.


```xml
<?xml version="1.0" encoding="UTF-8"?>
<kcfg xmlns="http://www.kde.org/standards/kcfg/1.0"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.kde.org/standards/kcfg/1.0
                          http://www.kde.org/standards/kcfg/1.0/kcfg.xsd" >
</kcfg>
```

For the moment, this `.kcfg` file does nothing, so let's add a config group, `general`,
and two config entries. The first entry, `SplitterSizes`, will store the sizes of the
application's QSplitter widgets. The second entry, `Width`, will store the width of the
main window. The last entry, `Platform`, will store the last operating system used, this
is an enum, and the value can be either Linux, FreeBSD or Windows.

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

The individual entries must have at least a name or a key attribute. The key is used
as the key in the config file. The name is used to create accessor and modifier
functions.  If `key` is not given, the name is used as the key in the config file. If `key` is
given, but not `name`, the name is constructed by removing all spaces from the `key`.

An entry must also have a type. The supported basic types are: `String`, `Url`,
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

This is often not needed, but it is also possible to have the default value computed
from a C++ expression. This is done by adding the `code=true` atribute to the
`<default>` tag.

In case you need to import a C++ header to compute the default value, you can add an
`<include>` tag to the .kcfg file which contains the header file that is needed.
Note that more than one `<include>` tag can be used as needed.

Additional code for computing default values can be provided via the `<code>` tag.
The content of the `<code>` tag is inserted as-is. A typical use for this, is to
compute a common default value which can then be referenced by subsequent entries.

## The .kcfgc files

KConfigXT options are stored in a `.kcfgc` file which describes the C++ file generation
options. The .kcfgc file is a simple ini file with the typical "entry=value" format.

```ini
File=config.kcfg
ClassName=Config
Mutators=true
DefaultValueGetters=true
```

The first line `File=config.kcfg` specifies where the configuration options for your
application are stored.

The second line `ClassName=YourConfigClassName` specifies the name of the class
that will be generated from the .kcfg file. The generated class will be derived from
KConfigSkeleton. Please make sure that `YourConfigClassName` is not a class name already
used in your application. Save this file under yourconfigclassname.kcfgc. This will ensure
the generation of the yourconfigclassname.{h,cpp} files where your configuration class will
reside.

There are additional optional entries, which your application might need. The full list is
available on the [kconfig_compiler](https://api.kde.org/frameworks/kconfig/html/kconfig_compiler.html).

{{< alert title="Note" color="info" >}}
You can find more information about all the available options in the
[kconfig_compiler documentation](https://api.kde.org/frameworks/kconfig/html/kconfig_compiler.html).
{{< /alert >}}

## Adjusting the CMakeLists.txt file

After creating the .kcfg and .kcfgc files, the next step is to adjust the build system to let
`kconfig_compiler` generate the required class at compile time. For in-source builds,
doing this is trivial and requires only one step, adding these two lines to the `CMakeLists.txt`
file (assuming your files are named `settings.kcfg` and `settings.kcfgc`): 

```cmake
kconfig_add_kcfg_files(<project name>_SRCS settings.kcfgc)
```

Since version 5.67 a target based variant is available: 

```cmake
add_executable(<target name> [source files])
kconfig_add_kcfg_files(<target name> settings.kcfgc)
```

Use optional `GENERATE_MOC` to generate moc if you use signals in your `kcfg` files.
This is the case for example you want to have your setting exposed to QML and setting
`GenerateProperties` to true.

```cmake
kconfig_add_kcfg_files(<project name>_SRCS GENERATE_MOC settings.kcfgc)
```
