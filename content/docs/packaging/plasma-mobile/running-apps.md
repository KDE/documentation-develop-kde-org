---
title: Execute applications
weight: 3
aliases:
  - /docs/plasma-mobile/running-apps
SPDX-FileCopyrightText: 2018 Jonah Brüchert <jbb.prv@gmx.de>
SPDX-License-Identifier: CC-BY-SA-4.0
---

This document describes the necessary environment variables and steps
for running and debugging applications in Plasma Mobile.

It is not necessary for end-users to set these. Applications can be
executed from the drawer easily, however this may be useful for
some development cases.

## Environment Setup

In order to run applications on the device, you need to set up your environment
similar to the environment in which the plasmashell is running:

```bash
export $(cat /proc/$(pidof plasmashell)/environ | tr '\0' '\n')
```

In case the plasmashell isn't running, you can use this environment
setup as a replacement:

```bash
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=KDE
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export XDG_CURRENT_DESKTOP=KDE
export KSCREEN_BACKEND=QScreen
export KDE_FULL_SESSION=1
export KDE_SESSION_VERSION=5
```

## Manually starting the Plasma shell (or applications)

If you want to run the Plasma phone shell, do:

```bash
export $(dbus-launch)
exec /usr/bin/plasmashell -p org.kde.plasma.phoneshell
```

## Forcing an UI type per-application

If you'd like to force an application to launch with its desktop user interface (if it offers one) rather than the mobile one, do:

```bash
QT_QUICK_CONTROLS_MOBILE=false $program_to_run
```

The inverse also works; If you wish to run an application on a desktop system with its mobile interface, simply set the above variable to true instead.
