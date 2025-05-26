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

We are going to discuss some basic code, and in the final section we will build it. You will need to set up your development environment (so that you can use the KDE Frameworks) first. You can do that in two ways.

Create a folder `~/kde/src/kxmlgui-tutorial`. In that folder you will place the source code files from this tutorial.

### Using kde-builder {#kde-builder}

[Set up your development environment with kde-builder]({{< ref "kde-builder-setup" >}}). That will give you the necessary development tools and underlying libraries, and build the KDE Frameworks from scratch.

Add the folowing at the end of your `~/.config/kde-builder.yaml`:

```yaml
project kxmlgui-tutorial:
  no-src: true
```

{{< alert color="info" title="⏳ With kdesrc-build..." >}}

<details>
<summary>Click here to know how this was done with kdesrc-build</summary></br>

This step used to be done by writing to `~/.config/kdesrc-buildrc` instead with a different syntax:

```
# after include ${module-definitions-dir}/kf6-qt6.ksb
module kxmlgui-tutorial
  no-src
end module
```

</details>

{{< /alert >}}

### Manually

{{< installpackage
    fedora="kf6-kcoreaddons-devel kf6-ki18n-devel kf6-kxmlgui-devel kf6-ktextwidgets-devel kf6-kconfigwidgets-devel kf6-kwidgetsaddons-devel kf6-kio-devel kf6-kiconthemes-devel"
    opensuse="kf6-kcoreaddons-devel kf6-ki18n-devel kf6-kxmlgui-devel kf6-ktextwidgets-devel kf6-kconfigwidgets-devel kf6-kwidgetsaddons-devel kf6-kio-devel kf6-kiconthemes-devel"
    arch="kcoreaddons ki18n kxmlgui ktextwidgets kconfigwidgets kwidgetsaddons kio kiconthemes"
>}}

## The Code

### Hello World

All the code we need will be in one file, `main.cpp`. We'll start simple and increment our file as we go further. Create it with the code below:

{{< readfile file="/content/docs/getting-started/kxmlgui/hello_world/main1.cpp" highlight="cpp" >}}

![](hello_world.webp)

Our popup box is a [KMessageBox](docs:kwidgetsaddons;KMessageBox), which has primarily two buttons:
a [PrimaryAction](docs:kwidgetsaddons;KMessageBox::PrimaryAction), which usually serves as a confirmation button, and a [SecondaryAction](docs:kwidgetsaddons;KMessageBox::SecondaryAction), which usually portrays a different action, like a cancel or discard button. The popup box uses the KMessageBox class, the primary action uses a custom [KGuiItem](docs:kwidgetsaddons;KGuiItem) with the text "Hello", and the secondary action uses [KStandardGuiItem::cancel()](docs:kwidgetsaddons;KStandardGuiItem::cancel).

First we need to create a [QApplication](docs:qtwidgets;QApplication) object. It needs to be created exactly once and before any other KDE Frameworks or Qt object, as it is the starting point for creating your application and thus required for other components, like [Ki18n](docs:ki18n;ki18n-index.html) for translations.

The first argument of the [KGuiItem](docs:kwidgetsaddons;KGuiItem) constructor is the text that will appear on the item (in our case, a button object to be used soon). Then we have the option to set an icon for the button, but for now we don't want one so we can pass an empty [QString](docs:qtcore;QString) using `QString()`. We then set the tooltip (the text that appears when you hover over an item), and finally the "What's This?" text (accessed through right-clicking or Shift-F1).

Now that we have the item needed for our primary action button, we can create our popup with [KMessageBox::questionTwoActions()](docs:kwidgetsaddons;KMessageBox::questionTwoActions). The first argument is the parent widget of the [KMessageBox](docs:kwidgetsaddons;KMessageBox), which is not needed for us here, so we pass `nullptr`. The second argument is the text that will appear inside the message box and above the buttons, in our case, "Hello World". The third is the caption shown in the window's titlebar, "Hello Title". Then, we set our custom [KGuiItem](docs:kwidgetsaddons;KGuiItem), `primaryAction`. Lastly, we add a convenience object with [KStandardGuiItem::cancel()](docs:kwidgetsaddons;KStandardGuiItem::cancel), which returns a ready-made [KGuiItem](docs:kwidgetsaddons;KGuiItem) with localized text and cancel functionality, satisfying the function signature.

{{< alert title="Important" color="warning" >}}

Using a QStringLiteral for strings like `QStringLiteral("Hello World!")` instead of literals like `"Hello World!"` is both a best practice in Qt programming and an expected coding practice in KDE software.

{{< /alert >}}

### About and Internationalization

