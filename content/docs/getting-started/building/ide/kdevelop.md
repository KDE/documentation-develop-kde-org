---
title: "KDevelop"
description: "KDE's own IDE."
weight: 4
authors:
    - SPDX-FileCopyrightText: 2024 Kristen McWilliam <kmcwilliampublic@gmail.com>
SPDX-License-Identifier: CC-BY-SA-4.0
---


KDevelop is an IDE from KDE.

A screen recording version is available https://www.youtube.com/watch?v=LcSfUNrd3S4


## kdesrc-build

Make sure kdesrc-build works correctly. Make sure ~/.config/kdesrc-buildrc contains the lines:

```ini
cmake-options -DCMAKE_BUILD_TYPE=Debug
```

Using kdesrc-build build a module. E.g.

```bash
kdesrc-build bluez-qt
```


## Importing a kdesrc-build project into KDevelop

E.g. on Kubuntu 22.04.

```bash
apt install kdevelop clazy heaptrack
```

Start kdevelop. From the kdevelop main menu Session > make sure that you have a new/clean session. E.g. Delete Current Session...

From kdevelop main menu > Project > Open/Import Project... Name: /home/n/kde/src/bluez-qt/CMakeLists.txt > Next > Finish. If it asks to Override, override.

A dialog is shown: Configure a Build Directory for bluez-qt. It will guess all of the values: Build directory: /home/n/kde/build/bluez-qt. "Using an already created build directory.". Installation prefix: /home/n/kde/usr. Build type: Debug. CMake executable: /usr/bin/cmake. Press OK button.


## Setting environment variables

By default kdesrc-build will install everything into separate `usr` directory to avoid messing with the system path. The file that contains these paths is called `prefix.sh` and can be found in the build directory of any project, for example `/home/n/kde/build/bluez-qt/prefix.sh`. By running `source prefix.sh` inside a terminal you will set up the environment for running a kdesrc-build project. By default the prefix should look something like this:

```bash
export PATH=/home/n/kde/usr/bin:$PATH

# LD_LIBRARY_PATH only needed if you are building without rpath
# export LD_LIBRARY_PATH=/home/n/kde/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

export XDG_DATA_DIRS=/home/n/kde/usr/share:${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}
export XDG_CONFIG_DIRS=/home/n/kde/usr/etc/xdg:${XDG_CONFIG_DIRS:-/etc/xdg}

export QT_PLUGIN_PATH=/home/n/kde/usr/lib/x86_64-linux-gnu/plugins:$QT_PLUGIN_PATH
export QML2_IMPORT_PATH=/home/n/kde/usr/lib/x86_64-linux-gnu/qml:$QML2_IMPORT_PATH

export QT_QUICK_CONTROLS_STYLE_PATH=/home/n/kde/usr/lib/x86_64-linux-gnu/qml/QtQuick/Controls.2/:$QT_QUICK_CONTROLS_STYLE_PATH
```

To set up the environment inside KDevelop, first Select "Settings" -> "Configure KDevelop" in the menu bar. Then open the "Environment" settings page. Click the button on the right-hand side called "Batch edit mode" to open a new dialog with an empty text area. Copy and paste the contents of `prefix.sh` into this window and click "OK" to confirm the text dialog. Finally click "OK" to close the settings window.


## Adding breakpoints

From kdevelop main menu > Window > Tool Views > Projects. Expand the treeview to one of the entrypoints (CMake targets). E.g. bluez-qt > autotests > managertest > managertest.cpp. The file "/home/n/kde/src/bluez-qt/autotests/managertest.cpp" will be opened in the text editor view.

Navigate to the method "bluezNotRunningTest()", put a breakpoint on the line with "{" (the opening curly bracket of the method). Right click on the line > Toggle Breakpoint.

In Projects view, right click on the CMake target "managertest" > Debug As... > Compiled Binary.

An error will be shown "Could not start debugger. Could not run 'lldb-mi'. Make sure that the path name is specified correctly.". From kdevelop main menu > Settings > Configure KDevelop... > Plugins >  Debugging > uncheck "LLDB Support" > OK.

Navigate to method "bluezNotRunningTest()", put a breakpoint on the line with "{" (the opening curly bracket of the method). Right click on the line > Toggle Breakpoint.

In Projects view, right click on the CMake target "managertest" > Debug As... > Compiled Binary.

The debugger starts and breaks on the first line of C++ source code after the breakpoint. From the main menu > Run > Step Over (F10)/Step Into (F11)/Step Out (F12).
