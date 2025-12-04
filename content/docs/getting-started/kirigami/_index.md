---
title: "Getting started with Kirigami"
linkTitle: "Kirigami"
weight: 2
layout: frontpage
groups:
  - name: "Setup"
    key: "setup"
  - name: "Introduction"
    key: "introduction"
  - name: "Style"
    key: "style"
  - name: "Components"
    key: "components"
  - name: "Advanced"
    key: "advanced"
  - name: "Manipulating data"
    key: "data"
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
functionality—should be written in a different language. We will also
explore how to integrate our business logic with our UI in the tutorials below.

First, you will need to set up a new project in a language of your choice. The introduction will show you how to make a small, but functional Kirigami application.

You will be shown the basics of how to deal with colors and text in your application, and you will get acquainted with most QML components. Next, you will get acquainted with most of the QML components you might want to use and how they look like. This section won't touch any business logic at all, only QML code.

You will get a deep dive into more advanced topics that concern manipulating the data that will be shown in your program.

Lastly, you will be presented with Kirigami Addons, a series of quality-of-life components that you can use to, among other things, design the Settings of your application.
