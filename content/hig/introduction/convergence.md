---
title: Optimized Convergence
weight: 2
---


Convergence is very important for KDE software. *Convergence* means that a software\'s
user interface can adapt its user experience to fit each type of device that KDE software can run on (desktops,
laptops, tablets, phones, TVs, etc).

For information regarding the differences between a user interface and
the user experience, see the [glossary](/hig/resources/glossary).

Device Types
------------

The KDE HIG defines an optimal user experience for each device type, as
described in [device type](../devicetypes).

To achieve convergence, KDE software development requires an understanding of important commonalities in the user
interface. Once this is understood, KDE software should aim to keep looks and user experience similar in all devices. Convergence can then be implemented by providing variations
of `the common UI components [architecture](../architecture) which
correspond with the optimal user experience for each device's usage model.

NOTE
----
Please note that while KDE software aims to keep a convergent experience in all devices, this also means that some constraints are too great to keep an experience the same. Therefore, it is advisable that a customized experience is provided and convergence is used where posible.

Making Convergent Applications
------------------------------

The best way to create convergent applications is to follow the
recommendations and best practices from the KDE HIG, and build your app
using the Kirigami UI toolkit.

This UI toolkit provides many of these patterns and
components \"out of the box\" so that they can be easily integrated.
