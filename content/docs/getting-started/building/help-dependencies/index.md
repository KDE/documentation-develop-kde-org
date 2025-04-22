---
title: "Installing build dependencies"
description: "What to do when you are missing dependencies"
weight: 5
group: "help"
---

If you have any trouble getting things to build due to missing 3rd-party package dependencies, read on to learn what to do.
If this guide does not manage to solve your compilation problems, be sure to [contact the developers]({{< ref "help-developers" >}}).

## How to install all the build dependencies of one package

Often the simplest solution to the problem of missing dependencies is to automatically install all of the project's required dependencies.

Because most distributions keep track of package dependencies, most also provide their own built-in commands to install all the build dependencies of a package.

While these commands will not *always* install all dependencies you will need when compiling KDE software (for example, when compiling with [kde-builder]({{< ref "kde-builder-setup" >}}), where the software is always changing), they will make your dependency resolution faster.

### Debian, Ubuntu, Kubuntu, and KDE neon

All known build dependencies for the package you want to build can be installed with `apt build-dep`:

```bash
sudo apt build-dep dolphin
```

### openSUSE

All known build dependencies for the package you want to build can be installed with `zypper source-install --build-deps-only`:

```bash
sudo zypper --plus-content repo-source source-install --build-deps-only dolphin
```

The `--plus-content` option is required to temporarily enable the source repositories containing the build dependency information.

### Fedora

All known build dependencies for the package you want to build can be installed with `dnf builddep`:

```bash
sudo dnf builddep dolphin
```

## Using build errors to find missing dependencies

Whenever you attempt to compile a project and it fails to build, most of the time this is caused by a missing dependency.

Let's say you see the following error when compiling a project:

```bash
-- Could NOT find KF6TextWidgets (missing: KF6TextWidgets_DIR)
-- Could NOT find KF6TextWidgets: found neither KF6TextWidgetsConfig.cmake nor kf6textwidgets-config.cmake
CMake Error at /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:230 (message):
  Could NOT find KF6 (missing: TextWidgets)
```

This error is provided by CMake and it means you are missing the KDE Frameworks 6 library KTextWidgets.

