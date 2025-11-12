---
title: Connect logic to your QML user interface
weight: 71
description: Connect a backend to do calculations and supply your user interface with data to display
group: data
aliases:
  - /docs/getting-started/kirigami/advanced-connect_backend/
---

To integrate logic into the application, we need C++ backend classes that can do the important calculations. Writing logic in the QML files is discouraged, so try to move as much as possible to the backend such that QML is used only for displaying the user interface.

We will use the [Using separate files in a C++ project](/docs/getting-started/kirigami/introduction-separatefiles) tutorial code as our base.

## Changes to existing code

### src/components/backend.h

First, create the header file that will have code exposed to QML, namely the `Backend` type:

```cpp
#pragma once

#include <QObject>
#include <QtQml/qqmlregistration.h>

class Backend : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit Backend(QObject *parent = nullptr);
};
```

There are two things needed to expose C++ code to QML, and one of them is simply using the [QML_ELEMENT](https://doc.qt.io/qt-6/qqmlintegration-h.html#QML_ELEMENT) macro, available in the `<QtQml/qqmlregistration.h>` header.

The backend will be created as a singleton, which means it will only be created once and exist for the whole duration of the application lifetime. For this, we use the [QML_SINGLETON](https://doc.qt.io/qt-6/qqmlintegration-h.html#QML_SINGLETON) macro.

### src/components/backend.cpp

We can add our initial code for the constructor to `backend.cpp`:

```cpp
#include "backend.h"

Backend::Backend(QObject *parent)
    : QObject(parent)
{

}
```

### src/components/CMakeLists.txt

The second part to exposing code to QML is in CMake, adding the source files to an existing QML module:

```cmake
add_library(kirigami-hello-components)

ecm_add_qml_module(kirigami-hello-components
    URI "org.kde.tutorial.components"
    GENERATE_PLUGIN_SOURCE
)

ecm_target_qml_sources(kirigami-hello-components
    SOURCES
    AddDialog.qml
    KountdownDelegate.qml
)

target_sources(kirigami-hello-components
    PRIVATE
    backend.cpp backend.h # Needs emphasize
)

ecm_finalize_qml_module(kirigami-hello-components)

install(TARGETS kirigami-hello-components ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
```

Note that the QML module should have been created with either [ecm_add_qml_module()](https://api.kde.org/ecm/module/ECMQmlModule.html) or [qt_add_qml_module()](https://doc.qt.io/qt-6/qt-add-qml-module.html), as they are required for [declarative registration](https://doc.qt.io/qt-6/qtqml-cppintegration-definetypes.html).

### src/Main.qml

From now on, the backend will be known to QML as the `Backend` QML type. It is contained in a module called `org.kde.tutorial.components`.

This means that just by having the import in our `Main.qml`, it is already possible to use the code exposed from C++:

```QML
import org.kde.tutorial.components
```

Let's also create a menu option that [pushes a new page](/docs/getting-started/kirigami/components-pagerow_pagestack/) to the application, just so we can test the model more easily:

```qml
globalDrawer: Kirigami.GlobalDrawer {
    isMenu: true
    actions: [
        Kirigami.Action {
            text: i18n("Exposing to QML Tutorial")
            icon.name: "kde"
            onTriggered: pageStack.push(exposingToQml)
        },
        Kirigami.Action {
            text: i18n("Quit")
            icon.name: "application-exit-symbolic"
            shortcut: StandardKey.Quit
            onTriggered: Qt.quit()
        }
    ]
}

Component {
    id: exposingToQml
    Kirigami.Page {
        title: "Exposing to QML Tutorial"
        // Code here...
    }
}
```

You should be able to compile and install the project with [the same steps as before](/docs/getting-started/kirigami/setup-cpp/#running-the-application).

## Making it functional

### src/components/backend.h

Now we have connected the class holding the future logic to the application, but it still doesn't do anything. To change that, let's add a property to the class. Properties are a lot more than a simple variable. They can inform the UI about changes so it can update the right areas.

Right under the `QML_SINGLETON` macro, add a new [Q_PROPERTY](docs:qtcore;QObject::Q_PROPERTY).

```cpp
Q_PROPERTY(QString introductionText READ introductionText WRITE setIntroductionText NOTIFY introductionTextChanged)
```

This may seem like a lot of code to just read and write some code from the backend. However, a closer look reveals that reading the property from the UI can already run some logic—same when it is written to. In this case, it will automatically inform the frontend and backend of changes.

The reading and writing is based on the concept of [getter and setter functions](https://www.w3schools.com/cpp/cpp_encapsulation.asp). Go ahead and add a new private attribute to your class that holds the data, as well as the relevant getter and setter functions.

Add a new private section with the following:

```C++
private:
    QString m_introductionText = "Hello World!";
```

And add the following to the existing public section:

```C++
public:
    QString introductionText() const;
    void setIntroductionText(const QString &introductionText);
    Q_SIGNAL void introductionTextChanged();
```

The first function is the getter, the second the setter, and the third a signal that is emitted when the property is changed.

### src/components/backend.cpp

The signal doesn't need any implementation in the `backend.cpp` file, since it doesn't do much more than being emitted, but the getter and setter need to be implemented similar to the following:

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

### src/Main.qml

To display the text, add a [Kirigami.Heading](https://api.kde.org/qml-org-kde-kirigami-heading.html) to `src/Main.qml` under the [title](https://doc.qt.io/qt-6/qml-qtquick-controls-page.html#title-prop) property of the [Kirigami.Page](docs:kirigami;org.kde.kirigami.Page) component we added to the code.

The resulting code in that part of the file should look like this:

```qml
Component {
    id: exposingToQml
    Kirigami.Page {
        Kirigami.Heading {
            anchors.centerIn: parent
            text: Backend.introductionText
        }
    }
}
```

Now [compile](/docs/getting-started/kirigami/setup-cpp/#running-the-application) and start your program again. You'll see that the new page has a centered Heading saying "Hello World!".

{{< figure class="text-center" src="/docs/getting-started/kirigami/advanced-connect_backend/result.webp" >}}

Congratulations, you learned:
* How to register backend types to QML
* Add new elements to the QML file
* Create new QObject subclasses
* How to add properties and what they do
* What signals are

If you want to know more about the integration between QML and C++, we recommend reading the [official Qt documentation](https://doc.qt.io/qt-6/qtqml-cppintegration-definetypes.html).
