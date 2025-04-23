---
title: "Building KDE software"
weight: 1
layout: home
groups:
  - name: "Finding assistance"
    key: "help"
  - name: "kde-builder"
    key: "kde-builder"
  - name: "Manual builds"
    key: "cmake-build"
  - name: "Containers"
    key: "containers"
description: >
  Learn how to build KDE software in multiple ways.
group: "getting-started"
---

By joining the ranks of KDE developers, you will get to implement new features and defeat bugs both daunting and simple. Developers collaborate in teams based on what area they are working on. These can be small teams working on a single application, up to large teams working on a group of related pieces of software, or even meta-teams working on broader topics such as QA or automation. Many developers participate in more than one team.

KDE runs or participates in several mentoring programs to help new developers, including an informal list of people who are willing to help newcomers get started. See the [Mentoring page](https://community.kde.org/Mentoring) for more details.

There are many ways in which you can build KDE software:

* [kde-builder]({{< ref "kde-builder-setup" >}})
* [kdesrc-build (unsupported)](https://invent.kde.org/sdk/kdesrc-build)
* [manual CMake compilation]({{< ref "cmake-build" >}})
* with [containers]({{< ref "containers-distrobox" >}})
* with [Craft](https://community.kde.org/Craft)

If you are completely new to KDE development and want to build it on Linux, you will want to [set up a development environment with kde-builder]({{< ref "kde-builder-setup" >}}) first. This is KDE's most complete and best supported method for building KDE software on Linux.

If you are on a rolling release Linux distribution or just want to build a single app, you may also learn how to compile KDE software using [manual CMake compilation]({{< ref "cmake-build" >}}).

If you are on a Linux distribution that is too old for the previous methods or you use an immutable Linux distribution where development is only possible with containers, it is possible to develop KDE software using [Podman + Distrobox](https://community.kde.org/Get_Involved/development/More#Option_2._distrobox) and [Docker + Distrobox](https://community.kde.org/Neon/Containers).

If you are on Windows or MacOS or want to build an application for Android, KDE also provides the meta build system and package manager [Craft](https://community.kde.org/Craft). Windows users may also be interested in [Packaging KDE Software for Windows]({{< ref "windows" >}}).

## Choosing the right method for your Linux system {#choosing}

If you are on Linux, then the method you'll need to use will depend
on your distribution and how often it updates.

| **Type of distribution**        | **Method**                | **Comment**             |
| ------------------------------- | ------------------------- | --------------------- |
| Sufficiently up-to-date[^1]     | kde-builder               | ✅ The preferred method. Works for all purposes. |
|                                 | manual CMake compilation  | ✅ Works well for standalone apps. Core software[^2] requires extra steps to work[^3]. |
|                                 | containers                | ✅ Redundant and takes extra setup, but possible. Doesn't work well for core software[^2]. |
| Not up-to-date distribution[^4] | kde-builder               | ⚠️ If the system is not too outdated, it might work, in which case all benefits of kde-builder apply. If the system is too outdated, it will not work. |
|                                 | manual CMake compilation  | ❌ Might work for standalone apps, but not recommended. |
|                                 | containers                | ✅ Works well for standalone apps, but not core software[^2]. |
| Immutable distribution[^5]      | kde-builder               | ⚠️ Possible only inside a container. |
|                                 | manual CMake compilation  | ⚠️ Possible only inside a container. |
|                                 | containers                | ✅ The only way to build software in these systems. |

[^1]: "Sufficiently up-to-date" means distributions like the latest non-LTS Ubuntu, Debian Testing, openSUSE Tumbleweed, Fedora, Arch Linux, and their derivatives.
[^2]: "Core software" refers to non-standalone software that is essential for Plasma to function like KWin, Plasma Desktop, or KIO.
[^3]: Currently undocumented.
[^4]: "Not up-to-date" means distributions such as Debian Stable, Ubuntu LTS or two versions behind current release, or openSUSE Leap.
[^5]: "Immutable distributions" means distributions like Fedora Kinoite, openSUSE Kalpa, or SteamOS.