{{< readfile file="/content/docs/getting-started/kxmlgui/hello_world/main2.cpp" highlight="cpp" emphasize="3-4 8 11-47 50-52 56-57" >}}

![](hello_world_complete.webp)

For your application to be localized, we must first prepare our code so that it can be adapted to various languages and regions without engineering changes: this process is called [internationalization](https://doc.qt.io/qt-6/internationalization.html). KDE uses [Ki18n](docs:ki18n;ki18n-index.html) for that, which provides [KLocalizedString](docs:ki18n;KLocalizedString).

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

{{< readfile file="/content/docs/getting-started/kxmlgui/hello_world/main3.cpp" highlight="cpp" emphasize="2 34-37" >}}

Then we come to [QCommandLineParser](docs:qtcore;QCommandLineParser). This is the class one would use to specify command line flags to open your program with a specific file, for instance. However, in this tutorial, we simply initialize it with the [KAboutData](docs:kcoreaddons;KAboutData) object we created before so we can use the `--version` or `--author` flags that are provided by default by Qt.

We're all done as far as the code is concerned. Now to build it and try it out.

## Compiling and running the project {#kxmlgui-running}

In order to run our project, we need a build system in place to compile and link the required libraries; for that, we use the industry standard CMake, together with files in our project folder called `CMakeLists.txt`.

### Writing a CMakeLists.txt

Create a file named `CMakeLists.txt` in the same directory as `main.cpp` with this content: 

{{< readfile file="/content/docs/getting-started/kxmlgui/hello_world/CMakeLists.txt" highlight="cmake" >}}

The [`find_package()`](https://cmake.org/cmake/help/latest/command/find_package.html) function locates the package that you ask it for (in this case ECM, Qt6, or KF6) and sets some variables describing the location of the package's headers and libraries. [ECM](https://api.kde.org/ecm/), or Extra CMake Modules, is required to import special CMake files and functions for building KDE applications.

Here we try to find the modules for Qt 6 and KDE Frameworks 6 required to build our tutorial. The necessary files are included by CMake so that the compiler can see them at build time. Minimum version numbers are set at the very top of `CMakeLists.txt` file for easier reference.

Then we use [`add_executable()`](https://cmake.org/cmake/help/latest/command/add_executable.html) to create an executable called `helloworld`. Afterwards, we link our executable to the necessary libraries using the [`target_link_libraries()`](https://cmake.org/cmake/help/latest/command/target_link_libraries.html) function. The [`install()`](https://cmake.org/cmake/help/latest/command/install.html) function call creates a default "install" target, putting executables and libraries in the default path using a convenience macro `KDE_INSTALL_TARGETS_DEFAULT_ARGS` provided by ECM. Additionally, just by including ECM, an "uninstall" target automatically gets created based on this "install" target.

### Compiling and running with kde-builder

Compile the necessary build dependencies with kde-builder, then compile `kxmlgui-tutorial` by running the following commands in a terminal:

```bash
kde-builder kcoreaddons ki18n kxmlgui ktextwidgets kconfigwidgets kwidgetsaddons kio kiconthemes
kde-builder kxmlgui-tutorial
```

You can then run the application with:

```bash
kde-builder --run helloworld
```

{{< alert color="info" title="⏳ With kdesrc-build..." >}}

<details>
<summary>Click here to know how this was done with kdesrc-build</summary></br>

In this case, the build process will result in an executable that does not match the project name: for example, the project `kxmlgui-tutorial` does not match the executable `helloworld`. Because kdesrc-build had no way to associate the name of the project with the executable name, you needed to use the `--exec` or `-e` flag:

```bash
kdesrc-build --run --exec helloworld kxmlgui-tutorial
```

</details>

{{< /alert >}}

### Compiling and running manually

Change directories to the project's root folder, then run the following command in a terminal:

```bash
cmake -B build/ --install-prefix ~/.local
cmake --build build/ --parallel
cmake --install build/
```

Each line above matches a step of the compilation process: the configuration, build, and install steps.

The `--parallel` flag lets CMake compile multiple files at the same time, and the `--install-prefix` flag tells CMake where it will be installed. In this case, the executable `helloworld` will be installed to `~/.local/bin/helloworld`.

You can then run the application with:

```bash
helloworld
```

You can also run the binary with flags. The flag `--help` is a standard flag added by Qt via [QCommandLineParser](docs:qtcore;QCommandLineParser), and the content of the `--version`, `--author` and `--license` flags should match the information we added with [KAboutData](docs:kcoreaddons;KAboutData).

```bash
kde-builder --run helloworld --help
kde-builder --run helloworld --version
kde-builder --run helloworld --author
kde-builder --run helloworld --license
```

or

```bash
helloworld --help
helloworld --version
helloworld --author
helloworld --license
```
