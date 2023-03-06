---
title: D-Bus Autostart Services
linkTitle: D-Bus Autostart Services
weight: 6
description: >
    Turn your application into a D-Bus autostart service with this tutorial. This D-Bus feature, also known as "D-Bus service activation", will ensure that even when your application isn't running that D-Bus calls made to it will work by relying on the D-Bus daemon itself to start your app if and when needed.
aliases:
  - /docs/features/d-bus/dbus_autostart_services/
---

## Abstract

The D-Bus daemon provides a mechanism to autostart applications if they aren't already running when a D-Bus call is made to a service provided by that program. This tutorial demonstrates how to create a D-Bus autostart service and integrate it with your CMake build.

## The Basic Mechanics

Whenever a D-Bus message arrives for the D-Bus server to deliver, it looks for the corresponding service that the message is addressed to on the bus it was sent on.

If no such service is currently registered, it then falls back to looking through files kept in the services directory in the D-Bus data path, e.g. `/usr/share/dbus-1/services`. It looks through each `.service` file looking for a matching service name. It then uses this file to determine what application to launch, waits for the application to finish launching and then (if all goes well) delivers the message.

All of this happens transparently to the application the message originated with.
## Creating a Service File

The service files are simple `.ini` style configuration files, much like standard `.desktop` files.

A valid service file:

 - ends with `.service`
 - has a `[D-BUS Service]` group
 - has a `Name` and `Exec` key

The contents of an example service file for an application called `MyApp` might look like this:

```ini
[D-BUS Service]
Name=org.kde.myapp
Exec=/usr/bin/myapp
```

The `Name` and `Exec` keys will be familiar to anyone who has worked with `.desktop` files before. Unlike `.desktop` files, though, the `Exec` line must contain the full path to the application that is to be started.

In the above example, if a message was sent to the `org.kde.myapp` service but such a service had not yet been registered on the bus, then `/usr/bin/myapp` will be launched. It is then up to myapp to register the proper service on the bus.

## Installing a Service File

Once you have created a service file for your application, place it somewhere in the source tree and append a suffix, such as `.in`, to the filename. This will allow us to process the file during the build to customize the Exec entry without the risk of overwriting the source file.

We will be using a simple CMake directive to perform the customization and installation. Since the install prefix is not known until build time, we need to adjust our service file slightly. Using the myapp example again, we create a file called `org.kde.myapp.service` that contains the following content:

```ini
[D-BUS Service]
Name=org.kde.myapp
Exec=@CMAKE_INSTALL_PREFIX@/bin/myapp
```

In the `CMakeLists.txt` file we will then add these two lines:

```cmake
configure_file(org.kde.myapp.service.in
               ${CMAKE_CURRENT_BINARY_DIR}/org.kde.myapp.service)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/org.kde.myapp.service
        DESTINATION ${KDE_INSTALL_DBUSSERVICEDIR})
```

When `make install` is run, a properly formed service file will be generated (using the `.service` file that you have just created), and installed to the correct location on disk. Your application is now set to be automatically activated when needed. 
