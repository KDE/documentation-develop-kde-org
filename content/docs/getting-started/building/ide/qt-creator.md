---
title: "Qt Creator"
description: "Supports many KDE project technologies including Qt, QML, C++, and CMake."
weight: 2
authors:
    - SPDX-FileCopyrightText: 2024 Kristen McWilliam <kmcwilliampublic@gmail.com>
SPDX-License-Identifier: CC-BY-SA-4.0
---

Qt Creator is an IDE from Qt.

A screen recording version is available https://www.youtube.com/watch?v=ASnDeEaXnbI https://www.youtube.com/watch?v=QVgInye6HDA

## Features 

Qt Creator is a good choice when starting to contribute to KDE. 

Qt Creator has: support for kde-builder, a good debugger, source code navigation, Qt widgets UI designer, basic QML editor, QML debugger, Qt resources editor, Qt project templates, good CMake support, C++ static analyzers.

Additional features:
* Source code navigation: switch header/source, follow symbol, switch between function declaration/definition, find references, open type hierarchy, open include hierarchy.
* Refactor rename symbol.
* Views: class view, tests view, document outline view and document outline combo box, CMake structure view, file system view.

For best results, download Qt Creator from the Qt website. https://www.youtube.com/watch?v=QVgInye6HDA

## kde-builder

After you configure kde-builder and you can correctly build a KDE project such as kcalc.

Edit ~/.config/kdesrc-buildrc . It should look like:

```ini
...                                                                                                    
    include-dependencies true
...                                                                                                               
    kdedir ~/kde/usr
...                                                                                                              
    source-dir ~/kde/src
...                                                                                                                
    build-dir ~/kde/build
...                                                                                
    cmake-options -DCMAKE_BUILD_TYPE=Debug
...
```

The line above is important in order to use the debugger from Qt Creator.

Make sure you have the correct number on the line `num-cores`.

Build kcalc, make sure there are no errors:

```bash
kde-builder kcalc
```

## Install Qt Creator

### Using the Qt online installer - recommended

The newest version of Qt Creator installed from the Qt website will have the latest features and the latest bug fixes.

Video version https://www.youtube.com/watch?v=QVgInye6HDA

Go to https://www.qt.io/ on the top right click on the button "Download. Try.". The web browser navigates to "https://www.qt.io/download", in the top right quarter of the page it says "Open source user? 
Find out how you can use Qt under the (L)GPL and contribute to the Qt project. Download open source". Click on the button "Download open source". The web browser navigates to https://www.qt.io/download-open-source. In the bottom middle of the page it says "Looking for Qt binaries? Find them in the Qt Online Installer. It will steer you to the right download version and help you install tools and add-on components that are available for your open source license. Download the Qt Online Installer". Click on the button "Download the Qt Online Installer" > Linux > "Qt Online Installer for Linux (64-bit)". A file named e.g. qt-unified-linux-x64-4.6.1-online.run is downloaded.

```bash
chmod +x qt-unified-linux-x64-4.6.1-online.run
./qt-unified-linux-x64-4.6.1-online.run
```

The Qt online installer will start. The Qt online installer requires that you create an online user account for https://www.qt.io .

### From Linux OS binary packages

E.g.

```bash
apt install qtcreator
```

### QML Designer

Qt Creator has a "forms editor" for QML. You can enable it from the Qt Creator main menu > Help > About Plugins... > Qt Quick > enable "QmlDesigner". If it asks you to restart Qt Creator, do it.

Test it. From Qt Designer main menu > File > Close all Files and Editors. File > New Project... > Application (Qt) > Qt Quick Application, finish the wizard correctly. Open the file "Main.qml" in "Switch to Edit mode Ctrl+2". In the left hand side, choose "Switch to Design mode Ctrl+3".

From the Qt Creator main menu > View > Workspaces > Views-All. Close all of the tool windows (views) that you do not need, e.g. "3D", "States", "Timeline", "Curves", "Transitions".

