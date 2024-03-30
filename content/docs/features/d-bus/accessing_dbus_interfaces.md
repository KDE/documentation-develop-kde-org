---
title: Accessing D-Bus interfaces
linkTitle: Accessing D-Bus interfaces
weight: 2
description: >
    A step-by-step guide to calling D-Bus methods and connecting to D-Bus signals using QtDBus.
aliases:
  - /docs/features/d-bus/accessing_dbus_interfaces/
---

## Abstract

D-Bus allows applications to expose their internal API to the outside world. These APIs can then be accessed at run-time via the D-Bus protocol using command line applications or D-Bus libraries and bindings themselves. This tutorial looks at the latter method with examples that you can use in your applications. 

## Using QDBusMessage

[QDBusMessage](https://doc.qt.io/qt-5/qdbusmessage.html) represents a D-Bus message that can be sent or has been received over a given bus. Each message is one of four types, depending on the purpose of the message:

 - method call
 - signal
 - reply
 - error

An enumeration covering each of these possibilities is defined in [QDBusMessage](https://doc.qt.io/qt-5/qdbusmessage.html). A message's type can be access via the `QDBusMessage::type` method.

### Calling a D-Bus Method

A [QDBusMessage](https://doc.qt.io/qt-5/qdbusmessage.html) can be used directly to call methods in D-Bus services using the
```cpp
QDBusMessage::createMethodCall(const QString &service, const QString &path, const QString &interface, const QString &method)
```
static method. It returns a [QDBusMessage](https://doc.qt.io/qt-5/qdbusmessage.html) object that you can then use to make the call.

The `interface` parameter is optional and only necessary if the method to be called is not unique in the object associated with the `path`. This can happen if the object implements multiple interfaces which have methods that are named the same. In such (rare) cases, if you do not explicitly define the interface to use there is no guarantee as to which method will actually get called. However, usually you can simply pass an empty string (e.g. "") as the argument for `interface`.

By way of example, to access the (fictional) ping method on the `/network` object in the `org.foo.bar` service, one might do this:

```cpp
QDBusMessage m = QDBusMessage::createMethodCall("org.foo.bar",
                                              "/network",
                                              "",
                                              "ping");
bool queued = QDBusConnection::sessionBus().send(m);
```

In line 5 of the above example we queue the message for sending on the current session bus. We get a bool returned letting us know if the queueing was successful or not.

This leaves us with two questions, however:

 - How can one set parameters for a method call?
 - How can one get a return message in the case of D-Bus methods that have a return value?
 
### Settings Parameters

Sending arguments along with the method call is quite straight forward. First we need to create a [QList](https://doc.qt.io/qt-5/qlist.html) of [QVariant](https://doc.qt.io/qt-5/qvariant.html) objects and then add those to our D-Bus message. So if the ping method in the above took a hostname as a parameter, we might alter the code in this way (note lines 5 through 7):

```cpp
QDBusMessage m = QDBusMessage::createMethodCall("org.foo.bar",
                                              "/network",
                                              "",
                                              "ping");
QList<QVariant> args;
args.append("kde.org");
m.setArguments(args);
bool queued = QDBusConnection::sessionBus().send(m);
```

Alternatively, [QDBusMessage](https://doc.qt.io/qt-5/qdbusmessage.html) provides a convenience method to appending parameters to the message, by way of its `operator<<` function. The above example becomes:

```cpp
QDBusMessage m = QDBusMessage::createMethodCall("org.foo.bar",
                                              "/network",
                                              "",
                                              "ping");
m << "kde.org";
bool queued = QDBusConnection::sessionBus().send(m);
```

{{< alert title="Note" >}}The arguments must appear in the [QList](https://doc.qt.io/qt-5/qlist.html) in the same order they are expected by the D-Bus method being called.{{< /alert >}}

### Getting Replies

If we wish to actually receive information back from the D-Bus method, we use the `QDBusConnection::call` method instead. It will block until there is a reply or the call times out. If our ping method returned information on the host we provided in the arguments above, we might alter our code to look like this:

```cpp
QDBusMessage m = QDBusMessage::createMethodCall("org.foo.bar",
                                               "/network",
                                               "",
                                               "ping");
m << "kde.org";
QDBusMessage response = QDBusConnection::sessionBus().call(m);
```

The response will be either of type `QDBusMessage::ReplyMessage` or `QDBusMessage::ErrorMessage` depending on whether it was successful or not. We can look through the values returned by retrieving the arguments with the `qdbusmessage::arguments()` method which returns a `QList<QVariant>`.

### Is This The Best Way?

Using [QDBusMessage](https://doc.qt.io/qt-5/qdbusmessage.html) directly in this way to invoke remote D-Bus methods is not the easiest, best or even recommend way of doing things. We will now look at the more convenient [QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html) class and then look at accessing remote D-Bus interfaces as if they were local methods using proxy classes auto-generated from XML.

## Using QDBusInterface

{{< alert title="Warning" color="warning" >}}This section is for learning purposes only. **Avoid using QDBusInterface, especially in graphical applications**. QDBusInterface's constructor makes a non-obvious blocking call to introspect the D-Bus service ([QTBUG-14485](https://bugreports.qt.io/browse/QTBUG-14485)). **This problem doesn't affect the classes generated from D-Bus XML explained in the later section**, since there the required information is available at compile time.

These blocking calls are especially problematic if used for initializing non-essential service interfaces, as each call requires a roundtrip to the process hosting the service: at best, this will cause a slight increase in the time to load your application; at worst, a hung process will keep your process blocked until the 25s timeout is reached.{{< /alert >}}

[QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html) provides a simple and direct method to make D-Bus calls and connect to D-Bus signals.

A [QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html) object represents a given D-Bus interface. The constructor accepts as parameters (in order) a service name, an object path, an optional interface and optionally which bus (e.g. system or session) to use. If no bus is explicitly defined, it defaults to the session bus. If no interface is given, the returned object will be used to call all interfaces on the bus.

However, note that explicitly passing an interface name to the [QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html) constructor is recommended. Due to the internals of QtDBus, if you pass an empty interface, you will always cause a round-trip to the remote application to verify which methods are available. On the other hand, if you pass a non-empty interface name, QtDBus may cache the result for further uses.

As [QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html) is a QObject, you can also pass it a parent object. This helps simplify the bookkeeping associated with creating new [QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html) objects by letting Qt clean up for you when the parent object is deleted.

Here is an example of [QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html) usage which we will then step through line by line:

```cpp
QString hostname("kde.org");
QDBusConnection bus = QDBusConnection::sessionBus();
QDBusInterface *interface = new QDBusInterface("org.foo.bar",
                                               "/network",
                                               "org.foo.bar.network", 
                                               bus,
                                               this); 

interface->call("ping");
interface->call("ping", hostname);

QList<QVariant> args;
args.append("kde.org");
interface->callWithArgumentList("ping", args);

QDBusReply<int> reply = interface->call("ping",
                                        hostname);

if (reply.isValid())
{
     KMessageBox::information(winId(), 
                              i18n("Ping to %1 took %2s")
                               .arg(hostname)
                               .arg(reply.value()),
                              i18n("Pinging %1")
                               .arg(hostname));
}

args.clear();
interface->callWithCallback("listInterfaces", args,
                            this,
                            SLOT(interfaceList(QDBusMessage)));

connect(interface, SIGNAL(interfaceUp(QString)),
        this, SLOT(interfaceUp(QString)));
```

### Synchronous Calls

The first thing we did was create a [QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html) on line 3 that represents the same object we were accessing in the QDBusMessage examples above.

We then called several D-Bus methods on that object using a few different techniques. On line 9 we make a simple call to a method called ping without any arguments. On line 10, we call the same method but with a parameter. Note that we didn't have to create a `QList<QVariant>` for the arguments. We can pass up to 8 arguments to a D-Bus method this way.

If you need to pass more than 8 arguments or for some other reason a `QList<QVariant>` is a better approach for the circumstances, then you may use the `callWithArgumentList` method instead as seen on lines 12-14 above.

### Handling Replies

On line 16 we call the ping method yet again, but this time save the reply in a [QDBusReply](https://doc.qt.io/qt-5/qdbusreply.html) object. We check to make sure the reply was valid (e.g. no errors were returned and we did indeed get an `int` back) and then use the returned data to populate a message in an informational popup.

### Asynchronous Method Calls and Signals

Up to this point in the example all of the calls made were synchronous and the application would block until a reply was received. The last two uses of [QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html) in the example show asynchronous usage of D-Bus, and in both cases we rely on Qt's signal and slot mechanism.

On line 29 we use `callWithCallback` and provide a regular [QObject](https://doc.qt.io/qt-5/qobject.html) slot to be called when the D-Bus reply returns. This way the application will not block as `callWithCallback` returns immediately after queueing the message to be sent on the bus. Later, the `interfaceList` slot would get called. Note that this method requires a `QList<QVariant>`; there is no shortcut for us this time.

Finally, on line 33 we connect to a D-Bus signal. Using [QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html) to do this looks exactly like connecting to a regular, local signal in our own application. We even use the standard `QObject::connect` method! This is accomplished by [QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html) using Qt's meta object system to dynamically add the signals the D-Bus interface advertises. Very slick!

### Can We Have Something More Convenient? 

This ease of use over [QDBusMessage](https://doc.qt.io/qt-5/qdbusmessage.html) is huge. There are still some annoyances we have to deal with, however, such as having to know the name of the interface, setting up the correct [QDBusReply](https://doc.qt.io/qt-5/qdbusreply.html) object such as we did above by templating it with an int and having to debug method name typos and the like at runtime versus letting the compiler do it for us. So while it's an improvement over [QDBusMessage](https://doc.qt.io/qt-5/qdbusmessage.html), it's still not perfect.

And that's precisely where `qdbusxml2cpp` comes to our rescue.

## Using Classes Generated From D-Bus XML

What would be truly great is if we could instantiate a local object that represented a given service and start using it right away. Perhaps something like this:

```cpp
org::foo::bar::network *interface = 
    new org::foo::bar::network("org.foo.bar", "/network",
                            QDBusConnection::sessionBus(),
                            this);
interface->ping("kde.org");
```

Fortunately for us, this is precisely what Qt allows us to do. The only requirement is an XML file describing the D-Bus service. Such files are installed in the D-Bus prefix in the interfaces directory.


{{< alert title="Tip" >}}The D-Bus prefix is 

```cmake
${CMAKE_INSTALL_PREFIX}/share/dbus-1/interfaces
```

, the `${CMAKE_INSTALL_PREFIX}` can be found by issuing following command in terminal 
```bash
pkg-config dbus-1 --variable=prefix
```{{< /alert >}}


We can also create our own XML files from the C++ header files and use those directly. This is covered in the next tutorial, [Creating D-Bus Interfaces](/docs/features/d-bus/creating_dbus_interfaces).

With the path to the XML in hand, we then add something like this to our `CMakeLists.txt`:

```cmake
set(network_xml ${CMAKE_INSTALL_PREFIX}/${DBUS_INTERFACES_INSTALL_DIR}/org.foo.bar.xml)
qt5_add_dbus_interface(myapp_SRCS ${network_xml} network_interface )
```

This will generate two files at build time, `network_interface.h` and `network_interface.cpp`, and add them to the compiled application. We can then simply
```cpp
#include "network_interface.h"
```
and use the generated class as seen in the example above.

Examining the generated header file, we can see exactly what methods, signals as well as their signatures and return values are according to the provider of the service. Using the class directly will let the compiler do type checking on method calls leaving fewer run-time breakages to track down.

Due to the generated class being a subclass of [QDBusAbstractInterface](https://doc.qt.io/qt-5/qdbusabstractinterface.html) just as [QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html) is, anything we can do with [QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html) is also available to us.

Due to this combination of ease of use and compile-time checking, this is generally the preferred mechanism to use when accessing *complicated* D-Bus interfaces.
{{< alert title="Tip" >}}If your CMake installation does not provide the `${DBUS_INTERFACES_INSTALL_DIR}`, remember to add KDE ECM module to your `CMakeLists.txt`.{{< /alert >}}

But it does come with its drawbacks, since we need a XML file to generate adaptor at compile time. The XML file must be present in system. This would mean one will have to build the project that carries this file first, leading to more compile time dependencies. Including the XML file in source code avoid this, but only feasible if you can guarantee the sync between the actual interface and the XML file you carry.

Each ways comes with pros and cons, feel free to choose your solution. My suggestions are:

* Use `QDBusInterface` only if blocking is not a problem (e.g. small console utilities) and the remote interface is simple enough.
* Use adaptor with a system XML file if the XML comes from a software very likely to be compiled first. E.g. XML files from `KWin` or `PowerDevil` or other important Plasma software packages.
* It's fine to use adaptor if the XML is installed by the same project. I.e. your project consists of a daemon and client, the XML file is from daemon and the adaptor is for client. Being in same project you can always guarantee the generated adaptor is correct.
* Including the XML in your project is less than perfect but it's appropriate for stable APIs and can be a good option if it would otherwise drag too many otherwise unnecessary dependencies or if no system XML exists (you can create your own with introspection).
* You can still raw `QDBusMessage` along with `QDBusConnection` for complex cases not covered by other methods.

## Doing A Little Introspection

It may also be helpful to find out if a given service is available or to check which application is providing it. Another [QDBusAbstractInterface](https://doc.qt.io/qt-5/qdbusabstractinterface.html) subclass, [QDBusConnectionInterface](https://doc.qt.io/qt-5/qdbusconnectioninterface.html), provides methods to query for such information as which services are registered and who owns them.

Once you have a service name, you can then use [QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html) to get the `org.freedesktop.DBus.Introspectable` interface and call `Introspect` on it. This will return an XML block describing the objects, which can in turn be introspected for what they provide. The XML itself can be processed using [QDomDocument](https://doc.qt.io/qt-5/qdomdocument.html), making it a fairly simple process.

The `qdbus` application that ships with Qt provides a nice example of code doing exactly this. It can be found in `tools/qdbus/tools/qdbus/qdbus.cpp` in the Qt source distribution. 
