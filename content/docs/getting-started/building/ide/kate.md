---
title: "Kate"
description: "KDE's advanced text editor."
weight: 3
authors:
    - SPDX-FileCopyrightText: 2024 Kristen McWilliam <kmcwilliampublic@gmail.com>
SPDX-License-Identifier: CC-BY-SA-4.0
---


Kate is the feature-packed text editor from KDE.

A screen recording version is available https://www.youtube.com/watch?v=WBWVTKEVkOU


## kdesrc-build

Make sure kdesrc-build works correctly. Make sure ~/.config/kdesrc-buildrc contains the lines:

```ini
cmake-options -G "Kate - Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug
# Build with LSP support for everything that supports it
compile-commands-linking true
compile-commands-export true
```

Using kdesrc-build build a module. E.g.

```bash
kdesrc-build kcalc
```


## kate

See the web page "Building Kate from Sources on Linux" https://kate-editor.org/build-it/ 

The web page talks about how to build kate using kdesrc-build and how to configure kate.

In kate enable the plugins: Project Plugin, LSP Client, Build Plugin, GDB.

Some of the features available in kate:

* LSP Client Symbol Outline
* Right click in text editor on a C++ identifier > LSP Client > Go to Declaration/Find References/ Switch Source Header F12/ Symbol Info/ Search and Go to Symbol Ctrl+Alt+P/ Format/ Rename/ Switch to diagnostics tab/ Quickfix This menu is also available from kate main menu > LSP Client.
* kate main menu > Tools > External Tools > Git > git blame/ gitk
* kate main menu > Tools > External Tools > Tools > Clang Format Full File/ Search KDE/Qt API/ JSON/XML Format Full File.


### Build and debug

#### With the ".kateproject" file

```bash
cd ~/kde/src/kcalc
ln -s ~/kde/build/kcalc/.kateproject ~/kde/src/kcalc/.kateproject
kate . &
```

* Build. kate main menu > Build > Select Target... > Target Set > Working Directory should be "~/kde/build/kcalc", all of the CMake targets should be listed, > OK button. "Build Output" tool view > "Output" is shown. kate main menu > Build > Build Default Target. 
* Debugger. kate main menu > Debug > Targets > Target 1. kate main menu > View > Tool Views > Show Debug View > Settings tab > Executable > select "~/kde/build/kcalc/bin/kcalc". Click on source code line, from kate main menu > Debug > Toggle Breakpoint. kate main menu > Debug > Start Debugging. kate main menu > Debug > Continue/ Step Over/ Step In/ Step Out.


#### Without the ".kateproject" file

If we do not have a ".kateproject" file. Then:
* Build. kate main menu > Build > Select Target... > Target Set > Working Directory should be "~/kde/build/kcalc" > OK button. "Build Output" tool view > "Output" is shown. Change to tab "Target Settings" from tool view "Build Output" > double click on cell "Dir:" > select "~/kde/build/kcalc", press Enter. kate main menu > Build > Build Default Target. 
* Debugger. kate main menu > Debug > Targets > Target 1. kate main menu > View > Tool Views > Show Debug View > Settings tab > Executable > select "~/kde/build/kcalc/bin/kcalc". Click on source code line, from kate main menu > Debug > Toggle Breakpoint. kate main menu > Debug > Start Debugging. kate main menu > Debug > Continue/ Step Over/ Step In/ Step Out.
