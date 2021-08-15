---
title: About Page
weight: 204
description: Informations about your application
group: advanced
---

The About Page allows you to have a page that shows the copyright notice of the application together with the contributors and some information of which platform it's running on.

First, we are going to create two files in the `src/` directory called `controller.cpp` and `controller.h`.

### controller.h
```C++
#pragma once

#include <QObject>

#include <KAboutData>

class Controller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(KAboutData aboutData READ aboutData CONSTANT)

public:
    static Controller &instance();

    [[nodiscard]] KAboutData aboutData() const;
};
```

In the `.h` file we create this class `Controller` which is inherited from [QObject](https://doc.qt.io/qt-5/qobject.html).


The `Q_OBJECT` macro tells the compiler that this class uses own signals and slots, the `Q_PROPERTY` macro behaves like a class data member, but it has additional features, it will allow our QML code to have access to this class.


The `instance` method will return an instance of `Controller`, and the `aboutData` method will return the application data from `KAboutData`.

### controller.cpp

```C++
#include "controller.h"

Controller &Controller::instance()
{
    static Controller _instance;
    return _instance;
}

KAboutData Controller::aboutData() const
{
    return KAboutData::applicationData();
}
```

In the `.cpp` file we have two methods, `instance` and `aboutData`.

`instance` just returns a `Controller` object and `aboutData` returns our application data.

### main.cpp

```C++
...
#include <KAboutData>
#include "config-helloworld.h"

#include "controller.h"

int main(int argc, char *argv[])
{
    ...

    KAboutData aboutData(
                         // The program name used internally.
                         QStringLiteral("helloworld"),
                         // A displayable program name string.
                         i18nc("@title", "Hello World"),
                         // The program version string.
                         QStringLiteral(HELLOWORLD_VERSION_STRING),
                         // Short description of what the app does.
                         i18n("Hello world application"),
                         // The license this code is released under.
                         KAboutLicense::GPL,
                         // Copyright Statement.
                         i18n("(c) 2021"));
    aboutData.addAuthor(i18nc("@info:credit", "Your name"), i18nc("@info:credit", "Author Role"), QStringLiteral("your@email.com"), QStringLiteral("https://yourwebsite.com"));
    KAboutData::setApplicationData(aboutData);

    qmlRegisterSingletonInstance("org.kde.helloworld", 1, 0, "Controller", &Controller::instance());

    QQmlApplicationEngine engine;

    ...
}
```

In the cpp file we include `KAboutData` and the `.h` file we just created, [KAboutData](docs:kcoreaddons;KAboutData) is a core KDE Frameworks component that stores information about an application, which can then be reused by many other KDE Frameworks components. We instantiate a new `KAboutData` object with its fairly complete default constructor and add author information.


We also include this `config-helloworld.h` file which gives us this `HELLOWORLD_VERSION_STRING` variable that we'll set later in this tutorial.

After all the required information has been set, we call `KAboutData::setApplicationData` to initialize the properties of the [QApplication ](https://doc.qt.io/qt-5/qapplication.html) object.


Before the QML Engine definition, we create a [qmlRegisterSingletonInstance](https://doc.qt.io/qt-5/qqmlengine.html#qmlRegisterSingletonInstance), the first argument is a URI, basically a package name, the second and third arguments are major and minor versions respectively, the fourth is the type name, the name that we will call when accessing the `Controller` methods, and the last one is a cpp object.


### main.qml

```QML
...
import org.kde.helloworld 1.0

Kirigami.ApplicationWindow {
    ...

    globalDrawer: Kirigami.GlobalDrawer {
        ...
        actions: [
            ...
            Kirigami.Action {
                text: i18n("About")
                icon.name: "help-about"
                onTriggered: pageStack.layers.push(aboutPage)
            }
            ...
        ]
    }

    Component {
        id: aboutPage

        Kirigami.AboutPage {
            aboutData: Controller.aboutData
        }
    }
}
```

First, we import the package we defined in the `main.cpp` file, add a `Kirigami.Action` to our global drawer that will send us to the about page and create a component with a `Kirigami.AboutPage` in it, the About Page only have one property: `aboutData`, we then pass `Conrtoller.aboutData` to it.


### CMakeLists

```CMAKE
...
project(helloworld)
set(PROJECT_VERSION "1.0")

...
include(ECMSetupVersion)
include(ECMGenerateHeaders)
include(ECMPoQmTools)
...

ecm_setup_version(${PROJECT_VERSION}
    VARIABLE_PREFIX HELLOWORLD
    VERSION_HEADER "${CMAKE_CURRENT_BINARY_DIR}/src/config-helloworld.h"
)

...
find_package(KF5 ${KF_MIN_VERSION} ... CoreAddons)
...
```

In the CMakeLists.txt file in our top-level folder, add `CoreAddons` to the `find_package` module. You'll also want to add these three `ECM` includes which will allow us to use the `ecm_setup_version` function, this function let's use the `PROJECT_VERSION` variable in our code so we only need to change one variable when bumping up versions.

```CMAKE
...
add_executable(helloworld main.cpp controller.cpp resources.qrc)
target_link_libraries(helloworld ... KF5::CoreAddons)
```

In the CMakeLists.txt file in the ‘src’ directory, add `controller.cpp` to the `add_executable` module and `KF5::CoreAddons` to the `target_link_libraries` module.

## Running the application

Now if you run your application and trigger the "About" action in the global drawer you should see our about page.

![Screenshot of the Kirigami About Page](about-page.png)
