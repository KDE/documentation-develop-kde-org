---
title: "Building KDE software"
weight: 1
layout: home
groups:
  - name: "Finding assistance"
    key: "help"
  - name: "kdesrc-build"
    key: "kdesrc-build"
description: >
  Learn how to build KDE software in multiple ways.
group: "getting-started"
---

By joining the ranks of KDE developers, you will get to implement new features and defeat bugs both daunting and simple. Developers collaborate in teams based on what area they are working on. These can be small teams working on a single application, up to large teams working on a group of related pieces of software, or even meta-teams working on broader topics such as QA or automation. Many developers participate in more than one team.

KDE runs or participates in several mentoring programs to help new developers, including an informal list of people who are willing to help newcomers get started. See the [Mentoring page](https://community.kde.org/Mentoring) for more details.

There are many ways in which you can build KDE software:

* [kdesrc-build]({{< ref "kdesrc-build-compile" >}})
* standalone with distro dependencies
* [with containers](https://community.kde.org/Get_Involved/development/More#Develop_in_a_Linux_container)
* with [Craft](https://community.kde.org/Craft)

If you are completely new to KDE development and want to build it on Linux, you will want to [set up a development environment with kdesrc-build]({{< ref "kdesrc-build-setup" >}}) first. This is KDE's most complete and best supported method for building KDE software on Linux.

If you are on a rolling release Linux distribution or just want to build a single app, you may also learn how to compile KDE software with manual CMake compilation.

If you are on a Linux distribution that is too old for the previous methods or use an immutable Linux distribution where development is only possible with containers, it is possible to develop KDE software using [Podman + Distrobox](https://community.kde.org/Get_Involved/development/More#Option_2._distrobox) and [Docker + Distrobox](https://community.kde.org/Neon/Containers).

If you are on Windows or MacOS or want to build an application for Android, KDE also provides the meta build system and package manager [Craft](https://community.kde.org/Craft).