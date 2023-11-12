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

After that, `project(helloworld)` defines the name of the project. We then use `set()` to define variables (`KF5_MIN_VERSION` and `QT_MIN_VERSION`) containing the versions of KDE Frameworks and Qt.

Then we get to a section where we include a number of necessary CMake and KDE settings by using [extra-cmake-modules](https://api.kde.org/ecm/). You shouldn't worry too much about these lines for now and we won't need to change them in this tutorial.

The following section is important, because it specifies which dependencies we'll be bringing in at compile time. Let's look at the first line: 

`find_package(Qt5 ${QT_MIN_VERSION} REQUIRED NO_MODULE COMPONENTS Core Quick Test Gui QuickControls2 Widgets)`
- [find_package()](https://cmake.org/cmake/help/latest/command/find_package.html) finds and loads the external component.
- The first word is the framework (`Qt5`).
- Then we are calling the variable with the version we set in the fifth line.
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

- [add_executable()](https://cmake.org/cmake/help/latest/command/add_executable.html) takes care of naming our executable and grabbing the files needed to create it
- [target_link_libraries](https://cmake.org/cmake/help/latest/command/target_link_libraries.html) dynamically links the libraries used in our code to our executable.

{{< alert title="Note" color="info" >}}

Note that these libraries should match the components that we included in our previous `CMakeLists.txt` file - otherwise these components will not be included and our application won't compile.

{{< /alert >}}

This setup will be useful when developing most Kirigami apps.
