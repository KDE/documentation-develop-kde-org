---
title: Ofono Telephony functions
SPDX-FileCopyrightText: 2021 Jonah Brüchert <jbb.mail@gmx.de>
SPDX-License-Identifier: CC-BY-SA-4.0
---

Plasma Mobile uses ofono to communicate with telephony hardware. Ofono
allows to make calls, send and receive sms and use the mobile broadband
network.

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


