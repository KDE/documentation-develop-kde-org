---
title: System daemon
description: Userland D-Bus IPC, KDE Telephony stack
weight: 2
SPDX-FileCopyrightText: 2021 Alexey Andreyev <aa13q@ya.ru>
SPDX-License-Identifier: CC-BY-SA-4.0
aliases:
  - /docs/plasma-mobile/telephony/system-daemon-userland-dbus-ipc-level/
---

### General overview: oFono and ModemManager

Even if the modem device is accessible via the OS [kernel level](../kernel-layer), the device-specific messages should be handled on the user-land side. To unify the access across different devices and track the modem events, the daemon could be implemented on the user-land level. There're two similar open-source projects currently: oFono and ModemManager. Both are using D-Bus to provide IPC API.

Since its inception, Plasma Mobile has used the oFono stack for telephony functions (mobile data, calling, SMS).

With [Plasma Mobile Gear 21.10 release](https://www.plasma-mobile.org/blog/), we are transitioning our telephony stack to ModemManager.

Both oFono and ModemManager are popular frameworks for the Telephony stack.

#### ModemManager

[ModemManager](modem-manager) is a FreeDesktop project (started in 2008 with the goal of providing USB dongle support for desktops).
It integrates with the higher-level NetworkManager network management daemon.

It is currently used on Plasma Desktop and GNOME to provide support for USB modems, as well as on Phosh for telephony functions.

#### oFono

[oFono](ofono) is a Nokia/Intel project (started in 2009 with the Nokia N900).
It integrates with the higher-level ConnMan connection manager.

It is currently used by projects like Ubuntu Touch and Sailfish, which maintain their own series of patches on top of the stack in order for it to work for their use-cases.

#### Rationale

oFono and ModemManager share similar goals in providing unified API for accessing modem devices via DBus.
However, the pace of development has been slow upstream for oFono, with our usage depending on a series of patches in order to have it working.

ModemManager has generally been better in that regard, with active development and new devices being upstreamed. There's also the [eg25-manager](https://gitlab.com/mobian1/eg25-manager) project for the PinePhone's Quectel EG25 mobile broadband modem, which depends on ModemManager and provides support for low-power modes.

The main drawback of switching off oFono, is that it is the only option for Halium devices.
However, due to our recent decision to drop Halium support, this factor is no longer a constraint. (See also: [kernel layer paragraph of the documentation](../kernel-layer))

On mainlined devices such as the Pinephone and OnePlus 6, ModemManager has also proved to be much more reliable with handling the modem, with much more active development than oFono on that front.

Our goal is to provide the best possible experience on mainline Linux devices, and so using the ModemManager stack will allow us to deliver that for telephony functions.

This also allows us to use the same stack as on Plasma Desktop, allowing for better integration into Plasma and for applications like Dialer and SpaceBar to be used on it.

#### Status

We have completed our initial switch to ModemManager. 

However, the code has not been extensively tested, and so features and fixes will still be rolling out on each Plasma Mobile Gear release (monthly).

Meta-task for ModemManager switch: https://invent.kde.org/teams/plasma-mobile/issues/-/issues/62

### Conclusion

System daemon on the user-land level could be used to track modem events and provide unified access to different modem devices with different command lists.

Handling calls or messages history, managing contacts, and interacting with other parts of the user environment are out of the scope of any system-side telephony daemon. The D-Bus API is exported via system bus enabling [the session side](../session-daemon-userland-dbus-ipc-level) to handle it.
