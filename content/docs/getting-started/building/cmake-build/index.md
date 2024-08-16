---
title: "Building KDE software manually"
description: "Understanding the traditional CMake build process"
weight: 41
group: "cmake-build"
---

While users on older Linux distributions might have to resort to [kdesrc-build]({{< ref "kdesrc-build-setup" >}}) or containers to be able to build KDE software, users of more up-to-date distributions might not need to use them.

The process of building KDE software with kdesrc-build or containers involves builds from the master branch, which includes unreleased code changes. These changes might rely on unreleased changes from other dependencies, so you end up needing to build those dependencies as well. This is often the case with very fast-paced software such as KDE’s [Itinerary](https://apps.kde.org/itinerary/) and [Neochat](https://apps.kde.org/neochat/).

kdesrc-build uniquely also makes it easy to run a whole Plasma Desktop session.

If the software you want to contribute to is an application that does not have bleeding edge build dependencies, it is perfectly possible (and faster and easier) to build it manually by running CMake commands on a sufficiently up-to-date Linux distribution, like the latest [Fedora](https://fedoraproject.org/spins/kde/), [openSUSE Tumbleweed](https://get.opensuse.org/tumbleweed/), or [Arch Linux](https://archlinux.org/).

If the software you want to contribute to does in fact have bleeding edge dependencies and you do not care about the dependencies themselves, it is also possible to build it manually with CMake by using a distribution that provides KDE software built from the master, like [openSUSE Krypton](https://en.opensuse.org/SDB:Argon_and_Krypton), [KDE neon Unstable Edition, or KDE neon Developer Edition](https://neon.kde.org/download).

This tutorial teaches you the basics of building a KDE project using standalone CMake the right way, how to deal with targets and tests, and the traditional way you *will* find in the wild.

This knowledge is also helpful to Windows users using [Craft](https://community.kde.org/Craft) who are designing a new application using KDE libraries and haven’t yet created their own Craft blueprints.

## Summary of commands to build a KDE project manually {#summary}

This summary is provided in case you are already somewhat familiar with CMake or you just want to skip the explanation and check the right commands to quickly start compiling a KDE project.

On Linux, do:

```bash
cmake -B build/
cmake --build build/ --parallel
cmake --install build/ --prefix ~/.local
```

On Windows, do:

```bash
cmake -B build/
cmake --build build/ --parallel
cmake --install build/
```

If you get stuck while running the first command, be sure to look at our [guide about installing build dependencies for a CMake project]({{< ref "help-dependencies" >}}).

If you get stuck while running the second command, it’s most likely a code issue that is in need of fixing.

To run tests, do:

```bash
cmake -B build/ -D BUILD_TESTING=ON
cmake --build build/ --target test
```

To uninstall the project, do:

```bash
cmake --build build/ --target uninstall
```

Keep reading this page if you want to know more about what’s happening under the hood or if you would like to understand the build instructions you might see being provided by KDE projects and others.

## The three compilation steps {#three-steps}

The compilation process of C++ software with CMake is made of three steps:

1. Configuration
2. Build
3. Installation

The terms “compilation” and “build” are typically used interchangeably, but from here on “build” will refer to the second compilation step.

These steps are done in CMake by running the following commands from the root directory of the software project:

```bash
cmake -B build/
cmake --build build/ --parallel
cmake --install build/ --prefix placetoinstall/
```

## CMake is a build system generator {#build-system-generator}

CMake itself is not really a build system. It doesn’t compile things by itself: it calls other software to compile the project for you, and that software is the build system.

On Linux, the most common build systems are Make and Ninja. On Windows, the main build system is the MSVC compiler toolset.

During the configuration step, CMake uses the source files of the project to *generate* the necessary files to build the project with a *build system* inside a *build directory*, otherwise known as *binary directory*. Hence, CMake is a *build system generator*.

CMake can then build the project by calling `make` or `ninja` (on Linux) or `msbuild` (on Windows) on the generated files:

* For `make`, the generated file is a `Makefile`
* For `ninja`, the generated file is a `ninja.build` file
* For `msbuild`, the generated file is a Visual Studio project file with extension `.vcxproj`

Lastly, during the installation step, CMake copies the files built by the build system to the place where it needs to be.

## Compiling on Windows

At this point in time, this guide does not go in-depth about manually compiling projects on Windows.

The easiest way to compile KDE software on Windows is with Craft, whether you use the provided `craft` tool or build a project manually.

All the instructions on this guide should work by default on a Linux terminal. To follow this guide’s instructions, you will need to set up Craft and run all of the commands using Craft’s provided terminal shell, CraftRoot.

## The configuration step {#configuration}

The first command prepares the project by trying to find its build dependencies:

```bash
cmake -B build/
```

You can read more about it in the [guide about installing build dependencies for a CMake project]({{< ref "help-dependencies" >}}).

{{< alert title="Note for Windows users" color="info" >}}

Windows users using [Craft](https://community.kde.org/Craft) can install missing build dependencies with the `craft` tool. For example: `craft kxmlgui`.

{{< /alert >}}

In reality, what CMake is actually running is:

```bash
cmake -S . -B build/
```

The `-S` flag specifies where to look for the project’s source code, and the `-B` flag specifies the build directory, so the place where to configure and build the project. The build/ directory is automatically created for you if it doesn’t exist.

This allows you to run the `cmake` command from anywhere, as long as you specify the source code directory and where to build it.

If either flag is omitted, the flag will point to the current directory.

If both the source code and build directory are omitted, CMake will default to searching for the source code in the current directory or any other place where you point it to, and will put the generated files in the current directory, for example:

```bash
# Configure the project using the source code
# in the above directory, then put the
# generated files in the current directory
cmake ..
```

### Out-of-tree builds {#out-of-tree}

There are four common ways to compile a project:

* from the source code folder, putting the generated files in the source code folder
* from a build folder, putting the generated files in the source code folder
* from the source code folder, putting the generated files in a build folder
* from outside the source code folder, putting the generated files in a build folder

The first causes the source code folder to become full with generated and build files together with the source code, making git output dirty. This method is always undesirable and should be avoided:

```bash
# From the root of the project source code
cmake -S . -B .
# Or simply
cmake .
```

The second is very common and can be found in the wild:

```bash
# From the root of the project source code
mkdir build/
cd build/
cmake ..
```

It is called an out-of-tree build because the generated files are not in the same place as the source code. The build/ directory is still present in the project itself, but it’s typically added to the .gitignore file of a project so as to keep git output clean.

The third is also an out-of-tree build. It is an optimization on top of the second method and should be preferred:

```bash
# From the root of the project source code
cmake -B build/
```

Instead of creating the build/ directory yourself, you can just tell CMake to create it for you with the `-B` flag.

This method is the cleanest and most convenient to use in KDE projects and tutorials.

The fourth way, which is very commonly done by IDEs (a notable example being [QtCreator](https://doc.qt.io/qtcreator/)), looks more like this:

```bash
# From a directory *above* the source code
cmake -S projectdir/ -B build/
```

It is also an out-of-tree build, and in this case the build directory is not even inside the project root folder. It requires doing extra navigation steps, but it is convenient, for example, if you want to have multiple, different build folders in the same place, as is the case with [multi-configuration builds]({{< ref "#multi-config" >}}).

### Defining a generator {#generators}

A *generator* in the context of CMake is the name given to a build system variant or specialization.

By running CMake with the `-G` flag without passing any parameter to it, CMake will show what generators are available on your system:

```bash
cmake -G
```

You’ll see something like this:

```man
CMake Error: No generator specified for -G

Generators
  Green Hills MULTI            = Generates Green Hills MULTI files
                                 (experimental, work-in-progress).
* Unix Makefiles               = Generates standard UNIX makefiles.
  Ninja                        = Generates build.ninja files.
  Ninja Multi-Config           = Generates build-<Config>.ninja files.
  Watcom WMake                 = Generates Watcom WMake makefiles.
  CodeBlocks - Ninja           = Generates CodeBlocks project files
                                 (deprecated).
  CodeBlocks - Unix Makefiles  = Generates CodeBlocks project files
                                 (deprecated).
  CodeLite - Ninja             = Generates CodeLite project files
                                 (deprecated).
  CodeLite - Unix Makefiles    = Generates CodeLite project files
                                 (deprecated).
  Eclipse CDT4 - Ninja         = Generates Eclipse CDT 4.0 project files
                                 (deprecated).
  Eclipse CDT4 - Unix Makefiles= Generates Eclipse CDT 4.0 project files
                                 (deprecated).
  Kate - Ninja                 = Generates Kate project files (deprecated).
  Kate - Ninja Multi-Config    = Generates Kate project files (deprecated).
  Kate - Unix Makefiles        = Generates Kate project files (deprecated).
  Sublime Text 2 - Ninja       = Generates Sublime Text 2 project files
                                 (deprecated).
  Sublime Text 2 - Unix Makefiles
                               = Generates Sublime Text 2 project files
                                 (deprecated).
```

The default generator is marked with an asterisk \*.

As you can see, even though Make is a single build system, CMake provides many specialized generators with the name “Unix Makefiles”. Same thing with Ninja.

Generally, on Linux, the only generators you will ever care about as a KDE developer are:

* `Unix Makefiles`
* `Ninja`
* `Ninja - Multi-Config`
* `Kate - Ninja`
* `Kate - Ninja Multi-Config`

On Windows, the only generators you will ever care about are:

* the `Visual Studio` generators
* `Mingw Makefiles`

Qt projects (and consequently also KDE projects) tend to build slightly faster with the Ninja build system on Linux and tend to produce more reliable builds with Visual Studio generators on Windows.

Ninja and Visual Studio are also able to do [multi-configuration builds]({{< ref "#multi-config" >}}).

The Kate-derived generators are essentially the same as the Make and Ninja generators, except they create `kateproject` files that can be opened with KDE’s main text editor [Kate](https://kate-editor.org) with the [build plugin](https://docs.kde.org/stable5/en/kate/kate/kate-application-plugin-build.html) already set up for the current project.

To set a generator for the project you are attempting to build, use the `-G` flag:

```bash
cmake -B build/ -G "Ninja - Multi-Config"
```

### Defining configuration options {#config-variables}

You can give instructions to override what CMake does by passing variables to the `-D` flag followed by `=somevalue`.

A common variable seen in KDE projects is used to enable tests:

```bash
cmake -B build/ -D BUILD_TESTING=ON
```

Not all KDE projects might use this variable, but they most likely have an equivalent that is specific to tests.

You can inspect the boolean configuration options available for a given project by running `ccmake` on the build directory after having configured the project:

```bash
ccmake build/
```

You can have a space between the `-D` flag and the variable, an equal sign, or no space at all:

```bash
cmake -B build/ -D=BUILD_TESTING=ON # Valid
cmake -B build/ -DBUILD_TESTING=ON # Valid
```

And you can use ON/OFF, YES/NO or TRUE/FALSE as values for boolean variables like the above:

```bash
cmake -B build/ -D BUILD_TESTING=YES # Valid
cmake -B build/ -D BUILD_TESTING=TRUE # Valid
```

KDE has mostly standardized on the ON/OFF pair of values.

There are two commonly used CMake variables that are found in the wild but have better replacements:

* [CMAKE_BUILD_TYPE](https://cmake.org/cmake/help/latest/variable/CMAKE_BUILD_TYPE.html) → `--config` flag for the build and install steps
* [CMAKE_INSTALL_PREFIX](https://cmake.org/cmake/help/latest/variable/CMAKE_INSTALL_PREFIX.html) → `--prefix` for the install step

See the sections on [multi-configuration]({{< ref "#multi-config" >}}) and the [install step]({{< ref "#install" >}}), respectively.

## The build step {#build}

It doesn’t matter which method you used to generate the necessary files to build the project, you can point to the build directory with the second command:

```bash
cmake --build build/
```

This step effectively calls the relevant build system *for* you. It is virtually the same as running the following with `make`:

```bash
cd build
make
```

or `ninja`:

```bash
cd build
ninja
```

It can be improved by parallelizing the build process, spreading out multiple source code files to your computer’s CPU cores and speeding up build times:

```bash
cmake --build build/ --parallel
```

Assuming your machine has 4 CPU cores, this is virtually the same as:

```bash
cmake --build build/ --parallel=4
# Or
cmake --build build/ -j4
# Or
cd build
make -j
# Or
cd build
ninja
```

It is not uncommon to encounter build instructions in the wild that look like the following:

```bash
mkdir build
cd build
cmake ..
make
```

They can (and should) be replaced with CMake-only instructions, as they better outline the CMake steps needed, require less typing overall, and are agnostic to the build system used:

```bash
cmake -B build/
cmake --build build/
```

Another traditional practice that can be observed in the wild and is often necessary is to delete the build directory to rebuild the project in full. This results in a longer build time, but can be used to resolve build cache issues.

```bash
rm -rf build
mkdir build
cd build
cmake ..
# Or the somewhat better version
rm -rf build
cmake -B build/
cmake --build build/
```

This is no longer necessary, as CMake provides a flag to rebuild the project from scratch:

```bash
cmake --build build/ --clean-first
```

## The install step {#install}

This step installs the contents of the build directory into a certain *install prefix*:

```bash
cmake --install build/ --prefix placetoinstall/
```


The place where you want a project to be installed *for users* is typically `/usr` on Linux and `c:/Program Files/${PROJECT_NAME}` for Windows.

For *local* builds on Linux however it is a better idea to install the project to `~/.local`, as it has the equivalent paths to `/usr`, but in userspace.

To summarize, when building a KDE project manually with CMake, use the following on Linux:

```bash
cmake --install build/ --prefix ~/.local
```

And the following on Windows:

```bash
cmake --install build/
```

### Where the files will be installed {#install-location}

KDE projects need to install multiple files:

* executables in prefix/bin (BINDIR)
* libraries in prefix/lib or prefix/lib64 (LIBDIR)
* public API header files in prefix/include (INCLUDEDIR)
* QML modules in prefix/${LIBDIR}/qml or prefix/${LIBDIR}/qt6/qml (QMLDIR)
* desktop files in prefix/share/applications (APPDIR)

On Linux with `/usr` and `~/.local`, these usually translate to:

* `/usr/bin` and `~/.local/bin`
* `/usr/lib` or `/usr/lib64` and `~/.local/lib`
* `/usr/include` and `~/.local/include`
* `/usr/${LIBDIR}/qml` or `/usr/${LIBDIR}/qt6/qml` and `~/.local/qml`
* `/usr/share/applications` and `~/.local/share/applications`

On Windows, they translate instead to:

* `c:/Program Files/${PROJECT_NAME}/bin`
* `c:/Program Files/${PROJECT_NAME}/lib`
* `c:/Program Files/${PROJECT_NAME}/include`
* `c:/Program Files/${PROJECT_NAME}/lib/qml`
* `c:/Program Files/${PROJECT_NAME}/bin/data/applications`

If you are using [Craft](https://community.kde.org/Craft)‘s terminal shell, CraftRoot, the default prefix is altered to be `c:/CraftRoot` instead of `c:/Program Files/${PROJECT_NAME}` for convenience.

All of these paths and more are standardized in KDE software that uses the [KDEInstallDirs module of extra-cmake-modules](https://api.kde.org/ecm/kde-module/KDEInstallDirs6.html). To make it easier to understand the linked documentation for KDEInstallDirs, consider:

* `EXECROOTDIR` the same as the prefix, so `/usr` or `c:/Program Files/$PROJECT_NAME`
* `DATAROOTDIR` the same as `/usr/share` on Linux or `c:/Program Files/${PROJECT_NAME}/bin/data` on Windows

## Multi-configuration builds {#multi-config}

Most of the time you will likely want to have only one build directory for simplicity, in which case CMake defaults to a “Debug” configuration with all debug symbols available for the developer.

There are however [multiple configurations](https://cmake.org/cmake/help/latest/manual/cmake-buildsystem.7.html#build-configurations) you can use to compile your project:

* Debug
* RelWithDebInfo (it stands for “release with debug information”)
* Release
* MinSizeRel (it stands for “minimum size release”)

They provide [varying levels of compiler optimizations](https://stackoverflow.com/questions/48754619/what-are-cmake-build-type-debug-release-relwithdebinfo-and-minsizerel):

* Debug takes the longest to compile but provides all debug symbols for developers to debug crashes in their software
* Release takes the least time to compile but provides no debug symbols for debugging
* RelWithDebInfo is a mid-term between Debug and Release
* MinSizeRel is simply Release optimized for size rather than speed

Depending on what you are attempting to do when building the software, you may prefer one configuration over another. For example, if you are certain you are not going to deal with crashes or you’d like to test software the way it will be delivered to users, you might want to use Release; if you want to improve build times while still keeping most debug symbols available, you might want to use RelWithDebInfo.

To choose a specific configuration, use the `--config` flag during **both** the build and install steps:

```bash
cmake -B build/
cmake --build build/ --parallel --config RelWithDebInfo
cmake --install build/ --config RelWithDebInfo
```

The main advantage of using multi-configuration builds is that you can have multiple build directories each with a different configuration. A similar thing is often done by IDEs under the hood.

```bash
cmake -B build-rel/
cmake --build build-rel/ --parallel --config Release
cmake --install build-rel/ --config Release

cmake -B build-debug/
cmake --build build-debug/ --parallel --config Debug
cmake --install build-debug/ --config Debug
```

It can be a bit impractical when doing manual compilation yourself. CMake provides a simpler way to doing multi-configuration with a single build directory, but you will need to specify a multi-configuration capable [generator]({{< ref "#generators" >}}) (on Linux there is Ninja, on Windows there is Visual Studio):

```bash
cmake -B build/ -G "Ninja Multi-Config"
cmake --build build/ --parallel --config Release
cmake --build build/ --parallel --config Debug
cmake --install build/ --config Release
cmake --install build/ --config Debug
```

## Building CMake targets {#targets}

CMake has the concept of targets, usually executables or libraries that have their own properties, source files, and dependencies.

Whenever the project’s `CMakeLists.txt` files have a call to [add_executable()](https://cmake.org/cmake/help/latest/command/add_executable.html), [add_library()](https://cmake.org/cmake/help/latest/command/add_library.html) or [add_custom_target()](https://cmake.org/cmake/help/latest/command/add_custom_target.html), a target is being created. The name of the target is always the first word of such calls: a call to `add_executable(projectbin)` creates an executable target called `projectbin`.

Well-structured desktop applications will usually have a single executable target, and multiple dependent smaller library targets that are linked to it. For example, a library target for settings, a target for models, a target for dialogs, having all these linked as dependencies to the main executable.

* project-bin
  * project-settings
  * project-models
  * project-dialogs

Using that target name, it is possible to build only a specific target (and its dependencies) using CMake. To build only the `project-settings` library, you can run the following:

```bash
cmake -B build/
cmake --build build/ --target project-settings
```

This both speeds build times dramatically and restricts the scope of warnings and errors to only the source code files used by the target. It is a good way to ensure a set of source files builds properly by itself.

Remember to build the whole project by the end to make sure the new changes don’t break anything!

There are custom targets provided both by CMake and by KDE’s extra-cmake-modules (ECM):

* CMake’s [add_test()](https://cmake.org/cmake/help/book/mastering-cmake/chapter/Testing%20With%20CMake%20and%20CTest.html) provides the `test` target
* ECM’s [ecm_add_tests()](https://api.kde.org/ecm/module/ECMAddTests.html) provides a new target for each C++ test file based on the filename without the file extension (.cpp)
* ECM’s [KDECMakeSettings](https://api.kde.org/ecm/kde-module/KDECMakeSettings.html) module provides the `uninstall` target

So to run all tests for a KDE project, you can do the following:

```bash
cmake -B build/ -D BUILD_TESTING=ON
cmake --build build/ --target test
```

To run only a specific test, you can do the following:

```bash
cmake -B build -D BUILD_TESTING=ON
# Inspecting the CMakeLists.txt in the project's tests directory,
# ecm_add_test() shows a file "settings-test.cpp"
cmake --build build/ --target settings-test
```

And if you are building a project locally on Linux and later would like to uninstall a project, you can do the following:

```bash
cmake -B build/
cmake --build build/ --parallel
cmake --install build/ --prefix ~/.local
# Later, when you no longer need the program installed
cmake --build build/ --target uninstall
```
