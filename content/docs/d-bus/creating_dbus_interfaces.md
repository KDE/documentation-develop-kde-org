---
title: Creating D-Bus Interfaces
linkTitle: Creating D-Bus Interfaces
weight: 4
description: >
    Learn how to expose functionality in your application by creating and using custom D-Bus interfaces. Covers generating the XML descriptions, instantiating interfaces at run time and setting up the build system with CMake.
---

## Abstract

D-Bus allows applications to expose internal API to the outside world by means of remotely callable interfaces. This tutorial shows how to create and implement such interfaces in your applications. 

## Lights: Defining The Interface

D-Bus interfaces generally reflect the API of one or more classes in the providing application. Bridging this API over to D-Bus is done using by creating a [QDBusAbstractAdaptor](https://doc.qt.io/qt-5/qdbusabstractadaptor.html) subclass that reacts to DBus messages and takes action directly. Usually, however, this simply results in one line methods that call similarly named methods in another object. This repetitive work can almost always be avoided by generating a D-Bus XML description file.

An interface as seen on the bus can be described using a standard XML format that is described in the [D-Bus specification](http://dbus.freedesktop.org/doc/dbus-specification.html#introspection-format).

Such XML might look like this example:

{{< readfile file="/content/docs/d-bus/creating_dbus_interfaces/example.xml" highlight="xml" >}}

If one has used a D-Bus application like `qdbus` (terminal) or `qdbusviewer` (graphical) to explore the `org.freedesktop.DBus.Introspectable.Introspect` method, the above might look familiar.

One can construct this XML by hand and manually map it to the API of a given class, but not only is this error prone and time consuming, it's not much fun. If it weren't for the fact that this XML can be used by other applications wishing to consume your D-Bus interface, one may as well write their own [QDBusAbstractAdaptor](https://doc.qt.io/qt-5/qdbusabstractadaptor.html)

Fortunately there are ways to automate the process so that it's hardly noticeable, namely: creating a class that includes the methods we wish to expose via D-Bus and using tools that come with Qt to do the rest for us.

### Defining Methods

We will be using the example of an interface that lets the user set the background wallpaper and query the current settings. We will be providing three methods in this interface, which can be seen in the following class definition:

{{< readfile file="/content/docs/d-bus/creating_dbus_interfaces/defining_methods.cpp" highlight="cpp" >}}

Next we need to mark which of the above methods we wish to expose via D-Bus. Fortunately, this is quite simple with the following options available to us:

 - export all signals
 - export all public slots
 - export all properties
 - export only scriptable signals
 - export only scriptable public slots
 - export only scriptable properties

We can also combine the above as we wish. To achieve the desired results from the above example, we need to adjust the class definition accordingly:

{{< readfile file="/content/docs/d-bus/creating_dbus_interfaces/exports.cpp" highlight="cpp" >}}

Note how we moved the methods we wish to export to to be public slots and marked the signal we want to export with `Q_SCRIPTABLE`. We will later choose to create an interface that exports all the public slots and all scriptable signals.

We would then go about creating an implementation of this class as defined above.

{{< alert title="Tip" >}} When exposing an API to other applications via D-Bus, other applications and users, via scripting, may come to rely on the calls available in the interface. Changing the D-Bus interface can therefore cause breakage for others. For this reason it is recommended to keep compatibility with publicly advertised D-Bus APIs over the lifespan of a major release of your application.{{< /alert >}}

### Naming The Interface

The next step after having defined our interface is to come up with a name that it will appear as on the bus. These names by convention take on the form of reverse domain names to prevent name collisions. Therefore if the domain for your project website is `foo.org` you should prefix your interface names with `org.foo`.

Therefore, we may choose to call our interface example `org.foo.Background`. The easiest way to define this is to add a `Q_CLASSINFO` macro entry to our class definition:

```cpp
class Background : QObject
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "org.foo.Background")
```

The interface will now be known as `org.foo.Background`.

## Camera: Generating the Interface

### The Simple Way
The simplest way of generating interfaces is to use your class as interface directly. Just make sure your class has `Q_CLASSINFO("D-Bus Interface", "org.foo.Background")` under the `Q_OBJECT` macro. Now you can skip the next section and head to [Instantiating the Interface At Runtime](#the-simple-way-1)

### The Complex But Portable Way
This way requires a more complicated build procedure, but if your project will be used by many other applications, this is probably the better way. It installs an XML file in the system, which other applications can use to generate their own adapter class. Anyone with your project installed can refer to this file without having to go to your project source.

Now that we have set up the interface in our class, we will want to generate an adaptor class that mediates between D-Bus and our application's objects. The first step is to generate the XML seen at the beginning of this tutorial.

You can generate the xml file manually by calling `qdbuscpp2xml` in a terminal, and ship the generated xml as part of the your project's source.

Another option is to make CMake to do it for you in compile time. This approach has the advantages of keeping your source code clean and not needing to remember to regenerate the xml file after each edit of the class.

### Solution one: call qdbuscpp2xml manually

To generate the XML we will be using the `qdbuscpp2xml` command line tool that comes with Qt. This program takes a C++ source file and generates a D-Bus XML definition of the interface for us. It lets us define which methods to export using the following command line switches:

|Switch | Exports                |
|-------|------------------------|
|-S     | all signals            |
|-M     | all public slots       |
|-P     | all properties         |
|-A     | all exportable items   |
|-s     | scriptable signals     |
|-m     | scriptable public slots|
|-p     | scriptable properties  |
|-a     | all scriptable items   |

In our example above we want to export all the public slots but only scriptable signals. Therefor we would use this command:

```bash
$> qdbuscpp2xml -M -s background.h -o org.foo.Background.xml
```

This produces a file named `org.foo.Background.xml` which contains this:

{{< readfile file="/content/docs/d-bus/creating_dbus_interfaces/org.foo.Background.xml" highlight="xml" >}}

This file should be shipped with your project's source distribution.

### Solution two: Call qdbuscpp2xml using CMake (Preferred)

Add the following code to your project's `CMakeLists.txt`:

```cmake
set(my_nice_project_SRCS 
    ${my_nice_project_SRCS}
    ${CMAKE_CURRENT_BINARY_DIR}/org.foo.Background.xml
)
qt5_generate_dbus_interface(
    background.h
    org.foo.Background.xml
    OPTIONS -a
)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/org.foo.Background.xml DESTINATION ${DBUS_INTERFACES_INSTALL_DIR})
```

This will generate `org.foo.Background.xml` from `background.h` and install it in `${DBUS_INTERFACES_INSTALL_DIR}` (wich usally means `/usr/share/dbus-1/interfaces`).

### Export the interface using CMake

Next we add this XML file to our project. This is done by adding the following line to the `CMakeLists.txt` file:

```cmake
qt5_add_dbus_adaptor(my_nice_project_SRCS org.foo.Background.xml
                     background.h Background)
```
                     
This will cause two files, in this case `backgroundadaptor.h` and `backgroundadaptor.cpp`, to be generated in the build directory, built and added to the application at build time. You should not ship these files with your project's source distribution.

The D-Bus XML description file will also be installed. This allows users to examine it as a reference and other applications to use this file to generate interface classes using `qdbusxml2cpp` as seen in the tutorial on [accessing D-Bus interfaces](/docs/d-bus/accessing_dbus_interfaces).

You can use the generated adaptor to [Instantiating the Interface At Runtime](#the-complex-way)

## Action: Instantiating the Interface At Runtime

### The Simple Way
You can use [`QDBusConnection::registerObject`](https://doc.qt.io/qt-5/qdbusconnection.html#registerObject) to register your class. Normally you'd do this in the constructor of your class, but if you have more than one instance of the same class, you need to ensure there is no DBus path conflict. For a singleton class, you may have something like this in the constructor:

{{< readfile file="/content/docs/d-bus/creating_dbus_interfaces/instantiating_interface_simple.cpp" highlight="cpp" >}}

In line 6 we register the service path with DBus. This name should not be used by any other project. Note that if you have

```cpp
    KLocalizedString::setApplicationDomain("myapp");
    KDBusService service(KDBusService::Unique);
```
in your `main` function, the service name `org.kde.myapp` is auto registered and you can safely omit line 6.

In line 7 we register this class as an object at `org.kde.myapp/foobar/org.foo.Background`. Note that other than the case of `/` which is the root path, the first argument should never end with `/`. The second argument is the pointer to the class you want to expose to DBus, this class should be a subclass of `QObject` and have `Q_CLASSINFO("D-Bus Interface", "org.foo.Background")`. The third argument is the methods you want to exposed to DBus, for detailed infomation, head to [Qt's documentation on QDBusConnection](https://doc.qt.io/qt-5/qdbusconnection.html#RegisterOption-enum).

However, if you have multiple instances of this class, we need to edit above example to avoid path conflict. Replace `QDBusConnection::sessionBus().registerObject("/foobar", this, QDBusConnection::ExportScriptableContents);` with `QDBusConnection::sessionBus().registerObject("/foobar/" + QString("YOUR UNIQUE INSTANCE IDENTIFIER"), this, QDBusConnection::ExportScriptableContents);`

### The Complex Way
Now that we have our interface created for us, all we need to do is create it at runtime. We do this by including the generated header file and instantiating an object, as seen in this example:

{{< readfile file="/content/docs/d-bus/creating_dbus_interfaces/instantiating_interface_complex.cpp" highlight="cpp" >}}

Since the generated adaptor is a QObject, when we pass the constructor `this` it not only will be deleted when our Background object is deleted but it will bind itself to `this` for the purposes of forwarding D-Bus calls.

We then need to register our object on the bus by calling `QDBusConnection::registerObject` and expose the interface for others to use by calling `QDBusConnection::registerService`.

{{< alert title="Tip" >}} If there will be more than one of the same object created in your application then you will need to register each object with a unique path. If there is no well defined, unique naming scheme for your objects the `this` pointer may come in handy.
{{< /alert >}}

