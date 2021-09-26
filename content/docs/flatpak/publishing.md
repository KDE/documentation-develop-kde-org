---
title: Your app on kdeapps
description: How to publish your manifests on KDE infrastructure
weight: 3
---

While flathub is a popular hub for flatpak'd software, it is possible to have multiple flatpak repositories due to its decentralized nature with the help of [flat-manager](https://github.com/flatpak/flat-manager). A few other flatpak repositories are GNOME Nightly, Fedora for Silverblue/Kinoite, openSUSE for MicroOS, and Winepak. The KDE Community has its own repository for nightlies, [kdeapps](https://community.kde.org/Guidelines_and_HOWTOs/Flatpak), which is [hosted on Invent](https://invent.kde.org/packaging/flatpak-kde-applications).

Kdeapps is particularly convenient for users to test applications that are new and have yet to be released or are still being developed. The repository integrates with a Jenkins instance hosted over [binary factory](https://binary-factory.kde.org/view/Flatpak/), requiring only that you submit your JSON manifests to the git repository one way or another.

One way is to fork the repository, add your manifest (either via web interface or via git), and create a merge request (MR). This process is [very extensively described in the wiki](https://community.kde.org/Infrastructure/GitLab), and requires you to create an account over [Identity](https://identity.kde.org/) first. The MR will then undergo a straightforward review process before being added.

If you are the application developer and want to take control of your flatpak package, you can instead host the JSON manifest in your application repository and make an MR to submit a fairly simple pointer file to the kdeapps repository instead, called a remoteapp. It consists of three lines:

```
ID=org.kde.yourapphere
JSON=org.kde.yourapphere.json
GITURL=https://invent.kde.org/application-group/application-repo.git
```

Your remoteapp needs to be named using your application ID + ".remoteapp", so "org.kde.yourapphere.remoteapp". You can see an example for Audiotube [here](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/org.kde.audiotube.remoteapp).

If you are submitting your manifest to kdeapps, there might be situations in which your packaged application has a dependency that is used by other applications. To minimize redundancy, it may make sense to create a different file where to host that dependency, which will work exactly as a module. This has been done for [boost](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/boost.json) which is used by [kdevelop](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/org.kde.kdevelop.json) and [kdiff3](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/org.kde.kdiff3.json), for instance; [libkdegames](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/libkdegames.json), which is used by most KDE games; [poppler](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/poppler.json) which is used for [okular_dependencies](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/okular_dependencies.json), which in turn is used for both [okular](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/org.kde.okular.json) and [kile](https://invent.kde.org/packaging/flatpak-kde-applications/-/blob/master/org.kde.kile.json), and so on.
