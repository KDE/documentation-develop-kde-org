---
title: "Visual Studio Code"
description: "Popular, customizable, has support for many programming languages."
weight: 1
authors:
    - SPDX-FileCopyrightText: 2024 Kristen McWilliam <kmcwilliampublic@gmail.com>
SPDX-License-Identifier: CC-BY-SA-4.0
---

Microsoft Visual Studio Code (VSCode) is a popular cross-platform, general-purpose, open source IDE. Thanks to its powerful extensions ecosystem it supports many languages as well as deep customization options for themes, fonts, keyboard controls, and more.

A screen recording version is available https://www.youtube.com/watch?v=BCJhD57GN0Y

## Installing

{{< installpackage
    arch="vscode"

    fedoraCommand=`sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install code`
 >}}


## Configuration

### Preparation

#### Enivronment

To ensure VS Code can find source-built libraries and allow running some terminal commands, add the following to your `~/.bashrc` or `~/.zshrc`:

```bash
export CMAKE_PREFIX_PATH="~/kde/usr"
```


#### kdesrc-build

Needed to enable [Language Server Protocol](https://en.wikipedia.org/wiki/Language_Server_Protocol) support:

In `~/.config/kdesrc-buildrc` ensure these two options are in the global section and set to true:

```ini
    compile-commands-linking true
    compile-commands-export true
```

Other recommended settings:

```ini
global
...
    cmake-options -DCMAKE_BUILD_TYPE=Debug
...
end global
```


### Automatic configuration

`kdesrc-build` can automatically generate the config files for projects that vscode needs to enable intellisense, building, debugging, tests, and more from directly within the IDE.

```ini
global
...
    generate-vscode-project-config true
...
end global
```

With this setting enabled, projects built by `kdesrc-build` will have the hidden `.vscode` folder created in their source directory, for example for kcalc this would be `kde/src/kcalc/.vscode`.

Now the project source directory can be opened as a workspace in vs code by opening the src directory as a folder:

* `File -> Open Folder...`
* Select the project src directory: `kde/src/kcalc`

A popup will ask if you want to install/enable the recommended extensions for working on this project:

![Screenshot of the prompt to install recommended extensions](recommended-extensions-prompt.png)

Click `Install`. You are ready to start working on the code with an advanced, modern IDE!


### Manual configuration

We will use kcalc (the KDE calculator app) as an example.
Build kcalc:

```bash
kdesrc-build kcalc
```

Either open VSCode, from the VSCode main menu > File > Open Folder... Ctrl+K Ctrl+O > select `~/kde/src/kcalc/`.

Or, in a terminal,

```bash
cd ~/kde/src/kcalc
code .
```

The directory opened in VSCode is also known as the VSCode workspace folder.

VSCode has two sets of settings: "User" settings (e.g. ~/.config/Code/User/settings.json) and "Workspace" settings (e.g. ~/kde/src/kcalc/.vscode/settings.json). You can see these in VSCode main menu > File > Preferences > Settings Ctrl+Comma > at the top there are two tabs: "User" and "Workspace"

VSCode stores settings related to a specific project in the top-level directory of that project, in a hidden directory named `.vscode`.

Create this file. Make it have the content:

`~/kde/src/kcalc/.vscode/settings.json`

```json
{
    "cmake.buildDirectory": "${workspaceFolder}/../../build/kcalc"
}
```

Create this file. This config enables the correct settings to support C++, CMake & IntelliSense. Make it have the content:

`~/kde/src/kcalc/.vscode/c_cpp_properties.json`

```json
{
    "configurations": [
        {
            "name": "Linux",
            "includePath": [
                "${workspaceFolder}/**"
            ],
            "defines": [],
            "compilerPath": "/usr/bin/gcc",
            "cStandard": "c17",
            "cppStandard": "c++17",
            "intelliSenseMode": "${default}",
            "compileCommands": "${workspaceFolder}/compile_commands.json"
        }
    ],
    "version": 4
}
```


#### User settings

These settings apply once to every project.

In VSCode open the command palette with Ctrl + Shift + P > "Preferences: Open User Settings (JSON)". On my machine the file has the content:

```json
{
    "editor.wordWrap": "on",
    "cmake.environment": {
      "PATH": "~/kde/usr/bin:${env:PATH}",
      "LD_LIBRARY_PATH": "~/kde/usr/lib/x86_64-linux-gnu:${env:LD_LIBRARY_PATH}",
      "XDG_DATA_DIRS": "~/kde/usr/share:${env:XDG_DATA_DIRS}",
      "XDG_CONFIG_DIRS": "~/kde/usr/etc/xdg:${env:XDG_CONFIG_DIRS}",
      "QT_PLUGIN_PATH": "~/kde/usr/lib/plugins:${env:QT_PLUGIN_PATH}",
      "QML2_IMPORT_PATH": "~/kde/usr/lib/qml:${env:QML2_IMPORT_PATH}",
      "QT_QUICK_CONTROLS_STYLE_PATH": "~/kde/usr/lib/qml/QtQuick/Controls.2/:${env:QT_QUICK_CONTROLS_STYLE_PATH}"
    },
    "cmake.generator": "Unix Makefiles",
    "cmake.installPrefix": "~/kde/usr"
}
```

Or, alternatively, from VSCode main menu > File > Preferences > Settings Ctrl+Comma > User > Extensions > CMake Tools > scroll through the list and make sure that you keep the defaults, plus you configure the following:

```json
{
    "cmake.environment": {
      "PATH": "~/kde/usr/bin:${env:PATH}",
      "LD_LIBRARY_PATH": "~/kde/usr/lib/x86_64-linux-gnu:${env:LD_LIBRARY_PATH}",
      "XDG_DATA_DIRS": "~/kde/usr/share:${env:XDG_DATA_DIRS}",
      "XDG_CONFIG_DIRS": "~/kde/usr/etc/xdg:${env:XDG_CONFIG_DIRS}",
      "QT_PLUGIN_PATH": "~/kde/usr/lib/plugins:${env:QT_PLUGIN_PATH}",
      "QML2_IMPORT_PATH": "~/kde/usr/lib/qml:${env:QML2_IMPORT_PATH}",
      "QT_QUICK_CONTROLS_STYLE_PATH": "~/kde/usr/lib/qml/QtQuick/Controls.2/:${env:QT_QUICK_CONTROLS_STYLE_PATH}"
    },
    "cmake.generator": "Unix Makefiles",
    "cmake.installPrefix": "~/kde/usr"
}
```

E.g. scroll to "Cmake: Environment Environment variables to set when running CMake commands." > Add Item > Key: `PATH`, Value: `~/kde/usr/bin:${env:PATH}`. Then, while you hover with the mouse over this settings, or wile you edit this setting, on the left hand side of "Cmake: Environment" a "gear" icon will appear > click on it > Copy Settings as JSON > make sure that the contents of the clipboard is equal to the JSON snippet from above, for "cmake.environment".

After you finish configuring VSCode, close all VSCode windows.


#### Extensions

Once VSCode is installed we need some extensions to enable support for the languages to work on KDE projects.

- [C/C++ Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-extension-pack) - Enables support for C++ and CMake.

- [Qt tools](https://marketplace.visualstudio.com/items?itemName=tonka3000.qtvsctools) - Enables some Qt support.

- [QML](https://marketplace.visualstudio.com/items?itemName=bbenoist.QML) - Enables syntax highlighting for QML.

Optional:

[Zeal](https://zealdocs.org/) is an application that allows browsing documentation offline.

[Dash](https://marketplace.visualstudio.com/items?itemName=deerawan.vscode-dash) is a VSCode extension that enables a hotkey (Ctrl + H) to instantly open the item under the cursor in Zeal.

These paired together make looking up documentation while working on code very quick and easy.


## Working on a project

If there is a file `~/kde/src/kcalc/CMakePresets.json` please delete it. Because it makes it really hard to use the correct CMake build configuration in VSCode. Deleting this file should be temporary. Be careful not to git commit this deleted file. E.g. do not stage to commit the deleted file `CMakePresets.json`. 

Open the kcalc project (i.e. the git work directory, i.e. the directory where kdesrc-build has git cloned the git repository of kcalc) `~/kde/src/kcalc`.

In VSCode, in the bottom status bar:
* In the button "Click to select the current build variant" the CMake build configuration selected should be "Debug". I.e. the button should say "CMake: \[Debug]: Ready".
* Ignore the button "No active kit" with tooltip "Click to change the active kit". Or select the "gcc" from your Linux distribution.
* In the right hand side there should be a button "Linux" with tooltip "C/C++ Configuration".
* In the button "Set the default build target", select your preferred CMake target, in our case "kcalc". In the button "Select the target to launch" select one of the executables which are created using CMake targets, in our case "kcalc".
* Ctrl+Shift+P > "CMake: Configure". It should say `[proc] Executing command: /usr/bin/cmake --no-warn-unused-cli -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE -DCMAKE_BUILD_TYPE:STRING=Debug -DCMAKE_INSTALL_PREFIX:STRING=~/kde/usr -S~/kde/src/kcalc -B~/kde/build/kcalc -G "Unix Makefiles"` and `Build files have been written to: ~/kde/build/kcalc`.
* Press the button "Build" with gear icon with tooltip "Build the selected target: \[kcalc]". It should say `[proc] Executing command: /usr/bin/cmake --build ~/kde/build/kcalc --config`.
* Press the button with the "Play" triangle icon with tooltip "Launch the selected target in the terminal window: \[kcalc]". The application kcalc will start. In another terminal you can run e.g. `lsof | grep kcalc | grep KF5` and make sure that the KDE *.so files are opened from the correct directory. I.e. from `~/kde/usr/lib`, not from `/lib` or from `/usr`.
* Open the file `~/kde/src/kcalc/kcalc.cpp`, place a breakpoint inside the function `int main(int argc, char *argv[])`, which is the entry point of the process/executable kcalc. Press in the status bar the button with a ladybug icon and with tooltip "Launch the debugger for the selected target: \[kcalc]". The debugger should start correctly and stop at the breakpoint.


## Troubleshooting

If a project is not building or debugging correctly, it may be that the needed environment variables are not being set correctly if the project uses cmake-presets. This is often the case if it works using kdesrc-build or kdesrc-run but not in VSCode.

The vscode-cmake-tools extension has an open issue about this:

https://github.com/microsoft/vscode-cmake-tools/issues/1829

The workaround is to source the project's `prefix.sh` file before opening VSCode:

```bash
source ~/kde/build/kcalc/prefix.sh
code ~/kde/src/kcalc
```
