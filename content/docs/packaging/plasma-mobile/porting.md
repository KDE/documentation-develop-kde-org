---
title: Porting a new device to Plasma Mobile
weight: 1
aliases:
  - /docs/plasma-mobile/porting
SPDX-FileCopyrightText: 2021 Carl Schwan <carlschwan@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
---

Plasma Mobile currently only supports device running a mainline
Linux kernel.

Many consumer mobile devices are Android only and do not work with the Linux kernel directly. [Android provides a Hardware abstraction layer](https://source.android.com/devices/architecture) on top of the Linux kernel. Even if the Linux kernel sources for the device are open, the Android environment is [Bionic](https://android.googlesource.com/platform/bionic.git/+/HEAD/docs) (not glibc or Musl) and HAL-specific, so Android drivers cannot be used in a general Linux kernel environment directly.

There are projects to support devices without mainline Linux. First of all, [libhybris](https://github.com/libhybris/libhybris) from Mer project and others. Project called [Halium](https://halium.org/) uses libhybris to provide a distro-agnostic Hardware Abstraction.

Previously Plasma Mobile also supported Halium devices (using Android kernel+userspace) but the support was dropped in favor of [focusing on the mainline device](https://www.plasma-mobile.org/2020/12/14/plasma-mobile-technical-debt/).

To port a device to mainline Linux, please refer to [Porting to a new device in postmarketOS wiki](https://wiki.postmarketos.org/wiki/Porting_to_a_new_device).

## See also

+ [Bionic (software) - Wikipedia](https://en.wikipedia.org/wiki/Bionic_(software))
+ [Hybris (software) - Wikipedia](https://en.wikipedia.org/wiki/Hybris_(software))
+ [Halium - Wikipedia](https://en.wikipedia.org/wiki/Halium)
+ [Hybris - postmarketOS](https://wiki.postmarketos.org/wiki/Hybris)
+ [Why will my phone not be updated to upcoming Android version?](https://medium.com/@tskho/why-my-phone-will-not-be-updated-to-upcoming-android-version-d6e4e9361287)
+ [In-Depth Capitulation of Why SD801 Devices Are Excluded from Nougat](https://www.xda-developers.com/in-depth-capitulation-of-why-msm8974-devices-are-excluded-from-nougat/)
