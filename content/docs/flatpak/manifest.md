---
title: Extending your package
description: Understand the core components of your manifest.
weight: 2
---

Let's take a look at our previous manifest to understand what each thing does.

{{< code-toggle prefix="kate" >}}id: org.kde.kate
runtime: org.kde.Platform
runtime-version: "5.15"
sdk: org.kde.Sdk
command: kate
desktop-file-name-suffix: " (Nightly)"
finish-args:
  - "--share=ipc"
  - "--socket=x11"
  - "--socket=wayland"
modules:
  - name: konsole
    buildsystem: cmake-ninja
    sources:
    - type: git
      url: https://invent.kde.org/utilities/konsole.git
  - name: kate
    buildsystem: cmake-ninja
    sources:
      - type: git
        url: https://invent.kde.org/utilities/kate.git
{{< /code-toggle >}}

Let's take a look at each component from a logical sequence of metadata.

`id` refers to the name of the flatpak package, the one that will be used for searching or installing. So when you run `flatpak install kate`, you can find `org.kde.kate` because flatpak is performing a fuzzy search based on the id.

`command` refers to the default program to be executed when you run a flatpak, in this case `kate`. So when you run `flatpak run org.kde.kate` you are effectively running kate from within the flatpak.

`desktop-file-name-suffix` is an addition to the package name as it will be shown in your application menu. In this case, `Kate (Nightly)`.

`runtime` refers to the bundle of libraries used to ship with your application, as opposed to using your system libraries. Runtimes are the reason flatpak can run on any Linux distribution: you always ensure that your application runs against the same libraries. `runtime-version` simply determines to which version of those libraries your application will be built. Each application is built only once for each runtime version, and updating library versions is as simple as bumping one number up.

`sdk` refers to the bundle of development libraries used for building your application. Away from your sight, `flatpak-builder` creates a .build folder in the same place where your manifest is, builds it there, then creates a package. Here we use the KDE/Qt development libraries provided by `org.kde.Sdk`.

`finish-args` are the arguments pertaining to the permissions your flatpak will have. Arguments here are meant like running `flatpak run org.kde.kate --arg1=value1 --arg2=value2` and so on, with values that allow your application to access certain functionality of your system. `--share=ipc` provides access to shared memory, `--socket=x11` allows your application to be controlled by an X server, usually Xorg, and `--socket=wayland` allows your application to be controlled by a Wayland compositor, like KWin.

`modules` are the things to be compiled and their respective compilation options. Here we build Konsole so we can make use of its KonsoleParts for Kate to display its embedded terminal. The `name` property is used for clarification and in the case of multiple flatpak manifests. `buildsystem` is the software used to compile, which in KDE software's case is usually cmake or cmake-ninja.

When building, the first step of `flatpak-builder` is to automatically fetch the source code (if it's not present already). The `sources` are used to specify where you want to fetch the source code from, but it is usually of type `git` or `archive`. Since the applications from our kdeapps repository are nightlies, those usually take a `git` type of source. Official releases either use `archive` by pulling from download.kde.org or `git` by specifying a `tag`.