For projects using [Meson](https://mesonbuild.com/), the error message would look like this:

```bash
Build-time dependency gi-docgen found: NO (tried pkgconfig and cmake)

docs/api/meson.build:5:15: ERROR: Dependency "gi-docgen" not found, tried pkgconfig and cmake
```

Meson projects typically prefer using `pkgconfig` over CMake package configuration files.

The error here states that Meson could not find the pkgconfig file for `gi-docgen` (most likely a file with the extension `.pc`) or the CMake file (most likely a file with the extension `.cmake`) that contains `gi-docgen` in its name (case insensitively).

### Generic search

There are two types of dependencies: build dependencies and runtime dependencies. The distribution package names for build dependencies usually begin with `lib` and/or end in `-dev` or `-devel`, whereas runtime dependencies usually just start with `lib`.

For build dependencies you will likely only need packages that end in `-dev` or `-devel`, but in some cases you might need to install packages starting with `lib` too.

In the previous cmake example, KTextWidgets is a build dependency.

The main way to find the package that provides KTextWidgets is to search for it in your package manager:

* Debian and derivatives: `sudo apt search textwidgets`
* openSUSE: `sudo zypper search textwidgets`
* Fedora: `sudo dnf search textwidgets`
* Arch: `sudo pacman -Ss textwidgets`
* FreeBSD: `sudo pkg search textwidgets`

Just searching for the component usually reveals the right package name, although it ultimately amounts to guessing or trial-and-error. KDE frameworks or other libraries often have various, slightly different, names, depending on the context. For example, KTextWidgets might sometimes be called TextWidgets, KF6TextWidgets or similar names. If you can't find anything for one name, try searching for such variations.

The usual pattern you will find for dependency packages looks like this:

* Debian and derivatives: `lib<packagename>-dev` or `<packagename>-dev`
* openSUSE and Fedora: `kf6-<packagename>-devel` or `libKF6<PackageName>`
* Arch: `<packagename>`

{{< alert title="Tip" color="success" >}}

You can also use web shortcuts provided by KRunner, which will open the package search website for each distribution.

For example: open KRunner with Alt + Space, then type: `debian: textwidgets`. Your browser will open the "textwidgets" page of the [Debian Package Search website](https://packages.debian.org/) automatically.

{{< /alert >}}

### Finding specific packages using CMake package configuration files

A more efficient way is to use the functionality provided by your package manager to search for the CMake config file:

* Debian and derivatives: `apt-file find KF6TextWidgetsConfig.cmake`
* openSUSE: `zypper what-provides 'cmake(KF6TextWidgets)'`
* Fedora: `dnf provides 'cmake(KF6TextWidgets)'`
* Arch: `pkgfile KF6TextWidgetsConfig.cmake`

Fedora and openSUSE come with this functionality by default. On Debian, you will need to install `apt-file` manually. On Arch, install `pkgfile`.

If while using `apt-file` you get an error similar to the following:

```bash
The imported target "Qt6::qtwaylandscanner" references the file
     "/usr/lib/qt6/libexec/qtwaylandscanner"
but this file does not exist.
```

You can run this to see what package contains this file:

```bash
apt-file find /usr/lib/qt6/libexec/qtwaylandscanner
```

You will get the following output:

```bash
qt6-wayland-dev-tools: /usr/lib/qt6/libexec/qtwaylandscanner
```

So the package you need to install is `qt6-wayland-dev-tools`.

### Finding specific packages using pkgconfig files

Similarly to the above, some distributions also allow querying for packages using pkgconfig files:

* openSUSE: `zypper what-provides 'pkgconfig(gi-docgen)'`
* Fedora: `dnf provides 'pkgconfig(gi-docgen)'`

### Finding missing executables

If the CMake error looks like the following:

```bash
CMake Error at /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:230 (message):
  Could NOT find Sass (missing: Sass_EXECUTABLE)
Call Stack (most recent call first):
  /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:600 (_FPHSA_FAILURE_MESSAGE)
  cmake/modules/FindSass.cmake:48 (find_package_handle_standard_args)
  CMakeLists.txt:31 (find_package)
```

This is due to CMake not finding the executable named `sass` (most likely a file `/usr/bin/sass`).

To solve this, you can specifically search for the executable in distribution packages:

* Debian and derivatives: `apt-file search /usr/bin/sass`
* Fedora: `sudo dnf provides sass`
* openSUSE: `sudo zypper search --provides /usr/bin/sass`
* Arch: `sudo pacman -F /usr/bin/sass`
* FreeBSD: `sudo pkg provides sass`

{{< alert title="Configuring pkg-provides on FreeBSD" color="info" >}}

<details>
<summary>Click here to set up pkg-provides on FreeBSD</summary>
<br>

Once you run `pkg provides`, if you face the error:

```bash
makeinfo: not found WARNING: 'makeinfo' is missing on your system.
```

This means you are missing the provides plugin:

```bash
sudo pkg install pkg-provides
```

Uncomment the following lines in `/usr/local/etc/pkg.conf` and add `provides` to the supported plugin list:

```ini
PKG_PLUGINS_DIR = "/usr/local/lib/pkg/";
PKG_ENABLE_PLUGINS = true;
PLUGINS [ provides ];
```

To confirm it is working:

```bash
sudo pkg plugins
# NAME       DESC                                          VERSION
# provides   A plugin for querying which package provides a particular file 0.7.3
sudo pkg provides -u
sudo pkg provides bin/makeinfo
# Name    : texinfo-7.0.3,1
# Comment : Typeset documentation system with multiple format output
# Repo    : FreeBSD
# Filename: usr/local/bin/makeinfo
sudo pkg install texinfo
```

</details>

{{< /alert >}}
