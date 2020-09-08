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

# The backend

To integrate logic into the application, we need C++ backend classes that can do the important calculation. Writing logic in the QML files is discouraged, so try to move as much as possible to the backend, so QML is purely used for displaying the user interface, which is what it is best at.

For your new backend class, create two new files called `backend.cpp` and `backend.h`. Don't forget to add the new cpp file to the executable in `src/CMakeLists.txt`, next to main.cpp.

to the new header file (the one with the `.h` extension), add the following content:
```C++
#pragma once

#include <QObject>

class Backend : public QObject
{
    Q_OBJECT

public:
    explicit Backend(QObject *parent = nullptr);
};
```

The cpp file containing the definitions is similarly empty right now, it should contain something like the following:
```C++
#include "backend.h"

Backend::Backend(QObject *parent)
    : QObject(parent)
{

}
```

Currently the user interface doesn't know about your backend class. To change that, we need to register the new type in main.cpp. The backend will be created as a singleton, that means it will only be created once and exist through the whole time from starting the application to closing it.

To `main.cpp`, right after creating the `QQmlApplicationEngine`, add the type registration as follows:
```
    Backend backend;
    qmlRegisterSingletonInstance<Backend>("org.kde.example", 1, 0, "Backend", &backend);
```

Don't forget to include the new header file at the top of main.cpp

From now on, the backend will be known to QML as "Backend". It is contained in a module called "org.kde.example". Since the module is part of the application, you don't need to worry about versioning it, just stay to the 1.0 and use it consistently throughout the application.

In `main.qml`, import the new module:
```QML
import org.kde.example 1.0
```

Now we have connected the class holding the future logic to the application, but it still doesn't do anything. To change that, let's add a property to the class. Properties are a lot more than a simple variable. They can inform the UI about changes so it can update the right areas.

Right under the `Q_OBJECT` macro, add a new `Q_PROPERTY`.

```
Q_PROPERTY(QString introductionText READ introductionText WRITE setIntroductionText NOTIFY introductionTextChanged)
```

That seems like quite a lot for a simple property we'll use to show some text from the backend, right?
But a closer look reveals that this can already run logic when the property is read by the user interface, and when it is written. It will automatically inform frontend and backend of changes.

The reading and writing is based on getter and setter functions, so add a new private attribute to your class, like this, and add getter and setter functions.
```C++
private:
    QString m_introductionText = "Hello World!";
```

To the public section, add
```
    QString introductionText() const;
    void setIntroductionText(const QString &introductionText);
    Q_SIGNAL void introductionTextChanged();
```
The first function is the getter, the second the setter, and the third a signal that is emitted when the property was changed. The signal doesn't need any implementation in the cpp file, since it doesn't do much more than being emitted, but the getter and setter need to be implemented similar to the following:
```C++
QString Backend::introductionText() const
{
    return m_introductionText;
}

void Backend::setIntroductionText(const QString &introductionText)
{
    m_introductionText = introductionText;
    Q_EMIT introductionTextChanged();
}
```

As you can see, when the setter is called, the signal will be emitted, and inform the ui and backend of the change.

# The user interface

To display the text, in `main.qml` add a heading displaying it right under the text property of the `Kirigami.Page` element that is already contained in the template.

The resulting code in that part of the file should look like this:
```
        ...
        Kirigami.Page {
            title: i18n("develop.kde.org tutorial")

            Kirigami.Heading {
                anchors.centerIn: parent
                text: Backend.introductionText
            }

            actions {
                main: Kirigami.Action {
                    ...
```

Now compile and start your program.

In case you are not using a graphical development environment that supports this out of the box, you can build it using:
```
cmake -B build/ . && cmake --build build/
```

The resulting binary can be found in `./build/src/<project name>`

Congratulations, you learned:
* How to register backend types to QML
* Add new elements to the QML file
* Create new QObject subclasses
* How to add properties and what they do
* What signals are

If you want to know more about the integration between QML and C++, we recommend reading the [official Qt documentation](https://doc.qt.io/qt-5/qtqml-cppintegration-definetypes.html).

To learn more about the controls you can use in your app's user interface, follow to the [next tutorial](../basic_controls).