## Load a KDE Git repository in Qt Creator

We'll use kcalc as an example KDE Git repository. First, make sure it was built correctly using `kde-builder`.

```bash
kde-builder kcalc
```

Start Qt Creator (for example, from the KDE Application Launcher).

###  Import the project and the build 

From the Qt Creator main menu, select `File` > `Open File or Project` > choose `~/kde/src/kcalc/CMakeLists.txt` to open the `kcalc` project.

In the left sidebar, switch to `Projects` mode (Ctrl+5), then click `Manage Kits...`

{{< figure alt="Manage Kits" width="300px" src="qt-creator-manage-kits.png" >}}

Under `Kits > Manual`, remove all kits except "Desktop (default)" or "Qt (default)". For example, if you see Manual > "Imported Kit", select it and press the `Remove` button. Make sure that you have removed all kits whose names end in "- temporary".

{{< figure alt="Remove all kits, except Desktop" width="500px" src="qt-creator-remove-all-kits-except-desktop.png" >}}

On the `Projects` page, click `Import Existing Build...` and choose the directory `~/kde/build/kcalc` to import the `kcalc` build that the `kde-builder` command created.

{{< figure alt="Import Existing Build" width="300px" src="qt-creator-import-existing-build.png" >}}

CMake should now be configured correctly and Qt Creator will run it automatically. You can view its output in the `General Messages` output panel (Alt+9).

###  Configure build settings 

On the `Projects` page (Ctrl+5), set the `Active Project` selector to `kcalc`. Then, in the `Build & Run` section, you should see a kit named `Imported Kit` (make sure not to choose the Desktop kit). Click `Build` under this kit to configure it.

{{< figure alt="Kit build configuration" width="250px" src="qt-creator-kit-build-configuration.png" >}}

In the `Build Settings` panel, make sure the `Edit build configuration:` field is set to `Debug2`.

{{< figure alt="Build settings Debug2" width="500px" src="qt-creator-build-settings-debug2.png" >}}

In the `Current Configuration` section, click the `Batch Edit...` button to open the CMake configuration editor. Then, open the file `~/kde/build/kcalc/prefix.sh` and translate its contents to the format of the configuration editor.

For example, for Debian-based distributions, `~/kde/build/kcalc/prefix.sh` might look like this:

```bash
export PATH=/home/username/kde/usr/bin:$PATH

# LD_LIBRARY_PATH only needed if you are building without rpath
# export LD_LIBRARY_PATH=/home/username/kde/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

export XDG_DATA_DIRS=/home/username/kde/usr/share:${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}
export XDG_CONFIG_DIRS=/home/username/kde/usr/etc/xdg:${XDG_CONFIG_DIRS:-/etc/xdg}

export QT_PLUGIN_PATH=/home/username/kde/usr/lib/x86_64-linux-gnu/plugins:$QT_PLUGIN_PATH
export QML2_IMPORT_PATH=/home/username/kde/usr/lib/x86_64-linux-gnu/qml:$QML2_IMPORT_PATH

export QT_QUICK_CONTROLS_STYLE_PATH=/home/username/kde/usr/lib/x86_64-linux-gnu/qml/QtQuick/Controls.2/:$QT_QUICK_CONTROLS_STYLE_PATH
```

The above script would translate to the following block of text for the `Edit CMake Configuration` window in Qt Creator. You'll need to repeat these steps when loading other KDE Git repositories in Qt Creator, so it's helpful to save this to a file such as `~/kde/qtcreator_run_environment.txt`.

```ini
PATH=+/home/username/kde/usr/bin
XDG_DATA_DIRS=+/home/username/kde/usr/share
XDG_CONFIG_DIRS=+/home/username/kde/usr/etc/xdg
QT_PLUGIN_PATH=+/home/username/kde/usr/lib/x86_64-linux-gnu/plugins
QML2_IMPORT_PATH=+/home/username/kde/usr/lib/x86_64-linux-gnu/qml
QT_QUICK_CONTROLS_STYLE_PATH=+/home/username/kde/usr/lib/x86_64-linux-gnu/qml/QtQuick/Controls.2/
```

