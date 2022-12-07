---
title: "Metadata"
linkTitle: "Metadata"
weight: 3
description: >
  How to make sure that users see correct information about your app
---

F-Droid and the Play Store need metadata in order for your application to be accepted. This includes descriptions, translations, screenshot, contact and licensing information, icons and others. Where it makes sense, the metadata is translated into different languages.
The metadata is important, since it's used to display the app to the user. It's comparable to how appstream files are used by different software centers on the desktop.

As part of the packaging step, craft will automatically generate [fastlane](https://f-droid.org/en/docs/All_About_Descriptions_Graphics_and_Screenshots/) metadata for the app based on the existing appstream metadata. Fastlane metadata is required to be accepted into the F-Droid store. When uploading apps to the Play Store, the binary factory will create the required metadata from the fastlane metadata. This means that normally, you won't need to manually create or edit most of the metadata. If there are problems with the descriptions in F-Droid or the Play Store, make sure the appstream file is correct.

Some metadata, for example a banner image for F-Droid, can be added manually. To do that, the files need to be put in a specific folder in the app's repository. For the banner image, this is at `fastlane/metadata/org.kde.<appname>/en-US/images/featureGraphic.svg`. For other metadata, have a look at the [fastlane documentation](https://f-droid.org/en/docs/All_About_Descriptions_Graphics_and_Screenshots/).
