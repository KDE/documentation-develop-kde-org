---
title: oFono Telephony functions
SPDX-FileCopyrightText: 2021 Jonah Brüchert <jbb.mail@gmx.de>
SPDX-License-Identifier: CC-BY-SA-4.0
---

Plasma Mobile uses oFono to communicate with telephony hardware. oFono
allows to make calls, send and receive sms and use the mobile broadband
network.

## Poring from oFono to ModemManager

[Both](https://lists.ofono.org/hyperkitty/list/ofono@ofono.org/thread/OMC2GMOHMWXYNQOOSBKQH5VVIE4HVBXD/?sort=date) oFono and ModemManager are popular frameworks for the Telephony stack.

### ModemManager
[ModemManager](https://www.freedesktop.org/wiki/Software/ModemManager/) is a _GPL-2.0-or-later & LGPL-2.1-or-later_ FreeDesktop project [stated in the year 2008 with customer USB dongles support for the desktops](https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/commits/0.2.997/plugins). It integrates with the higher-level [NetworkManager](https://gitlab.freedesktop.org/NetworkManager/NetworkManager) network management daemon.

### oFono
[oFono](https://01.org/ofono) is a _GPL-2.0-only_ Nokia/Intel project [started in the year 2009 with mobile devices support like Nokia N900's Phonet/ISI](https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/drivers/isimodem/isimodem.c?h=0.1&id=bc42f6ab5939034e5b010acf55de6b1c4daa1d6f). It integrates with the higher-level [ConnMan](https://git.kernel.org/pub/scm/network/connman/connman.git/about/) connection manager.

### Plasma Mobile Status

So oFono and ModemManager are sharing similar goals to provide unified userland access to the different modem devices via D-Bus IPC interfaces.

Plasma Mobile is currently [in transition from oFono to ModemManager](https://invent.kde.org/teams/plasma-mobile/issues/-/issues/62). The motivation is related to the [eg25-manager](https://gitlab.com/mobian1/devices/eg25-manager) project for the PinePhone's Quectel EG25 mobile broadband modem. Since eg25-manager depends on ModemManager.

So, the current documentation page is going to be archived after finishing the porting to ModemManager. 

### Relations with Telepathy IM

[Telepathy IM](https://github.com/TelepathyIM/wiki/wiki) is a FreeDesktop project supported by Nokia and Collabora. It's a framework to build instant messaging client applications with interoperability via D-Bus IPC. It could use oFono or ModemManager to implement calls and messaging clients. oFono integration is [already implemented](https://github.com/TelepathyIM/telepathy-qt/wiki/Connection-Managers#gsm).

Telepathy IM is currently having the contributors flaw. Telepathy project roots are from the [good](https://translate.yandex.ru/translate?url=https%3A%2F%2Fhabr.com%2Fru%2Fpost%2F171325%2F&lang=ru-en)-[old](https://en.wikipedia.org/wiki/Peter_principle)-days of the Nokia N900/N9 Linux devices and [Collabora](https://mail.gnome.org/archives/desktop-devel-list/2017-September/msg00047.html) team development. A lot of contributors are needed to support such a level of standardization. Right now we have [Kaffeine](https://matrix.to/#/@kaffeine:matrix.org) maintainer who has “picked up the flag” and few other project sympathizers. It’s the well-known chicken-or-the-egg problem that could be solved step-by-step though. The main weak point of the spec is probably [service-side history](https://github.com/TelepathyIM/wiki/wiki/Specification-TODO-list#service-side-history).

So, the current dialer client implementation is going to be based on the ModemManager without higher-level TelepathyIM usage, while it still could be interesting to have an IM client solution with interoperability in the long-distant future. 

## Phonesim

Phonesim will add a fake phone modem, that can be controlled via a Qt
based user interface from which it will be possible to test various aspects
of the phone UI: making calls, receiving, signal strength, send SMS and so
on. It will not generate any real call, but only make the UI think a SIM is
working and that a phone call is in progress.

The current stable release of phonesim is still based on Qt4, therefore we
recommend compiling the [Qt5 based git master branch](https://git.kernel.org/pub/scm/network/ofono/phonesim.git).
In some cases, you might be able to install ofono-phonesim from your
distribution’s repository.

To set up ofono-phonesim for development:

* Edit `/etc/ofono/phonesim.conf`, uncomment everything so that it looks like

```ini
[phonesim]
Address=127.0.0.1
Port=12345
```

* Start ofonod as root
* Start phonesim

  Please note that the binary may be called ofono-phonesim in some distributions.

  ```bash
  phonesim -p 12345 -gui /usr/share/phonesim/default.xml
  ```

  A bit surprisingly, at first nothing will happen. That is fine, since the UI will
only be displayed once the virtual modem is activated.

* From the oFono source directory, call ./test/enable-modem to bring the modem up, the
  control UI should come up
* Call `./test/online-modem` to activate the test phonesim modem

## On an actual device

Ofono can be controlled (for development purposes), using scripts located in `/usr/share/ofono/scripts/`.
