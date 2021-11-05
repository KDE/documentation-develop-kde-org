---
title: QML declarative plugin layer
description: KDE Telephony stack
weight: 4
SPDX-FileCopyrightText: 2021 Alexey Andreyev <aa13q@ya.ru>
SPDX-License-Identifier: CC-BY-SA-4.0
---

[kde-telephony-plugin-declarative](https://invent.kde.org/andreyev/kde-telephony-plugin-declarative) — `org.kde.telephony` QML plugin to work with the telephony daemon D-Bus interfaces.

The plugin provides QML interfaces to all the session-level D-BUS telephony daemon interfaces (See also: [D-Bus APIs of the session-side daemons](../session-daemon-userland-dbus-ipc-level#daemons))

There's no need to split it into several parts like Modem Daemon and KDE Telephony Daemon, since the plugin is not KDE-specific and could use any implementation that follows the appropriate XML D-Bus API description.

Work-in-Progress.

### Getting started

Minimal iteration could contain these packages:

+ **kde-telephony-meta** (D-Bus API descriptions)
+ **modem-daemon** (calls and history) — provides d-bus adaptor according to *kde-telephony-meta*
+ **kde-telephony-plugin-declarative** (QML plugin) — provides d-bus interface to *kde-telephony-meta*

After building these packages and running `/usr/lib/libexec/modem-daemon` via `/etc/xdg/autostart/org.kde.modem.daemon.desktop` you should be able to play with USSD via QML interfaces like this:

```sh
qml draft.qml
```

```qml
// ...
import QtQuick 2.15
import org.kde.telephony 1.0

Item {

    // ...

    Component.onCompleted: {
        const deviceUni =  DeviceUtils.deviceUniList()[0]
        const number = "*100#"
        UssdUtils.initiate(deviceUni, number)
    }

    Connections {
        target: UssdUtils

        function onNotificationReceived(deviceUni, message) {
            console.log(message)
        }

        function onRequestReceived(deviceUni, message) {
            console.log(message)
        }

        function onInitiated(deviceUni, command) {
            console.log("initiated")
        }
    }
}

```

The USSD is probably the simplest part of the API to start with. The same logic could also be found in the *plasma-dialer* project. Feel free to provide feedback via the issues list of the appropriate repositories.

### Future Work

In theory, it could be added to the Plasma Phone Components repo, since the current ModeManagerQt QML plugin is there right now.

After that, the next things could be ported to these plugins:

+ The part of the Plasma Phone Components called [mmplugin](https://invent.kde.org/plasma/plasma-phone-components/-/tree/master/mmplugin) could be ported to Modem Daemon (after it will be ready; when `SignalIndicator` API will be ported here).

+ The part of the [SpaceBar](https://invent.kde.org/plasma-mobile/spacebar) (SMS Application for Plasma Mobile):
    + Not related to KDE (MMQt-only) could be ported to Modem Daemon
    + Related to KDE (contacts and avatars) could be ported to KDE Telephony Daemon

As a result, any [KDE telephony-related application](../kde-application-layer) should be able to reuse the introduced Qt/QML declarative library.
