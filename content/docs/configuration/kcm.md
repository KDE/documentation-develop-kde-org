---
title: Settings module development
description: This tutorial will guide you into creating a Plasma configuration module.
weight: 3
---

## Introduction

Settings in Plasma are provided by Configuration Modules (KCM). These can be loaded by multiple wrapper applications
such as `systemsettings5` on the desktop, `plasma-settings` on mobile or `kcmshell5` for standalone config windows.

You can query the available KCMs using `kcmshell5 --list`. To load an individual module in a standalone window pass its
name to kcmshell5, e.g. `kcmshell5 kcm_kaccounts`. To open it in plasma-settings use the `-m` parameter, e.g. `plasma-settings -m kcm_kaccounts`.

## Basic KCM

KCMs consist of a KPackage holding the QML UI and a C++ library holding the logic. Some legacy KCMs are based on QtWidgets,
however this is not recommended for new KCMs and it's not possible to load these in `plasma-settings`.

The basic structure of a hypothetical time settings module is the following:


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

## timesettings.h

{{< readfile file="/content/docs/configuration/kcm/timesettings.h" highlight="cpp" >}}

[KQuickAddons::ConfigModule](docs:kdeclarative;KQuickAddons::ConfigModule)
serves as the base class for all QML-based KCMs. The
[KQuickAddons::ManagedConfigModule](docs:kdeclarative;KQuickAddons::ManagedConfigModule) inherits `ConfigModule` and adds the [KConfigXt](../kconfig_xt) integration.
Please consult the API documentation for a full description.

## timesettings.cpp

{{< readfile file="/content/docs/configuration/kcm/timesettings.cpp" highlight="cpp" >}}

## package/metadata.desktop

{{< readfile file="/content/docs/configuration/kcm/package/metadata.desktop" highlight="ini" >}}

Example metadata file

* `Name` defines the name of the KCM which is shown in the settings app.
* `Description` is a short, one sentence description of the module.
* `X-KDE-Library` must match the library name defined in CMakeLists.txt.
* `X-KDE-FormFactors` defines on which kinds of devices this KCM should be shown.
* `X-Plasma-MainScript` points to the main QML file in the KPackage.
* `X-KDE-System-Settings-Parent-Category` defines the category systemsettings5 is showing the module in.
* `X-KDE-Keywords` defines Keywords used for searching modules.

## package/contents/ui/main.qml

{{< readfile file="/content/docs/configuration/kcm/package/contents/ui/main.qml" highlight="json" >}}

Basic KCM QML file

Depending on the content use one of the following root type:

 - Use [ScrollViewKCM](docs:kdeclarative;org::kde::kcm::ScrollViewKCM) for content that is vertically scrollable, such as ListView.
 - Use [GridViewKCM](docs:kdeclarative;org::kde::kcm::GridViewKCM) for arranging selectable items in a grid.
 - Use [SimpleKCM](docs:kdeclarative;org::kde::kcm::SimpleKCM) otherwise.

## Run it!

```bash
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=~/.local/kde
make -j8 install
source prefix.sh
kcmshell5 kcm_time
```

![the time kcm running](./screenshot-kcm.png)

## Multi-page KCM

KCMs can consist of multiple pages that are dynamically opened and closed. To push another page use

```js
kcm.push("AnotherPage.qml")
```

AnotherPage.qml should have one of the above types as root element. To pop a page use

```js
kcm.pop()
```
