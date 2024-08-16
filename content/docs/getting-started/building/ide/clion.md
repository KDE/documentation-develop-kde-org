---
title: "CLion"
description: "C++ IDE from JetBrains."
weight: 5
authors:
    - SPDX-FileCopyrightText: 2024 Kristen McWilliam <kmcwilliampublic@gmail.com>
    - SPDX-FileCopyrightText: 2024 Andrew Shark <ashark@linuxcomp.ru>
SPDX-License-Identifier: CC-BY-SA-4.0
---

[CLion](https://www.jetbrains.com/clion/) is a proprietary IDE for C++ from JetBrains.

This article will show you how to configure and develop KDE projects in CLion. We will use _KCalc_ as an example project.

## Install CLion

Follow the [Install CLion](https://www.jetbrains.com/help/clion/installation-guide.html) documentation.

If you are using Arch Linux, you can install the AUR package [clion](https://aur.archlinux.org/packages/clion)
or [clion-eap](https://aur.archlinux.org/packages/clion-eap).

{{< alert title="Note" color="info" >}}
This article assumes you use KDE Builder. The older tool kdesrc-build does not support CLion configuration generation.
{{< /alert >}}

## KDE Builder configuration

To allow kde-builder to generate CLion project files, add the following to your `~/.config/kdesrc-buildrc`:

```
global
  # other options
  generate-clion-project-config true
end global
```

Instead of enabling the `generate-clion-project-config` option globally, you may choose to enable it only for a single project:

```
options kcalc
  generate-clion-project-config true
end options
```

Ensure you have successfully built _kcalc_ following the kde-builder instructions.

In case you enabled `generate-clion-project-config` after you have built _kcalc_ previously, or do not want to edit your config, you can generate CLion 
configs by running:

```
kde-builder kcalc --no-include-dependencies --no-src --build-system-only --generate-clion-project-config
```

## Using generated project in CLion

### Opening project

From the CLion main menu, select **File | Open**.

An "Open File or Project" dialog will show up. Choose `~/kde/src/kcalc` directory and press OK.

{{< figure alt="Selecting directory in Open File or Project window" width="400px" src="open-file-or-project-directory.png" >}}

<details>
<summary>Alternative ways of opening projects</summary>

If you have not yet opened any projects, or you have disabled "Reopen projects on startup" setting, when starting CLion, you will see a "Welcome to Clion"
window. Press the "Open" button.

{{< figure alt="Open button in Welcome to Clion window" width="400px" src="open-from-welcome-to-clion-window.png" >}}

In "Open or Import Project" dialog, you can also select the root CMakeLists.txt file (i.e. `~/kde/src/kcalc/CMakeLists.txt`) and choose to open it as a 
project.

{{< compare >}}
{{< figure alt="Selecting cmakelists in Open File or Project window" width="400px" src="open-file-or-project-cmakelists.png" >}}

&nbsp;&nbsp;&nbsp;&nbsp;

{{< figure alt="open as cmake project" width="500px" src="open-cmakelists-as-project.png" >}}

{{< /compare >}}

</details>

### Selecting CMake Profile

The "Open Project Wizard" window will open:

{{< figure alt="Open Project Wizard window" width="800px" src="open-project-wizard-window.png" >}}

{{< alert title="Tip" color="info" >}}
You can reach these settings later by going to **Settings | Build, Execution, Deployment | CMake**.
{{< /alert >}}

If the project has a `CMakePresets.json` in its root directory (KCalc does), you will see many greyed-out CMake Profiles. They are read only, and 
disabled by default. You do not need them. Scroll the list down to be able to see the "KDE Builder cmake profile", which you want to select.

The very first time you use a kde-builder generated CLion project, you will need to create a toolchain named "KDE Builder toolchain".
Press "Manage toolchains" link, and follow the next section instructions.

If you have done that, proceed by pressing OK.

#### Creating the toolchain

{{< alert title="Tip" color="info" >}}
This is a global IDE setting, so you will only need to do it once.
{{< /alert >}}

The "Toolchains" window will appear:

{{< figure alt="Toolchains window" width="700px" src="kb-toolchain-creation.png" >}}

{{< alert title="Tip" color="info" >}}
You can reach these settings later by going to **Settings | Build, Execution, Deployment | Toolchains**.
{{< /alert >}}

* Press "+" icon, and select "System" from the list.
* In the Name field, enter exactly "KDE Builder toolchain".
* In the CMake field, enter "cmake".
* In the Debugger field, select "Custom GDB executable" and enter "gdb".

You can specify the full path to the tools or use bundled tools for CMake and GDB. But note that the toolchain name should be exactly that, because it is 
used 
in generated project configurations.

Press OK.

### Selecting Run/Debug Configuration

In the upper right corner of CLion's window, you will see that "KDE Builder cmake profile" is applied, and "KDE Builder run/debug configuration" is applied.

{{< figure alt="IDE window with selected run configuration" width="900px" src="kb-run-debug-conf-applied.png" >}}

You can now start developing. Set a breakpoint, start a debugging session, create your own run/debug configuration based on original, and so on.

## Tips and Tricks

### JetBrains Dolphin Plugin

[JetBrains Dolphin Plugin](https://github.com/alex1701c/JetBrainsDolphinPlugin) is a service menu plugin (context menu action) which allows you to easily open folders as IDE projects.

You can install it from the store.kde.org (in the _Configure Dolphin_ choose _Context Menu_, then press _Download New Services..._ button. Search for
_Jetbrains Dolphin Plugin_ by alex1701c).

If you are using Arch Linux, you will prefer to install from AUR:
[kf6-servicemenus-jetbrains-dolphin-plugin-git](https://aur.archlinux.org/packages/kf6-servicemenus-jetbrains-dolphin-plugin-git).

{{< figure width="500px" src="jb-dolphin-plugin.png" >}}

### JetBrains Runner

You can install [JetBrainsRunner](https://github.com/alex1701c/JetBrainsRunner) search plugin to be able to quickly open recent projects in JetBrains IDEs.

If you are using Arch Linux, you will prefer to install from AUR: [plasma6-runners-jetbrains-runner-git](https://aur.archlinux.org/packages/plasma6-runners-jetbrains-runner-git).

{{< figure width="500px" src="jb-runner-plugin.png" >}}

### Plugins for CLion

#### Qt6Renderer

Currently, the Qt classes do not support pretty printing in debugger in CLion out of the box.
See [Bug CPP-605](https://youtrack.jetbrains.com/issue/CPP-605/Qt-types-renderers) for more information.

You can install [Qt6Renderer](https://plugins.jetbrains.com/plugin/19882-qt6-renderer) plugin.

#### GNU GetText files support (*.po)

Install the [GetText files support (*.po)](https://plugins.jetbrains.com/plugin/7123-gnu-gettext-files-support--po-) plugin. It will make the source lines in
the po files clickable.

For example, you search the strings in local language, to find the place in code where it is used, you find it in *.po files. They contain stanzas like this:

```bash {title="~/kde/src/ark/po/ru/ark.po"}
#: part/part.cpp:132
#, kde-format
msgid "Comment has been modified."
msgstr "Комментарий был изменен."
```

You want to quickly jump to the source file. That source file (`part/part.cpp:132`) becomes a clickable link if you install the plugin.

### Non-project executable to run

When developing a library, it may be convenient to launch some application that uses it, from the current project. For example, you work with Ark's libraries
used in Dolphin context menu actions. You can make your run configuration to launch custom binary - dolphin.

To do that, do the following:
* Open `Run/Debug Configurations` window
* Click "Copy" icon to create a new run configuration based on the run configuration we have generated with kde-builder.

The new configuration will appear.
* Give it a meaningful name, for example _ark (run dolphin)_.
* In the _Executable_ field, specify path to dolphin binary: _/home/username/kde/build/dolphin/bin/dolphin_.
* Press OK.

Now when you run this configuration, the Ark will be built, but Dolphin will be launched.

### Use native titlebar with New UI

It is possible to show a normal window titlebar. For this, open the registry (double-tap Shift, search for "Registry") and disable the
property `ide.linux.hide.native.title`.

### Use KWallet for git credentials

You need to enable this key in Registry: `credentialStore.linux.prefer.kwallet`. It allows to use KWallet if KWallet and SecretService are both available.

{{< alert title="Note" color="info" >}}
See the developer documentation in KDE Builder for details about [config generation for CLion](https://kde-builder.kde.org/en/developer/ide-configs-generation.html#clion).
{{< /alert >}}
