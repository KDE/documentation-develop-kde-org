---
title: Getting Started with Kirigami
weight: 1
description: Hello world in Kirigami
---

In this tutorial, you will be able to learn how to create a convergent
application that adapts to smartphones, tablets, desktop PCs and even larger screens

You are going to use QML/QtQuick and Kirigami. QML is the declarative UI
language from the Qt project. Unlike the older QWidgets it is designed with
(embedded) touch systems in mind and thus is ideal for mobile apps. Kirigami
is a set of QtQuick components designed for creating convergent
mobile/desktop apps.

First of all you will need to install Kirigami on your system, this can
usually be done with your Linux distribution package manager.

While the ui code is done in QML in a declarative way, the buisness logic
is created in C++.

## Basic application

Before getting started you  need to install a few things. First of all we need
a C++ compiler, the Qt development package and Kirigami. On Ubuntu, Debian and Neon you can install it via `sudo apt install build-essential extra-cmake-modules cmake qtbase5-dev qtdeclarative5-dev libqt5svg5-dev qtquickcontrols2-5-dev qml-module-org-kde-kirigami2 kirigami2-dev libkf5i18n-dev`.

<!-- Todo cover kdesrc-build somewhere and link to it -->

We will also use KAppTemplate to generate a suitable project to start from. On Debian-based distributions, it can be installed using `sudo apt install kapptemplate`.

After starting KAppTemplate, skip through to the page that lets you choose a template for your new project. From the Qt category, choose "Graphical" and then "Kirigami Application". If you can't find the Kirigami template, your installed Kirigami version might be too old.

After choosing the template, follow through the wizard to create your project.
Once the wizard finished, you can finally start coding. Open the generated folder in an editor or Integrated Development Enviroment of your choice, like QtCreator or Kdevelop.

In your project, navigate to the file called main.cpp. It is the entrypoint to your application.
The two parts of your project, the backend and the user interface are both set up and started here.
Currently there is only a basic user interface, in the file called main.qml that is being load into the QML engine to the end of the `main` function.

<!-- Add more explanations of the template -->

## Compiling and running the application

In case you are not using a graphical development environment that supports this out of the box, you can build it using:
```
cmake -B build/ . && cmake --build build/
```

The resulting binary can be found in `./build/src/<project name>`

To learn more about the controls you can use in your new QML application, follow to the [next tutorial](../basic_controls).
