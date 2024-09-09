---
title: "Packaging and publishing applications for Windows"
linkTitle: "Packaging and publishing"
weight: 2
description: >
  Learn how to package and publish your applications for Windows
authors:
  - SPDX-FileCopyrightText: 2024 Ingo Klöcker <kloecker@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
---

## Introduction

This tutorial will guide you in packaging an application for Windows and publishing the installer on KDE's CDN.

We assume that there is already a working blueprint for the application you want to package, i.e. you can build your application with Craft on a (virtual) Windows machine.

We use [NeoChat](https://invent.kde.org/network/NeoChat) as example.


## Packaging the application

In the first step we configure the CI/CD pipeline of NeoChat in KDE's GitLab, so that it creates installers for Windows.
We do this by adding the template `/gitlab-templates/craft-windows-x86-64-qt6.yml` to the `.gitlab-ci.yml` file of NeoChat:

```yml
include:
  - project: sysadmin/ci-utilities
    file:
      [...]
      - /gitlab-templates/craft-windows-x86-64-qt6.yml
```

This template adds one job to CI/CD pipeline of NeoChat:
* `craft_windows_qt6_x86_64` which builds the app with MSVC and creates a Windows installer.

When we now run a CI/CD pipeline for NeoChat then, after successful completion, the `craft_windows_qt6_x86_64` job will have created an executable Windows installer (and a few other packages) which we can download by browsing the job artifacts. You'll find the installer in the folder `kde-ci-packages/`.

By default, the installer is not signed. Windows may refuse to run this installer.

{{< alert title="Note" color="info" >}}
If the application you want to package is based on Qt 5 then include the template `/gitlab-templates/craft-windows-x86-64.yml`.

If you need to use MinGW instead of MSVC for building your application then include the template `/gitlab-templates/craft-windows-mingw64-qt6.yml` (for Qt 6) or `/gitlab-templates/craft-windows-mingw64.yml` (for Qt 5).

See the [documentation of our CI/CD pipelines](https://invent.kde.org/sysadmin/ci-utilities/-/tree/master/gitlab-templates?ref_type=heads#our-gitlab-cicd-pipelines) for more information about the available CI/CD job templates.
{{< /alert >}}


## Signing the installer

Now we configure our CI/CD system, so that it signs the installer (and the included binaries) created by the CI/CD pipeline.
The CI/CD system signs Windows binaries on project branches which are cleared for signing. We want to sign the Windows binaries created for the 24.02 release branch.
Project branches are cleared for signing of Windows binaries by adding them to the
[project settings of the windowsbinariessigner](https://invent.kde.org/sysadmin/ci-utilities/-/blob/master/signing/windowsbinariessigner-projects.yaml?ref_type=heads) in the
ci-utilities repository. To clear the 24.02 release branch of NeoChat for signing of Windows binaries we add the following to `windowsbinariessigner-projects.yaml`:

```yml
network/neochat:
  branches:
    release/24.02:
```

See the documentation of the [windowsbinariessigner's project settings](https://invent.kde.org/sysadmin/ci-utilities/-/tree/master/signing?ref_type=heads#windowsbinariessigner)
for details.

When we now run a CI/CD pipeline for NeoChat on the `release/24.02` branch then the `craft_windows_qt6_x86_64` job will create a signed Windows installer which you should be able to install on your Windows machine.

{{< alert title="Note" color="info" >}}
Only mainline branches can be cleared for signing. Mainline branches are the `master` branch and release branches like `release/24.02`.
Windows installers created on work branches and forks are never signed.
{{< /alert >}}


## Publishing the application on KDE's CDN

Now that we have a signed Windows installer created for the latest release branch of NeoChat we want to publish it at a location that doesn't change with each build, so that we can link to this location to make it easier for our users to download the latest installer. Such a location is [KDE's CDN](https://cdn.kde.org/ci-builds/).

To configure the CI/CD system to publish the Windows installer created for the 24.02 release branch of NeoChat on KDE's CDN we add the following to the [project settings of the buildpublisher](https://invent.kde.org/sysadmin/ci-utilities/-/blob/master/signing/buildpublisher-projects.yaml?ref_type=heads):

```yml
network/neochat:
  branches:
    release/24.02:
```

These settings tell the CI/CD system that the Windows installer built on the `release/24.02` branch shall be published on KDE's CDN. The latest successfully built installer of NeoChat 24.02 is now available at [this location](https://cdn.kde.org/ci-builds/network/neochat/release-24.02/windows/).

See the documentation of the [buildpublisher's project settings](https://invent.kde.org/sysadmin/ci-utilities/-/tree/master/signing?ref_type=heads#buildpublisher) for details.


## Summary

In this tutorial we have learned how to configure KDE's CI/CD system to create a Windows installer for an application and how to publish this installer on KDE's CDN so that our users can easily install it.
