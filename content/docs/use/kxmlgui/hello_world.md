---
title: Hello World!
linkTitle: Hello World!
weight: 1
description: >
  Your first window using KDE Frameworks
aliases:
  - /docs/getting-started/hello_world/
---

## Abstract

Your first program shall greet the world with a friendly "Hello World!". For that, we will use a [KMessageBox](docs:kwidgetsaddons;KMessageBox) and customize one of its buttons.

![](result.png)

{{< alert title="Note" color="info" >}}
To get more information about any class you come across, you can use [KDE's API Reference site](https://api.kde.org/index.html). It can be quickly accessed via KRunner with the 'kde:' search keyword (e.g. 'kde: KMessageBox'). You may also find it useful to consult Qt's documentation with `qt:`, since much of KDE's Frameworks builds upon it.
{{< /alert >}}

## Preparation

You will need to set up your development environment (so that you can use the KDE Frameworks) first. You can do that in two ways:
- Go through the [setting up your development environment](https://community.kde.org/Get_Involved/development) part of the *Get Involved* documentation. That will give you the necessary development tools and underlying libraries, and build the KDE Frameworks from scratch.
- Install the KDE Frameworks development packages from your Operating System or Distribution. The names of these packages, and how to install them, varies per distro, so you will need to investigate on your own.

## The Code

### Hello World

All the code we need will be in one file, `main.cpp`. We'll start simple and increment our file as we go further. Create it with the code below: 


{{< readfile file="/content/docs/use/kxmlgui/hello_world/main1.cpp" highlight="cpp" >}}

First we need to create a [QApplication](https://doc.qt.io/qt-5/qapplication.html) object. It needs to be created exactly once and before any other KDE Framework or Qt object, as it's the starting point for creating your application and thus required for other components, like [Internationalization](../i18n/).

We're going to create a popup box but we're going to customise one of the buttons by creating a [KGuiItem](docs:kwidgetsaddons;KGuiItem) object. The first argument of the [KGuiItem](docs:kwidgetsaddons;KGuiItem) constructor is the text that will appear on the item (in our case, a button object to be used soon). Then we have the option to set an icon for the button, but for now we don't want one so we can just give it a `QString()`, which is just a null [QString](https://doc.qt.io/qt-5/qstring.html). We then set the tooltip (what appears when you hover over an item), and finally the "What's This?" text (accessed through right-clicking or Shift-F1).

Now that we have our item, we can create our popup. We call the [KMessageBox::questionYesNo](docs:kwidgetsaddons;KMessageBox::questionYesNo) function which, by default, creates a message box with a "Yes" and a "No" button. The first argument is the parent widget of the [KMessageBox](docs:kwidgetsaddons;KMessageBox), but since we are just using a ternary operator to ask whether our message box returns yes, we do not need to specify the parent, so we can use 0, nullptr or NULL instead. The second argument is the text that will appear inside the message box and above the buttons. The third is the caption shown in the window's titlebar, and then we set the [KGuiItem](docs:kwidgetsaddons;KGuiItem) for (what would normally be) the "Yes" button to the KGuiItem yesButton we created.

### About and Internationalization

{{< readfile file="/content/docs/use/kxmlgui/hello_world/main2.cpp" highlight="cpp" >}}

For your application to be localized, it must first be internationalized, that is, you must prepare your code for it to be localized later. For that, we start with a call to [KLocalizedString::setApplicationDomain](docs:ki18n;KLocalizedString::setApplicationDomain) is required to properly set the translation catalog and must be done before everything else (except QApplication). After that, we can just start enveloping the relevant user-visible strings with `i18n()`. The non-user visible strings that should be kept as-is (that is, read only) should use a [QStringLiteral](https://doc.qt.io/qt-5/qstring.html#QStringLiteral). We'll use those next with [KAboutData](docs:kcoreaddons;KAboutData).

More information on internalization can be found in the [i18n](https://techbase.kde.org/Localization) tutorial.

[KAboutData](docs:kcoreaddons;KAboutData) is a core KDE Frameworks component that stores information about an application, which can then be reused by many other KDE Frameworks components. We instantiate a new [KAboutData](docs:kcoreaddons;KAboutData) object with its fairly complete default constructor and add author information. After all the required information has been set, we call [KAboutData::setApplicationData](docs:kcoreaddons;KAboutData::setApplicationData) to initialize the properties of the [QApplication ](https://doc.qt.io/qt-5/qapplication.html) object.

### Command line

{{< readfile file="/content/docs/use/kxmlgui/hello_world/main3.cpp" highlight="cpp" >}}

Then we come to [QCommandLineParser ](https://doc.qt.io/qt-5/qcommandlineparser.html). This is the class one would use to specify command line flags to, for example, open the program with a specific file. However, in this tutorial, we simply initialize it with the [KAboutData](docs:kcoreaddons;KAboutData) object we created before so we can use the `--version` or `--author` flags that are provided by default by Qt.

We're all done as far as the code is concerned. Now to build it and try it out.

## Build

You want to use `cmake` for your build environment. You provide a file `CMakeLists.txt`, CMake uses this file to generate all Makefiles out of it. Learn more about why [KDE uses CMake from Alexander Neundorf](https://lwn.net/Articles/188693/).

### CMakeLists.txt

Create a file named `CMakeLists.txt` in the same directory as `main.cpp` with this content: 

{{< readfile file="/content/docs/use/kxmlgui/hello_world/CMakeLists.txt" highlight="cpp" >}}

The `find_package()` function locates the package that you ask it for (in this case ECM, Qt5, or KF5) and sets some variables describing the location of the package's headers and libraries. ECM, or Extra CMake Modules, is required to import special CMake files and functions for building KDE applications.

Here we try to find the modules for Qt 5 and KDE Frameworks 5 required to build our tutorial. The necessary files are included by CMake so that the compiler can see them at build time. Minimum version numbers are set at the very top of `CMakeLists.txt` file for easier reference.

Next we create a variable called `helloworld_SRCS` using the `set()` function. In this case we simply set it to the name of our only source file. 

Then we use `add_executable()` to create an executable called `helloworld` from the source files listed in our `helloworld_SRCS` variable. Afterwards, we link our executable to the necessary libraries using `target_link_libraries()` function. The line starting with install writes a default "install" target into the Makefile. 

Make And Run
------------

To compile, link and install your program, you must have several software installed, e.g. cmake, make and gcc-c++, and the Qt 5 and KDE Frameworks development files. To be sure you have everything, best follow [this install guide](https://community.kde.org/Get_Involved/development#One-time_setup:_your_development_environment).

While you can run **CMake** directly inside the source code directory itself, it is a best practice, and actually enforced in some KDE software, to use a separate build directory and run **CMake** from there: 

```bash
mkdir build && cd build
```

You can invoke CMake and make manually:

```bash
cmake .. && make
```

And launch it with: 

```bash
./helloworld
```
