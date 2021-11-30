---
title: Session Daemons
description: Userland D-Bus IPC, KDE Telephony stack
weight: 3
SPDX-FileCopyrightText: 2021 Alexey Andreyev <aa13q@ya.ru>
SPDX-License-Identifier: CC-BY-SA-4.0
---

ModemManager (or oFono previously) [provides](../system-daemon-userland-dbus-ipc-level) unified access to different modem devices with different command lists via system D-Bus IPC.

The tasks of the session side daemons are (but not limited to):

+ Handle calls and messages
+ Provide calls and messages history
+ Provide contacts PIM mapping
+ Power management
+ Notifications
+ Interacting with other parts of the user environment
+ Filter spam

### Worth mentioning dependencies

#### eg25-manager

[eg25-manager](https://gitlab.com/mobian1/devices/eg25-manager) is a daemon to handle low-power modes of the Quectel EG25 via ModemManager. It's used for the Pinephone.

#### kop316 projects

+ [SMS/MMS Daemon](https://gitlab.com/kop316/mmsd)
+ [Visual Voicemail Daemon](https://gitlab.com/kop316/vvmd)

Both projects are developed for Phosh but are [environment-agnostic](https://gitlab.com/kop316/vvmd/-/issues/5). They could be used directly via session-level D-Bus API to implement a Qt/QML library.

If not, at least the D-Bus scheme could be shared among both GNOME and KDE via Freedesktop project. And re-implemented in Qt after that if needed (for example, at _modem-daemon_ repository described below). The described approach will provide interoperability on the GUI application level.

#### ModemManagerQt

[ModemManagerQt](https://invent.kde.org/frameworks/modemmanager-qt) is a Qt wrapper for ModemManager DBus API.

#### KDE Telephony Meta

[kde-telephony-meta](https://invent.kde.org/plasma-mobile/plasma-dialer/-/tree/master/kde-telephony-meta/) is KDE Telephony shared data:

+ D-Bus XML Interface descriptions
+ ready to reuse Qt meta types for complex D-Bus types as a header or a static library

### Daemons

#### Modem Daemon

[modem-daemon](https://invent.kde.org/plasma-mobile/plasma-dialer/-/tree/master/modem-daemon) is a daemon for background tracking the modem events to:

+ Provide access to calls for client applications and daemons via D-Bus session level
+ Save the history

The daemon is written in Qt. It is similar to kop316 projects. It's working with the system D-Bus and provides session D-Bus API for applications. It's ModemManagerQt-first, but provides higher-level API so any possible manager switching should be transparent for the application level. 

It's not KDE specific (just Qt) and could be used directly in projects like [Nemo Mobile](https://nemomobile.net/) or even [GNOME Phosh](https://gitlab.gnome.org/World/Phosh/phosh).

Work-in-Progress.

#### KDE Telephony Daemon

[kde-telephony-daemon](https://invent.kde.org/plasma-mobile/plasma-dialer/-/tree/master/kde-telephony-daemon) is a daemon for background tracking the modem events to:

+ Enable audio channels when needed
+ Show notifications
+ Automatically launch dialer GUI
+ Share KDE-related Telephony services via session DBus

It is KDE-specific and depends on _Modem Daemon_. It's not ModemManagerQt specific. Could also depend on such KF5 libraries as People, Notifications, I18n. Contains _contactphonenumbermapper_ — a library to work with KDE KPeople and Google phonenumber libraries.

Work-in-Progress.

### Relations with Telepathy IM

[Telepathy IM](https://github.com/TelepathyIM/wiki/wiki) is a FreeDesktop project supported by Nokia and Collabora. It's a framework to build instant messaging client applications with interoperability via D-Bus IPC. It could use oFono or ModemManager to implement calls and messaging clients. oFono integration is [already implemented](https://github.com/TelepathyIM/telepathy-qt/wiki/Connection-Managers#gsm).

Telepathy IM could cover both telephony daemons in theory. The project is currently having the contributors' flaws. Telepathy project roots are from the [good](https://translate.yandex.ru/translate?url=https%3A%2F%2Fhabr.com%2Fru%2Fpost%2F171325%2F&lang=ru-en)-[old](https://en.wikipedia.org/wiki/Peter_principle) days of the Nokia N900/N9 Linux devices and [Collabora](https://mail.gnome.org/archives/desktop-devel-list/2017-September/msg00047.html) team development. A lot of contributors are needed to support such a level of standardization. Right now we have [Kaffeine](https://matrix.to/#/@kaffeine:matrix.org) maintainer who has “picked up the flag” and a few other project sympathizers. It’s the well-known chicken-or-the-egg problem that could be solved step-by-step though. The main weak point of the spec is probably [service-side history](https://github.com/TelepathyIM/wiki/wiki/Specification-TODO-list#service-side-history).

So, the current dialer client implementation is going to be based on the ModemManager without higher-level TelepathyIM usage, while it still could be interesting to have an IM client solution with interoperability in the long-distant future.

### Conclusion

Session daemons on the user-land level could be used to interact with other parts of the user environment and provide a unified API for GUI applications.

To provide actual developer libraries (environment- and language-specific) is out of the scope for any session-side telephony daemon. The D-Bus API exported via session bus enabling [QML declarative plugin as library side](../qml-declarative-plugin-layer) to handle it.