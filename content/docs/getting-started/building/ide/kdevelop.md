---
title: "KDevelop"
description: "KDE's own IDE."
weight: 4
authors:
    - SPDX-FileCopyrightText: 2024 Kristen McWilliam <kmcwilliampublic@gmail.com>
SPDX-License-Identifier: CC-BY-SA-4.0
---

KDevelop is an IDE from KDE.

A screen recording version is available https://www.youtube.com/watch?v=CtuRMCFJNqw


## kde-builder

Make sure kde-builder works correctly. Make sure ~/.config/kde-builder.yaml contains the lines:

```ini
  cmake-options: >
    -DCMAKE_BUILD_TYPE=Debug
```

Using kde-builder build a module. E.g.

```bash
kde-builder bluez-qt
```


## Importing a KDE project built using kde-builder into KDevelop

E.g. on Kubuntu 25.04.

```bash
apt install kdevelop clazy heaptrack
```

Start kdevelop. From the kdevelop main menu Session > make sure that you have a new/clean session. E.g. "Delete Current Session...".

From kdevelop main menu > Project > "Open/Import Project..." > Name: /home/n/kde/src/bluez-qt/CMakeLists.txt > Next > Finish. If it asks to Override, override.

A dialog is shown: Configure a Build Directory for bluez-qt. It will guess all of the values: Build directory: /home/n/kde/build/bluez-qt. "Using an already created build directory.". Installation prefix: /home/n/kde/usr. Build type: Debug. CMake executable: /usr/bin/cmake. Press OK button.


## Configure environment for run and debug

At this point KDevelop can build the project correctly.

KDevelop will be able to run and debug the project if we set environment variables.

By default kde-builder will install everything into a separate `~/kde/usr` directory to avoid messing with the system path (`/usr`). A file `~/kde/build/bluez-qt/prefix.sh` was generated when building the project using kde-builder. By running `source prefix.sh` inside a terminal you will set up the environment for running the binaries of the project built using kde-builder. By default the prefix should look something like this:

```bash
export PATH=/home/n/kde/usr/bin:$PATH

# LD_LIBRARY_PATH only needed if you are building without rpath
# export LD_LIBRARY_PATH=/home/n/kde/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

export XDG_DATA_DIRS=/home/n/kde/usr/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}
export XDG_CONFIG_DIRS=/home/n/kde/usr/etc/xdg:${XDG_CONFIG_DIRS:-/etc/xdg}

export QT_PLUGIN_PATH=/home/n/kde/usr/lib/x86_64-linux-gnu/plugins:$QT_PLUGIN_PATH
export QML2_IMPORT_PATH=/home/n/kde/usr/lib/x86_64-linux-gnu/qml:$QML2_IMPORT_PATH

export QT_QUICK_CONTROLS_STYLE_PATH=/home/n/kde/usr/lib/x86_64-linux-gnu/qml/QtQuick/Controls.2/:$QT_QUICK_CONTROLS_STYLE_PATH

export MANPATH=/home/n/kde/usr/share/man:${MANPATH:-/usr/local/share/man:/usr/share/man}

export SASL_PATH=/home/n/kde/usr/lib/x86_64-linux-gnu/sasl2:${SASL_PATH:-/usr/lib/x86_64-linux-gnu/sasl2}
```

Run:

```bash
source ~/kde/build/bluez-qt/prefix.sh

echo PATH=$PATH
echo XDG_DATA_DIRS=$XDG_DATA_DIRS
echo XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS
echo QT_PLUGIN_PATH=$QT_PLUGIN_PATH
echo QML2_IMPORT_PATH=$QML2_IMPORT_PATH
echo QT_QUICK_CONTROLS_STYLE_PATH=$QT_QUICK_CONTROLS_STYLE_PATH
echo MANPATH=$MANPATH
echo SASL_PATH=$SASL_PATH
```

Should return text like:

```bash
PATH=/home/n/kde/usr/bin:/home/n/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/n/.local/share/JetBrains/Toolbox/scripts
XDG_DATA_DIRS=/home/n/kde/usr/share:/home/n/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share:/var/lib/snapd/desktop
XDG_CONFIG_DIRS=/home/n/kde/usr/etc/xdg:/home/n/.config/kdedefaults:/etc/xdg:/usr/share/kubuntu-default-settings/kf5-settings
QT_PLUGIN_PATH=/home/n/kde/usr/lib/x86_64-linux-gnu/plugins:
QML2_IMPORT_PATH=/home/n/kde/usr/lib/x86_64-linux-gnu/qml:
QT_QUICK_CONTROLS_STYLE_PATH=/home/n/kde/usr/lib/x86_64-linux-gnu/qml/QtQuick/Controls.2/:
MANPATH=/home/n/kde/usr/share/man:/usr/local/share/man:/usr/share/man
SASL_PATH=/home/n/kde/usr/lib/x86_64-linux-gnu/sasl2:/usr/lib/x86_64-linux-gnu/sasl2

```

Save the text block above to the file `~/kde/expanded-prefix-sh.txt`.

Copy to clipboard the content of the file `~/kde/expanded-prefix-sh.txt`. From the KDevelop main menu "Settings" -> "Configure KDevelop". Then open the "Environment" settings page. Click the button on the right-hand side with tooltip "Batch edit mode" to open a new dialog with an empty text area. Paste from the clipboard into this window and click "OK" to confirm the text dialog. Finally click "OK" to close the settings window.


## Adding breakpoints

From kdevelop main menu > Window > Tool Views > Projects. Expand the treeview to one of the entrypoints (CMake targets). E.g. bluez-qt > autotests > managertest > managertest.cpp. The file "/home/n/kde/src/bluez-qt/autotests/managertest.cpp" will be opened in the text editor view.

Navigate to the method "bluezNotRunningTest()", put a breakpoint on the first line of this method that is not "{" (the opening curly bracket of the method), is not whitespace or comment. That is, a line of actual source code. Right click on the line > Toggle Breakpoint.

In the Projects view, right click on the CMake target "managertest" > Debug As... > Compiled Binary.

If the kdevelop debugger does not pause, from the kdevelop main menu > Settings > Configure KDevelop... > Plugins > Debugging > uncheck "LLDB Support" > OK.

Navigate to the method "bluezNotRunningTest()", put a breakpoint on the first line of this method that is not "{" (the opening curly bracket of the method), is not whitespace or comment. That is, a line of actual source code. Right click on the line > Toggle Breakpoint.

In the Projects view, right click on the CMake target "managertest" > Debug As... > Compiled Binary.

The debugger starts and breaks on the first line of C++ source code after the breakpoint. From the main menu > Run > Step Over (F10)/Step Into (F11)/Step Out (F12).
