---
title: Understanding CMakeLists
weight: 301
group: advanced
description: > 
  Getting to grips with how CMakeLists.txt files work
aliases:
  - /docs/getting-started/kirigami/advanced-understanding_cmakelists/
---

## CMake
In our introductory tutorial, we used [CMake](https://cmake.org/) as the build system for our application, but we only really paid close attention to one of our `CMakeLists.txt` files. Here, we're going to go over how it works in a bit more detail.

CMake is useful because it allows us to automate much of the stuff that needs to be done before compilation.

## CMakeLists.txt

You might remember this `CMakeLists.txt` file from the first tutorial:

{{< readfile file="/content/docs/getting-started/kirigami/introduction-getting_started/CMakeLists.txt" highlight="cmake" >}}

The first line, `cmake_minimum_required(VERSION 3.16)` sets the version of CMake we will be calling.

After that, `project(helloworld)` defines the name of the project.

Then we get to a section where we include a number of necessary CMake and KDE settings by using [extra-cmake-modules](https://api.kde.org/ecm/). You shouldn't worry too much about these lines for now and we won't need to change them in this tutorial.

The following section is important, because it specifies which dependencies we'll be bringing in at compile time. Let's look at the first:

{{< readfile file="/content/docs/getting-started/kirigami/introduction-getting_started/CMakeLists.txt" highlight="cmake" start=11 lines=8 >}}

- [find_package()](https://cmake.org/cmake/help/latest/command/find_package.html) finds and loads the external component.
- The first word is the framework, Qt. `${QT_MAJOR_VERSION}` is a convenience variable provided by extra-cmake-modules that lets us choose the Qt version to be used, 5 or 6, depending on whether we use the CMake flag `-DBUILD_WITH_QT6=ON`.
- `REQUIRED` tells CMake that these dependencies are indeed required and that it shall exit with an error if the package can not be found.
- `NO_MODULE` switches CMake into the Config mode. We don't need to worry about that at the moment.
- `COMPONENTS` is a parameter that precedes the specific components of the framework we will include.
- Each word after `COMPONENTS` refers to a specific component.

{{< alert title="Note" color="info" >}}

If you are looking to add any components listed in the [KDE API documentation](https://api.kde.org/) to your application, you may check the right sidebar for how to add the component with CMake. For instance, for [Kirigami2](docs:kirigami2;), you will find something like `find_package(KF5Kirigami2)`, which with the addition of [extra-cmake-modules](https://api.kde.org/ecm/) becomes something like `find_package(KF5 COMPONENTS Kirigami2)`.

Pay close attention to your included components, as omitting ones used in our code will stop our application from compiling.

{{< /alert >}}

The final line lets CMake print out which packages it has found.
And above that, `add_subdirectory(src)` points CMake into the `src/` directory, where it finds another `CMakeLists.txt` file:

{{< readfile file="/content/docs/getting-started/kirigami/introduction-getting_started/src/CMakeLists.txt" highlight="cmake" >}}

Since most of the heavy lifting is done by the first file, this one is a lot shorter.

- [add_executable()](https://cmake.org/cmake/help/latest/command/add_executable.html) takes care of generating our executable.
- [target_sources()](https://cmake.org/cmake/help/latest/command/target_sources.html) lets us add files that will be used by our new executable.
- [target_link_libraries()](https://cmake.org/cmake/help/latest/command/target_link_libraries.html) dynamically links the libraries used in our code to our executable. Kirigami is not included here because we are using only its QML module.
- [install()](https://cmake.org/cmake/help/latest/command/install.html) puts our executable in its right place by using `${KDE_INSTALL_TARGETS_DEFAULT_ARGS}`, a convenience variable provided by [KDEInstallDirs](https://api.kde.org/ecm/manual/ecm-kde-modules.7.html) in extra-cmake-modules that installs executables and libraries in their right place for you without needing to specify the absolute path, similarly to [GNUInstallDirs](https://cmake.org/cmake/help/latest/module/GNUInstallDirs.html).

{{< alert title="Note" color="info" >}}

Note that these libraries should match the components that we included in our previous `CMakeLists.txt` file - otherwise these components will not be included and our application won't compile.

{{< /alert >}}

This setup will be useful when developing most Kirigami apps.
