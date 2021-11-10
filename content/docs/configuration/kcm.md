---
title: Settings module (KCM) development
description: This tutorial will help you create a Plasma configuration module.
weight: 3
---

## Introduction

Settings in Plasma are provided by Configuration Modules (KCM). These can be loaded by multiple wrapper applications
such as `systemsettings5` on the desktop, `plasma-settings` on mobile or `kcmshell5` for standalone config windows.

You can query the available KCMs using `kcmshell5 --list`. To load an individual module in a standalone window pass its
name to kcmshell5, e.g. `kcmshell5 kcm_kaccounts`. To open it in plasma-settings use the `-m` parameter, e.g. `plasma-settings -m kcm_kaccounts`.

## Basic KCM

KCMs consist of a KPackage holding the QML UI and a C++ library holding the logic. Some legacy KCMs are based on QtWidgets,
however this is not recommended for new KCMs and it's not possible to load these in `plasma-settings`. In Plasma, new KCMs should be built using QML and Kirigami.

As an example, we are going to create a time settings module that allows us to configure the time in our system.
The basic structure of this hypothetical time settings module is the following:


```
├── CMakeLists.txt
├── timesettings.{cpp,h}
└── package
    ├── metadata.desktop
    └── contents/ui
        └── main.qml
```


## CMakeLists.txt

{{< readfile file="/content/docs/configuration/kcm/CMakeLists.txt" highlight="cpp" >}}

This CMake file contains a few packages of note: `KCMUtils` provides various classes that allow us to work with KCModules, and `Config` includes the KConfig classes. You are likely to have seen most of the other packages elsewhere in this documentation; if not, [you can read this page](../../kirigami/advanced-understanding_cmakelists) which goes through a similar CMakeLists file line by line.

What's different here is that we are using C++ code as a plugin for our QML code. This is why we don't have a `main.cpp`: we only need the class that will provide the backend functionality for our KCM.

For our KCM to work properly we must install it in our system, so at the end of our CMakeLists.txt we instruct CMake to install our KCM as a KPackage (similarly to a plasmoid, for example).

## timesettings.h

{{< readfile file="/content/docs/configuration/kcm/timesettings.h" highlight="cpp" >}}

Here we are defining the class we will be using for our KCM.
[KQuickAddons::ConfigModule](docs:kdeclarative;KQuickAddons::ConfigModule)
serves as the base class for all QML-based KCMs. The
[KQuickAddons::ManagedConfigModule](docs:kdeclarative;KQuickAddons::ManagedConfigModule) inherits `ConfigModule` and adds the [KConfigXT](../kconfig_xt) integration.
You can read the linked API documentation to get a full description, and the previous page in this section goes into more detail about how KConfigXT works.

## timesettings.cpp

{{< readfile file="/content/docs/configuration/kcm/timesettings.cpp" highlight="cpp" >}}

Here is where we would put any backend code that changes things behind the scenes. We can expose functions in here to our QML so that elements of our UI can be used to trigger backend functionality. This C++ code is then installed in our system on compilation in a KCM plugin directory, where upon execution the KCM can access and use it.

In this C++ file we define the constructor for the class in the previous file. We include some basic metadata about this KCM and we provide the buttons that we will want included in our window.

## package/metadata.desktop

{{< readfile file="/content/docs/configuration/kcm/package/metadata.desktop" highlight="ini" >}}

This `.desktop` file provides further metadata about our KCM. These entries specify the following:

* `Name` defines the name of the KCM which is shown in the settings app.
* `Description` is a short, one sentence description of the module.
* `X-KDE-Library` must match the library name defined in CMakeLists.txt.
* `X-KDE-FormFactors` defines on which kinds of devices this KCM should be shown.
* `X-Plasma-MainScript` points to the main QML file in the KPackage.
* `X-KDE-System-Settings-Parent-Category` defines the category systemsettings5 is showing the module in.
* `X-KDE-Keywords` defines Keywords used for searching modules.

This file will allow our KCM to appear in desktop launchers and KRunner, providing quick access to our KCM from outside the system settings application.

## package/contents/ui/main.qml

{{< readfile file="/content/docs/configuration/kcm/package/contents/ui/main.qml" highlight="json" >}}

As you can see, this is a very basic KCM QML file. We have used a `SimpleKCM` component as the root component, and we have just included a label inside here.

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
In this case, we are installing our KCM to `~/.local/kde/`, a non-standard location, so that we don't risk messing up anything on our local environment (if you're feeling confident, you can omit `-DCMAKE_INSTALL_PREFIX`).

```bash
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=~/.local/kde
make -j8 install
source prefix.sh
kcmshell5 kcm_time
```

Now that our KCM is installed, we can run it (that is, so long as we have executed `source prefix.sh`, which includes our non-standard `~/.local/kde/` location in our current environment).

![the time kcm running](./screenshot-kcm.png)
