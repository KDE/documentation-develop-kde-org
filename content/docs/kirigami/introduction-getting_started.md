---
title: Setting up and getting started
weight: 1
group: introduction
description: >
  Getting ready to create our first Kirigami application
---

## Installing required packages

Before getting started, we must install a few things. We need a C++ compiler, Qt development packages, and Kirigami. 

On Ubuntu, Debian and Neon we can install these with APT:

```bash
sudo apt install build-essential extra-cmake-modules cmake qtbase5-dev qtdeclarative5-dev libqt5svg5-dev qtquickcontrols2-5-dev qml-module-org-kde-kirigami2 kirigami2-dev libkf5i18n-dev gettext
```

On Arch-based distributions (like Manjaro) we can use Pacman:

```bash
sudo pacman -Syu base-devel extra-cmake-modules cmake kirigami2 kde-sdk-meta gettext
```

For Fedora, we use DNF:

```bash
sudo dnf groupinstall "Development Tools" "Development Libraries"
sudo dnf install extra-cmake-modules cmake qt5-qtbase-devel qt5-qtdeclarative-devel qt5-qtquickcontrols2-devel kf5-kirigami2 kf5-kirigami2-devel gettext
```

Further information for other distributions can be found [here](https://community.kde.org/Guidelines_and_HOWTOs/Build_from_source/Install_the_dependencies).

## Getting ready
While there are tools that can easily set up our files, we are going to create them manually. This will let us better understand the pieces that are going to make up our new application.

First we create our project folder. We are going to call ours 'helloworld'.

```
helloworld
├── CMakeLists.txt
└── src
    ├── CMakeLists.txt
    ├── contents
    │   └── ui
    │       └── main.qml
    ├── main.cpp
    └── resources.qrc
```
Within this folder we are going to create a `src` folder and `CMakeLists.txt`. It is generally considered good practice to place all our main code files in a `src` folder. Our `src` folder in turn will contain a folder named `contents`, which itself contains a folder called `ui`. Here is where we will create our QML files. 

This is KDE convention, but not all KDE projects use this structure. You are free to set things up differently, but you will have to take this into account when creating your `CMakeLists.txt` and `resources.qrc` files.

### CMakeLists.txt

`CMakeLists.txt` files are needed to use KDE's build system of choice, [CMake](https://cmake.org/). The CMakeLists.txt file in our top-level folder is going to specify some of our application's characteristics. It also includes some of the dependencies we need to compile it.

{{< readfile file="/content/docs/kirigami/getting_started/CMakeLists.txt" highlight="cmake" >}}

The CMakeLists.txt defines how to build your projects. Most of the content here is just to bootstrap your project. You can read a line-by-line, in-depth explanation of what this CMakeLists file does [here](https://develop.kde.org/docs/kirigami/understanding-cmakelists/). 

The most important thing to keep in mind is that the Qt and KDE Frameworks dependencies are managed with `find_package`. You will have to modify these lines and include any additional components that you decide to use during the development of your application.

The final line, `add_subdirectory(src)`, points CMake into the 'src' directory, where our source code is located. Let's delve into the CMakeLists.txt file in there.

{{< readfile file="/content/docs/kirigami/getting_started/src/CMakeLists.txt" highlight="cmake" >}}

This one's a lot shorter! Let's go through what it does:

- `set` is used to set `helloworld_SRCS` to `main.cpp` and `resources.qrc` (if we decide to create additional C++ files we'll need to add them here too)
- `add_executable` takes care of naming our executable and grabbing the files needed to create it
- `target_link_libraries` links the libraries used in our code to our executable. 

{{< alert title="Note" color="info" >}}
Note that these libraries should match the components that we included in our previous CMakeLists.txt file - otherwise these components will not be included and our application won't compile.
{{< /alert >}}

Now that CMake has been taken care of, let's look at the files we are going to spend the majority of our time working with.

### resources.qrc
`resources.qrc` contains the list of all QML files as well as other files (like custom icons) that will be included in the binary.

{{< readfile file="/content/docs/kirigami/getting_started/src/resources.qrc" highlight="xml" >}}

Notice the line `<file alias="main.qml">contents/ui/main.qml</file>`. It details which QML files are going to be included in the compilation process. In our case we are only using `main.qml`, but if we were to add more QML files to our code, we'd need to make sure we include it in `resources.qrc` file by adding another line like this one.

You can read more about the specifics of how the Qt resource system works [in Qt's docs](https://doc.qt.io/qt-5/resources.html).

### main.cpp

`main.cpp` handles the 'business logic' of our application. C++ is handy because it is flexible and fast, even if it is more involved than other programming languages.

`main.cpp` is also the entrypoint to our application. The two parts of our project, the backend and the user interface, are both set up and started here. 

{{< readfile file="/content/docs/kirigami/getting_started/src/main.cpp" highlight="cpp" >}}

For now, we don't need to go into too much detail regarding what our `main.cpp` code does, but its role will grow significantly more important once we decide to add more complex functionality to our application in the future. If you want to get ahead, you can read more about how this `main.cpp` works [in this page](/content/docs/kirigami/maincpp/).

### main.qml

{{< readfile file="/content/docs/kirigami/getting_started/src/contents/ui/main.qml" highlight="qml" >}}

We finally reach our QML file, where we will be handling our application's frontend.

If you know some Javascript, then much of QML will seem familiar to you (though it does have its own peculiarities). [Qt's documentation](https://doc.qt.io/qt-5/qtqml-index.html) has an extensive amount of material on this language if you feel like trying something on your own. Over the course of these tutorials we will be focusing much of our attention on our QML code, where we can use Kirigami to get the most out of it. 

For now, let's focus on `main.qml`. First we import a number of important modules:
- QtQuick, the standard library used in QML applications.
- QtQuick Controls, which provides a number of standard controls we can use to make our applications interactive.
- QtQuick Layouts, which provides tools for placing components within the applications window.
- Kirigami, which provides a number of components suited for creating applications that work across devices of different shapes and sizes.

We then come to our base element, [`Kirigami.ApplicationWindow`](docs:kirigami2;ApplicationWindow)
which provides some basic features needed for all Kirigami applications. This is the window that will contain each of our pages, the main sections of our UI.

We then set the `id` property of `Kirigami.ApplicationWindow` to 'root'. IDs are useful because they let us uniquely reference a component, even if we have several of the same type. 

We also set the window `title` property to 'Hello World'. You'll notice that we have wrapped our "Hello World" string in a function called `i18nc`, where we detail the context of the string as well as the string itself.

{{< alert title="Note" color="info" >}}
[`i18n()`](https://techbase.kde.org/Development/Tutorials/Localization/i18n#Translatable_Code_Using_i18n.28.29) functions make your app more easily translatable, as they return a version of the provided string in the user's language (as long as your app has been localised for that language). While an English user might see our window title as 'Hello World', a Spanish user would see 'Hola Mundo'. 

[`i18nc()`](https://techbase.kde.org/Development/Tutorials/Localization/i18n#Adding_Context_with_i18nc.28.29) builds on the `i18n()` function by allowing developers to provide some context to translators working on the app; that's why we have included the string "@title" before "Hello World".
{{< /alert >}}

We then set the first page of our page stack. Most Kirigami applications are organised as a stack of pages, each page containing related components suited to a specific task. For now, we are keeping it simple, and sticking to a single page. With `pageStack.initialPage: Kirigami.Page{...}` we set the first page presented upon loading the application to a `Kirigami.Page`, which will contain all our content.

Finally, we include in our page a `Controls.Label` that lets us place text on our page. We use `anchors.centerIn: parent` to center our label horizontally and vertically within our parent element. In this case, `Controls.Label`'s parent component is `Kirigami.Page`. The last thing we need to do is set the text: `text: i18n("Hello World!")`.

## Compiling and running the application

We are almost at the finish line. The last thing we need to do is build and compile our application. To do that, we need to enter our 'helloworld' folder in our terminal application of choice and run the following command:

```
cmake -B build/ . && cmake --build build/
```

Voila! The resulting binary can be found in `helloworld/build/src/<project name>`. Run it, and you will see your very first Kirigami app appear before your very own eyes.

![Screenshot of the generated Kirigami application](hello-kworld.png)

{{< alert title="Note" color="info" >}}
Next time you want to create the files and folders needed, you can use [KAppTemplate](https://apps.kde.org/kapptemplate) or KDevelop to automatically generate a suitable project to start from. They are available from each major distribution's repositories. These applications will also generate files containing [AppStream](https://www.freedesktop.org/software/appstream/docs/sect-Metadata-Application.html) metadata and a `.desktop` file that contains information about how the application should be displayed in a linux application launcher.

Thanks to the magic of CMakeLists, you can also use IDEs such as KDevelop or QtCreator to develop this application within a comfortable environment with minimal effort.
{{< /alert >}}


