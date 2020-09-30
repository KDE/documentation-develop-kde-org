---
title: "Getting started with Kirigami"
linkTitle: "Kirigami"
weight: 2
description: >
  Learn the Kirigami framework by creating your first convergent application
group: "getting-started"
---

In today's world, there are many types of digital devices: desktop and laptop
computers, smartphones, tablets, and so on. A harmonious and efficient user
experience is only possible when the software's user interface is tailored to
each device's physical characteristics and the way that a user will interact
with it.

Some devices are adaptable, e.g. a tablet with a keyboard plugged in, or a
convertible laptop with only the touchscreen in use. These types of devices
will require the user interface to adapt as necessary for each usage mode.
If minimal changes are needed (for example, a laptop plugged into a large
external screen) this can be achieved with a "responsive" design, as described
in [responsiveness](https://hig.kde.org/introduction/responsive.html) in the HIG.
For more extensive changes (for example, a tablet plugged into a docking
station with a mouse and keyboard attached), an entirely different user
interface paradigm may need to be presented.

The design of KDE software, and by extension the Kirigami Framework, is made
with convergence in mind. *Convergence* means that a piece of software's user
interface can immediately adapt its user experience to the particularities of
each type of device that it can run on (desktop, laptop, tablet, phone, etc).

This tutorial will guide you into creating your own convergent application
using the [Kirigami framework](/frameworks/kirigami). 

Kirigami is build on top of the QML language provided by the Qt project and Qt Quick
Controls 2 components. QML is the declarative UI language from the Qt project
and unlike the older QWidgets it is designed with (embedded) touch systems in
mind and thus is ideal for mobile apps.

Kirigami is a set of QtQuick components designed for creating convergent
appslications.

While the ui code is done in QML in a declarative way, the buissness logic
is usually created in C++ for performance reasons.

