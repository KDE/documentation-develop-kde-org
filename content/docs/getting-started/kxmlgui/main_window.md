---
title: Creating the main window
weight: 2
description: >
  This tutorial shows you the magic of an application's most important thing: the main window.
aliases:
  - /docs/getting-started/main_window/
---

## Summary

This tutorial carries on from our [Hello World project]({{< ref "hello_world.md" >}}) and will introduce the [KXmlGuiWindow](docs:kxmlgui;KXmlGuiWindow) class.

In the previous tutorial, the program caused a dialog box to pop up. Now we are going to take steps towards creating a functioning application with a more advanced window structure.

![](main_window.webp)

## KXmlGuiWindow

[KXmlGuiWindow](docs:kxmlgui;KXmlGuiWindow) provides a full main window view with menubars, toolbars, a statusbar and a main area in the centre for a large widget. For example, the help menu is predefined. Most KDE applications will derive from this class as it provides an easy way to define menu and toolbar layouts through XML files (this technology is called [KXmlGui](docs:kxmlgui)). While we will not be using it in this tutorial, we will use it in the next.

In order to have a useful [KXmlGuiWindow](docs:kxmlgui;KXmlGuiWindow), we must subclass it. So we create two files, `mainwindow.cpp` and `mainwindow.h`, which will contain our code.

### mainwindow.h


{{< readfile file="/content/docs/getting-started/kxmlgui/main_window/mainwindow.h" highlight="cpp" >}}

First we [subclass](https://en.wikipedia.org/wiki/Inheritance_%28object-oriented_programming%29#Subclasses_and_superclasses) [KXmlGuiWindow](docs:kxmlgui;KXmlGuiWindow) with `class MainWindow : public KXmlGuiWindow`, then we declare the [constructor](https://en.wikipedia.org/wiki/Constructor_(object-oriented_programming)) with `MainWindow(QWidget *parent = nullptr);`.

Finally, we declare a pointer to the object that will make up the bulk of our program, turning it into a text editor. [`KTextEdit`](docs:ktextwidgets;KTextEdit) is a generic rich text editing widget with some niceties like cursor auto-hiding and spell checking.

### mainwindow.cpp

{{< readfile file="/content/docs/getting-started/kxmlgui/main_window/mainwindow.cpp" highlight="cpp" >}}

First, of course, we have to include the header file containing the class declaration. 

Inside the constructor of our subclassed [KXmlGuiWindow](docs:kxmlgui;KXmlGuiWindow), we initialize our [KTextEdit](docs:ktextwidgets;KTextEdit) `textArea`. Because `textArea` derives from [QWidget](docs:qtwidgets;QWidget) and our [KXmlGuiWindow](docs:kxmlgui;KXmlGuiWindow) `MainWindow` derives from [QMainWindow](docs:qtwidgets;QMainWindow), we can call [QMainWindow::setCentralWidget()](docs:qtwidgets;QMainWindow::setCentralWidget) to make our `textArea` occupy the empty area in the central section of our window.

Finally, [KXmlGuiWindow::setupGUI()](docs:kxmlgui;KXmlGuiWindow::setupGUI) is called which does a lot of behind-the-scenes stuff and creates the default menus (Settings, Help).

### Back to main.cpp

In order to actually run this window, we need to add a few lines in main.cpp:


{{< readfile file="/content/docs/getting-started/kxmlgui/main_window/main.cpp" highlight="cpp" emphasize="5 39-42" >}}

We include our new header file `mainwindow.h`. This lets us create our new `MainWindow` object which we then display near the end of the main function (by default, new window objects are hidden).

## CMake

The best way to build the program is to use CMake. We add `mainwindow.cpp` to the sources list, include the `XmlGui` and `TextWidgets` frameworks, and replace all `helloworld` text with `mainwindow`.

### CMakeLists.txt

{{< readfile file="/content/docs/getting-started/kxmlgui/main_window/CMakeLists.txt" highlight="cmake" emphasize="3 24-25 28 30 33 35 39-40 43" >}}

## Running our application

For mature projects, the best way to compile, link and run KDE software is to [set up a correct build environment]({{< ref "building" >}}). But for a simple tutorial like this, it's enough to just create a build directory and build from there. Like before:

```bash
cmake -B build/
cmake --build build/
./build/bin/mainwindow
```
