---
title: Using actions
weight: 3
description: >
  How to add actions to the menus and toolbars.
aliases:
  - /docs/getting-started/using_actions/
---

Introduction
------------

This tutorial introduces the concept of actions. Actions are a unified way of supplying the user with ways to interact with your program.

For example, if we wanted to let the user of our [main window tutorial]({{< ref "main_window.md" >}}) clear the text box by clicking a button in the toolbar, from an option in the File menu or through a keyboard shortcut, it could all be done with one [QAction](docs:qtwidgets;QAction).

![](using_actions.webp)

## QActions

A [QAction](docs:qtwidgets;QAction) is an object which contains all the information about the icon and shortcuts that are associated with a certain action. With the use of [signals and slots](https://doc.qt.io/qt-5/signalsandslots.html), whenever that action is triggered (like clicking a menu option), a function in a different part of your program is automatically run.

[QActions](docs:qtwidgets;QAction) are most commonly used in [QMenus](docs:qtwidgets;QMenu) shown in a [QMenuBar](docs:qtwidgets;QMenuBar), a [QToolBar](docs:qtwidgets;QToolBar), or in a right click context menu.

## The Code

### main.cpp

We are going to install our UI .rc file under the component `texteditor`, so `main.cpp` should be changed to reflect that change in name.

Don't worry about the .rc file just yet. We will see what it's about by the end of this tutorial.

```c++
    // ...
    KLocalizedString::setApplicationDomain("texteditor");
    
    KAboutData aboutData(// The program name used internally. (componentName)
                         u"texteditor"_s,
    // ...
```

### mainwindow.h

{{< readfile file="/content/docs/getting-started/kxmlgui/using_actions/mainwindow.h" highlight="cpp" >}}

Only a function `void setupActions()` has been added which will do all the work setting up the [QActions](docs:qtwidgets;QAction).

### mainwindow.cpp

{{< readfile file="/content/docs/getting-started/kxmlgui/using_actions/mainwindow.cpp" highlight="cpp" >}}

## Explanation

This builds upon the [KXmlGuiWindow](docs:kxmlgui;KXmlGuiWindow) code from our previous [main window]({{< ref "main_window.md" >}}). Most of the changes are to `mainwindow.cpp`, an important structural change being that the constructor for MainWindow now calls `setupActions()` instead of `setupGUI()`. `setupActions()` is where the new [QAction](docs:qtwidgets;QAction) code goes before finally calling `setupGUI()` itself.

### Creating the QAction object

The QAction is built up in a number of steps. The first is including the [QAction](docs:qtwidgets;QAction) header and then creating one:

```c++
#include <QAction>
...
QAction *clearAction = new QAction(this);
```

This creates a new [QAction](docs:qtwidgets;QAction) called `clearAction`.

### Setting QAction Properties

Now that we have our [QAction](docs:qtwidgets;QAction) object, we can start setting its properties. With [QAction::setText()](docs:qtwidgets;QAction::setText), we can set the text that will be displayed in the menu and with an optional [QAction::icon()](docs:qtwidgets;QAction::icon) in the toolbar, depending on the widget style (whether beside or below the icon) or setting (whether to display the action text or not).

```c++
clearAction->setText(i18n("&Clear"));
```

Note that the text is passed through the `i18n()` function; this is necessary for the UI to be translatable, as mentioned in [Hello World]({{< relref "hello_world/#about-and-internationalization" >}}) (more information on this can be found in the [internationalisation docs](docs:ki18n)).

The ampersand (&) in the action text denotes which letter will be used as an accelerator for said action. If the user opens a menu and presses the 'Alt' key, this will highlight the first letter of 'Clear' with an underscore, denoting the key they can press to perform said action. In this case, the user would press 'Alt+C' to clear the textbox when the `File` menu is open.

![](using_actions_highlighting.webp)

The ampersand is also useful for internationalisation: in non-Latin languages such as Japanese (where 'copy' is コピー), using the first letter of that language to accelerate the action could be cumbersome. The ampersand lets translators know whether they should include the Latin character in parentheses, allowing non-English users to use the same accelerator key even if the translated string is completely different.

### Icon

If the action is going to be displayed in a toolbar, it is nice to have an icon depicting the action. The icon may also be displayed beside the action in the menus, depending on the widget style. We use a [QIcon::fromTheme()](docs:qtgui;QIcon::fromTheme) to grab the system's default icon for "document-new-symbolic" and use [QAction::setIcon()](docs:qtwidgets;QAction::setIcon) to assign it to our `clearAction`.

```c++
clearAction->setIcon(QIcon::fromTheme(u"document-new-symbolic"_s));
```

### Adding to the Collection

In order for the action to be accessed via [KXmlGui](docs:kxmlgui) (explained in depth later) it must be added to the application's action collection.

Because our [KXmlGuiWindow](docs:kxmlgui;KXmlGuiWindow) uses the [KXmlGuiClient](docs:kxmlgui;KXMLGUIClient) interface, we can use the utility virtual function [KXmlGuiClient::actionCollection()](docs:kxmlgui;KXMLGUIClient::actionCollection) to retrieve the list of actions in our application, returning a [KActionCollection](docs:kxmlgui;KActionCollection).

Because of the `actionCollection()`'s return type, we can use convenience functions made available via [KActionCollection](docs:kxmlgui;KActionCollection), like [KActionCollection::addAction()](docs:kxmlgui;KActionCollection::addAction).

The action collection is accessed via the `actionCollection()` function like this:

```c++
actionCollection()->addAction("clear", clearAction);
```

Here, our `clearAction` [QAction](docs:qtwidgets;QAction) is added to the collection and given a name of `clear`. This name (clear) is used by the [KXmlGui](docs:kxmlgui) framework to refer to the action, so it is used internally and will not be localized.

###  Keyboard Shortcuts

We can then use one of the utility functions of our action collection, [KActionCollection::setDefaultShortcut()](docs:kxmlgui;KActionCollection::setDefaultShortcut), to attribute a default keyboard shortcut of `Ctrl+W`:


```c++
actionCollection()->setDefaultShortcut(clearAction, Qt::CTRL + Qt::Key_W);
```

The list of available keys can be found in the [Qt namespace Key enum](docs:qtcore;Qt::Key).

### Connecting the action

Now that the action is fully set up, it needs to be connected to something useful. In this case (because we want to clear the text area), we connect our action to the [KTextEdit::clear()](docs:ktextwidgets;KTextEdit::clear) slot belonging to a [KTextEdit](docs:ktextwidgets;KTextEdit) (which, unsurprisingly, clears the text):

```c++
connect(clearAction, &QAction::triggered, 
     textArea, &KTextEdit::clear);
```

Here we are using a [QObject::connect()](docs:qtcore;QObject::connect), Qt's most useful magic. The first parameter is the object we created and which sends the signal, our `clearAction`; the second is a reference to the signal itself, namely `triggered()`; the third is the object whose slot will receive the signal, our `textArea`; and the last one is a reference to the slot to receive the signal, namely `clear()`. In other words, this can be read as "connect this object's signal to that object's slot", or "when this signal fires, run that slot".

Refer to Qt's documentation on [Signals and Slots](https://doc.qt.io/qt-6/signalsandslots.html) to understand this better. Signals and slots are essential to make Qt apps, understanding them is highly recommended.

### KStandardAction

For actions which would likely appear in almost every KDE application such as 'quit', 'save', and 'load' there are pre-created convenience [QActions](docs:qtwidgets;QAction), accessed through [`KStandardAction`](docs:kconfigwidgets;KStandardAction).

They are very simple to use. Once the library has been included (`#include <KStandardAction>`), simply supply it with what you want the function to do and which QActionCollection to add it to. For example: 

```c++
KStandardAction::quit(qApp, &QCoreApplication::quit, actionCollection());
```

Here we call the [QApplication::quit()](docs:qtwidgets;QApplication::quit) method whenever [KStandardAction::quit()](docs:kconfigwidgets;KStandardAction::quit) is triggered. We are able to access that method via the [QApplication::qApp](docs:qtwidgets;QApplication::qApp) macro, which returns a pointer to the specific [QApplication](docs:qtwidgets;QApplication) object used in our application, the one in `main()`.

In the end, this creates an action with the correct icon, text and shortcut and even adds it to the File menu.

### Adding the action to menus and toolbars

At the moment, the new "Clear" action has been created but it hasn't been associated with any menus or toolbars. We will be using [KXmlGui's](docs:kxmlgui) capabilities for that, as it does nice things like create movable toolbars for you.

