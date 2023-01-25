---
title: Optimized Convergence
weight: 2
---


KDE's objective is to design optimized convergent software. 

**Optimized convergence** means that the application's
user interface can dynamically adapt its user experience to the
form factor of each type of device that it runs on. For example, desktop,
laptop, tablet, phone, TVs, etc.

For information regarding differences between user interface and user experience, see the [glossary]({{< relref "glossary" >}}).

Device Types
------------

The KDE HIG defines an optimal user experience for each device type, as
described in [device type]({{< relref "devicetypes" >}}).

Optimized convergence requires an understanding of the commonalities in the user interface. Convergence can be implemented by providing variations
of `the common UI components [architecture]({{< relref "architecture" >}}) which correspond with the optimal user experience for each device's usage model.

The same application can accommodate various form factors. The application can decide which forms to apply depending on available screen sizes.

Making Convergent Applications
------------------------------

The best way to create convergent applications is to follow the
recommendations and best practices from the KDE HIG, and build your app
using the Kirigami UI toolkit, which provides many of these patterns and
components \"out of the box\" so that they can be easily integrated.
