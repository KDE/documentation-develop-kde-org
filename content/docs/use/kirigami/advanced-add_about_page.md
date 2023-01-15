---
title: About Page
weight: 204
description: Informations about your application
group: advanced
aliases:
  - /docs/kirigami/advanced-add_about_page/
---

The About Page allows you to have a page that shows the copyright notice of the application together with the contributors and some information of which platform it's running on.

First, we are going to create two files in the `src/` directory called `about.cpp` and `about.h`.

### about.h

{{< readfile file="/content/docs/use/kirigami/advanced-add_about_page/src/about.h" highlight="cpp" >}}

In the `.h` file we create this class `AboutType` which is inherited from [QObject](https://doc.qt.io/qt-5/qobject.html).


The `Q_OBJECT` macro tells the compiler that this class uses own signals and slots, the `Q_PROPERTY` macro behaves like a class data member, but it has additional features, it will allow our QML code to have access to this class.


The `aboutData` method will return the application data from `KAboutData`.

### about.cpp

{{< readfile file="/content/docs/use/kirigami/advanced-add_about_page/src/about.cpp" highlight="cpp" >}}

In the `.cpp` file we just include the `.h` file.

### main.cpp

{{< readfile file="/content/docs/use/kirigami/advanced-add_about_page/src/main.cpp" highlight="cpp" >}}

In the cpp file we include `KAboutData` and the `.h` file we just created, [KAboutData](docs:kcoreaddons;KAboutData) is a core KDE Frameworks component that stores information about an application, which can then be reused by many other KDE Frameworks components. We instantiate a new `KAboutData` object with its fairly complete default constructor and add author information.


After all the required information has been set, we call `KAboutData::setApplicationData` to initialize the properties of the [QApplication ](https://doc.qt.io/qt-5/qapplication.html) object.


After the QML Engine definition, we create a [qmlRegisterSingletonType](https://doc.qt.io/qt-5/qqmlengine.html#qmlRegisterSingletonType), the first argument is a URI, basically a package name, the second and third arguments are major and minor versions respectively, the fourth is the type name, the name that we will call when accessing the `AboutType` methods.

In the `qmlRegisterSingletonType` lambda we just return a new `AboutType` object;


### main.qml

{{< readfile file="/content/docs/use/kirigami/advanced-add_about_page/src/contents/ui/main.qml" highlight="qml" >}}

First, we import the package we defined in the `main.cpp` file, add a `Kirigami.Action` to our global drawer that will send us to the about page and create a component with a `Kirigami.AboutPage` in it, the About Page only have one property: `aboutData`, we then pass `AboutType.aboutData` to it.


### CMakeLists

{{< readfile file="/content/docs/use/kirigami/advanced-add_about_page/CMakeLists.txt" highlight="cmake" >}}

In the CMakeLists.txt file in our top-level folder, add `CoreAddons` to the `find_package` module. 

{{< readfile file="/content/docs/use/kirigami/advanced-add_about_page/src/CMakeLists.txt" highlight="cmake" >}}

In the CMakeLists.txt file in the ‘src’ directory, add `about.cpp` to the `add_executable` module and `KF5::CoreAddons` to the `target_link_libraries` module.


## Running the application

Now if you run your application and trigger the "About" action in the global drawer you should see our about page.

![Screenshot of the Kirigami About Page](about-page.png)
