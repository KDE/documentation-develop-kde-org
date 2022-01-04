---
title: ModemManager Telephony functions
SPDX-FileCopyrightText: 2021 Alexey Andreyev <aa13q@ya.ru>
SPDX-License-Identifier: CC-BY-SA-4.0
aliases:
  - /docs/plasma-mobile/telephony/system-daemon-userland-dbus-ipc-level/modem-manager/
---

[ModemManager](https://www.freedesktop.org/wiki/Software/ModemManager/) is a _GPL-2.0-or-later & LGPL-2.1-or-later_ FreeDesktop project [stated in the year 2008 with customer USB dongles support for the desktops](https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/commits/0.2.997/plugins). It integrates with the higher-level [NetworkManager](https://gitlab.freedesktop.org/NetworkManager/NetworkManager) network management daemon.

## fakemodem

ModemManager is currently lacking a manual testing tool similar to [oFono Phonesim](../ofono#phonesim). Phonesim support could probably be implemented on the ModemManager or ModemManagerQt side if needed.

For [unit testing](https://invent.kde.org/frameworks/modemmanager-qt/-/tree/master/autotests) ModemManagerQt provides [fakemodem backend](https://invent.kde.org/frameworks/modemmanager-qt/-/tree/master/src/fakemodem).