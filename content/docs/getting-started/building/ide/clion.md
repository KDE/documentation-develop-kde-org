---
title: "CLion"
description: "C++ IDE from JetBrains."
weight: 5
authors:
    - SPDX-FileCopyrightText: 2024 Kristen McWilliam <kmcwilliampublic@gmail.com>
SPDX-License-Identifier: CC-BY-SA-4.0
---


[CLion](https://www.jetbrains.com/clion/) is a proprietary IDE for C++ from JetBrains.


## Install CLion

Follow the [Install CLion](https://www.jetbrains.com/help/clion/installation-guide.html) documentation.

If using Arch Linux, you can install the AUR package [clion](https://aur.archlinux.org/packages/clion).


## Setup a KDE project in CLion

In this article we will use _dolphin_ as an example project. Prerequisite is that you have successfully built a project following kdesrc-build setup procedure. This article assumes your username is `username`, and the kdesrc-build setup path is `/home/username/kde/`. Replace them to the your values in the specified commands.


### Importing project

In the "Welcome to Clion" window press "Open" button. In the "Open File or Project", chose a root folder of _dolphin_ project (`~/kde/src/dolphin`) or select the `CMakeLists.txt` file in that directory. It will ask how do you want to open it. Press "Open as Project" for file, or "Open as CMake project" for directory.

{{< figure alt="open as cmake project" width="300px" src="open-as-cmake-project.png" >}}


### CMake profile

After previous step, the new window will open to setup cmake profile. You can reach these settings later by going to `Settings | Build, Execution, Deployment | CMake`. 
* Choose _Debug_ build.
* In the _Generator_, set "Let Cmake decide".
* In the _Build directory_, specify the build directory path, for this example it will be `/home/username/kde/build/dolphin`.

{{< figure alt="build configuration" width="700px" src="build-configuration.png" >}}

* Under CMake options (in this same window), we must set some important variables such as CMAKE_PREFIX_PATH. If the prefix was in "/home/username/kde", then the CMake options line would look like:

```ini
-DCMAKE_PREFIX_PATH=/home/username/kde/usr
-DCMAKE_MODULE_PATH=/home/username/kde/usr/lib64/cmake:/home/username/kde/usr/lib/cmake
-DQT_PLUGIN_PATH=/home/username/kde/usr/lib64/plugins:/home/username/kde/usr/lib/plugins
-DXDG_DATA_DIRS=/home/username/kde/usr/share
```

You probably would want to save that to file `~/kde/clion_cmake_options.txt` for future use.

* Press OK.


### Run/Debug Configuration

In the run/debug target (in the upper right corner of main window), select "dolphin".

{{< figure alt="select run debug configuration" width="300px" src="select-run-debug-configuration.png" >}}

Expand it and choose Edit.

{{< figure alt="go to run debug configuration edit" width="300px" src="go-to-run-debug-configuration-edit.png" >}}

The Run/Debug Configurations window will appear.

{{< figure alt="run debug configuration" width="500px" src="run-debug-configuration.png" >}}

In the Environment variables field click edit button. 

You can add variables in there manually or reuse exports from `prefix.sh` script from build directory.

Note: if you want to modify debugging output messages, you can add corresponding variables there. See [here](https://community.kde.org/Guidelines_and_HOWTOs/Debugging/Using_Error_Messages#Controlling_Messages).


#### Variants to setup environment variables

{{< figure alt="run debug variables configuration" width="400px" src="run-environment-variables.png" >}}


##### Reusing existing prefix.sh

For convenience, copy the `/home/username/kde/build/dolphin/prefix.sh` to `/home/username/kde/clion_run_environment.sh`. [Use](https://www.jetbrains.com/help/clion/2023.2/run-debug-configuration.html#envvars-progargs) the following syntax for setting variables in that script: `export VAR=value`.

In the Environment Variables dialog, in the Load Variables from file field, paste the path `/home/username/kde/clion_run_environment.sh`.

While it is possible to specify some additional variables alongside with
environment script (as specified in [#Setting variables manually]({{< ref "#setting-variables-manually" >}})), it
may be inconvenient to edit them in case you want to keep the same variables for
many run/debug configurations. For example, when you decide to change the
QT_MESSAGE_PATTERN. There is a way to keep them in one place, while having
control over them.

The environment script supports sourcing another script. So we need to place our common environment variables to separate file:

```bash
~/kde/qt_logging_environment.sh

export QT_FORCE_STDERR_LOGGING=1
export QT_LOGGING_RULES='ark*=true;kf.coreaddons=false;kf.service.services=false;kf.service.sycoca=false;qt.qpa.wayland=false;kf.moretools=false;default=false'
export QT_MESSAGE_PATTERN='[%{time hh:mm:ss} %{if-debug}D%{endif}%{if-info}I%{endif}%{if-warning}W%{endif}%{if-critical}C%{endif}%{if-fatal}F%{endif}] %{function} %{file}:%{line} %{message}'
```

and source it from the first file:

```bash
~/kde/clion_run_environment.sh

...
source /home/username/kde/qt_logging_environment.sh
```

But keep in mind, you need to touch the original script for changes to be applied. See [CPP-35329](https://youtrack.jetbrains.com/issue/CPP-35329/Load-variables-from-file-is-updated-only-when-changing-script-itself-ignores-changes-of-other-scripts-sourced-from-it).


##### Setting variables manually

Take the content of the generated environment script:

```bash
~/kde/build/dolphin/prefix.sh

export PATH=/home/username/kde/usr/bin:$PATH

# LD_LIBRARY_PATH only needed if you are building without rpath
# export LD_LIBRARY_PATH=/home/username/kde/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

export XDG_DATA_DIRS=/home/username/kde/usr/share:${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}
export XDG_CONFIG_DIRS=/home/username/kde/usr/etc/xdg:${XDG_CONFIG_DIRS:-/etc/xdg}

export QT_PLUGIN_PATH=/home/username/kde/usr/lib/x86_64-linux-gnu/plugins:$QT_PLUGIN_PATH
export QML2_IMPORT_PATH=/home/username/kde/usr/lib/x86_64-linux-gnu/qml:$QML2_IMPORT_PATH

export QT_QUICK_CONTROLS_STYLE_PATH=/home/username/kde/usr/lib/x86_64-linux-gnu/qml/QtQuick/Controls.2/:$QT_QUICK_CONTROLS_STYLE_PATH
```

and translate it to the form of variables list that you can paste to CLion. Note that their variables have trailing '$' sign. In order to reuse it when loading other KDE projects in CLion, save it to the file:

```bash
~/kde/clion_run_environment.txt

PATH=/home/username/kde/usr/bin:$PATH$
XDG_DATA_DIRS=/home/username/kde/usr/share:$XDG_DATA_DIRS$:/usr/local/share/:/usr/share/}
XDG_CONFIG_DIRS=/home/username/kde/usr/etc/xdg:$XDG_CONFIG_DIRS$:/etc/xdg
QT_PLUGIN_PATH=/home/username/kde/usr/lib/x86_64-linux-gnu/plugins:$QT_PLUGIN_PATH$
QML2_IMPORT_PATH=/home/username/kde/usr/lib/x86_64-linux-gnu/qml:$QML2_IMPORT_PATH$
QT_QUICK_CONTROLS_STYLE_PATH=/home/username/kde/usr/lib/x86_64-linux-gnu/qml/QtQuick/Controls.2/:$QT_QUICK_CONTROLS_STYLE_PATH$
```

Then in the Environment Variables dialog, paste the contents of the `~/kde/clion_run_environment.txt`.


## Tips and Tricks

### Set defaults for new projects

When opening new project in CLion, you fill in their settings manually every time. For convenience, you can specify default settings for newly opened projects. To do this, follow these steps:
* Go to `File | New Projects Setup | Settings for New Projects`.
: The `Build, Execution, Deployment | CMake` page will be opened.
* Open the _Debug_ profile.
* In the _Generator_ field choose 'Let CMake decide'.
* In the _Build directory_ field type: `$PROJECT_DIR$/../../build/$PROJECT_NAME$`.
* Press OK button.


### JetBrains Dolphin Plugin

[JetBrains Dolphin Plugin](https://github.com/alex1701c/JetBrainsDolphinPlugin) is a service menu plugin (context menu action) which allows you to easily open folders as ide projects.

You can install it from the store.kde.org (in the _Configure Dolphin_ choose _Context Menu_, then press _Download New Services..._ button. Search for _Jetbrains Dolphin Plugin_ by alex1701c).

If using Arch Linux, you will prefer to install from [AUR](https://aur.archlinux.org/packages/kf5-servicemenus-jetbrains-dolphin-plugin-git).


### JetBrains Runner

You can install [JetBrainsRunner](https://github.com/alex1701c/JetBrainsRunner) search plugin to be able to quickly open recent projects in JetBrains IDEs.

If you using Arch Linux, you will prefer to install from AUR: [plasma5-runners-jetbrains-runner-git](https://aur.archlinux.org/packages/plasma5-runners-jetbrains-runner-git) or [plasma6-runners-jetbrains-runner-git](https://aur.archlinux.org/packages/plasma6-runners-jetbrains-runner-git).


### Plugins for CLion

#### Qt6Renderer

Currently, the Qt classes do not support pretty printing in debugger in CLion out of the box. See [Bug CPP-605](https://youtrack.jetbrains.com/issue/CPP-605/Qt-types-renderers) for more information.

You can install [Qt6Renderer](https://plugins.jetbrains.com/plugin/19882-qt6-renderer) plugin by Nikita Kobzev. Note that currently it works only with lldb debugger.


#### GNU GetText files support ​(*.​po)​

Install the [GetText files support ​(*.​po)](https://plugins.jetbrains.com/plugin/7123-gnu-gettext-files-support--po-) plugin. It will make the source lines in the po files clickable.

For example, you search the strings in local language, to find the place in code where it is used, you find it in *.po files. They contain stanzas like this:

```bash
~/kde/src/ark/po/ru/ark.po

#: part/part.cpp:132
#, kde-format
msgid "Comment has been modified."
msgstr "Комментарий был изменен."
```

You want to quickly jump to the source file. That source file (`part/part.cpp:132`) becomes a clickable link if you install the plugin.


#### Breeze Dark theme

If using Classic UI, you may want to install [Breeze Dark](https://plugins.jetbrains.com/plugin/13224-breeze-dark) theme, so that you IDE appearance correspond to standard KDE theme.


### Non-project executable to run

When developing a library, it may be convenient to launch some application that uses it, from the current project. For example, you work with Ark's libraries used in Dolphin context menu actions. You can make your run configuration to launch custom binary - dolphin.

To do that, do the following:
* Open `Run/Debug Configurations` window
* Click "+" button to add a new configuration
* Choose type _CMake Application_
:The new configuration will appear.
* Give it a meaningful name, for example _ark (run dolphin)_.
* In _Target_ field choose _All Targets_.
* In the _Executable_ field, specify path to dolphin binary: _/home/username/kde/build/dolphin/bin/dolphin_.
* In the _Environment Variables_ set it up as described in the corresponding section.
* Press OK.

{{< figure alt="run debug variables configuration" width="400px" src="run-debug-conf-external-app.png" >}}

Now when you run this configuration, the Ark will be built, but Dolphin will be launched.


### Use KWallet for git credentials

You need to enable this key in Registry: `credentialStore.linux.prefer.kwallet`. It allows to use KWallet if KWallet & SecretService are both available.


### Use native titlebar with New UI

It is possible to switch to "New UI", while still showing normal window titlebar. For this, open registry (Double tab Shift, search for Registry) and disable property `ide.linux.hide.native.title`.


## External links

* https://nmariusp.github.io/kde/clion.html.