### Defining your own help menu

The Help menu has been standardized to ease the lives of both developers and users, which is why all KDE software Help menus look the same. If you want to create your own help menu, you should refer to the explanation provided in the `Using your own "about application" dialog box` section of [KHelpMenu](docs:kxmlgui;KHelpMenu).

### XMLGUI

The `setupGUI()` function in [KXmlGuiWindow](docs:kxmlgui;KXmlGuiWindow) depends on the [KXmlGui](docs:kxmlgui) system to construct the GUI, which is done by parsing an XML file description of the interface.

The rule for naming this XML file is `appnameui.rc`, where appname is the name you set in [`KAboutData`](docs:kcoreaddons;KAboutData) (in this case, `TextEditor`). So in our example, the file is called `texteditorui.rc`, and is placed in the same folder as our other files. Where the file will ultimately be placed is handled by CMake.

#### appnameui.rc file

Since the description of the UI is defined with XML, the layout must follow strict rules. This tutorial will not go into great depth on this topic.

<!-- TODO: needs a reference material for XML to be linked here. -->

#### texteditorui.rc

{{< readfile file="/content/docs/getting-started/kxmlgui/using_actions/texteditorui.rc" highlight="xml" >}}

The `<Toolbar>` tag allows you to describe the toolbar, which is the bar across the top of the window normally with icons. Here it is given the unique name `mainToolBar` and its user visible name set to "Main Toolbar" using the `<text>` tag. The `clear` action is added to the toolbar using the `<Action>` tag, the name parameter in this tag being the string that was passed to the action collection with [KActionCollection::addAction()](docs:kxmlgui;KActionCollection::addAction) in `mainwindow.cpp`.

