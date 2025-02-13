---
title: "Kate"
description: "KDE's advanced text editor."
weight: 5
authors:
    - SPDX-FileCopyrightText: 2024 Kristen McWilliam <kmcwilliampublic@gmail.com>
SPDX-License-Identifier: CC-BY-SA-4.0
---

{{< alert color="info" title="⏳ Outdated" >}}

This tutorial might have inaccuracies or be outdated.

If you'd like to send us fixes for this page, please make a merge request on the [KDE Developer repository](https://invent.kde.org/documentation/develop-kde-org).

{{< /alert >}}


Kate is the feature-packed text editor from KDE.

A screen recording is available showing how to use Kate with kdesrc-build: [KDE's Kate and kdesrc-build tutorial](https://www.youtube.com/watch?v=WBWVTKEVkOU)

## kde-builder setup

Make sure that `~/.config/kde-builder.yaml` contains the line:

```yaml
cmake-generator: "Kate - Unix Makefiles"
```

## kdesrc-build setup

Make sure that `~/.config/kdesrc-buildrc` contains the lines:

```ini
cmake-options -G "Kate - Unix Makefiles"
# Build with LSP support for everything that supports it
compile-commands-linking true
compile-commands-export true
```

## Kate

Kate provides its own tutorial on setting up Kate for kdesrc-build development: [Building Kate from Sources on Linux](https://kate-editor.org/build-it/).

In Kate, go to Settings -> Configure Kate... -> Plugins and enable:

* Project Plugin
* LSP Client
* Build & Run
* Kate Debugger

Some of the features available in Kate:

* LSP Client Symbol Outline
* Right click in text editor on a C++ identifier
  * LSP Client > Go to Declaration/Find References/ Switch Source Header F12/ Symbol Info/ Search and Go to Symbol Ctrl+Alt+P/ Format/ Rename/ Switch to diagnostics tab/ Quickfix This menu is also available from kate main menu > LSP Client.
* Tools > External Tools > Git
  * git blame
  * gitk
* Tools > External Tools > Tools
  * Clang Format Full File
  * Search KDE API
  * Search Qt API
  * JSON Format Full File
  * XML Format Full File

### Build and debug

#### With the ".kateproject" file

```bash
cd ~/kde/src/kcalc
ln -s ~/kde/build/kcalc/.kateproject ~/kde/src/kcalc/.kateproject
kate . &
```

To build the project from within Kate:

* Build > Select Target... > Target Settings tab
  * Set the Working Directory of the project to "~/kde/build/kcalc". This will cause all of the CMake targets to be listed.
* Build > Build Default Target.

To use the Kate debugger:

* Debug > Targets > Target 1.
  * View > Tool Views > Show Debug View > Settings tab > Executable > select "~/kde/build/kcalc/bin/kcalc".
  * Click on a source code line.
  * Debug > Toggle Breakpoint.
  * Debug > Start Debugging.

To start debugging, you can use the options:

* Debug
  * Continue
  * Step Over
  * Step In
  * Step Out

Most of these options should show up on the Kate toolbar.

#### Without the ".kateproject" file

If we do not have a ".kateproject" file. Then:
* Build. kate main menu > Build > Select Target... > Target Set > Working Directory should be "~/kde/build/kcalc" > OK button. "Build Output" tool view > "Output" is shown. Change to tab "Target Settings" from tool view "Build Output" > double click on cell "Dir:" > select "~/kde/build/kcalc", press Enter. kate main menu > Build > Build Default Target. 
* Debugger. kate main menu > Debug > Targets > Target 1. kate main menu > View > Tool Views > Show Debug View > Settings tab > Executable > select "~/kde/build/kcalc/bin/kcalc". Click on source code line, from kate main menu > Debug > Toggle Breakpoint. kate main menu > Debug > Start Debugging. kate main menu > Debug > Continue/ Step Over/ Step In/ Step Out.
