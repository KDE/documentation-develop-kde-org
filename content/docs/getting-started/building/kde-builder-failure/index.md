---
title: "Basic troubleshooting"
description: "What to do in case of build issues"
weight: 13
group: "kde-builder"
aliases: kdesrc-build-failure
---

## The project has failed to build

Did one or more modules fail to build (displayed in red font) using `kde-builder`?
This page should tell you the most likely causes and how to fix them.

Remember that you can [contact the development team]({{< ref "help-developers" >}}) to get assistance with kde-builder.

### Missing dependencies

The most likely reason is that you are missing the dependencies necessary for the failing module.
Once `kde-builder` finishes its build and fails, it will display the path to the module's CMake log files (for example: `~/kde/src/log/latest/kwallet/error.log`).

You should take a look at the log files to see if anything is missing: you can read more about how to understand the errors you get from CMake in [Install the dependencies]({{< ref "help-dependencies" >}}).
That page will also tell you how to search for dependencies in your distribution.

When you have the necessary dependencies, you can save time and resume from the failing module with the `--resume-from` flag:

```
kde-builder [module you want to build] --resume-from [the module that failed]
```

### Old cache

Sometimes a project has suffered big enough changes to its code that its cache starts to affect subsequent builds.

To clear the cache, you can use the `--refresh-build` flag:

```
kde-builder [failing module] --refresh-build --no-include-dependencies
```

### Broken master branch

It is rare, but if the master branch of a project contains faulty code, it will not compile with kde-builder.

To check, look at the [Invent](https://invent.kde.org), KDE's Gitlab instance where all code is stored.
If the project has a GitLab build pipeline and the pipeline is broken, then it's not your fault.

{{< figure class="text-center mr-5 pr-5" caption="Where to see if the pipeline is working." src="gitlab-successful.webp" >}}

## The project has failed to run

Did the project build successfully, but it does not run as intended?
Here are a few reasons why.

### Changes to the installed files

Sometimes some changes to a project's code (or one of its dependency libraries) lead to its installed files to be renamed or moved.
When that happens, the old files might still linger in `~/kde/usr`.

There are multiple ways to address this:

* You can just always run kde-builder with the `--use-clean-install` flag. This will call the uninstall target of CMake that KDE projects using extra-cmake-modules have, uninstalling previously installed files before installing new ones. This will decrease the speed of installing files built with kde-builder.
* You can nuke your current installed files with `rm -rf ~/kde/usr` and then rerun kde-builder.
* You can start with a new and clean kde-builder installation. This can be done by creating a new user and installing kde-builder from scratch. Another possibility is to rename your existing development setup with `mv ~/kde ~/kde~bak` and then rerun kde-builder.

## Common problems in stable distributions

Distributions that are [not sufficiently up-to-date]({{< ref "building#choosing" >}}) may encounter unavoidable problems that will need to be addressed to .

Sometimes lack a required library for building a specific project, and if you have followed our [Qt setup with the online installer]({{< ref "kde-builder-setup#setting-up-qt" >}}), you might have noticed that the default recommended installation is lean by default, which means you might be missing some Qt library.

### Cannot build Python bindings / missing stddef.h

To build the [Python bindings for KDE Frameworks]({{< ref "python-bindings" >}}), the following packages are required:

* python3-build
* python3-shiboken6 and respective development package
* python3-pyside6 and respective development package
* clang

The names may vary according to the distribution.

If you get an error similar to this:

```
(kcoreaddons) Clang: 1 diagnostic messages:
  /usr/include/c++/14/cstddef:50:10: fatal: 'stddef.h' file not found
```

This means you need to install clang.

If you encounter other errors referencing shiboken or pyside, you might be missing some of the other packages.

Note that by default you won't encounter this issue on most major distributions if you have allowed kde-builder to install the necessary distro packages with either `kde-builder --initial-setup` or `kde-builder --install-distro-packages`.

Alternatively, you may disable building the Python bindings altogether by adding the following to the global `cmake-options` section of your `~/.config/kde-builder.yaml`:

```yaml
cmake-options: >
  -DBUILD_WITH_PYTHON_BINDINGS=OFF
```

### Qt online installer: missing libraries

We opt to recommend a leaner installation of Qt with the online installer in our [Qt setup]({{< ref "kde-builder-setup#setting-up-qt" >}}), but sometimes this might mean you will end up missing a major optional Qt library such as QtWebengine, QtTextToSpeech, or QtVirtualKeyboard.

To install the missing libraries, open the "Qt Maintenance Tool" entry in your menu and select the optional library that you need that matches the Qt version you have installed.

Alternatively, many projects offer to disable specific features that require optional libraries. To do this, first attempt to compile them once with kde-builder. Afterwards, run `ccmake` in its respective build directory:

```bash
ccmake ~/kde/build/ktextwidgets
```

You will see that in the KTextWidgets case there is a setting to disable building `WITH_TEXT_TO_SPEECH`, which bypasses the need for you to have QtTextToSpeech installed on your system.

You can then override KTextWidgets to disable this option by adding the following to the end of your `~/.config/kde-builder.yaml` file:

```yaml
override ktextwidgets:
  cmake-options: >
    -DWITH_TEXT_TO_SPEECH=OFF
```

### Missing non-KDE library that is not managed by kde-builder

By default kde-builder does build third-party libraries that are required by bleeding edge KDE applications or libraries, such as gpgme, poppler and wayland-protocols. You can list them with `kde-builder --dry-run workspace | grep third`.

Sometimes a KDE application might require a third-party library that is not managed by kde-builder and is not available on your distribution. For such cases, the only solution is to build that library manually with kde-builder. This makes sure that the library will be accessible by applications compiled and run with kde-builder, as it will be installed in `~/kde/usr` like the rest of the compiled projects.

To achieve this, you may add a `project` to your `~/.config/kde-builder.yaml`, similarly to [Building custom projects]({{< ref "kde-builder-compile#new-projects" >}}):

```yaml
project outside-project:
  repository: git@invent.kde.org:youruser/outside-project.git
```

Thus allowing you to run:

```bash
kde-builder outside-project
```
