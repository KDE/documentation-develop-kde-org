---
title: "Visual Studio Code"
description: "Popular, customizable, has support for many programming languages."
weight: 1
authors:
    - SPDX-FileCopyrightText: 2024 Kristen McWilliam <kmcwilliampublic@gmail.com>
SPDX-License-Identifier: CC-BY-SA-4.0
---

Microsoft Visual Studio Code (VS Code) is a popular cross-platform, general-purpose, open source IDE. Thanks to its powerful extensions ecosystem it supports many languages as well as deep customization options for themes, fonts, keyboard controls, and more.

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
automatically generate the configuration files needed for VS Code to work with
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
`.vscode` folder created in their source directory; for example, for KCalc this
would be `kde/src/kcalc/.vscode`.

The configuration files are generated when a project is built or rebuilt with 
`kdesrc-build`. If you have already built the project you want to work on 
before enabling the `generate-vscode-project-config` option, make sure to 
rebuild it before opening it in VS Code.


## Working on a project

We will use [KCalc](https://apps.kde.org/kcalc/) as an example.

{{< alert title="Tip" color="success" >}}
The [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette) 
(`Ctrl+Shift+P`) is your friend. It allows you to search for and run commands
and it is a great way to discover features.
{{< /alert >}}


### Opening the project

The project can be opened as a workspace in vs code by opening the src directory as a folder:

* `File` -> `Open Folder...`
* Select the project's source code directory: `~/kde/src/kcalc`

If you have the `kdesrc-build` configuration set up as described above, VS Code
will automatically detect the `.vscode` folder and load the project with the
correct settings.

The following configuration sections will only need to be done the first time
you open a new project in VS Code.


### Installing extensions

A notification popup at the bottom-right of the window will ask if you want to
install the recommended extensions for working on this project:

{{< figure alt="Screenshot of the prompt to install recommended extensions" width="800px" src="recommended-extensions-prompt.png" >}}

These extensions add support to VS Code for technologies commonly used in KDE 
projects, such as CMake, C++, Qt, and more.

Click `Install`.


### Configuring the project

After the extensions have been installed:

- If a notification prompt asks if you want to switch to a pre-release version
  of the C++ extension, click `No`.
- A notification prompt will ask `Would you like to configure project "kcalc"?`
  Click `Yes`.

{{< figure alt="Screenshot of the prompt to configure the project" width="800px" src="configure-project-prompt.png" >}}

A prompt will open at the top-middle of the window asking to choose a kit
(a set of predefined configurations used when building and running the project). Select 
`Unspecified` to have the kit chosen automatically based on the project and 
system configuration:

{{< figure alt="Screenshot of the prompt to select a kit" width="800px" src="select-kit-prompt.png" >}}

The integrated terminal will open at the bottom of the window, and if the
project was configured successfully, the last line should say:

```
[cmake] -- Build files have been written to: /home/<username>/kde/build/kcalc
```

{{< figure alt="Screenshot of the terminal showing successful configuration" width="800px" src="configuration-successful.png" >}}

You are ready to start working on the code with VS Code! 🎉


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


### Debugging KCMs

{{< alert title="Note" color="info" >}}
The configurations for KCMs are only generated by the newer `kde-builder` build tool, and not by the legacy `kdesrc-build` tool.
{{< /alert >}}

We'll use the `plasma-workspace` project as an example, as it contains many `KDE
Configuration Modules` (KCMs).

Open the build target selector by clicking the button (defaults to `all`):

{{< figure alt="Screenshot of button to choose the build configuration" width="800px" src="kcm-choose-build-button.png" >}}

Filter for KCMs by typing `kcm_` in the popup, and choose one of the options marked `MODULE_LIBRARY` that represents a KCM:

{{< figure alt="Screenshot filtering build targets for available KCMs" width="800px" src="kcm-choose.png" >}}

Now you can start debugging the KCM by selecting the `kcm` launch configuration and clicking the green play button:

{{< figure alt="Screenshot of choosing the kcm launch configuration" width="800px" src="kcm-start-debugging.png" >}}

The KCM will open in a new window, and the debugger will hit breakpoints in the 
C++ code. Breakpoints in QML are sadly not possible.

{{< figure alt="Screenshot of kcm running" width="800px" src="kcm-running.png" >}}


## Troubleshooting

- Reloading the window (Command Palette -> `Developer: Reload Window`) can fix
  some issues, and cause notifications/prompts to reappear if they were missed.
- Command Palette -> `CMake: Delete Cache and Reconfigure` or 
  `CMake: Reset CMake Tools Extension State (For troubleshooting)` can be 
  useful if things are not working as expected.

{{< alert title="Note" color="info" >}}
In case something goes wrong in config generation, if using kde-builder, you can use the `ide_project_configs` logger. Create the file
  `~/.config/kde-builder-logging.yaml` with the following content:
```yaml
loggers:
  ide_project_configs:
    level: DEBUG
    handlers: [console-named]
```
  After that, run kde-builder as normal, and you will see corresponding debug messages.
{{< /alert >}}

## Tips

- The [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette)
  (`Ctrl+Shift+P`) is your friend. It allows you to search for and run commands, 
    and is a great way to discover features.
- There is extensive documentation available for VS Code at
  https://code.visualstudio.com/docs.
- There are first-party video tutorials available at
  https://code.visualstudio.com/docs/getstarted/introvideos.


## Notes

The templates for the `.vscode` configuration files are available
[here](https://invent.kde.org/sdk/kdesrc-build/-/tree/master/data/vscode) if you
need to reference them or create them manually.
