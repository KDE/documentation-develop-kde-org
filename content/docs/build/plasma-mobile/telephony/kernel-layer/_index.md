---
title: Kernel layer
description: KDE Telephony stack
weight: 1
SPDX-FileCopyrightText: 2021 Alexey Andreyev <aa13q@ya.ru>
SPDX-License-Identifier: CC-BY-SA-4.0
aliases:
  - /docs/plasma-mobile/telephony/kernel-layer/
---

While the kernel side is not a scope of the KDE project, it could be helpful to get a general overview to support the higher levels of the KDE Telephony stack.

Plasma Mobile currently only supports devices running a mainline Linux kernel. (See also: [Porting a new device to Plasma Mobile](../../porting)).

Mobile devices have a component called the WWAN modem. If the system is modular, the modem is still a distinct submodule: typically either soldered to the board or mounted in an mPCIe slot where it uses just the embedded USB bus and power. In modern proprietary phone SoCs, the modem is a couple of chips rather than a distinct module and may use other interfaces: in not a few smartphone SoCs part of the modem has been a processor core on the same die as the application processor, communicating via proprietary on-chip-interfaces and shared memory.

Among other details (like USB or voice-related stack support), the OS kernel should also have appropriate logic implemented to support protocols of the Radio Interface Layer (RIL). Depending on the manufacturer of the modem, it could be a serial (TTY) interface (legacy mode with AT commands), or some modern protocols (like MBIM or QRTR with QMI commands), or some other.

For example, the [Pinephone devices](https://wiki.pine64.org/index.php/PinePhone) has a Quectel EG-25 modem connected to the main ARM SoC via USB. The modem could be accessed [with QMI commands via USB](https://github.com/torvalds/linux/blob/master/drivers/net/usb/qmi_wwan.c) thanks to the support of the mainlined Linux kernel.

[Mainlined SDM845 smartphones](https://wiki.postmarketos.org/wiki/SDM845_Mainlining) like OnePlus 6 have a modem exposed as a remote processor of the SoC and also working [with QMI](https://github.com/torvalds/linux/blob/master/drivers/soc/qcom/Kconfig) via [QRTR](https://github.com/torvalds/linux/blob/master/net/qrtr/Kconfig) interface and supported on the kernel level.

Handling a protocol like QMI is out of the scope for any kernel driver. It is exported as a character device enabling [the userland side](../system-daemon-userland-dbus-ipc-level) to handle it.

### See also

+ [Wireless WAN - Wikipedia](https://en.wikipedia.org/wiki/Wireless_WAN)
+ [Radio Interface Layer - Wikipedia](https://en.wikipedia.org/wiki/Radio_Interface_Layer)
+ [Qualcomm MSM Interface - Wikipedia](https://en.wikipedia.org/wiki/Qualcomm_MSM_Interface)
+ [raspbian - Difference between PPP, QMI and AT commands - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/523321/difference-between-ppp-qmi-and-at-commands)
+ [Cellular module(4G/3G/GSM) interface to host processor or microcontroller through UART how the data rate is achieved? - Electrical Engineering Stack Exchange](https://electronics.stackexchange.com/questions/510392/cellular-module4g-3g-gsm-interface-to-host-processor-or-microcontroller-throug)
+ [Upstreaming support for Qualcomm PCIe modems - Linaro](https://www.linaro.org/blog/upstreaming-support-for-qualcomm-pcie-modems/)
+ [what open source software use qrtr? (#45) · Issues · Mobile broadband connectivity / libqmi · GitLab](https://gitlab.freedesktop.org/mobile-broadband/libqmi/-/issues/45)