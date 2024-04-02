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


## Setup

The KDE build tool [kdesrc-build]({{< ref "kdesrc-build-setup" >}}) can
automatically generate the configuration files needed for VSCode to work with
KDE projects.

To enable this feature, first ensure that `kdesrc-build` is installed and
configured; then enable the feature in the `kdesrc-build` configuration file 
(located at `~/.config/kdesrc-buildrc` by default) - ensure these options are in 
the `global` section and set to `true`:

```bash
global
    # ... other settings ...

    compile-commands-linking true
    compile-commands-export true

    generate-vscode-project-config true
end global
```

With these settings, projects built by `kdesrc-build` will have the hidden
`.vscode` folder created in their source directory; for example for kcalc this
would be `kde/src/kcalc/.vscode`.

The configuration files are generated when a project is build or rebuilt with 
`kdesrc-build`. If you have already built the project you want to work on 
before enabling the `generate-vscode-project-config` option, make sure to 
rebuild it before opening it in VSCode.

*****

Now the project source directory can be opened as a workspace in vs code by opening the src directory as a folder:

* `File -> Open Folder...`
* Select the project src directory: `kde/src/kcalc`

A popup will ask if you want to install/enable the recommended extensions for working on this project:

![Screenshot of the prompt to install recommended extensions](recommended-extensions-prompt.png)

Click `Install`. You are ready to start working on the code with an advanced, modern IDE!


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


## Notes

The templates for the `.vscode` configuration files are available
[here](https://invent.kde.org/sdk/kdesrc-build/-/tree/master/data/vscode) if you
need to reference them or create them manually.
