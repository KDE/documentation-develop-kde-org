---
title: Optimized Convergence
weight: 2
---


The design of KDE software, and by extension the KDE HIG, is made with
convergence in mind. *Convergence* means that a piece of software\'s
user interface can immediately adapt its user experience to the
particularities of each type of device that it can run on (desktop,
laptop, tablet, phone, etc).

For information regarding the differences between a user interface and
the user experience, see the [glossary](/hig/glossary).

Device Types
------------

The KDE HIG defines an optimal user experience for each device type, as
described in [device type](../devicetypes).

Convergence requires an understanding of the commonalities in the user
interface. Convergence can then be implemented by providing variations
of `the common UI components [architecture](../architecture) which
correspond with the optimal user experience for each device's usage model.

Making convergent applications
------------------------------

The best way to create convergent applications is to follow the
recommendations and best practices from the KDE HIG, and build your app
using the Kirigami UI toolkit, which provides many of these patterns and
components \"out of the box\" so that they can be easily integrated.
