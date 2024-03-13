---
title: "Packaging your app for the Microsoft Store"
linkTitle: "Packaging"
weight: 2
description: >
  Learn how to package your applications for the Microsoft Store
authors:
  - SPDX-FileCopyrightText: 2024 Ingo Klöcker <kloecker@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
---

## Introduction

This tutorial will guide you in packaging an application for publication in the Microsoft Store.

We assume that you have already set up your project to package and publish a Windows installer. If not then read the tutorial on [packaging and publishing applications for Windows]({{< ref "../packaging" >}}). Further, we assume that you are building your application with MSVC. The process for publishing applications built with MinGW in the Microsoft Store is completely different.

We continue using [NeoChat](https://invent.kde.org/network/NeoChat) as example.


## Packaging the application for the Microsoft Store

To publish your application in the Microsoft Store is has to be packaged as APPX (or MSIX) package.

First we need to add the identifier of your application for the Microsoft Store to the [project settings of the windowsbinariessigner](https://invent.kde.org/sysadmin/ci-utilities/-/blob/master/signing/windowsbinariessigner-projects.yaml?ref_type=heads) in the
ci-utilities repository. For NeoChat we add the following to `windowsbinariessigner-projects.yaml`:

```yml
network/neochat:
  applicationid: KDEe.V.NeoChat
  branches:
    release/24.02:
```

See the documentation of the [windowsbinariessigner's project settings](https://invent.kde.org/sysadmin/ci-utilities/-/tree/master/signing?ref_type=heads#windowsbinariessigner)
for details.

Next we configure the CI/CD pipeline of NeoChat in KDE's GitLab, so that it creates APPX packages additionally to the Window installer.
We do this by adding a file called `.craft.ini` to the `release/24.02` branch of NeoChat with the following content:

```ini
# SPDX-FileCopyrightText: None
# SPDX-License-Identifier: CC0-1.0

[BlueprintSettings]
kde/applications/neochat.packageAppx = True
```

The important line is `kde/applications/neochat.packageAppx = True` where `kde/applications/neochat` is the path of the Craft blueprint of NeoChat in the [KDE Craft Blueprints repository](https://invent.kde.org/packaging/craft-blueprints-kde).

When we now run a CI/CD pipeline for NeoChat then, after successful completion, the `craft_windows_qt6_x86_64` job will have created two additional files which we can download by browsing the job artifacts (in the folder `.kde-ci-packages/`) or, more conveniently, from [KDE's CDN](https://cdn.kde.org/ci-builds/network/neochat/release-24.02/windows/). The file ending with `.appxupload` is that one you need to publish your application in the Microsoft Store. The second file ending with `-sideload.appx` can be used to install your application manually on Windows. You should use this sideload APPX to verify that your application works as expected before you upload it to the Microsoft Store.
