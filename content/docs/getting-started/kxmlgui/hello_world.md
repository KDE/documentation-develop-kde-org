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

Your first program shall greet the world with a friendly "Hello World". For that, we will use a [KMessageBox](docs:kwidgetsaddons;KMessageBox) and customize one of its buttons.

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

{{< readfile file="/content/docs/getting-started/kxmlgui/hello_world/main1.cpp" highlight="cpp" >}}

![](hello_world.webp)

Our popup box is a [KMessageBox](docs:kwidgetsaddons;KMessageBox), which has primarily two buttons:
a [PrimaryAction](docs:kwidgetsaddons;KMessageBox::PrimaryAction), which usually serves as a confirmation button, and a [SecondaryAction](docs:kwidgetsaddons;KMessageBox::SecondaryAction), which usually portrays a different action, like a cancel or discard button. The popup box uses the KMessageBox class, the primary action uses a custom [KGuiItem](docs:kwidgetsaddons;KGuiItem) with the text "Hello", and the secondary action uses [KStandardGuiItem::cancel()](docs:kwidgetsaddons;KStandardGuiItem::cancel).

First we need to create a [QApplication](docs:qtwidgets;QApplication) object. It needs to be created exactly once and before any other KDE Frameworks or Qt object, as it is the starting point for creating your application and thus required for other components, like [Ki18n](docs:ki18n) for translations.

The first argument of the [KGuiItem](docs:kwidgetsaddons;KGuiItem) constructor is the text that will appear on the item (in our case, a button object to be used soon). Then we have the option to set an icon for the button, but for now we don't want one so we can pass an empty [QString](docs:qtcore;QString) using `QString()`. We then set the tooltip (the text that appears when you hover over an item), and finally the "What's This?" text (accessed through right-clicking or Shift-F1).

Now that we have the item needed for our primary action button, we can create our popup with [KMessageBox::questionTwoActions()](docs:kwidgetsaddons;KMessageBox::questionTwoActions). The first argument is the parent widget of the [KMessageBox](docs:kwidgetsaddons;KMessageBox), which is not needed for us here, so we pass `nullptr`. The second argument is the text that will appear inside the message box and above the buttons, in our case, "Hello World". The third is the caption shown in the window's titlebar, "Hello Title". Then, we set our custom [KGuiItem](docs:kwidgetsaddons;KGuiItem), `primaryAction`. Lastly, we add a convenience object with [KStandardGuiItem::cancel()](docs:kwidgetsaddons;KStandardGuiItem::cancel), which returns a ready-made [KGuiItem](docs:kwidgetsaddons;KGuiItem) with localized text and cancel functionality, satisfying the function signature.

{{< alert title="Important" color="warning" >}}

Using a QStringLiteral for strings like `QStringLiteral("Hello World!")` instead of literals like `"Hello World!"` is both a best practice in Qt programming and an expected coding practice in KDE software.

{{< /alert >}}

### About and Internationalization

{{< readfile file="/content/docs/getting-started/kxmlgui/hello_world/main2.cpp" highlight="cpp" >}}

![](hello_world_complete.webp)

