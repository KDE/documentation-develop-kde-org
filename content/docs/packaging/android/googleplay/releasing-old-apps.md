---
title: Releasing new versions of old apps
weight: 4
description: >
  Learn how to publish new releases of old applications on Google Play
authors:
  - SPDX-FileCopyrightText: 2024 Ingo Klöcker <kloecker@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
---

Here you learn how to publish new releases of applications on Google Play that have previously been published on Google Play by uploading APKs.
New applications must be published as Android App Bundles (AABs).

## Adding the GitLab Job for submitting APKs to Google Play

To configure the CI/CD pipeline of your application in KDE's GitLab, so that it submits APKs built by the pipeline to Google Play, we add the template `/gitlab-templates/craft-android-qt6-googleplay-apks.yml` to the `.gitlab-ci.yml` file in the latest release branch (e.g. branches/24.02) of your application:

```yml
include:
  - project: sysadmin/ci-utilities
    file:
      - /gitlab-templates/craft-android-qt6-apks.yml
      - /gitlab-templates/craft-android-qt6-googleplay-apks.yml
```

This template adds one job to the CI/CD pipeline of your application:
* `googleplay_apks_qt66` which publishes the APKs as new (draft) beta release of your app on Google Play. (This job is only added for pipelines on mainline branches of mainline repositories. In particular, you won't see it in a merge request pipeline.)

When we now run a CI/CD pipeline for your app on the latest branch then the job will log something like this:

> Branch 'release/24.02' of project '*your_app*' is not cleared for publishing. Skipping.

Continue with the page on [publishing a release of your application on Google Play]({{< ref "publishing" >}}) to learn how to clear the 24.02 branch of your application for publishing on Google Play.

{{< alert title="Note" color="info" >}}
If the application you want to publish on Google Play is based on Qt 5 then include the template `/gitlab-templates/craft-android-qt5-googleplay-apks.yml`.

See the [documentation of our CI/CD pipelines](https://invent.kde.org/sysadmin/ci-utilities/-/tree/master/gitlab-templates?ref_type=heads#our-gitlab-cicd-pipelines) for more information about the available CI/CD job templates.
{{< /alert >}}