Besides having the action in the toolbar, it can also be added to the menubar. Here the action is being added to the `File` menu of the `MenuBar` the same way it was added to the toolbar. 

Change the 'version' attribute of the `<gui>` tag if you changed the .rc file since the last install to force a system cache update. Be sure it is an integer, if you use a decimal value, it will not work, and you will get no warning about it.

{{< alert title="Warning" color="warning" >}}
The version attribute must always be an integer number.
{{< /alert >}}

Some notes on the interaction between code and the .rc file: menus appear automatically and should have a `<text/>` child tag unless they refer to standard menus. Actions need to be created manually and inserted into the `actionCollection()` using the same name as in the .rc file. Actions can be hidden or disabled, whereas menus can't. 

## CMake

Finally, the `texteditorui.rc` needs to go somewhere where the system can find it (you can't just leave it in the source directory!). **This means the project needs to be installed somewhere**, unlike in the previous tutorials. 

### CMakeLists.txt

{{< readfile file="/content/docs/getting-started/kxmlgui/using_actions/CMakeLists.txt" highlight="cmake" >}}

This file is almost identical to the one for the [previous tutorial]({{< relref "main_window/#cmakeliststxt" >}}), but with two extra lines at the end that describe where the files are to be installed. Firstly, the `texteditor` target is installed to the right place for binaries using `${KDE_INSTALL_TARGETS_DEFAULT_ARGS}`, then the `texteditorui.rc` file that describes the layout of the user interface is installed to the application's data directory, `${KDE_INSTALL_KXMLGUIDIR}`.

## Running our application

This is probably the trickiest part. The place where you install the files is important, especially `texteditorui.rc`. Normally, you'd want to install it where KDE software is installed by your distribution, which is usually under `/usr`. That works for distributions, but for our purposes we can install it to a folder in our home directory.

To tell CMake where to install the program, set the `-DCMAKE_INSTALL_PREFIX` switch. You probably just want to install it somewhere local for testing (it's probably a bit silly to go to the effort of installing these tutorials to your system), so the following might be appropriate:

```bash
cmake -B build -DCMAKE_INSTALL_PREFIX=$HOME/kde/usr
cmake --build build/
cmake --install build/
```

which will create a `/usr`-like directory structure in your user's home directory. Specifically, it will create the directories `$HOME/kde/usr/bin/` and `$HOME/kde/usr/share/`, then install the executable to `$HOME/kde/usr/bin/texteditor` and the `texteditorui.rc` file to `$HOME/kde/usr/share/kxmlgui/texteditor/texteditorui.rc`.

However, to be able to run the program properly, you will need to let the system know where our XML file is. Because [KDEInstallDirs](https://api.kde.org/ecm/kde-module/KDEInstallDirs5.html) was included in the project, we should have an autogenerated `prefix.sh` file in the build directory. This file is particularly useful here because it uses the value of `CMAKE_INSTALL_PREFIX` to export the path of the `texteditor` executable to `$PATH` and export the path of `texteditorui.rc` to `$XDG_DATA_DIRS`. So we can simply run:

```bash
source build/prefix.sh # located in the build directory
texteditor
```
