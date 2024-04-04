---
title: Packaging your app
weight: 1
description: >
  Learn how to package your application for Google Play
authors:
  - SPDX-FileCopyrightText: 2024 Ingo Klöcker <kloecker@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
---

In this first part of the tutorial you will learn how to create an [Android App Bundle](https://developer.android.com/guide/app-bundle) (AAB)
for an application. For new apps Google Play requires the upload of applications as AABs.

We use [KTrip](https://apps.kde.org/ktrip) as example.


## Packaging the application for Google Play

The CI/CD system already creates APKs for KTrip that can be published on F-Droid or separately, but to publish KTrip on Google Play we need to create an Android App Bundle.

To achieve this, we add the template `/gitlab-templates/craft-android-qt6-appbundle.yml` to the `.gitlab-ci.yml` file in the 24.02 release branch of KTrip:

```yml
include:
  - project: sysadmin/ci-utilities
    file:
      - /gitlab-templates/craft-android-qt6-apks.yml
      - /gitlab-templates/craft-android-qt6-appbundle.yml
```

This template adds three jobs to the CI/CD pipeline of KTrip:
* `craft_android_appbundle_qt66` which creates an AAB of KTrip.
* `googleplay_aab_qt66` which publishes the AAB as beta release of KTrip on Google Play.
* `sign_aab_qt66` which signs the AAB so that it can be uploaded manually to Google Play. This job does not run automatically.

The last two jobs are only added for pipelines on mainline branches of mainline repositories. In particular, you won't see them in a merge request pipeline.

{{< alert title="Note" color="info" >}}
Mainline branches are the `master` branch and release branches like `release/24.02`.
{{< /alert >}}

After successfully running a CI/CD pipeline for the 24.02 branch of KTrip, the `craft_android_appbundle_qt66` job will have created an AAB that we can download by browsing the job artifacts. The `googleplay_aab_qt66` job will have logged

> Branch 'release/24.02' of project 'utilities/ktrip' is not cleared for publishing. Skipping.

We will change this later.

The `sign_aab_qt66` job has not run. That's okay. We will run it later.

{{< alert title="Note" color="info" >}}
If the application you want to publish on Google Play is based on Qt 5 then include the template `/gitlab-templates/craft-android-appbundle.yml`.

See the [documentation of our CI/CD pipelines](https://invent.kde.org/sysadmin/ci-utilities/-/tree/master/gitlab-templates?ref_type=heads#our-gitlab-cicd-pipelines) for more information about the available CI/CD job templates.
{{< /alert >}}


## Signing the Android App Bundle

To prepare Google Play for the publication of KTrip we need to upload one AAB manually as we will see in the next section.
This AAB needs to be signed with KDE's upload key so that Google Play accepts it.

We will now configure our CI/CD system, so that it allows signing the AAB created by the CI/CD pipeline.
We want to sign the AAB created for the 24.02 release branch.
Project branches are cleared for AAB signing by adding them to the
[project settings of the aabsigner](https://invent.kde.org/sysadmin/ci-utilities/-/blob/master/signing/aabsigner-projects.yaml?ref_type=heads) in the
ci-utilities repository. To clear the 24.02 release branch of KTrip for AAB signing we add the following to `aabsigner-projects.yaml`:

```yml
utilities/ktrip:
  applicationid: org.kde.ktrip
  branches:
    release/24.02:
```

See the documentation of the [aabsigner's project settings](https://invent.kde.org/sysadmin/ci-utilities/-/tree/master/signing?ref_type=heads#aabsigner)
for details.

When we now run a CI/CD pipeline for KTrip on the `release/24.02` branch, only after a successful completion of the `craft_android_appbundle_qt66` job can we trigger the `sign_aab_qt66` job. Once the latter finishes, this job will have signed the AAB that was created by the `craft_android_appbundle_qt66` job. Download the signed AAB by browsing the job artifacts and remember where you saved it for the next part of the tutorial.

If the `sign_aab_qt66` job logs show the following:

> Branch 'release/24.02' of project 'utilities/ktrip' is not cleared for signing. Skipping.

Then we may have to ask sysadmin to restart the aabsigner service so that it loads the updated project settings.


## Summary

In this part of the tutorial we have configured the CI/CD system to create an Android App Bundle (AAB) of KTrip on the release/24.02 branch.
We have signed the AAB with the help of the CI/CD system and downloaded the signed AAB.
