---
title: Solid
linkTitle: Solid
weight: 10
group: "features"
description: >
    Hardware abstraction
---

## Introduction

With Solid, KDE developers are able to easily write applications with hardware
interaction features. The necessary abstraction to support cross-platform
application development is provided by Solid's clear and comprehensive API.

Its aim is not the control of the devices (Solid doesn't let you synchronize
your mobile phone with your local address book): Solid looks for devices and
gives you access to the information it has about them. This way, you could
easily look at the functions of the cpu, or at the driver that handles your
camera, or the mount point of your usb pen. In sum: it gives you the
possibility of "seeing without touching" your devices.

Now you would ask (at least, I asked myself): "Why should I need this library?
I want to control the available hardware, not just see it!"

Well, Solid helps you a lot again: for any device interface, it gives you
enough information to easily access it using other libraries or stacks. This
way, if you want to manage your camera, you can use Solid to recognize it (you
can use Solid::Notifier that will let you know when your camera has been
plugged in), and then you can ask Solid to give you the information you need to
handle it, for example with GPhoto or any other library you can think of. The
same applies for any other plugged device: DVB cards (once recognized, Solid
gives you the name of the associated device), audio cards (you can use ALSA,
OSS or whatever you want: Solid knows the data to access it), portable media
players, network cards, et cetera. Moreover, it lets you check if you're
connected to any network or not, and you can use Solid to tell the system to
connect (that is, you can ask Solid: "Give me access to the network, I don't
want to care about details").

Anyway, some other things need to be said about network devices and Bluetooth.
For these two classes of devices, Solid provides the "Control" namespace: that
is, it lets you control them directly, without using external libraries. This
means that with Solid, you can even handle your wireless or wired network
interfaces, associate them to an essid, and choose ip configuration for them.
You can even access your phone through Bluetooth, and so on.

## Device Discovery

### Listing Devices

Our first program will be a simple console based app that gets a list of all
the hardware devices and prints them out to the screen.

```cpp
auto notifier = Solid::DeviceNotifier::instance();
```

This gets us the device manager. All the devices are queried through and
returned from the device manager. Once we have the list of devices we can
interact with them as follows:

```cpp
for(const Solid::Device &device : Solid::Device::allDevices()) {
    // print the name of device
    qDebug() << device.udi();
}
```

`device.udi()` returns the Unique Device Identifier for the device as a QString.
Even if you have more than one identical device, the UDI is guaranteed to be
unique. For example if you have a MythTV box with two PVR-250 T.V. capture
cards in it, you will be able to refer to card #1 and #2 by their respective
UDI.

### Searching for specific devices

This second program makes uses of filters built into the solid framework. Using
these filters you can list only devices according to supported capabilities,
sub-devices of a given parent, and various predicates. In our example we'll be
limiting our list to only audio hardware. A full list of capabilities can be
viewed under the Solid::Capability namespace.

```cpp
auto notifier = Solid::DeviceNotifier::instance();
    
// get a list of all devices that are AudioHw
const auto devices = Solid::Device::listFromType(Solid::DeviceInterface::AudioInterface, QString());
for (const Solid::Device &device : devices)
{
   qDebug() << device.udi().toLatin1().constData();
}
```

In this example `Solid::DeviceManager::findDevicesFromQuery` looks for a device
with any parent and the `Solid::Capability::AudioHw` capability. If we had
wanted to specify an AudioHw device with the parent "real_specific_parent" it
would look like this:

```cpp
Solid::Device::listFromType(Solid::Capability::AudioHw, QStringLiteral("real_specific_parent"));
```

### From QML

You can also access the list of devices from QML.

```qml
Solid.Devices {
    id: allDevices
}
 
Solid.Devices {
    id: networkShares
    query: "IS NetworkShare"
}
 
Solid.Devices {
    id: mice
    query: "PointingDevice.type == 'Mouse'"
}
 
Text {
    text: "Total number of devices: " + allDevices.count
}
 
Text {
    text: "NFS url: " + networkShares.device(
        networkShares.devices[0], "NetworkShare"
    ).url
}
```

### What do we do with a device once we get it?

Now that we got a device, what do we do with it? First let's look at the
relationship between the Solid::Device and Solid::Capability. A Solid::Device
can contain many Solid::Capability. A device can be tested to have a capability
in the following way:

```cpp
auto notifier = Solid::DeviceNotifier::instance();

// get a Processor
const auto list = Solid::Device::listFromType(Solid::DeviceInterface::Processor, QString());

// take the first processor
Solid::Device device = list[0];
if (device.is<Solid::Processor>()) {
    qDebug() << "We've got a processor!";
} else {
    qDebug() << "Device is not a processor.";
}

auto processor = device.as<Solid::Processor>();
qDebug() << "This processors maximum speed is:" << processor->maxSpeed();
```

### solid-hardware tool

Solid also provides solid-hardware, a command line tool to investigate available devices.

Listing udi for all installed devices:

```bash
solid-hardware5 list
```

Listing full details for all installed devices:

```bash
solid-hardware5 list details
```

Listing all audio hardware devices:

```bash
solid-hardware5 query 'IS AudioInterface'
```

## Device Actions

When a new data device is inserted or detected by Solid, it gets added to the
Device Notifier (a Plasma widget that is responsible for handling device
events), Places list and other relevant areas in the user interface.

Each device has a set of related actions which the user can perform on the
device, depending on the device type and its contents. For example, when the
media is an audio CD, the Device Notifier may offer to play that CD using
Amarok. The default actions are not a part of Plasma Desktop, however; rather,
each action is defined by a simple .desktop file that is installed by the
application that handles the action (e.g. Amarok in our Audio CD example), and
goes away when the application is removed.

You can add your own actions and modify existing ones using the Device Actions
system setting module; however, such changes are limited to the user that
requests the change. If you want to install a custom action along with your
application, you have to dig a bit deeper.

### Anatomy of an action

An Action file is a desktop configuration file similar to the following one:

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

### Actions and devices

The **Device Notifier** gets the devices and their corresponding actions by
interrogating the _hotplug_ Plasma DataEngine.  The _hotplug_ DataEngine
gets the set of devices from **Solid** and the set of actions from the
subdirectories `~/.local/share/solid/actions` relative. The set of actions
pertaining to each device is then obtained by evaluating the Solid Predicate
specified in the action against the physical and logical properties of the
device; if the predicate holds, the action is included. This is, of course, not
limited to Plasma Desktop: any application can similarly query **Solid** for
the same actions.

### Action predicates

The predicate for each action is specified in the entry
`X-KDE-Solid-Predicate`. The syntax of the predicate allows to construct an
object of class
[Solid::Predicate](https://api.kde.org/frameworks/solid/html/classSolid_1_1Predicate.html)
out of it.

Atomic predicates can be of the form
* `DeviceClass.attribute == value`
* `DeviceClass.attribute & value`

the latter form meaning that the Solid attribute may have a set of values, and
the specified value must be a part of that set.  

For example, the predicate `OpticalDisc.availableContent & 'Audio'`
means that the device medium is an optical disc and that it contains audio
tracks and possibly something else, while the hypothetical predicate
`OpticalDisc.availableContent == 'Audio'` means that a matching device
contains audio tracks and nothing else.

Atomic predicates can be composed using the keywords `AND` and 
`OR` and parentheses.  In practice, it is easiest to create a custom
action with **System Settings** and peek the description from the custom
action desktop file (within the user profile directory).

## Executing actions

A matching action can be selected for execution by the user.  When that
happens, the command line in the Exec key of the action is executed given the
device as a parameter.  The location and value of the parameter is specified in
the following way:

* `%f` Device mount point location, if applicable
* `%d` Device special file path
* `%i` Device identifier, as if returned by the command `solid-hardware`

So you are free to choose whatever command syntax your application supports.
Note, however, that the forms `%d` and `%i` are deprecated by
the Free Desktop standard and may be discontinued.

## Installing actions

You install system-wide actions in the directory where the **hotplug** data
engine will look for them (see above). The action is available immediately
after installation.
