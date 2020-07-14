---
SPDX-FileCopyrightText: 2006 Zack Rusin <zack@kde.org>
SPDX-LicenseRef: CC-BY-SA-4.0
title: Using KConfig XT
description: >
  This tutorial introduces the main concepts of the KconfigXT configuration framework and shows how to efficiently use it in applications.
---

The main idea behind KConfig XT is to make the life of application developers easier while making the administration of large KDE installations more manageable. The four basic parts of the new framework are: 
+ `KConfigSkeleton` - a class in the libkdecore library which grants a more flexible access to the configuration options,
+ XML file containing information about configuration options (the `.kcfg` file)
+ An ini like file which provides the code generation options (the `.kcfgc` file)
+ `kconfig_compiler` - which generates C++ source code from `.kcfg` and `.kcfgc` files. The generated class is based on KConfigSkeleton and provides an API for the application to access its configuration data.

## .kcfg Structure

The structure of the .kcfg file is described by its XML Schema (kcfg.xsd - available from [here](http://www.kde.org/standards/kcfg/1.0/kcfg.xsd)).

Lets create a simple .kcfg file. Please reference the code below as we go through each step. 

```cpp
<?xml version="1.0" encoding="UTF-8"?>
<kcfg xmlns="http://www.kde.org/standards/kcfg/1.0"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.kde.org/standards/kcfg/1.0
                          http://www.kde.org/standards/kcfg/1.0/kcfg.xsd" >
  <include>kglobalsettings.h</include>
  <kcfgfile name="kjotsrc"/>
  <group name="kjots">
    <entry name="SplitterSizes" type="IntList">
      <label>How the main window is divided.</label>
    </entry>
    <entry name="Width" type="Int">
      <label>Width of the main window.</label>
      <default>600</default>
    </entry>
    <entry name="Height" type="Int">
      <label>Height of the main window.</label>
      <default>400</default>
    </entry>
    <entry name="OpenBooks" type="StringList">
      <label>All books that are opened.</label>
    </entry>
    <entry name="CurrentBook" type="String">
      <label>The book currently opened.</label>
    </entry>
    <entry name="Font" type="Font">
      <label>The font used to display the contents of books.</label>
      <default code="true">KGlobalSettings::generalFont()</default>
    </entry>
  </group>
</kcfg>
```

+ Use your favorite code editor to open a your_application_name.kcfg file (of course replacing your_application_name with the name of the application you want to convert to KConfig XT).
+ Start that file by opening the `<kcfgfile>` tag which controls which KConfig file the data will be stored in. There are three possibilities: 
  1. If the `<kcfgfile>` tag has no attributes the generated code will use the application's default KConfig file (normally `$HOME/.config/<appname>rc`).
  2. The "name" attribute is used to manually specify a file name. If the value assigned to "name" is not an absolute file path, the file will be created in the default KDE config directory (normally `$HOME/.kde/config`).
  3. If you would like to be able to specify the config file at construction time, use `<kcfgfile arg="true">`. This causes the constructor of the generated class to take a `KSharedConfig::Ptr` as an argument, allowing you to construct multiple instances pointing to different files.