For your application to be localized, we must first prepare our code so that it can be adapted to various languages and regions without engineering changes: this process is called [internationalization](https://doc.qt.io/qt-6/internationalization.html). KDE uses [Ki18n](docs:ki18n) for that, which provides [KLocalizedString](docs:ki18n;KLocalizedString).

We start with a call to [KLocalizedString::setApplicationDomain()](docs:ki18n;KLocalizedString::setApplicationDomain), which is required to properly set the translation catalog and must be done before everything else (except the creation of the [QApplication](docs:qtwidgets;QApplication) instance). After that, we can just start enveloping the relevant user-visible, translatable strings with `i18n()`. The non-user visible strings that do not need to be translated should use a [QStringLiteral](docs:qtcore;QString::QStringLiteral) instead. We'll use those next with [KAboutData](docs:kcoreaddons;KAboutData).

More information on internalization can be found in the [programmer's guide for internationalization](https://api.kde.org/frameworks/ki18n/html/prg_guide.html).

{{< alert title="Important" color="warning" >}}

Since we are about to use many string arguments, instead of writing `QStringLiteral()` 7 times, we can use QString's [operator""_s](https://doc.qt.io/qt-6/qstring.html#operator-22-22_s), a shorter notation for [string literals](https://en.cppreference.com/w/cpp/language/string_literal) special to Qt that does the same thing. This is also where the `using namespace Qt::Literals::StringLiterals;` comes from.

So instead of `QStringLiteral("Hello World!")`, just typing `u"Hello World!"_s` is enough.

{{< /alert >}}

[KAboutData](docs:kcoreaddons;KAboutData) is a core KDE Frameworks component that stores information about an application, which can then be reused by many other KDE Frameworks components. We instantiate a new [KAboutData](docs:kcoreaddons;KAboutData) object with its fairly complete default constructor and add author information. After all the required information has been set, we call [KAboutData::setApplicationData()](docs:kcoreaddons;KAboutData::setApplicationData) to initialize the properties of the [QApplication ](docs:qtwidgets;QApplication) object.

Note how the message box adapts to its own contents, and how the window title now includes "Tutorial 1", like we set using [KAboutData](docs:kcoreaddons;KAboutData). This property can then be accessed with [KAboutData::displayName()](docs:kcoreaddons;KAboutData::displayName) when needed.

One more thing of note is that, if you are using a different system language, the [KStandardGuiItem::cancel()](docs:kwidgetsaddons;KStandardGuiItem::cancel) button we created will likely already show up in your language instead of saying "Cancel".

### Command line

{{< readfile file="/content/docs/getting-started/kxmlgui/hello_world/main3.cpp" highlight="cpp" >}}

Then we come to [QCommandLineParser](docs:qtcore;QCommandLineParser). This is the class one would use to specify command line flags to open your program with a specific file, for instance. However, in this tutorial, we simply initialize it with the [KAboutData](docs:kcoreaddons;KAboutData) object we created before so we can use the `--version` or `--author` flags that are provided by default by Qt.

We're all done as far as the code is concerned. Now to build it and try it out.

## Build

In order to run our project, we need a build system in place to compile and link the required libraries; for that, we use the industry standard CMake, together with files in our project folder called `CMakeLists.txt`. CMake uses this file to run mainly three steps: configure, build, and install. During the configure step it will generate a `Makefile` (if using `make`) or a `build.ninja` (if using `ninja`), which is then used to build.

You can learn more about why KDE uses CMake in [this article from Alexander Neundorf](https://lwn.net/Articles/188693/).

The Qt Company provides a [good tutorial for using CMake with Qt](https://doc.qt.io/qt-6/cmake-get-started.html).

The CMake website also provides a [tutorial from scratch with examples](https://cmake.org/cmake/help/latest/guide/tutorial/index.html).

And KDAB provides a [YouTube playlist explaining CMake](https://www.youtube.com/playlist?list=PL6CJYn40gN6g1_yY2YkqSym7FWUid926M).

### CMakeLists.txt

Create a file named `CMakeLists.txt` in the same directory as `main.cpp` with this content: 

{{< readfile file="/content/docs/getting-started/kxmlgui/hello_world/CMakeLists.txt" highlight="cpp" >}}

The [`find_package()`](https://cmake.org/cmake/help/latest/command/find_package.html) function locates the package that you ask it for (in this case ECM, Qt5, or KF5) and sets some variables describing the location of the package's headers and libraries. [ECM](https://api.kde.org/ecm/), or Extra CMake Modules, is required to import special CMake files and functions for building KDE applications.

Here we try to find the modules for Qt 5 and KDE Frameworks 5 required to build our tutorial. The necessary files are included by CMake so that the compiler can see them at build time. Minimum version numbers are set at the very top of `CMakeLists.txt` file for easier reference.

Next we create a variable called `helloworld_SRCS` using the [`set()`](https://cmake.org/cmake/help/latest/command/set.html) function. In this case we simply set it to the name of our only source file.

Then we use [`add_executable()`](https://cmake.org/cmake/help/latest/command/add_executable.html) to create an executable called `helloworld` from the source files listed in our `helloworld_SRCS` variable. Afterwards, we link our executable to the necessary libraries using the [`target_link_libraries()`](https://cmake.org/cmake/help/latest/command/target_link_libraries.html) function. The [`install()`](https://cmake.org/cmake/help/latest/command/install.html) function call creates a default "install" target, putting executables and libraries in the default path using a convenience macro provided by ECM. Additionally, just by including ECM, an "uninstall" target automatically gets created based on this "install" target.

Running our application
------------

To compile, link and install your program, you must have the following software installed: `cmake`, `make` or `ninja`, and `gcc-c++`/`g++`, and the Qt 6 and KDE Frameworks development packages.

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

You can also run the binary with flags. The flag `--help` is a standard flag added by Qt via [QCommandLineParser](docs:qtcore;QCommandLineParser), and the content of the `--version`, `--author` and `--license` flags should match the information we added with [KAboutData](docs:kcoreaddons;KAboutData).

```bash
./build/bin/helloworld --help
./build/bin/helloworld --version
./build/bin/helloworld --author
./build/bin/helloworld --license
```
