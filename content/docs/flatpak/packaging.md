---
title: Distributing KDE Software as Flatpak
description: The new decentralized packaging standard for Linux applications
weight: 20
group: "packaging"
---

Flatpak is a new package format in the Linux world that works on many Linux
distributions and gives back control to the application developers. Many Flatpak
applications are distributed via [Flathub](https://flathub.org), but Flatpak is
decentralized by nature and applications can be provided using alternatives sources.

Flatpak applications can be downloaded using Discover (KDE Software Center), GNOME
Software and other software centers compatible with Flatpak.

One of the key differences to traditional packages is dependency management.
Instead of depending on many other packages and unpacking all of them into one system directory, flatpak uses so called runtimes.
Runtimes collect common frameworks and libraries used for a specific kind of application. In our case, that's the KDE Flatpak Runtime.
Once users install the common KDE runtime, applications don't have any further dependencies, and can be distributed together with their more special library requirements (like a protocol implementation for an instant messenger) in one flatpak package.

Building flatpaks consists mostly of three steps:
* Finding and installing the necessary Flatpak SDK and Runtime for your application. Most can be found in the common flatpak repository, Flathub. In case it isn't configured already, add it to your Flatpak setup: `flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo`
  For KDE software and other applications making use of Qt, this is `org.kde.Sdk`.
  As runtimes are versioned, to make sure not to break other applications with sudden updates, you'll have to pick the latest available one.
  Flatpak will ask you to choose a version when running the install command `flatpak install org.kde.Sdk`.
* Writing a flatpak manifest. Flatpak manifests can be written in json or yaml, depending on what you like better. The KDE Team on flathub currently uses json.
  A list of all possible keys for a flatpak manifest can be found in the official [flatpak documentation](https://docs.flatpak.org/en/latest/flatpak-builder-command-reference.html#flatpak-manifest), but in many cases a minimal recipe is enough.
  
  This is a minimal manifest for Kate:

{{< code-toggle prefix="kate" >}}id: org.kde.kate
runtime: org.kde.Platform
runtime-version: "5.15"
sdk: org.kde.Sdk
command: kate
finish-args:
  - "--share=ipc"
  - "--socket=x11"
  - "--socket=wayland"
modules:
  - name: kate
    buildsystem: cmake-ninja
    sources:
      - type: git
        url: https://invent.kde.org/utilities/kate.git
{{< /code-toggle >}}

  Dependencies can be added as modules just like the "kate" module that contains the application. Kate has an optional integration with Konsole. To get it working, we need to include konsole before the kate module.
  
{{< code-toggle prefix="konsole" >}}name: konsole
buildsystem: cmake-ninja
sources:
  - type: git
    url: https://invent.kde.org/utilities/konsole.git
{{< /code-toggle >}}

* The third step is building the binary. Although the final binary will be built on a CI system, you'll need to test your manifest locally.
  A useful command for that is `flatpak-builder build --force-clean --ccache org.kde.kate.json`. It will build the application in a directory called "build", clean the directory if needed and cache the build files so later builds will be faster.
  
  If the command finishes without errors, it is possible to run the application from within the build folder: `flatpak-builder --run build org.kde.kate.json kate`.
  Please not that this will not use your sandbox settings from "finish-args". For a final test of the sandbox settings, you need to install the flatpak using `flatpak-builder build --force-clean --ccache org.kde.kate.json --install`.

You can now submit your new manifest to [flatpak-kde-applications](https://invent.kde.org/packaging/flatpak-kde-applications). 
After testing it for a few days, you can submit a stable release to flathub.
