---
title: Developing Telephony functionality
SPDX-FileCopyrightText: 2024 Jonah Brüchert <jbb@kaidan.im>
SPDX-License-Identifier: CC-BY-SA-4.0
aliases:
  - /docs/plasma-mobile/telephony/system-daemon-userland-dbus-ipc-level/modem-manager/
---

Plasma Mobile uses ModemManager as telephony stack.
However, there is a very useful debugging tool for the competing telephony stack, oFono.
This page describes how to use it for development of Plasma Mobile telephony features.

## Phonesim

Phonesim will add a fake phone modem that can be controlled via a Qt
based user interface.
This interface makes it possible to test various aspects
of the phone UI: making calls, receiving, signal strength, send SMS and so
on.

The current stable release of phonesim is still based on Qt5.
On most distributions, you need to compile it yourself from the [source code](https://git.kernel.org/pub/scm/network/ofono/phonesim.git). If you need a Qt6 based version, you currently have to resort to [this fork](https://invent.kde.org/jbbgameich/ofono-phonesim/-/tree/qt6).
In some cases, you might be able to install ofono-phonesim from your distribution’s repository.

To set up ofono-phonesim for development:
* Install oFono
* Edit `/etc/ofono/phonesim.conf`, and uncomment everything so that it looks like

```ini
[phonesim]
Address=127.0.0.1
Port=12345
```

* Start ofonod (`systemctl start ofono`)
* Start phonesim
  ```bash
  ./src/phonesim -gui -p 12345 ../src/default.xml
  ```

  A bit surprisingly, at first nothing will happen. That is fine, since the UI will
only be displayed once the virtual modem is activated.

* From the [oFono source directory](https://git.kernel.org/pub/scm/network/ofono/ofono.git), call `./test/enable-modem` to bring the modem up, the
  control UI should come up
* Call `./test/online-modem` to activate the test phonesim modem
* Install the `phonesim` branch of this [oFono2MM](https://github.com/jbruechert/oFono2MM/tree/phonesim) fork, until it is merged [upstream](https://github.com/droidian/oFono2MM).

  Then reload the available systemd services `systemctl daemon-reload` and restart ModemManager `systemctl restart ModemManager`).
  The running ModemManager will now be the fake oFono based implementation.

  If you need to restore the normal ModemManager later, delete `/usr/lib/systemd/system/ModemManager.service.d/10-ofono2mm.conf`

You should now be able to receive SMS in Spacebar. Make sure to start `spacebar-daemon` before `spacebar`.