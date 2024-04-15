---
title: Extending your package
description: Understand the core components of your manifest.
weight: 2
aliases:
  - /docs/flatpak/manifest/
---

Let's first take a look at our previous manifest to understand what each thing does.

{{< code-toggle prefix="kate" >}}id: org.kde.kate
runtime: org.kde.Platform
runtime-version: "5.15-21.08"
sdk: org.kde.Sdk
command: kate
desktop-file-name-suffix: " (Nightly)"
finish-args:
  - "--share=ipc"
  - "--socket=fallback-x11"
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

If we read the [official flatpak-builder documentation](https://docs.flatpak.org/en/latest/flatpak-builder-command-reference.html), we can see values in parentheses for each property, namely `string`, `boolean`, `integer`, `object`, `array of strings` and `array of objects and strings`.

While non-KDE software typically gets included to Flathub as YAML, KDE software added to the kdeapps and Flathub repositories is included via JSON manifests, so we will focus on that. The practical distinction between the above types for when writing a JSON manifest is mostly syntactic. For basic types like string, boolean, integer and object, their syntax in JSON would be simply:

`"Property": "Value"`

For array of strings, this would be:

`"Property": [ "String1", "String2", "String3" ]`

wherein [] represents an array.

For array of objects and strings, this would be something like:

`"Property": ["string1", {"PropertyA": "ValueA", "PropertyB": "ValueB"}]`

wherein inside the [] array, there is a string and an object, the latter being everything inside {}.

You must be wary of the correct syntax for each type of property, as this can get confusing pretty fast, especially if you are not well acquainted with JSON syntax.

Now let's take a look at each component from a logical sequence of information (rather than the arbitrary one in the example).

`id` refers to the name of the flatpak package, the one that will be used for searching or installing. So when you run `flatpak install kate`, you can find `org.kde.kate` because flatpak is performing a fuzzy search based on the id.

`command` refers to the default program to be executed when you run a flatpak, in this case `kate`. So when you run `flatpak run org.kde.kate` you are effectively running `kate` from within the flatpak.

`desktop-file-name-suffix` is an addition to the package name as it will be shown in your application menu. In this case, `Kate (Nightly)`.

`runtime` refers to the bundle of libraries used to ship with your application, as opposed to using your system libraries. Runtimes are the reason flatpak can run on any Linux distribution: you always ensure that your application runs against the same libraries. `runtime-version` simply determines to which version of those libraries your application will be built. Each application is built only once for each runtime version, and updating library versions is as simple as bumping one number up.

`sdk` refers to the bundle of development libraries used for building your application. Away from your sight, `flatpak-builder` creates a .build folder in the same place where your manifest is, builds it there, then creates a package. Here we use the KDE/Qt development libraries provided by `org.kde.Sdk`.

`finish-args` are the arguments pertaining to the permissions your flatpak will have. `--share=ipc` provides access to shared memory, `--socket=wayland` allows your application to be controlled by a Wayland compositor, like KWin, and `--socket=fallback-x11` allows your application to be controlled by an X server, usually Xorg, but only when using an X11 session, meaning that the app won't have unnecessary X11 permissions while on a Wayland session.

`modules` are the things to be compiled and their respective compilation options. Here we build Konsole so we can make use of its KonsoleParts for Kate to display its embedded terminal. The `name` property is used for clarification and in the case of multiple flatpak manifests. `buildsystem` is the software used to compile, which in KDE software's case is usually cmake or cmake-ninja.

When building, the first step of `flatpak-builder` is to automatically fetch the source code (if it's not already present). The `sources` are used to specify where you want to fetch the source code from, but it is usually of type `git` or `archive`. Since the applications from our kdeapps repository are nightlies, those usually take a `git` type of source. Official releases either use `archive` by pulling from [download.kde.org](https://download.kde.org) or `git` by specifying a `tag`.

Like the above `tag` example, there are other properties that can be used to improve your flatpak package.

One of the top level properties that is common in the kdeapps repository is `branch`. It is not about git branches, but rather flatpak branches. Apps from `flathub` are usually of branch `stable` or of specific versions, those of `kdeapps` are usually `master`, and those of `flathub-beta` are usually `beta`. This way a user can install the same application under different branches as defined by the package publisher.

`rename-icon` allows you to specify an icon in your sources that will be renamed according to the id of the application so it gets properly detected by the .desktop file used for the flatpak in specific cases.

There are some particularly useful non-top-level properties.

`builddir` allows your build to use an out of source build folder in case you have any issues with the default build folder place.

`cleanup` allows you to delete specific files from your final flatpak. This way it is possible to make the resulting package smaller. In case you'd like to see the folder structure of the generated package so you are aware of which files were generated, you can get a shell inside a non-installed flatpak during build time using `flatpak-builder --run <build-dir> <manifest> bash` or get a shell in an installed flatpak while running using `flatpak ps` and then `flatpak enter <instance> bash`. After that, you can navigate to `/app`, which is where the actual flatpak files will be.

`config-opts` is used by buildsystems like cmake in case specific options or flags are needed to compile the application. This can be useful for example to toggle debug/testing mode, or to hinder the creation of docs.

`base` is used for cases where applications extend upon existing applications. For instance, `org.kde.falkon` extends upon `io.qt.qtwebengine.BaseApp`.

`build-commands` is used in case your build system is `simple` rather than `cmake` or `cmake-ninja` and you need to specify the compilation commands yourself.
