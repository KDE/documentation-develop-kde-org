---
title: Figuring out main.cpp
weight: 302
group: advanced
description: >
  Understanding the central file of our backend code
aliases:
  - /docs/getting-started/kirigami/advanced-maincpp/
---

## The role of main.cpp

While QML is used for the front-end of Kirigami applications, the backend is usually written in C++ thanks to this language's speed and flexibility. While in previous pages we have covered QML in a lot of depth, we'll need to gain an understanding of our backend C++ code in order to make applications that are more useful than what we can achieve with pure QML.

Here, we'll be going over the `main.cpp` file we created in the [Getting Started](/docs/getting-started/kirigami/introduction-getting_started) page so that we can better understand what is going on in the central C++ file of our application. While this is a basic `main.cpp`, the features we will go over will remain essential no matter what kind of application you decide to create.

## What it does

{{< readfile file="/content/docs/getting-started/kirigami/introduction-getting_started/src/main.cpp" highlight="cpp" >}}

First we must include a number of Qt [header files](https://www.learncpp.com/cpp-tutorial/header-files/), allowing us to use their functions. In this case, we include a number of Qt headers that handle application logic, and to allow us to read QML files.

We then create a [QApplication](docs:qtwidgets;QApplication) instance which we call `app`. Passing [argc and argv](https://www.learncpp.com/cpp-tutorial/command-line-arguments/) to the constructor is required for the call.

We also set some metadata relating to the application. These include the organisation that created the application, the organisation's website, and the name of the application. We set these properties by calling [QApplication](docs:qtwidgets;QApplication), instantiating an object that comes from [QCoreApplication](docs:qtcore;QCoreApplication) and provides the [event loop](docs:qtcore;QCoreApplication::exec) for applications regardless of whether they have a GUI or not (so if we ran our program without the GUI, this metadata would still be set).

To make our app look good with KDE's [Breeze icons](https://invent.kde.org/frameworks/breeze-icons) and [Breeze style](https://invent.kde.org/plasma/breeze) on non-Plasma environments such as Windows or GNOME, we need to do three things:

* initialize the theming facilities of [KIconThemes](https://invent.kde.org/frameworks/kiconthemes) on platforms where icon themes aren't part of the system (like Windows or MacOS) with `KIconTheme::initTheme()`
* set the QStyle with [QApplication::setStyle()](docs:qtwidgets;QApplication::setStyle) to force Breeze instead of the native platform style
* set the QtQuick Controls style with [QQuickStyle::setStyle()](docs:qtquickcontrols;QQuickStyle::setStyle) to force Breeze with KDE's [qqc2-desktop-style](https://invent.kde.org/frameworks/qqc2-desktop-style)

The call to `KIconTheme::initTheme()` needs to be done before creating the QApplication and lets the app find Breeze icons to use. Setting the QStyle to Breeze is needed because we used QApplication for our app instead of [QGuiApplication](docs:qtgui;QGuiApplication). Actual interface controls in the window like buttons and checkboxes will follow Breeze by using `qqc2-desktop-style`.

The [QQmlApplicationEngine](docs:qtqml;QQmlApplicationEngine) lets us load an application from a QML file, which we do in the next line. In `engine.loadFromModule("org.kde.tutorial", "Main");` we load our QML from the URI import defined in CMake.

Next, we check if our engine correctly loaded the QML file by checking that the engine's [rootObjects()](docs:qtqml;QQmlApplicationEngine::rootObjects) list is not empty. We can then run our application with [app.exec()](docs:qtcore;QCoreApplication::exec).
