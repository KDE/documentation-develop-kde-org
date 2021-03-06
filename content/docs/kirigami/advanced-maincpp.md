---
title: Figuring out main.cpp
weight: 202
group: advanced
description: >
  Understanding the central file of our backend code
---

## The role of main.cpp

While QML is used for the front-end of Kirigami applications, the backend is usually written in C++ thanks to this language's speed and flexibility. While in previous pages we have covered QML in a lot of depth, we'll need to gain an understanding of our backend C++ code in order to make applications that are more useful than what we can achieve with pure QML.

Here, we'll be going over the `main.cpp` file we created in the 'Getting Started' page so that we can better understand what is going on in the central C++ file of our application. While this is a basic `main.cpp`, the features we will go over will remain essential no matter what kind of application it is that you decide to create.

## What it does

{{< readfile file="/content/docs/kirigami/introduction-getting_started/src/main.cpp" highlight="cpp" >}}

First we must include a number of Qt header files, allowing us to use their functions. In this case, we include a number of Qt headers that handle application logic, reading QML files, and accessing files defined in `resources.qrc`.

Enter our main function. Its first line `QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);` enables High DPI scaling. This lets our application scale properly across devices with different display pixel densities. 

We then create a [`QApplication`](https://doc.qt.io/qt-5/qapplication.html#QApplication) instance which we call `app`. We pass `argc` and `argv` to the constructor here, letting Qt parse and use arguments meant to affect Qt.

We also set some metadata relating to the application. These include the organisation that created the application, the organisation's website, and the name of the application. We set these properties in [`QCoreApplication`](https://doc.qt.io/qt-5/qcoreapplication.html), an object which provides the event loop for applications regardless of whether they have a GUI or not (so if we ran our program without the GUI, this metadata would still be set).

The [`QQmlApplicationEngine`](https://doc.qt.io/qt-5/qqmlapplicationengine.html) lets us load an application from a QML file, which we do in the next line. In `engine.load(QUrl(QStringLiteral("qrc:/main.qml")));` we load our QML from a URL in our `resources.qrc` file.

Next, we check if our engine correctly loaded the QML file by checking that the engine's `rootObjects` list is not empty. We can then run our application with `app.exec()`.
