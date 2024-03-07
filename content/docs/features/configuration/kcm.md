---
title: Settings module (KCM) development
description: This tutorial will help you create a Plasma configuration module.
weight: 3
aliases:
  - /docs/features/configuration/kcm/
---

## Introduction

Settings in Plasma are provided by KDE Configuration Modules (KCM). These can be loaded by multiple wrapper applications
such as `systemsettings` on the desktop, `plasma-settings` on mobile or `kcmshell6` for standalone config windows.
The source code for the different modules is split across different locations, such as [plasma-workspace](https://invent.kde.org/plasma/plasma-workspace/-/tree/master/kcms) or [plasma-desktop](https://invent.kde.org/plasma/plasma-desktop/-/tree/master/kcms).

You can query the available KCMs using `kcmshell6 --list`. To load an individual module in a standalone window pass its
name to the wrapper application, e.g. `systemsettings kcm_accounts`, `plasma-settings -m kcm_kaccounts`, or `kcmshell6 kcm_kaccounts`.

## Basic KCM

KCMs consist of a KPackage holding the QML UI and a C++ library holding the logic. Some legacy KCMs are based on QtWidgets,
however this is not recommended for new KCMs and it's not possible to load these in `plasma-settings`. In Plasma, new KCMs should be built using QML and [Kirigami](docs:kirigami2).

As an example, we are going to create a time settings module that allows us to configure the time in our system.
The basic structure of this hypothetical time settings module is the following:


```
...
├── CMakeLists.txt
└── src
    ├── CMakeLists.txt
    ├── timesettings.cpp
    ├── timesettings.h
    ├──  kcm_time.json
    └── ui
        └── main.qml
```


## CMakeLists.txt

There are two CMake files here, one inside `src` folder and one in the root folder.

### ./CMakeLists.txt

{{< readfile file="/content/docs/features/kcm/CMakeLists.txt" highlight="cmake" >}}

The `CMakeLists.txt` file in the root folder declares the project and prepares the KCM for building.
This is only needed if you build the KCM alone, but usually KCM is included with the project
it's for.
Therefore it's not necessarily needed, but you need to make sure the project includes
the libraries its KCM needs as well.

### ./src/CMakeLists.txt

{{< readfile file="/content/docs/features/kcm/src/CMakeLists.txt" highlight="cmake" >}}

These CMake files contain a few packages of note: [KCMUtils](docs:kcmutils) provides various classes that allow us to work with [KCModules](docs:kconfigwidgets;KCModule), and `Config` includes the [KConfig](docs:kconfig) classes. You are likely to have seen most of the other packages elsewhere in this documentation; if not, [you can read this page](/docs/getting-started/kirigami/advanced-understanding_cmakelists) which goes through a similar CMakeLists file line by line.

What's different here is that we are using C++ code as a plugin for our QML code. This is why we don't have a `main.cpp`: we only need the class that will provide the backend functionality for our KCM. `kcoreaddons_add_plugin` creates such a plugin and installs it to the right location.

## timesettings.h

{{< readfile file="/content/docs/features/kcm/src/timesettings.h" highlight="cpp" >}}

Here we are defining the class we will be using for our KCM.
[KQuickConfigModule](docs:kcmutils;classKQuickConfigModule.html)
serves as the base class for all QML-based KCMs.
You can read the linked API documentation to get a full description, and the KConfigXT page goes into more detail about how KConfigXT works.

## timesettings.cpp

{{< readfile file="/content/docs/features/kcm/src/timesettings.cpp" highlight="cpp" >}}

Here is where we would put any backend code that changes things behind the scenes. We can expose functions in here to our QML so that elements of our UI can be used to trigger backend functionality. This C++ code is then installed in our system on compilation in a KCM plugin directory, where upon execution the KCM can access and use it.

In this C++ file we define the constructor for the class in the previous file. We include some basic metadata about this KCM and we provide the buttons that we will want included in our window.

## package/kcm_time.json

{{< readfile file="/content/docs/features/kcm/src/kcm_time.json" highlight="json" >}}

This `.json` file provides metadata about our KCM. These entries specify the following:

* `Name` defines the name of the KCM which is shown in the settings app.
* `Description` is a short, one sentence description of the module.
* `FormFactors` defines on which kinds of devices this KCM should be shown.
* `X-KDE-System-Settings-Parent-Category` defines the category systemsettings5 is showing the module in.
* `X-KDE-Keywords` defines Keywords used for searching modules.

## package/contents/ui/main.qml

{{< readfile file="/content/docs/features/kcm/src/ui/main.qml" highlight="json" >}}

As you can see, this is a very basic KCM QML file. We have used a [SimpleKCM](docs:kdeclarative;org::kde::kcm::SimpleKCM) component as the root component, and we have just included a label inside here.

More complex layouts will require using a different root component. Each has its own use:

 - Use [ScrollViewKCM](docs:kdeclarative;org::kde::kcm::ScrollViewKCM) for content that is vertically scrollable, such as ListView.
 - Use [GridViewKCM](docs:kdeclarative;org::kde::kcm::GridViewKCM) for arranging selectable items in a grid.
 - Use [SimpleKCM](docs:kdeclarative;org::kde::kcm::SimpleKCM) otherwise.

{{< alert title="Note" color="info" >}}
KCMs can consist of multiple pages that are dynamically opened and closed. To push another page to the page-stack, we can use:

```js
kcm.push("AnotherPage.qml")
```

AnotherPage.qml should have one of the aforementioned KCM component types as the root element. 

To pop a page (remove the last page on the page-stack) you can just use:

```js
kcm.pop()
```
{{< /alert >}}

## Run it!

All we need to do now is compile and run our KCM.
In this case, we are installing our KCM to `~/kde/usr`, a non-standard location, so that we don't risk messing up anything on our local environment.

```bash
// Configure our project in an out-of-tree build/ folder
cmake -B build/ -DCMAKE_INSTALL_PREFIX=~/kde/usr
// Compile the project inside the build/ folder
cmake --build build/
// Install the files compiled in build/ into the ~/kde/usr prefix
cmake --install build/
```

Now that our KCM is installed, we can run it (that is, so long as we have executed `source prefix.sh`, which includes our non-standard `~/kde/usr/` location in our current environment).

```bash
source build/prefix.sh
kcmshell6 kcm_time
```

{{< figure src="../screenshot-kcm.png" caption="The Time KCM running." >}}
