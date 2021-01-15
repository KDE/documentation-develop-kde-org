---
title: Using Actions
weight: 3
description: >
  How to add actions to the menus and toolbars.
---

Introduction
------------

This tutorial introduces the concept of actions. Actions are a unified way of supplying the user with ways to interact with your program.

For example, if we wanted to let the user of your [window](../main_window) clear the text box by clicking a button in the toolbar, from an option in the File menu or through a keyboard shortcut, it could all be done with one [QAction](https://doc.qt.io/qt-5/qaction.html). 

![](result.png)

## QAction

A [QAction ](https://doc.qt.io/qt-5/qaction.html) is an object which contains all the information about the icon and shortcuts that are associated with a certain action. The action is then connected to a [slot](https://doc.qt.io/qt-5/signalsandslots.html) which carries out the work of your action. 

## The Code

### main.cpp

This time, nothing changed in `main.cpp`.

### mainwindow.h

{{< readfile file="/content/docs/getting-started/using_actions/mainwindow.h" highlight="cpp" >}}

Only a function void `setupActions()` has been added which will do all the work setting up the QActions.

### mainwindow.cpp

{{< readfile file="/content/docs/getting-started/using_actions/mainwindow.cpp" highlight="cpp" >}}

## Explanation

This builds upon the [KXmlGuiWindow](docs:kxmlgui;KXmlGuiWindow) code from our previous [main window](main_window). Most of the changes are to mainwindow.cpp, an important structural change being that the constructor for MainWindow now calls `setupActions()` instead of `setupGUI()`. `setupActions()` is where the new QAction code goes before finally calling `setupGUI()` itself.

### Creating the QAction object

The QAction is built up in a number of steps. The first is including the QAction header and then creating the QAction: 

```c++
#include <QAction>
...
QAction *clearAction = new QAction(this);
```

This creates a new QAction called `clearAction`. 

### Setting QAction Properties

Now that we have our QAction object, we can start setting its properties. The following code sets the text that will be displayed in the menu and with the QAction's icon in the toolbar, depending on the widget style (whether beside or below the icon) or setting (whether to display the action text or not).

```c++
clearAction->setText(i18n("&Clear"));
```

Note that the text is passed through the i18n() function; this is necessary for the UI to be translatable (more information on this can be found in the [docs](docs:ki18n). 

The ampersand (&) in the action text denotes which letter will be used as an accelerator for said action. If the user opens a menu and presses the 'Alt' key, this will highlight the first letter of 'Clear', denoting the key they can press to perform said action. In this case, they would press 'Alt+C' to clear the textbox when the 'file' menu is open.

![](accelerator-highlight.png)

The ampersand is also useful for internationalisation: in non-latin languages such as Japanese (where 'copy' is コピー), using the first letter of that language to accelerate the action could be cumbersome. The ampersand lets translators know whether they should include the latin character in parentheses, allowing non-English users to use the same accelerator key even if the translated string is completely different.

### Icon

If the action is going to be displayed in a toolbar, it is nice to have an icon depicting the action. The icon may also be displayed beside the action in the menus, depending on the widget style. The following code sets the icon to the standard the document-new icon through the use of the setIcon() function:

```c++
clearAction->setIcon(QIcon::fromTheme("document-new"));
```

###  Keyboard Shortcut

Setting a keyboard shortcut to perform our action is equally simple:


```c++
actionCollection()->setDefaultShortcut(clearAction, Qt::CTRL + Qt::Key_W);
```

This associates Ctrl+W with the QAction.


### Adding to the Collection

In order for the action to be accessed by the XMLGUI framework (explained in depth later) it must be added to the application's action collection. The action collection is accessed via the `actionCollection()` function like this: 

```c++
actionCollection()->addAction("clear", clearAction);
```

Here, the `clearAction` QAction is added to the collection and given a name of `clear`. This name (clear) is used by the XMLGUI framework to refer to the action, ergo, it should not be localized, since it is used internally only. 

### Connecting the action

Now that the action is fully set up, it needs to be connected to something useful. In this case (because we want to clear the text area), we connect our action to the clear() action belonging to a KTextEdit (which, unsurprisingly, clears the KTextEdit)


```c++
connect(clearAction, &QAction::triggered), 
     textArea, &KTextEdit::clear);
```

### KStandardAction

For actions which would likely appear in almost every KDE application such as 'quit', 'save', and 'load' there are pre-created convenience QActions, accessed through [`KStandardAction`](docs:kconfigwidgets;KStandardAction). 

They are very simple to use. Once the library has been included (`#include <KStandardAction>`), simply supply it with what you want the function to do and which QActionCollection to add it to. For example: 

```c++
KStandardAction::quit(qApp, &QCoreApplication::quit, actionCollection());
```

Here we call the QApplicaton's [quit ](https://doc.qt.io/qt-5/qapplication.html#quit) method whenever [`KStandardAction::quit`](docs:kconfigwidgets;KStandardAction::quit) is triggered. We are able to access that QApplication method via the [qApp](https://doc.qt.io/qt-5/qapplication.html#qApp) macro, which returns a pointer to the specific QApplication object in question. 

In the end, this creates a QAction with the correct icon, text and shortcut and even adds it to the File menu.

### Adding the action to menus and toolbars

At the moment, the new "Clear" action has been created but it hasn't been associated with any menus or toolbars. This is done with a KDE technology called XMLGUI, which does nice things like create movable toolbars for you.

### Defining your own help menu

The Help menu has been standardized to ease the lives of both developers and users, which is why all KDE software Help menus look the same. If you want to create your own help menu, search for the explanation around `showAboutApplication()` in from the [KHelpMenu](docs:kxmlgui;KHelpMenu) class in XMLGUI.

### XMLGUI

The `setupGUI()` function in [KXmlGuiWindow](docs:kxmlgui;KXmlGuiWindow) depends on the XMLGUI system to construct the GUI, which XMLGUI does by parsing an XML file description of the interface.

The rule for naming this XML file is `appnameui.rc`, where appname is the name you set in [`KAboutData`](docs:kcorewidgetsapi;KAboutData) (in this case, TextEditor). So in our example, the file is called `texteditorui.rc`, and is placed in the same folder as our other files. Where the file will ultimately be placed is handled by CMake. 

#### appnameui.rc file

Since the description of the UI is defined with XML, the layout must follow strict rules. This tutorial will not go into great depth on this topic, but for more information, see the detailed [`XMLGUI`](docs:kxmlgui) page. 

#### texteditorui.rc

{{< readfile file="/content/docs/getting-started/using_actions/texteditorui.rc" highlight="xml" >}}

The `<Toolbar>` tag allows you to describe the toolbar, which is the bar across the top of the window normally with icons. Here it is given the unique name `mainToolBar` and its user visible name set to Main Toolbar using the `<text>` tag. The clear action is added to the toolbar using the `<Action>` tag, the name parameter in this tag being the string that was passed to the KActionCollection with `addAction()` in `mainwindow.cpp`. 

Besides having the action in the toolbar, it can also be added to the menubar. Here the action is being added to the `File` menu of the `MenuBar` the same way it was added to the toolbar. 

Change the 'version' attribute of the `<gui>` tag if you changed .rc file since the last install to force a system cache update. Be sure it is an integer, if you use a decimal value, it will not work, but will not notify that it didn't.

{{< alert title="Warning" color="warning" >}}
The version attribute must always be an integer number.
{{< /alert >}}

Some notes on the interaction between code and the .rc file: menus appear automatically and should have a `<text/>` child tag unless they refer to standard menus. Actions need to be created manually and inserted into the `actionCollection()` using the same name as in the .rc file. Actions can be hidden or disabled, whereas menus can't. 

## CMake

Finally, the `texteditorui.rc` needs to go somewhere where the system can find it (you can't just leave it in the source directory!). **This means the project needs to be installed somewhere**, unlike in the previous tutorials. 

### CMakeLists.txt

{{< readfile file="/content/docs/getting-started/using_actions/CMakeLists.txt" highlight="cmake" >}}

This file is almost identical to the one for [previous tutorial](../main_window), but with two extra lines at the end that describe where the files are to be installed. Firstly, the `texteditor` target is installed to the `KDE_INSTALL_TARGETS_DEFAULT_ARGS` then the `texteditorui.rc` file that describes the layout of the user interface is installed to the application's data directory under `KDE_INSTALL_KXMLGUI5DIR`.

## Make, Install And Run

This is probably the trickiest part. Where you install the files, especially `texteditorui.rc` is important. Normally, you'd want to install it where KDE software is installed by your distribution, which is usually under `/usr`. That, however, would require root/admin access and If you don't have that, you can install it to a folder in your home directory. 

To tell CMake where to install the program, set the `DCMAKE_INSTALL_PREFIX` switch. You probably just want to install it somewhere local for testing (it's probably a bit silly to go to the effort of installing these tutorials to your KDE directory), so the following might be appropriate: 

```bash
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/.local-kde
make install
```

which will create a `/usr`-like directory structure in your user's home directory. Specifically, it will create the directories `$HOME/.local-kde/bin/` and `$HOME/.local-kde/share/` and will install the executable to `$HOME/.local-kde/bin/texteditor` and the `texteditorui.rc` file to `$HOME/.local-kde/share/kxmlgui/texteditor/texteditorui.rc`. 

However, to be able to run the program properly, you will need to let the system know where the XMLGUI file is. Since we installed it in a nonstandard location, we'll have to explicitly to do so every time. The following command would suffice: 


```bash
source prefix.sh # located in the build directory
texteditor
```

This temporarily adds (prepends) the newly created "share" location to [`XDG_DATA_DIRS`](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html), the standard path for application data files, and changes the `PATH` and other Qt environment variables.
