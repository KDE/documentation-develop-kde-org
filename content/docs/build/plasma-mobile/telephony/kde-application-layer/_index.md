---
title: KDE application layer
description: KDE Telephony stack
weight: 5
aliases:
  - /docs/plasma-mobile/telephony/kde-application-layer/

SPDX-FileCopyrightText: 2021 Alexey Andreyev <aa13q@ya.ru>
SPDX-License-Identifier: CC-BY-SA-4.0
---

The list of Plasma Mobile applications related to telephony.

## Applications

Client GUI Applications related to telephony. Right now they are using ModemManagerQt directly, since initiated with Plasma Dialer repository split is a work in progress.

### Plasma Dialer

[plasma-dialer](https://invent.kde.org/plasma-mobile/plasma-dialer/-/tree/master/plasma-dialer) — Dialer for Plasma Mobile.

Similar projects:

+ [KDE Maui: Communicator](https://invent.kde.org/maui/communicator)
+ [UBports: Dialer App](https://github.com/ubports/dialer-app)
+ [Nemo Mobile: Glacier Dialer](https://github.com/nemomobile-ux/glacier-dialer)
+ [GNOME Calls](https://gitlab.gnome.org/GNOME/calls)
+ [sxmo: mmcli scripts](https://git.sr.ht/~mil/sxmo-utils/tree/master/item/scripts/modem)

### Spacebar

[spacebar](https://invent.kde.org/plasma-mobile/spacebar/) — SMS/MMS Application for Plasma Mobile.

Currently uses [ModemManagerQt directly](https://invent.kde.org/plasma-mobile/spacebar/-/merge_requests/48).

Similar projects:

+ [UBports: Messaging App](https://github.com/ubports/messaging-app)
+ [Nemo Mobile: Glacier Messages](https://github.com/nemomobile-ux/glacier-messages)
+ [Librem5: Chatty](https://source.puri.sm/Librem5/chatty)
+ [sxmo: mmcli scripts](https://git.sr.ht/~mil/sxmo-utils/tree/master/item/scripts/modem)

### Plasma Settings App

[plasma-sessings](https://invent.kde.org/plasma-mobile/plasma-settings) — Settings application for Plasma Mobile. Provide options to select networks, modes, APNs.

Currently uses [ModemManagerQt directly](https://invent.kde.org/plasma-mobile/plasma-settings/-/merge_requests/92).

## Other

Not applications technically, but also related to the GUI client-side

### Plasma Phone Components

[plasma-phone-components](https://invent.kde.org/plasma/plasma-phone-components) — General UI components for Plasma Phone including shell, containment, and applets. Shell displays a signal strength indicator.

Currently uses [ModemManagerQt directly](https://invent.kde.org/plasma/plasma-phone-components/-/merge_requests/176).

Similar projects:

+ [GNOME Phosh](https://gitlab.gnome.org/World/Phosh/phosh/-/tree/main/src/wwan)

### Plasma Network Manager Applet

[plasma-nm](https://invent.kde.org/plasma/plasma-nm) — Plasma applet is written in QML for managing network connections. Provides SIM unlocking PIN dialog.

Currently uses [ModemManagerQt directly](https://invent.kde.org/plasma/plasma-nm/-/merge_requests/66).

Similar projects:

+ [GNOME Settings Daemon](https://gitlab.gnome.org/GNOME/gnome-settings-daemon)

