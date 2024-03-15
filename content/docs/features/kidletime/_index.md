---
title: KIdleTime
description: Detect and handle system idling
weight: 6
group: "features"
SPDX-License-Identifier: CC-BY-SA-4.0
SPDX-FileCopyrightText: 2014 Andreas Cord-Landwehr <cordlandwehr@kde.org>
aliases:
  - /docs/kidletime/
---

KIdleTime is a helper framework to get reporting information on idle time of the system. It is useful not only for finding out about the current idle time of the system, but also for getting
notified upon idle time events, such as custom timeouts or user activity. It features:

* current idling time
* timeout notifications, to be emitted if the system idled for a specified time
* activity notifications, if the user resumes acting after an idling period

## Using It

To understand how to use KIdleTime, we will create a small testing application, called "KIdleTest". This application initially waits for the first user action and afterwards registers some timeout intervals, acting whenever the system idles for such a time. The framework includes the singleton KIdleTime, which provides all necessary signals and information about the idling status of the system. For our example, we start by connecting to the signals for user resuming from idling and for reaching timeouts that we will set ourselves:

{{< snippet repo="frameworks/kidletime" file="examples/KIdleTest.cpp" part="initialize" lang="cpp" >}}

We also tell KIdleTime to notify us the very next time when the user acts. Note that this is actually only for the next time. If we were interested in further events, we would need to invoke `catchNextResumeEvent()` again.

Next, in our event listener for the user resume event, we register a couple of idle intervals:

{{< snippet repo="frameworks/kidletime" file="examples/KIdleTest.cpp" part="resumeEvent" lang="cpp" >}}

If any of these idle intervals is reached, our initially registered `timeoutReached(...)` slot is invoked and we print out an appropriate message.

{{< snippet repo="frameworks/kidletime" file="examples/KIdleTest.cpp" part="timeoutReached" lang="cpp" >}}

From then on, depending on the reached idle interval, we can go back to one of the former steps.


