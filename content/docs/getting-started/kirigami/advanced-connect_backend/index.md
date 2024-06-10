---
title: Connect logic to your QML user interface
weight: 303
description: Connect a backend to do calculations and supply your user interface with data to display
group: advanced
aliases:
  - /docs/getting-started/kirigami/advanced-connect_backend/
---

To integrate logic into the application, we need C++ backend classes that can do the important calculations. Writing logic in the QML files is discouraged, so try to move as much as possible to the backend, so QML is purely used for displaying the user interface, which is what it is best at.

For your new backend class, create two new files called `backend.cpp` and `backend.h`. Don't forget to add the new cpp file to the executable in `src/CMakeLists.txt`, next to main.cpp.

Add the following content to the new header file (`backend.h`):
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

The `backend.cpp` file containing the definitions is similarly empty right now, it should contain something like the following:
```C++
#include "backend.h"

Backend::Backend(QObject *parent)
    : QObject(parent)
{

}
```

Currently the user interface doesn't know about your backend class. To change that, we need to register the new type in `main.cpp`. The backend will be created as a singleton, that means it will only be created once and exist through the whole time from starting the application to closing it.

Right after creating the [QQmlApplicationEngine](docs:qtqml;QQmlApplicationEngine), add the [type registration](https://doc.qt.io/qt-6/qtqml-cppintegration-definetypes.html) to `main.cpp` as follows:
```C++
    Backend backend;
    qmlRegisterSingletonInstance<Backend>("org.kde.example", 1, 0, "Backend", &backend);
```

Don't forget to include the new header file at the top of `main.cpp`.

From now on, the backend will be known to QML as `Backend`. It is contained in a module called `org.kde.example`. Since the module is part of the application, you don't need to worry about versioning it, just stay with `1.0` and use it consistently throughout the application.

In `main.qml`, import the new module:
```QML
import org.kde.example 1.0
```

Now we have connected the class holding the future logic to the application, but it still doesn't do anything. To change that, let's add a property to the class. Properties are a lot more than a simple variable. They can inform the UI about changes so it can update the right areas.

Right under the [Q_OBJECT](docs:qtcore;QObject::Q_OBJECT) macro, add a new [Q_PROPERTY](docs:qtcore;QObject::Q_PROPERTY).

```
Q_PROPERTY(QString introductionText READ introductionText WRITE setIntroductionText NOTIFY introductionTextChanged)
```

This may seem like a lot of code to just read and write some code from the backend. However, a closer look reveals that reading the property from the UI can already run some logic—same when it is written to. In this case, it will automatically inform the frontend and backend of changes.

The reading and writing is based on the concept of [getter and setter functions](https://www.w3schools.com/cpp/cpp_encapsulation.asp). Go ahead and add a new private attribute to your class that holds the data, as well as the relevant getter and setter functions.
```C++
private:
    QString m_introductionText = "Hello World!";
```

To the public section, add
```C++
public:
    QString introductionText() const;
    void setIntroductionText(const QString &introductionText);
    Q_SIGNAL void introductionTextChanged();
```
The first function is the getter, the second the setter, and the third a signal that is emitted when the property is changed. The signal doesn't need any implementation in `backend.cpp` file, since it doesn't do much more than being emitted, but the getter and setter need to be implemented similar to the following:
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

To display the text, add a heading to `main.qml` under the `title` property of the [Kirigami.Page](docs:kirigami2;Page) element already contained in the template.

The resulting code in that part of the file should look like this:

```qml
// ...
Kirigami.Page {
    title: i18n("develop.kde.org tutorial")

    Kirigami.Heading {
        anchors.centerIn: parent
        text: Backend.introductionText
    }

    actions: [
        Kirigami.Action {
            // ...
        }
    ]
}
```

Now compile and start your program again.

Congratulations, you learned:
* How to register backend types to QML
* Add new elements to the QML file
* Create new QObject subclasses
* How to add properties and what they do
* What signals are

If you want to know more about the integration between QML and C++, we recommend reading the [official Qt documentation](https://doc.qt.io/qt-6/qtqml-cppintegration-definetypes.html).
