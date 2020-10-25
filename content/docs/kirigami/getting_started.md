---
title: Getting Started with Kirigami
weight: 1
group: introduction
description: >
  Create your first application in Kirigami: "Hello World!"
---

## Basic application

Before getting started you need to install a few things. First of all we need
a C++ compiler, the Qt development packages and Kirigami. On Ubuntu, Debian and
Neon you can install these with your package manager:

```bash
sudo apt install build-essential extra-cmake-modules cmake qtbase5-dev \
                 qtdeclarative5-dev libqt5svg5-dev qtquickcontrols2-5-dev \
                 qml-module-org-kde-kirigami2 kirigami2-dev libkf5i18n-dev
```

<!-- Todo cover kdesrc-build somewhere and link to it -->

We will also use [KAppTemplate](https://kde.org/applications/kapptemplate) to generate a suitable project to start from.
On Debian-based distributions, it can be installed using `sudo apt install kapptemplate`.

After starting KAppTemplate, skip through to the page that lets you choose
a template for your new project. From the Qt category, choose *Graphical*
and then *Kirigami Application*. If you can't find the Kirigami template,
your installed Kirigami version might be too old.

After choosing the template, follow through the wizard to create your project.
Once the wizard finishes, you should get the following folder hierarchy:

```
├── CMakeLists.txt
├── org.kde.myapp.appdata.xml
├── org.kde.myapp.desktop
└── src
    ├── CMakeLists.txt
    ├── contents
    │   └── ui
    │       └── main.qml
    ├── main.cpp
    └── resources.qrc
```

`org.kde.myapp.appdata.xml` contains the [AppStream](https://www.freedesktop.org/software/appstream/docs/sect-Metadata-Application.html)
metadata. These are the data that are displayed on Linux software stores
and should be filled with care before releasing an application.

`org.kde.myapp.desktop` is the so called `.desktop` file that
contains information about how the application should be displayed
in a linux application launcher.

The two `CMakeLists.txt` files contains all the information about how the
application will be compiled and installed.

`resources.qrc` contains the list of all the qml files and other files
that will be included in the binary. It is important to update it each
time a new qml file is added in the application.

`main.cpp` is the entrypoint to your application. The two parts of your
project, the backend and the user interface are both set up and started
here. Currently there is only a basic user interface, in the file called
`main.qml` that is being loaded into the QML engine at the end of the
`main` function.

Open the generated folder in an editor or Integrated Development Enviroment
of your choice, like QtCreator or [KDevelop](https://kdevelop.org).


## Anatomy of `main.qml`

{{< readfile file="/content/docs/kirigami/getting_started/main.qml" highlight="json" >}}

The base element is a [Kirigami.ApplicationWindow](docs:kirigami2;ApplicationWindow)
and it provides some basic features
needed for all Kirigami applications.

The [Kirigami.GlobalDrawer](docs:kirigami2;GlobalDrawer)
is the left sidebar of the application
and will contain your application's navigation. The right sidebar is
provided by the [Kirigami.ContextDrawer](docs:kirigami2;ContextDrawer)
and it contains all your context specific actions on mobile.

The last and most important part of `main.qml` is the [Kirigami.Page](docs:kirigami2;Page)
and contains your content. This is also that we will see in the next part
of this tutorial.

## Compiling and running the application

In case you are not using a graphical development environment that supports this out of the box, you can build it using:
```
cmake -B build/ . && cmake --build build/
```

The resulting binary can be found in `./build/src/<project name>` or 
`./build/bin/<project name>` if you are using a recent version of the
template.

![Screenshot of the generated Kirigami application](template.png)
