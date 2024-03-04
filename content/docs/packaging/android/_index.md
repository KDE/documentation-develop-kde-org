---
title: "KDE on Android"
linkTitle: "Android"
weight: 2
group: "packaging"
description: >
  Learn how to port your applications to the most widely used mobile platform
---

## Abstract

Android is currently the largest mobile platform regarding market share and number of application, so supporting it is an excellent opportunity for gaining many users for our applications.

Qt supports building for Android, as do many of the [KDE frameworks](https://api.kde.org). Using this foundation, there is a good chance an application will be buildable for android. The usability of the application depends on different factors. As a general rule of thumb, applications using QtWidgets do not work well on Android, since their user interfaces are not well-suited for smaller screens. For applications developed using QML, the quality depends on how well the user interface adapts to different screen sizes. Ideally, the application uses Kirigami, which enables user interfaces that adapt well to different form-factors.

## Contact

For questions and discussion around KDE software on Android join our [Matrix channel](https://matrix.to/#/%23kde-android:kde.org) and [mailing list](https://mail.kde.org/mailman/listinfo/kde-android).

## Getting Applications

Stable releases of our Android apps are available on KDE's [Android Release Builds F-Droid repository](https://cdn.kde.org/android/stable-releases/fdroid/repo/?fingerprint=13784BA6C80FF4E2181E55C56F961EED5844CEA16870D3B38D58780B85E1158F). Some apps are also available on [Google Play](https://play.google.com/store/apps/dev?id=4758894585905287660).

Nightly builds of our apps are available on KDE's [Android Nightly Builds F-Droid repository](https://cdn.kde.org/android/nightly/fdroid/repo/?fingerprint=B3EBE10AFA6C5C400379B34473E843D686C61AE6AD33F423C98AF903F056523F). Alternatively, they can be downloaded from [KDE's GitLab](https://invent.kde.org) by browsing the build artifacts of the project's `craft_android_*` jobs.

If you want to install an application from one of KDE's F-Droid repositories then you have to add the repository as a package source to your F-Droid client using the URL or the QR code displayed on the pages linked above.

## Publishing Applications

Every Android application built on [KDE's GitLab](https://invent.kde.org) is published in KDE's F-Droid repositories. For details see the tutorial on [packaging and publishing applications for Android]({{< ref "packaging_applications" >}}).
