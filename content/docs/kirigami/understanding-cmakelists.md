---
title: Understanding CMakeLists
weight: 201
group: advanced
description: > 
  Getting to grips with how CMakeLists.txt files work
---

## CMake
In our introductory tutorial, we used CMake as the build system for our application, but we only really paid close attention to one of our CMakeLists. Here, we're going to go over how CMakeLists work in a bit more detail.

CMake is useful because it allows us to automate much of the stuff that needs to be done before compilation. 

## CMakeLists.txt

You might remember this CMakeLists file from the first tutorial:

{{< readfile file="/content/docs/kirigami/getting_started/CMakeLists.txt" highlight="cmake" >}}

The first line, `project(helloworld)` defines the name of the project.

After that, we are setting the versions of our needed tools. `cmake_minimum_required(VERSION 3.10)` sets the version of CMake we will be calling. We then use `set` to define variables (`KF5_MIN_VERSION` and `QT_MIN_VERSION`) containing the versions of the KDE Frameworks and Qt.

Then we get to a section where we include a number of necessary CMake and KDE settings. You shouldn't worry too much about these lines for now and we won't need to change them in this tutorial.

The following section is important, because it specifies which dependencies we'll be bringing in at compile time. Let's look at the first line: 

`find_package(KF5 ${KF5_MIN_VERSION} COMPONENTS Kirigami2 I18n CoreAddons WidgetsAddons)`
- `find_package` finds and loads the external component.
- The first word is the framework (`KF5`).
- Then we are calling the variable with the versions we set in the second line.
- `COMPONENTS` is a parameter that precedes the specific components of the framework we will include.
- Each word after `COMPONENTS` refers to a specific component.

{{< alert title="Note" color="info" >}}
Pay close attention to your included components, as omitting ones used in our code will stop our application from compiling.
{{< /alert >}}

The final line, `add_subdirectory(src)`, points CMake into the 'src' directory.

{{< readfile file="/content/docs/kirigami/getting_started/src/CMakeLists.txt" highlight="cmake" >}}

Since most of the heavy lifting is done by the first file, this one is a lot shorter.

- `set` is used to set `helloworld_SRCS` to `main.cpp` and `resources.qrc` (if we decide to create additional C++ files we'll need to add them here too)
- `add_executable` takes care of naming our executable and grabbing the files needed to create it
- `target_link_libraries` dynamically links the libraries used in our code to our executable. 

{{< alert title="Note" color="info" >}}
Note that these libraries should match the components that we included in our previous CMakeLists.txt file - otherwise these components will not be included and our application won't compile.
{{< /alert >}}

This setup will be useful when developing most Kirigami apps.
