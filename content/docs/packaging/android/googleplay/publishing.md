---
title: Publishing your app
weight: 3
description: >
  Learn how to publish a release of your application on Google Play
authors:
  - SPDX-FileCopyrightText: 2024 Ingo Klöcker <kloecker@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
---

## Automatically publishing beta releases on Google Play

In the previous parts of this tutorial we created an Android App Bundle of KTrip for the latest release branch and added KTrip to Google Play.
Now we want to automate the publication of beta releases on Google Play.

To enable publishing of the 24.02 release branch of KTrip on Google Play we add the following to the
[project settings of the googleplaypublisher](https://invent.kde.org/sysadmin/ci-utilities/-/blob/master/signing/googleplaypublisher-projects.yaml?ref_type=heads)
in the ci-utilities repository:

```yml
utilities/ktrip:
  applicationid: org.kde.ktrip
  branches:
    release/24.02:
```

See the documentation of the [googleplaypublisher's project settings](https://invent.kde.org/sysadmin/ci-utilities/-/tree/master/signing?ref_type=heads#googleplaypublisher)
for details.

After successfully running a CI/CD pipeline for the 24.02 branch of KTrip, the `craft_android_appbundle_qt66` job will have created an AAB (as before) and the `googleplay_aab_qt66` job will have uploaded this AAB to a new (draft) beta release on Google Play.


## Publishing production releases on Google Play

Publishing a new production release can only be done in the Google Play Console. After verifying that the latest beta release works you can promote the release to the Production track.


## Summary

This concludes the tutorial on how to publishing a new application on Google Play. We have learned how to configure KDE's CI/CD system to package an application for Google Play, how to add a new application to Google Play, and how to publish releases on Google Play.
