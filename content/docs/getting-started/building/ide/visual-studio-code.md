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

## Installation

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


## Working on a project

We will use the `kcalc` project as an example.


### Opening the project

The project can be opened as a workspace in vs code by opening the src directory as a folder:

* `File` -> `Open Folder...`
* Select the project src directory: `~/kde/src/kcalc`

If you have the `kdesrc-build` configuration set up as described above, VSCode
will automatically detect the `.vscode` folder and load the project with the
correct settings.

The following configuration sections will only need to be done the first time
you open a new project in VSCode.


### Installing extensions

A notification popup at the bottom-right of the window will ask if you want to
install the recommended extensions for working on this project:

{{< figure alt="Screenshot of the prompt to install recommended extensions" width="800px" src="recommended-extensions-prompt.png" >}}

These extensions add support to VSCode for technologies commonly used in KDE 
projects, such as CMake, C++, Qt, and more.

Click `Install`.


### Configuring the project

After the extensions have been installed:

- If a notification prompt asks if you want to switch to a pre-release version
  of the C++ extension, click `No`.
- A notification prompt will ask `Would you like to configure project "kcalc"?`
  Click `Yes`.

{{< figure alt="Screenshot of the prompt to configure the project" width="800px" src="configure-project-prompt.png" >}}

A prompt will open at the top-middle of the window asking to choose a kit (A kit 
is a configuration used when building and running the project.) Select 
`Unspecified` to have the kit chosen automatically based on the project and 
system configuration:

{{< figure alt="Screenshot of the prompt to select a kit" width="800px" src="select-kit-prompt.png" >}}

The integrated terminal will open at the bottom of the window, and if the
project was configured successfully, the last line should say:

```
[cmake] -- Build files have been written to: /home/<username>/kde/build/kcalc
```

{{< figure alt="Screenshot of the terminal showing successful configuration" width="800px" src="configuration-successful.png" >}}

You are ready to start working on the code with an advanced, modern IDE! 🎉


### Debugging

To start debugging, click on the `Run and Debug` icon on the left sidebar, then 
click on the green play button to start debugging.

{{< figure alt="Screenshot of how to start a debug session" width="800px" src="run-and-debug.png" >}}

If the project has multiple targets it will open a prompt at the top-middle of 
the window asking to choose a target. Select the target you want to debug; in
this case, `kcalc`:

{{< figure alt="Screenshot of the prompt to select a target" width="800px" src="initial-launch-target.png" >}}

We should now be running a debug session of the `kcalc` project. 🚀

{{< figure alt="Screenshot of the debug session" width="800px" src="debug-session.png" >}}

To later change the target, open the Command Palette (`Ctrl+Shift+P`) and run 
the `CMake: Set Debug Target` command.


## Troubleshooting

If a project is not building or debugging correctly, it may be that the needed environment variables are not being set correctly if the project uses cmake-presets. This is often the case if it works using kdesrc-build or kdesrc-run but not in VSCode.

The vscode-cmake-tools extension has an open issue about this:

https://github.com/microsoft/vscode-cmake-tools/issues/1829

The workaround is to source the project's `prefix.sh` file before opening VSCode:

```bash
source ~/kde/build/kcalc/prefix.sh
code ~/kde/src/kcalc
```


## Tips

- There is extensive documentation available for VSCode at
  https://code.visualstudio.com/docs.
- There are first-party video tutorials available at
  https://code.visualstudio.com/docs/getstarted/introvideos.


## Notes

The templates for the `.vscode` configuration files are available
[here](https://invent.kde.org/sdk/kdesrc-build/-/tree/master/data/vscode) if you
need to reference them or create them manually.
