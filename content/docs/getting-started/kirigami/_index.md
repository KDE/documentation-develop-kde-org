---
title: "Getting started with Kirigami"
linkTitle: "Kirigami"
weight: 2
layout: home
groups:
  - name: "Introduction"
    key: "introduction"
  - name: "Style"
    key: "style"
  - name: "Components"
    key: "components"
  - name: "Advanced"
    key: "advanced"
  - name: "Kirigami Addons"
    key: "addons"
description: >
  Learning to create your first applications using Kirigami
group: "getting-started"
aliases:
  - /docs/use/kirigami/
---

This tutorial will guide you through the process of creating your own convergent
application using the [Kirigami framework](/frameworks/kirigami). A *convergent
application*, in this context, means people can use the program easily
regardless of the device it is running on. If it is on a desktop computer, it
will adapt to a large screen and a mouse and keyboard; if it is being used on a
mobile device, it will accept input from a touchscreen and adapt to a smaller portrait
screen. And so on.

Kirigami is built on top of the QML language and Qt Quick Controls 2 components
provided by the Qt project. QML has built in support for touch systems, which
makes it ideal for mobile apps. Qt Quick components are reusable visual items we
can use when building our applications' interfaces. Kirigami is a set of Qt
Quick components designed for creating convergent applications.

While you will use QML to create the visual part of your application, the
business logic—the code that does the heavy lifting for your application's
functionality—is usually created in C++ for performance reasons. We will also
explore how to integrate our business logic with our UI in the tutorials below.
