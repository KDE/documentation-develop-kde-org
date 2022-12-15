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
To get more information about any class you come across, you can use [KDE's API Reference site](https://api.kde.org/index.html). It can be quickly accessed via KRunner with the `kde:` search keyword (e.g. `kde: KMessageBox`). You may also find it useful to consult Qt's documentation with `qt:`, since much of KDE's Frameworks builds upon it.
{{< /alert >}}

## Preparation

You will need to set up your development environment (so that you can use the KDE Frameworks) first. You can do that in two ways:
- Go through the [setting up your development environment](https://community.kde.org/Get_Involved/development) part of the *Get Involved* documentation. That will give you the necessary development tools and underlying libraries, and build the KDE Frameworks from scratch.
- Install the KDE Frameworks development packages from your operating system or distribution. The names of these packages, and how to install them, varies per distro, so you will need to investigate on your own.

## The Code

### Hello World

All the code we need will be in one file, `main.cpp`. We'll start simple and increment our file as we go further. Create it with the code below: 

{{< readfile file="/content/docs/use/kxmlgui/hello_world/main1.cpp" highlight="cpp" >}}

We are going to create a popup box which displays some text and has a custom-made "Yes" button which simply displays "Hello". The popup box will use the [KMessageBox](docs:kwidgetsaddons;KMessageBox) class, and the Yes button will use [KGuiItem](docs:kwidgetsaddons;KGuiItem).
![](result.webp)

First we need to create a [QApplication](docs:qtwidgets;QApplication) object. It needs to be created exactly once and before any other KDE Frameworks or Qt object, as it is the starting point for creating your application and thus required for other components, like [Ki8n](docs:ki18n) for translations.
First we need to create a [QApplication](docs:qtwidgets;QApplication) object. It needs to be created exactly once and before any other KDE Frameworks or Qt object, as it is the starting point for creating your application and thus required for other components, like [Ki18n](docs:ki18n) for translations.

The first argument of the [KGuiItem](docs:kwidgetsaddons;KGuiItem) constructor is the text that will appear on the item (in our case, a button object to be used soon). Then we have the option to set an icon for the button, but for now we don't want one so we can just give it a `QString()`, which is just a null [QString](docs:qtcore;QString). We then set the tooltip (what appears when you hover over an item), and finally the "What's This?" text (accessed through right-clicking or Shift-F1).

Now that we have the item needed for our "Yes" button, we can create our popup. We call the [KMessageBox::questionYesNo()](docs:kwidgetsaddons;KMessageBox::questionYesNo) function which, by default, creates a message box with "Yes" and "No" buttons. The first argument is the parent widget of the [KMessageBox](docs:kwidgetsaddons;KMessageBox), but since we are just using a ternary operator to ask whether our message box returns yes, we do not need to specify the parent, so we can use `0`, `nullptr` or `NULL` instead. The second argument is the text that will appear inside the message box and above the buttons. The third is the caption shown in the window's titlebar, and then we set our custom [KGuiItem](docs:kwidgetsaddons;KGuiItem) `yesButton` to (what would normally be) the "Yes" button in our [KMessageBox](docs:kwidgetsaddons;KMessageBox).

{{< alert title="Note" color="info" >}}
If you are using KDE Frameworks equal or higher than 5.100, the example in this tutorial will compile just fine, but you should receive a warning saying that [KMessageBox::questionYesNo()](docs:kwidgetsaddons;KMessageBox::questionYesNo) has been deprecated in favor of [KMessageBox::questionTwoActions()](docs:kwidgetsaddons;KMessageBox::questionTwoActions). The new API is easy to use as well.
{{< /alert >}}


### About and Internationalization

{{< readfile file="/content/docs/use/kxmlgui/hello_world/main2.cpp" highlight="cpp" >}}

For your application to be localized, we must first prepare our code so that it can be adapted to various languages and regions without engineering changes: this process is called [internationalization](https://doc.qt.io/qt-6/internationalization.html). KDE uses [Ki8n](docs:ki18n) for that, which provides [KLocalizedString](docs:ki18n;KLocalizedString).
For your application to be localized, we must first prepare our code so that it can be adapted to various languages and regions without engineering changes: this process is called [internationalization](https://doc.qt.io/qt-6/internationalization.html). KDE uses [Ki18n](docs:ki18n) for that, which provides [KLocalizedString](docs:ki18n;KLocalizedString).

We start with a call to [KLocalizedString::setApplicationDomain()](docs:ki18n;KLocalizedString::setApplicationDomain), which is required to properly set the translation catalog and must be done before everything else (except [QApplication](docs:qtwidgets;QApplication)). After that, we can just start enveloping the relevant user-visible, translatable strings with `i18n()`. The non-user visible strings that do not need to be translated should use a [QStringLiteral](docs:qtcore;QString::QStringLiteral) instead. We'll use those next with [KAboutData](docs:kcoreaddons;KAboutData).

More information on internalization can be found in the [programmer's guide for internationalization](https://api.kde.org/frameworks/ki18n/html/prg_guide.html).

[KAboutData](docs:kcoreaddons;KAboutData) is a core KDE Frameworks component that stores information about an application, which can then be reused by many other KDE Frameworks components. We instantiate a new [KAboutData](docs:kcoreaddons;KAboutData) object with its fairly complete default constructor and add author information. After all the required information has been set, we call [KAboutData::setApplicationData()](docs:kcoreaddons;KAboutData::setApplicationData) to initialize the properties of the [QApplication ](https://doc.qt.io/qt-5/qapplication.html) object.

### Command line

{{< readfile file="/content/docs/use/kxmlgui/hello_world/main3.cpp" highlight="cpp" >}}

Then we come to [QCommandLineParser](docs:qtcore;QCommandLineParser). This is the class one would use to specify command line flags to open your program with a specific file, for instance. However, in this tutorial, we simply initialize it with the [KAboutData](docs:kcoreaddons;KAboutData) object we created before so we can use the `--version` or `--author` flags that are provided by default by Qt.

We're all done as far as the code is concerned. Now to build it and try it out.

## Build

In order to run our project, we need a build system in place to compile and link the required libraries; for that, we use the industry standard CMake, together with files in our project folder called `CMakeLists.txt`. CMake uses this file to run mainly three steps: configure, build, and install. During the configure step it will generate a `Makefile` (if using `make`) or a `build.ninja` (if using `ninja`), which is then used to build.

You can learn more about why KDE uses CMake in [this article from Alexander Neundorf](https://lwn.net/Articles/188693/).

TheQtCompany provides a [good tutorial for using CMake with Qt](https://doc.qt.io/qt-6/cmake-get-started.html).

The CMake website also provides a [tutorial from scratch with examples](https://cmake.org/cmake/help/latest/guide/tutorial/index.html).

And KDAB provides a [YouTube playlist explaining CMake](https://www.youtube.com/playlist?list=PL6CJYn40gN6g1_yY2YkqSym7FWUid926M).

### CMakeLists.txt

Create a file named `CMakeLists.txt` in the same directory as `main.cpp` with this content: 

{{< readfile file="/content/docs/use/kxmlgui/hello_world/CMakeLists.txt" highlight="cpp" >}}

The [`find_package()`](https://cmake.org/cmake/help/latest/command/find_package.html) function locates the package that you ask it for (in this case ECM, Qt5, or KF5) and sets some variables describing the location of the package's headers and libraries. ECM, or Extra CMake Modules, is required to import special CMake files and functions for building KDE applications.

Here we try to find the modules for Qt 5 and KDE Frameworks 5 required to build our tutorial. The necessary files are included by CMake so that the compiler can see them at build time. Minimum version numbers are set at the very top of `CMakeLists.txt` file for easier reference.

Next we create a variable called `helloworld_SRCS` using the [`set()`](https://cmake.org/cmake/help/latest/command/set.html) function. In this case we simply set it to the name of our only source file.

Then we use [`add_executable()`](https://cmake.org/cmake/help/latest/command/add_executable.html) to create an executable called `helloworld` from the source files listed in our `helloworld_SRCS` variable. Afterwards, we link our executable to the necessary libraries using [`target_link_libraries()`](https://cmake.org/cmake/help/latest/command/target_link_libraries.html) function. The line starting with install creates a default "install" target, putting executables and libraries in the default path using a convenience macro provided by ECM.

Running our application
------------

To compile, link and install your program, you must have the following software installed: `cmake`, `make` or `ninja`, and `gcc-c++`/`g++`, and the Qt 5 and KDE Frameworks development packages. To be sure you have everything, follow [this install guide](https://community.kde.org/Get_Involved/development#One-time_setup:_your_development_environment).

First we configure our project inside of a `build/` folder:

```bash
cmake -B build/
# Alternatively, with ninja instead of make:
cmake -B build/ -G Ninja
```

Then we compile the project inside the same `build/` folder:

```bash
cmake --build build/
```

And launch it with: 

```bash
./build/helloworld
```
