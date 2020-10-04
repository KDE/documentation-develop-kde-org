---
title: Intermediate D-Bus
linkTitle: Intermediate D-Bus
weight: 3
description: >
    Tips to make use of QtDBus when faced with problematic real-world interfaces.
---

## Abstract

The basic techniques explained in [Accessing Interfaces](/docs/d-bus/accessing_dbus_interfaces) are suitable for using D-Bus methods with relatively simple signatures, but the more complex interfaces often found in the wild require additional techniques to address, explained in this article.

## Complex Return Types

QtDBus requires additional setup to deal with methods that return more complex return types than single primitives. The return type needs to be declared to the Qt type system so that it can be demarshalled.

### Lists

Lists of values returned by D-Bus methods are mapped to [QList](https://doc.qt.io/qt-5/qlist.html) in QtDBus. The appropriate specialisation of [QList](https://doc.qt.io/qt-5/qlist.html) should be declared as a type to the Qt type system, for example:

```cpp
Q_DECLARE_METATYPE(QList<QDBusObjectPath>)
```

It is essential that the `Q_DECLARE_METATYPE` macro is used outside any code blocks or methods in source code. The best place to use it is at the top of the file.

The type should also be declared to QtDBus using:

```cpp
qDBusRegisterMetaType<QList<QDBusObjectPath>>();
```

### Dicts

The DBus Dict type should map to [QMap](https://doc.qt.io/qt-5/qmap.html).

### Arbitrary sets of return types

Some D-Bus methods return an arbitrary tuple of values. The [QDBusReply](https://doc.qt.io/qt-5/qdbusreply.html) class can only handle the first value returned by a method, so to get the rest of the returned parameters we fall back to using [QDBusMessage](https://doc.qt.io/qt-5/qdbusmessage.html). Since `QDBusAbstractInterface::call()` and similar actually return `QDBusMessage`, when we use `QDBusReply` we are actually just constructing this from the `QDBusMessage` containing all the return values.

Once we have the [QDBusMessage](https://doc.qt.io/qt-5/qdbusmessage.html), we can access the return values using `arguments()` which returns a `QList<QVariant>`.

For example, for a method `org.kde.DBusTute.Favourites.Get( out INT32 number, out STRING colour, out STRING flavour )`, we would use the following code:

```cpp
QDBusInterface iface( "org.kde.DBusTute",
                      "/org/kde/DBusTute/Favourites",
                      "org.kde.DBusTute.Favourites",
                      QDBus::sessionBus());
QDBusMessage reply = iface.call( "Get" );
QList<QVariant> values = reply.arguments();
int favouriteNumber = values.takeFirst().toInt();
QString favouriteColour = values.takeFirst().toString();
QString favouriteFlavour = values.takeFirst().toString();
```

## Interfaces that don't support Introspect

[QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html), as a proxy for the remote D-Bus interface, makes use of introspection to provide high level access to D-Bus signals and properties. However, the object must support the interface `org.freedesktop.DBus.Introspectable` to do so, which is not mandatory.

### Properties

`Introspect` is required to discover properties that are accessed via `QObject::property()`. If it is not present, but the names and signature of the properties are known by looking at the source code of the remote interface, the D-Bus property system can be used manually, with these methods:

```
org.freedesktop.DBus.Properties.Get (in STRING interface_name,
                                     in STRING property_name,
                                     out VARIANT value);
org.freedesktop.DBus.Properties.Set (in STRING interface_name,
                                     in STRING property_name,
                                     in VARIANT value);
```
                                     
### Signals

If Introspect is not supported, `QObject::connect()` will get a `'no such signal'` error at runtime.

It is still possible to connect to these signals with QtDBus, at a lower level, using `QDBusConnection::connect()`. If you are using [QDBusInterface](https://doc.qt.io/qt-5/qdbusinterface.html) for its convenient `call()` methods, get its connection and call `connect()` on it:

```cpp
QDBusInterface iface("org.kde.DBusTute",
                     "/org/kde/DBusTute/Favourites",
                     "org.kde.DBusTute.Favourites",
                     QDBus::sessionBus());

iface.connection().connect("org.kde.DBusTute",
                           "/org/kde/DBusTute/Favourites",
                           "org.kde.DBusTute.Favourites",
                           "FavouritesChanged", this,
                           SLOT(favouritesChanged()));
```

The connection semantics are similar to a regular `QObject::connect()`, with the exception of unsupported new syntax, including lambdas.
