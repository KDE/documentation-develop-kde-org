---
title: Solid
linkTitle: Solid
weight: 10
group: "features"
description: >
    Hardware abstraction
---

## Introduction

Solid allows to write applications with hardware
interaction features. The necessary abstraction to support cross-platform
application development is provided by Solid's comprehensive API.

Solid looks for devices and
gives you access to the information it has about them. This way, you could
easily look at the functions of the cpu, or at the driver that handles your
camera, or the mount point of your usb pen.

You can use Solid to retrieve information about a device without needing to know about its specificities so that you can use another library to control them. This information retrieval works even for network devices.

## Device Discovery

### Listing Devices

Our first program will be a simple console based app that gets a list of all
the hardware devices and prints them out to the screen.

```cpp
#include <Solid/Device>
// ...
for(const Solid::Device &device : Solid::Device::allDevices()) {
    qInfo() << device.udi();
}
```

`device.udi()` returns the Unique Device Identifier for the device as a QString, which is guaranteed to be
unique. For example if you have a MythTV box with two PVR-250 T.V. capture
cards in it, you will be able to refer to card #1 and #2 by their respective UDI.

### Searching for specific devices

This second program makes uses of filters built into the solid framework. Using
these filters you can list only devices according to supported types,
sub-devices of a given parent, and various [predicates]({{< ref "#predicates" >}}). In our example we'll be
limiting our list to only audio hardware. A full list of device types can be
viewed under the [Solid::DeviceInterface::Type](https://api.kde.org/solid-deviceinterface.html#Type-enum).

```cpp
#include <Solid/Device>
#include <Solid/DeviceInterface>
// ...

// get a list of battery devices
const auto devices = Solid::Device::listFromType(Solid::DeviceInterface::Battery, QString());
for (const Solid::Device &device : devices)
{
   qDebug() << device.udi();
}
```

In this example [Solid::Device::listFromType()](https://api.kde.org/solid-device.html#listFromType) looks for a device
with any parent and the `Solid::DeviceInterface::Battery` type. If we had
wanted to specify a battery device with the parent `/org/freedesktop/UPower` it
would look like this:

```cpp
Solid::Device::listFromType(Solid::Type::Battery, QStringLiteral("/org/freedesktop/UPower"));
```

### What do we do with a device once we get it?

First let's look at the
relationship between the [Solid::Device](https://api.kde.org/solid-device.html) and [Solid::DeviceInterface::Type](https://api.kde.org/solid-deviceinterface.html#Type-enum).
A device can include many different types and can be tested to have a certain type
in the following way:

```cpp
#include <Solid/Device>
#include <Solid/DeviceInterface>
#include <Solid/Processor>
// ...

const auto list = Solid::Device::listFromType(Solid::DeviceInterface::Processor, QString());

// take the first processor in the list
Solid::Device device = list[0];
if (device.is<Solid::Processor>()) {
    qDebug() << "We've got a processor!";
} else {
    qDebug() << "Device is not a processor.";
}

auto processor = device.as<Solid::Processor>();
qInfo() << "This processors maximum speed is:" << processor->maxSpeed();
```

### Being notified of newly-added devices

The following gets us the device notifier, which can then be used as a signal to trigger something in our application:

```cpp
#include <Solid/Device>
#include <Solid/DeviceNotifier>
#include <Solid/DeviceInterface/StorageDrive>
// ...

auto notifier = Solid::DeviceNotifier::instance();

auto refresh = [this] (const QString &udi) {
    Solid::Device device(udi);
    if (device.is<Solid::StorageDrive>()) {
        qInfo() << "A new storage drive was added!";
    }
};

QObject::connect(notifier, &Solid::DeviceNotifier::deviceAdded, refresh);
```

### Network devices

Using [NetworkShare](https://api.kde.org/solid-networkshare.html), it is possible to fetch a network device type and run custom behavior for each one:

```cpp
const auto devices = Solid::Device::listFromType(Solid::DeviceInterface::NetworkShare);

for (const auto &device : devices) {
    switch (device.as<Solid::NetworkShare>()->type()) {
    case Solid::NetworkShare::Cifs:
        hasCifsShare = true;
        continue;
    case Solid::NetworkShare::Smb3:
        hasSmb3Share = true;
        continue;
    case Solid::NetworkShare::Nfs:
        hasNfsShare = true;
        continue;
    default:
        continue;
    }
}
```

### solid-hardware tool

Solid also provides `solid-hardware`, a command line tool to investigate available devices.

Listing udi for all installed devices:

```bash
solid-hardware6 list
```

Listing full details for all installed devices:

```bash
solid-hardware6 list details
```

Listing all battery devices:

```bash
solid-hardware6 query 'IS Battery'
```

The above query uses [Solid predicates]({{< ref "#predicates" >}}).

## Device Actions

When a new data device is inserted or detected by Solid, it gets added to the
"Disks & Devices" Plasma widget responsible for handling device
events, to [Dolphin](https://apps.kde.org/dolphin/)'s Places list, and other relevant areas in the user interface.

Each device has a set of related actions which the user can perform on the
device, depending on the device type and its contents. For example, when the
media is an audio CD, "Disks & Devices" may offer to play that CD using
a music player. The default actions are defined by a simple .desktop file that is installed by the
application that handles the action, and
goes away when the application is removed.

You can add your own actions and modify existing ones on Plasma by going to `System Settings` → `Disks & Cameras` → `Device Actions`; however, such changes are limited to the user that
requests the change. If you want to install a custom action along with your
application, you have to dig a bit deeper.

### Anatomy of an action

An Action is created with a desktop file under `~/.local/share/solid/actions` or `/usr/share/solid/actions` that includes an [additional application action](https://specifications.freedesktop.org/desktop-entry/latest/extra-actions.html) similar to the following one:

```ini
[Desktop Entry]
X-KDE-Solid-Predicate=OpticalDisc.availableContent & 'Audio'
Type=Service
Actions=Play;

[Desktop Action Play]
Name=Play Audio CD with Amarok
Name[fr]=Jouer CD Audio avec Amarok
# names in other languages
Icon=amarok
Exec=amarok --cdplay %f
```

Note that the value of the `Actions=` field should match the `Desktop Action` group.

### Actions and devices

"Disks & Devices" gets the devices and their corresponding actions by
interrogating the [hotplug Plasma DataEngine](https://invent.kde.org/plasma/plasma5support/-/tree/master/src/dataengines/hotplug).  The hotplug DataEngine
gets the set of devices from Solid and the set of actions from the
subdirectories `~/.local/share/solid/actions` or `/usr/share/solid/actions`. The set of actions
pertaining to each device is then obtained by evaluating the [Solid Predicate]({{< ref "#predicates" >}})
specified in the action against the physical and logical properties of the
device; if the conditions for the predicate match, the action is included. This is, of course, not
limited to Plasma Desktop: any application can similarly query Solid for
the same actions.

### Action predicates {#predicates}

The predicate for each action is specified in the entry
`X-KDE-Solid-Predicate`. The syntax of the predicate allows to construct an
object of class
[Solid::Predicate](https://api.kde.org/solid-predicate.html)
out of it.

Predicates can be of the form:
* `DeviceClass.attribute == value`
* `DeviceClass.attribute & value`

The latter form meaning that the Solid attribute may have a set of values, and
the specified value must be a part of that set. These values are available based on each device class.

For example, the predicate `OpticalDisc.availableContent & 'Audio'`
means that the device medium is a [Solid::OpticalDisc](https://api.kde.org/solid-opticaldisc.html) device and that it contains [ContentType](https://api.kde.org/solid-opticaldisc.html#ContentType-enum) of `Audio`
tracks and possibly something else, while the predicate
`OpticalDisc.availableContent == 'Audio'` means that a matching device
contains audio tracks and nothing else.

Predicates can be composed using the keywords `AND` and 
`OR` and parentheses.  In practice, it is easiest to create a custom
action with System Settings on Plasma and peek at the description from the custom
action desktop file (within the user profile directory).

### Executing actions

A matching action can be selected for execution by the user. When that
happens, the command line in the `Exec=` key of the action is executed given the
device as a parameter.  The location and value of the parameter is specified in
the following way:

* `%f` Device mount file path, if applicable
* `%d` Device special file path (like the path to a block device)
* `%i` Device identifier

So you are free to choose whatever command syntax your application supports.
Note, however, that the forms `%d` and `%i` are [deprecated by
the FreeDesktop spec](https://specifications.freedesktop.org/desktop-entry/latest/exec-variables.html) and may be discontinued.

### Installing actions

You install system-wide actions in the directory where the hotplug data
engine will look for them. This can be done using extra-cmake-modules [KDEInstallDirs](https://api.kde.org/ecm/kde-module/KDEInstallDirs6.html):

```cmake
install(FILES someSolidAction.desktop
    someSolidAction.desktop
    DESTINATION ${KDE_INSTALL_DATADIR}/solid/actions/)
```

The action is available immediately
after installation.