Note: if you want to see debugging messages, you can add corresponding variables
here. [See
here](https://community.kde.org/Guidelines_and_HOWTOs/Debugging/Using_Error_Messages#Controlling_Messages)
for more information.


###  Configure run settings 

In the `Build & Run` section of the `Projects` page, click `Run` under the `Imported Kit` to configure the Run settings.

In the `Run` section under `Run Settings`, find `Run configuration:` and select `kcalc`. This is the CMake executable target for the GUI application `kcalc`. The other items in the combobox such as `knumbertest` are binary executable (CTest type) tests.

{{< figure alt="Run target" width="500px" src="qt-creator-run-target.png" >}}

In the `Environment` section > open the `Details` section next to `Use Build Environment`. If the `Reset` button is clickable, click it. Press the `Batch Edit...` button and paste in the configuration you prepared for the Build Settings in the previous section.

{{< figure alt="Run environment" width="700px" src="qt-creator-run-environment.png" >}}

Click the button in the sidebar that shows an icon of a computer monitor with the project name above it and the build configuration below it. It should show: 

|           |                      |
| --------- | -------------------- |
| `Project` | kcalc                |
| `Kit`     | Imported Kit         |
| `Deploy`  | Deploy Configuration |
| `Build`   | Debug2               |
| `Run`     | kcalc                |

{{< figure alt="Project button above run" width="200px" src="qt-creator-project-button-above-run.png" >}}

CMake configure was run automatically. You can run it again from the Qt Creator main menu > `Build` > `Run CMake`.

###  Build the project 

You can build by pressing the hammer icon on the lower left with tooltip "Build Project Ctrl+B", Or from the Qt Creator main menu > `Build` > `Build Project "kcalc"`.

###  Try the debugger 

In the left sidebar, switch to `Edit` mode (Ctrl+2). Select "Projects" from the drop-down menu at the top of the leftmost panel. Expand kcalc > kcalc > Source Files > double click on the file `kcalc.cpp` to show it in the editor view.

{{< figure alt="Open file in editor" width="300px" src="qt-creator-open-file-in-editor.png" >}}

In the text editor's top bar, open the `Select Symbol` drop-down menu, scroll to the bottom of the options, and select the last item in it: `main(int, char**) -> int`. Click on the line with the opening curly bracket of the function main. Set a breakpoint by opening the `Debug` menu > `Set or Remove Breakpoint` (F9).

Start debugging the project by opening the `Debug` menu > `Start Debugging` > `Start Debugging of Startup Project` (F5). The debugger will start and pause execution on the source code line with the curly bracket.

Use the debugger by opening the `Debug` menu > `Step Over` (F10)/`Step Into` (F11)/`Step Out` (Shift+F11).

## Enable parallel jobs in Qt Creator

* Left Sidebar > Switch to Projects mode (Ctrl+5).
* Under the Build settings of the imported kit find the "Build Steps" option.
* Click on the "Details" button on the right side of the "Build Steps" option to access the detailed build configuration.
* Under the "Tool arguments" field add the argument `-j<jobs>`.  Replace "<jobs>" with the desired number of parallel jobs you want to use during compilation. For example, if you have a CPU with 16 threads and want to use 12 parallel jobs, you would enter `-j12`.

{{< figure alt="Parallel jobs" width="600px" src="qt-creator-parallel-jobs.png" >}}

* Rebuild your project to get faster compilation.

## Tips and Tricks 

###  Custom executable to run 

When developing a library, it may be convenient to launch some application that uses it, from the current project. For example, you work with Ark's libraries used in dolphin context menu actions. You can make your run configuration to launch custom binary - dolphin. See [documentation](https://doc.qt.io/qtcreator/creator-run-settings.html#specifying-a-custom-executable-to-run) on how to configure that.
