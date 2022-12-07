---
title: "KDE on Android"
linkTitle: "Android"
weight: 2
description: >
  Learn how to port your applications to the most widely used mobile platform
---

## Abstract

Android is currently the largest mobile platform regarding market share and number of application, so supporting it is an excellent opportunity for gaining many users for our applications.

Qt supports building for Android, as do many of the [KDE frameworks](https://api.kde.org). Using this foundation, there is a good chance an application will be buildable for android. The usability of the application depends on different factors. As a general rule of thumb, applications using QtWidgets do not work well on Android, since their user interfaces are not well-suited for smaller screens. For applications developed using QML, the quality depends on how well the user interface adapts to different screen sizes. Ideally, the application uses Kirigami, which enables user interfaces that adapt well to different form-factors.

## Contact

For questions and discussion around KDE software on Android join our [Matrix channel](https://matrix.to/#/%23kde-android:kde.org) and [mailing list](https://mail.kde.org/mailman/listinfo/kde-android).

## Getting Applications

Stable releases of our Android apps are available on [Google Play](https://play.google.com/store/apps/dev?id=4758894585905287660) and [F-Droid](https://f-droid.org/).

Nightly builds can be downloaded either from the [Binary Factory](https://binary-factory.kde.org) or from KDE's [F-Droid repo](https://cdn.kde.org/android/fdroid/repo/?fingerprint=B3EBE10AFA6C5C400379B34473E843D686C61AE6AD33F423C98AF903F056523F).

## Releasing Application

Every android application built on KDE's [Binary Factory](https://binary-factory.kde.org) is released in KDE's [F-Droid repo](https://cdn.kde.org/android/fdroid/repo/?fingerprint=B3EBE10AFA6C5C400379B34473E843D686C61AE6AD33F423C98AF903F056523F). From there, the applications can be downloaded manually or by adding the url as a package source in the F-Droid application.
