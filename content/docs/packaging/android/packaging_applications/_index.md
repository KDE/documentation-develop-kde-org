---
title: "Packaging and publishing applications for Android"
linkTitle: "Packaging and publishing"
weight: 2
description: >
  Learn how to package and publish your applications for Android
authors:
  - SPDX-FileCopyrightText: 2024 Ingo Klöcker <kloecker@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
---

## Introduction

This tutorial will guide you in packaging an application for Android and publishing it in one of KDE's F-Droid repositories.

We assume that there is already a working blueprint for the application you want to package and publish. If not then read the tutorial on [building applications for Android]({{< relref "docs/packaging/android/building_applications/" >}}).

We use [Kongress](https://invent.kde.org/utilities/kongress) as example.


## Packaging the application

In the first step we configure the CI/CD pipeline of Kongress in KDE's GitLab, so that it creates APKs.
We do this by adding the template `/gitlab-templates/craft-android-qt6-apks.yml` to the `.gitlab-ci.yml` file of Kongress:

```
include:
  - project: sysadmin/ci-utilities
    file:
      [...]
      - /gitlab-templates/craft-android-qt6-apks.yml
```

This template adds four jobs to CI/CD pipeline of Kongress:
* `craft_android_qt66_arm32`, `craft_android_qt66_arm64`, and `craft_android_qt66_x86_64` which build APKs for three different processor architectures, and
* `fdroid_apks_qt66` which we will look at a bit later.

When we now run a CI/CD pipeline for Kongress then, after successful completion, the three `craft_android_*` jobs will have created APKs which we can download by browsing the job artifacts. You'll find the APKs in the folder `.kde-ci-packages/`.

By default, the APKs are not signed. If you want to install such an APKs on your device then you have to sign it as described in the
[previous tutorial]({{< relref "docs/packaging/android/building_applications/#signing-apks" >}}).

{{< alert title="Note" color="info" >}}
If the application you want to package is based on Qt 5 then include the template `/gitlab-templates/craft-android-apks.yml`.

See the [documentation of our CI/CD pipelines](https://invent.kde.org/sysadmin/ci-utilities/-/tree/master/gitlab-templates?ref_type=heads#our-gitlab-cicd-pipelines) for more information about the available CI/CD job templates.
{{< /alert >}}


## Signing the APKs

Now we configure our CI/CD system, so that it signs the APKs created by the CI/CD pipeline.
The CI/CD system signs APKs on project branches which are cleared for APK signing. We want to sign the APKs created for the 24.02 release branch.
Project branches are cleared for APK signing by adding them to the
[project settings of the apksigner](https://invent.kde.org/sysadmin/ci-utilities/-/blob/master/signing/apksigner-projects.yaml?ref_type=heads) in the
ci-utilities repository. To clear the 24.02 release branch of Kongress for APK signing we add

```
utilities/kongress:
  applicationid: org.kde.kongress
  branches:
    release/24.02:
```

to `apksigner-projects.yaml`.

See the documentation of the [apksigner's project settings](https://invent.kde.org/sysadmin/ci-utilities/-/tree/master/signing?ref_type=heads#apksigner)
for details.

When we now run a CI/CD pipeline for Kongress on the `release/24.02` branch then the three `craft_android_*` jobs will create signed APKs which you can install on your device without having the sign them yourself.

{{< alert title="Note" color="info" >}}
Only so called mainline branches can be cleared for signing. Mainline branches are the `master` branch and release branches like `release/24.02`.
APKs created on work branches and forks are never signed.
{{< /alert >}}


## Publishing the application on F-Droid

Now that we have signed APKs created for the latest release branch of Kongress we want to publish them in our F-Droid repository to make it more easy to
install and update Kongress. But before we do this we download the APK, install it on our device and perform a more or less thorough test to ensure that
the APK works.

After we have verified that the APK works we configure the CI/CD system to publish the APKs created for the 24.02 release branch of Kongress in our
[Android Release Builds F-Droid repository](https://cdn.kde.org/android/stable-releases/fdroid/repo/). For this we add

```
utilities/kongress:
  applicationid: org.kde.kongress
  branches:
    master:
    release/24.02:
      repository: stable-releases
```

to the [project settings of the fdroidpublisher](https://invent.kde.org/sysadmin/ci-utilities/-/blob/master/signing/fdroidpublisher-projects.yaml?ref_type=heads). These settings tell the CI/CD system that the APKs built on the `master` branch shall be published in the default repository (which is
the nightly builds repository) and that the APKs built on the `release/24.02`

See the documentation of the [fdroidpublisher's project settings](https://invent.kde.org/sysadmin/ci-utilities/-/tree/master/signing?ref_type=heads#fdroidpublisher)
for details.


## Summary

In this tutorial we have learned how to configure KDE's CI/CD system to package an application for Android and how to publish it in one of KDE's F-Droid
repositories so that our users can easily install it. A possible next step would be the publication on Google Play.
