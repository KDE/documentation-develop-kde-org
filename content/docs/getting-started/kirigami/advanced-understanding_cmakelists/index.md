---
title: Understanding CMakeLists
weight: 61
group: advanced
description: > 
  Getting to grips with how CMakeLists.txt files work
aliases:
  - /docs/getting-started/kirigami/advanced-understanding_cmakelists/
---

## CMake
In our introductory tutorial, we used [CMake](https://cmake.org/) as the build system for our application, but we only really paid close attention to one of our `CMakeLists.txt` files. Here, we're going to go over how it works in a bit more detail.

CMake is useful because it allows us to automate much of the stuff that needs to be done before compilation.

## The root CMakeLists.txt

You might remember this `CMakeLists.txt` file from the first tutorial:

{{< readfile file="/content/docs/getting-started/kirigami/setup-cpp/CMakeLists.txt" highlight="cmake" >}}

The first line, `cmake_minimum_required()` sets the version of CMake we will be calling.

After that, `project(kirigami-tutorial)` defines the name of the project.

Then we get to a section where we include a number of necessary CMake and KDE settings by using [extra-cmake-modules](https://api.kde.org/ecm/). They provide a set of useful utilities:

- [KDEInstallDirs](https://api.kde.org/ecm/kde-module/KDEInstallDirs6.html) provides convenience variables such as `${KDE_INSTALL_TARGETS_DEFAULT_ARGS}`, `${KDE_INSTALL_QMLDIR}`, `${KDE_INSTALL_BINDIR}` and `${KDE_INSTALL_LIBDIR}`.
- [KDECMakeSettings](https://api.kde.org/ecm/kde-module/KDECMakeSettings.html) provides things like `CMAKE_AUTORCC ON`, an `uninstall` target that can be used with `cmake --build build/ --target uninstall`, and `ENABLE_CLAZY`.
- [KDECompilerSettings](https://api.kde.org/ecm/kde-module/KDECMakeSettings.html) provides a minimum C++ standard, compiler flags such as `-pedantic`, and best practices macros like `-DQT_NO_CAST_FROM_ASCII` to require explicit conversions such as `QStringLiteral()`.
- [ECMFindQmlModule](https://api.kde.org/ecm/module/ECMFindQmlModule.html) provides a way to ensure a runtime QML dependency is found at compile time.
- [ECMQmlModule](https://api.kde.org/ecm/module/ECMQmlModule.html) provides CMake commands like `ecm_add_qml_module()` and `ecm_target_qml_sources()`.

The following section is important, because it specifies which dependencies we'll be bringing in at compile time. Let's look at the first:

{{< readfile file="/content/docs/getting-started/kirigami/setup-cpp/CMakeLists.txt" highlight="cmake" start=13 lines=14 >}}

- [find_package()](https://cmake.org/cmake/help/latest/command/find_package.html) finds and loads the external library and its components.
- `REQUIRED` tells CMake to exit with an error if the package cannot be found.
- `COMPONENTS` is a parameter that precedes the specific components of the framework we will include.
- Each word after `COMPONENTS` refers to a specific component of the library.

{{< alert title="Note" color="info" >}}

If you are looking to add any components listed in the [KDE API documentation](https://api.kde.org/) to your application, you may check the right sidebar for how to add the component with CMake. For instance, for [Kirigami](docs:kirigami;kirigami-index.html), you will find something like `find_package(KF6Kirigami)`, which with the addition of ECM becomes:

```cmake
find_package(KF6 COMPONENTS Kirigami)
```

Pay close attention to your included components, as omitting ones used in our code will stop our application from compiling.

{{< /alert >}}

The install line instructs CMake to install the desktop file in `${KDE_INSTALL_APPDIR}`, which on Linux translates to `$XDG_DATA_DIRS/applications`, usually `/usr/share/applications`, and on Windows translates to `C:/Program Files/${PROJECT_NAME}/bin/data/applications`:

{{< readfile file="/content/docs/getting-started/kirigami/setup-cpp/CMakeLists.txt" highlight="cmake" start=34 lines=1 >}}

The final line lets CMake print out which packages it has found, and it makes compilation fail immediately if it encounters an error:

{{< readfile file="/content/docs/getting-started/kirigami/setup-cpp/CMakeLists.txt" highlight="cmake" start=36 lines=1 >}}

And above that, `add_subdirectory(src)` points CMake into the `src/` directory, where it finds another `CMakeLists.txt` file.

## src/CMakeLists.txt

{{< readfile file="/content/docs/getting-started/kirigami/setup-cpp/src/CMakeLists.txt" highlight="cmake" >}}

While the first file handled metadata and finding libraries, this one will consist of handling dependencies and installing the application. It has the following CMake calls:

- [add_executable()](https://cmake.org/cmake/help/latest/command/add_executable.html) creates the executable target we will use to run our project.
- `ecm_add_qml_module()` creates a QML module target that will be accessible via the "org.kde.tutorial" import.
- [target_sources()](https://cmake.org/cmake/help/latest/command/target_sources.html) adds C++ source files to the executable target.
- `ecm_target_qml_sources()` adds QML files to the module.
- [target_link_libraries()](https://cmake.org/cmake/help/latest/command/target_link_libraries.html) links the C++ libraries used in our code to our executable. Kirigami is not included here because we are using only its QML module.
- [install()](https://cmake.org/cmake/help/latest/command/install.html) installs the executable to the system.

The documentation for the two ECM commands can be found in the [extra-cmake-modules API for ECMQmlModule](https://api.kde.org/ecm/module/ECMQmlModule.html).

The call to `ecm_add_qml_module()` was used here to modify the traditional C++ source code executable target and turn it into something that can accept QML files and C++ source code that is accessible from QML in what is called [using the executable as backing target for a QML module](https://doc.qt.io/qt-6/qt-add-qml-module.html#executable-as-a-qml-module). This means the QML files are run directly as part of the application, which is often the case for applications.

You may also create a separate QML module that does not use the executable as backing target using `ecm_add_qml_module()`. In this case, you'd create a library target using [add_library()](https://cmake.org/cmake/help/latest/command/add_library.html), link it to an existing executable target using `target_link_libraries()`, and in addition to installing the library with `install()` you will need to finalize the QML module with [ecm_finalize_qml_module()](https://api.kde.org/ecm/module/ECMQmlModule.html) so it can generate two files: `qmldir` and `qmltypes`. These files are used by QtQuick applications to find separate QML modules.

The method for creating a separate QML module is better exemplified in [Using separate files](/content/docs/getting-started/kirigami/introduction-separatefiles).

These are additions provided by extra-cmake-modules to make the use of [Qt declarative registration](https://doc.qt.io/qt-6.7/cmake-build-qml-application.html) (the [replacement to Qt resource files](https://doc.qt.io/qt-6/resources.html)) easier.

{{< alert title="Note" color="info" >}}

These libraries should match the components that we included in our previous `CMakeLists.txt` file, otherwise these components will not be included and our application won't compile.

{{< /alert >}}

The documentation for all three commands can be found in the [extra-cmake-modules API for ECMQmlModule](https://api.kde.org/ecm/module/ECMQmlModule.html).

## src/components/CMakeLists.txt

In the tutorial about [how to split your code into separate files](/docs/getting-started/kirigami/introduction-separatefiles#preparing-cmake-for-the-new-files), a new CMake file was introduced to allow for separate QML modules:

{{< readfile file="/content/docs/getting-started/kirigami/introduction-separatefiles/components/CMakeLists.txt" highlight="cmake" >}}

The requirement for this file to be read by CMake is adding a call to `add_subdirectory()` in the `src/CMakeLists.txt` pointing to it.

We create a new target called `kirigami-hello-components` and then turn it into a QML module using [ecm_add_qml_module()](https://api.kde.org/ecm/module/ECMQmlModule.html) under the import name `org.kde.tutorial.components` and add the relevant QML files.

The call to [add_library()](https://cmake.org/cmake/help/latest/command/add_library.html) generates a new target called `kirigami-hello-components`. This target will have its own set of source code files, QML files, link its own libraries and so on, but it needs to be linked to the executable, but once it is compiled it needs to be linked to the executable created in the `src/CMakeLists.txt`. This is done by adding the target name to the list of libraries that will be linked to the executable in `target_link_libraries()`.

The call to `ecm_add_qml_module()` changes the library to allow it to accept QML files as before, but this time we need to use [GENERATE_PLUGIN_SOURCE](https://api.kde.org/ecm/module/ECMQmlModule.html). When the executable is used as a backing target (like with `kirigami-hello`) it doesn't need to generate plugin code since it's built into the executable; with separate QML modules like `kirigami-hello-components` the plugin code is necessary.

Upstream Qt's [qt_add_qml_module()](https://doc.qt.io/qt-6/qt-add-qml-module.html#targets-and-plugin-targets) by default generates a plugin together with the QML module, but KDE's `ecm_add_qml_module()` by default does not for backwards compatibility.

Another thing that is necessary for separate QML modules is to finalize the target. This mainly means CMake generates two files, [qmldir and qmltypes](https://doc.qt.io/qt-6/qtqml-modules-qmldir.html), which describe the QML modules we have and exports their symbols for use in the library. They are important when installing your application so that the executable being run is able to find where the QML files for each module are, so they are automatically added to the target.

You can then just install the target as before.

Next time you need to add more QML files, remember to include them in this file. C++ files that use the [QML_ELEMENT](https://doc.qt.io/qt-6/qtqml-cppintegration-definetypes.html) keyword which we will see much later in the tutorial can also be added here using `target_sources()`. You can logically separate your code by creating more QML modules with different imports as needed.

This setup will be useful when developing most Kirigami apps.
