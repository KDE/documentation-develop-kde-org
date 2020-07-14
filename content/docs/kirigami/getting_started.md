---
title: Getting Started with Kirigami
weight: 0
---

In this tutorial, you will be able to learn how to create a convergent
application that allow to check departure and routes from public
transport, that works on mobile operating system and on your desktop.

You are going to use QML/QtQuick and Kirigami. QML is the declarative UI
language from the Qt project. Unlike the older QWidgets it is designed with
(embedded) touch systems in mind and thus is ideal for mobile apps. Kirigami
is a set of QtQuick components designed for creating convergent
mobile/desktop apps.

First of all you will need to install Kirigami on your system, this can
usually be done with your Linux distribution package manager. It is also
possible to use a statically build version of Kirigami but this tutorial
won't cover this usecase.

While the ui code is done in QML in a declarative way, the buisness code
is created in either C++ or Python. In this tutorial, we will only cover
the Python usecase with the offical Qt for Python bindings (also called
pyside2).

## Basic application

Before getting started you  need to install a few things. First of all we
need Python (obviously) and Qt for Python. Qt for Python was formerly known
as PySide2. You can install it via `pip install pyside2 --user`. Next there is
Kirigami. On Ubuntu you can install it via `sudo apt install qml-module-org-kde-kirigami2`. 

After that you can start coding. The following main.py file is creating an
app and loading the UI from a .qml file. The exact details are not too
important at this point.

```python
#!/usr/bin/env python3

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine

if __name__ == "__main__":
    app = QGuiApplication()
    engine = QQmlApplicationEngine()

    context = engine.rootContext()
    engine.load("qml/main.qml")

    if len(engine.rootObjects()) == 0:
        quit()
    app.exec_()
```

Next you need to define our UI in a QML file. To keep things organized you are
going to put your QML files in a qml/ subfolder. Your first main.qml is rather
simple.

```json
import QtQuick 2.2
import QtQuick.Controls 2.4
import org.kde.kirigami 2.0 as Kirigami

Kirigami.ApplicationWindow
{
    width: 480
    height: 720

    Label {
        text: "Hello world!"
        anchors.centerIn: parent
    }
}
```

width and height are a bit arbitrary since the window will always be maximized on the phone, but this way we get a somewhat realistic window on the desktop. Executing the python file should result in something like this.

In the [next part of this tutorial](../basic_controls) we are going to fill this window with more life using QtQuick and Kirigami components. 


