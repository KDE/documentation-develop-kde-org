---
title: Adding your app to Google Play
weight: 2
description: >
  Learn how to add your application to Google Play
authors:
  - SPDX-FileCopyrightText: 2024 Ingo Klöcker <kloecker@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
---

In this part of the tutorial for publishing an application on [Google Play](https://play.google.com/store/apps)
you will learn how to add your app to Google Play and how to make a first internal release.

We assume that you have access to the Google Play Console account of KDE. You can request access by sending a ticket to our [KDE system administrators](https://community.kde.org/Sysadmin).


## Adding your app on Google Play

Sign in on [Google Play Console](https://accounts.google.com/ServiceLogin?service=androiddeveloper&passive=true&continue=https%3A%2F%2Fplay.google.com%2Fconsole%2Fdeveloper%2Fapp-list).

After signing in you'll see the KDE apps that are already registered on Google Play.

Add a new app with "Create app".

![Screenshot showing 'Create app' link in KDE's Play Console account](01-create-app-1.png)

Enter the name of your app, select "App" or "Game", select "Free" or "Paid" (note the hint if you select "Free"), confirm the declarations (after reading them), and then click "Create app".

![Screenshot showing the 'Create app' form](01-create-app-2.png)

After creating your app you'll see the dashboard for your app with suggestions for the next steps.

![Screenshot showing the Dashboard for KTrip](01-create-app-3.png)


## Creating a first internal release of your app

We will create a first internal release of KTrip. The dashboard tells us what to do.

![Screenshot showing the 'Start testing now' section on the Dashboard for KTrip](02-release-for-internal-testing-1.png)

We skip the task "Select testers" for now. Click on "Create a new release" instead. This brings us to the "Internal testing" page.

![Screenshot showing the 'Internal testing' page for KTrip](02-release-for-internal-testing-2.png)

Click "Create new release". This opens the page for creating an internal testing release.

![Screenshot showing the 'Create internal testing release' form with request to choose a signing key](02-release-for-internal-testing-3.png)

Before we can upload the first app bundle of KTrip we need to take a short detour to set the signing key and the upload key to use for KTrip.


## Setting Signing Key and Upload Key

Alternatively to generating the signing key yourself you can ask our [system administrators](https://community.kde.org/Sysadmin) to generate a new signing key and upload it to Google Play. In this case you can skip the first two sections and continue with [Upload the Upload Key Certificate](#uploading-the-upload-key-certificate-to-google-play).

### Generating a Signing Key

Click on "Choose signing key". Google Play asks whether we want to use a Google-generated app signing key or our own app signing key.

![Screenshot showing 'Choose signing key' choice](03-signing-key-and-upload-key-1.png)

For KTrip we choose to use our own key because this gives us more flexibility. Click on "Use a different key".

Google recommends to use individual signing keys for each app. We follow this good practice and generate a new signing key for KTrip. [keytool](https://docs.oracle.com/en/java/javase/11/tools/keytool.html), the tool we use for generating the key, is included in the OpenJDK runtime environment.

```bash
# first we generate a decent password for the new key
head -c 18 /dev/urandom | base64 >ktrip-google-play-signing.keystorepass

# then we generate the new key
keytool -genkeypair -alias org.kde.ktrip -keyalg RSA -keysize 2048 \
    -dname "CN=KTrip Signing Key, OU=Release Team, O=KDE, L=Berlin, C=DE" \
    -keypass:file ktrip-google-play-signing.keystorepass \
    -validity 10000 \
    -keystore ktrip-google-play-signing.keystore \
    -storepass:file ktrip-google-play-signing.keystorepass
```

I have generated the key on the machine the signing service runs on. If you generate the key yourself then you have to ask our [system administrators](https://community.kde.org/Sysadmin) to upload the keystore file and the file with the password to this machine.

{{< alert title="Note" color="info" >}}
For the releases of KTrip published in our F-Droid repositories we use a different signing key which is also used to sign almost all other apps published in our F-Droid repositories. We decided not to upload this key to Google Play. The minor drawback is that one cannot update a KTrip installed from F-Droid with a KTrip from Google Play and vice versa.
{{< /alert >}}

### Uploading the Signing Key to Google Play

Google Play gives us instructions how to export and upload the signing key. Follow those instructions.

![Screenshot showing 'App signing preferences' form](03-signing-key-and-upload-key-2.png)

Clicking on "Download encryption public key" will, after a short time, download a file named `encryption_public_key.pem`.

Clicking on "Download PEPK tool" downloads a file named `pepk.jar`.

For the key generated above the commands for exporting and encrypting the private signing key with the PEPK tool looks as follows:

```bash
# print the password that protects the signing key and the keystore
cat ktrip-google-play-signing.keystorepass

# run the PEPK tool
java -jar pepk.jar --keystore=ktrip-google-play-signing.keystore \
    --alias=org.kde.ktrip \
    --output=ktrip-signing-key.zip \
    --include-cert --rsa-aes-encryption \
    --encryption-key-path=encryption_public_key.pem
Enter password for store 'ktrip-google-play-signing.keystore':
Enter password for key 'org.kde.ktrip':
```

Click on "Upload generated ZIP" and upload the file `ktrip-signing-key.zip`.

### Uploading the Upload Key Certificate to Google Play

Download KDE's [Upload Key Certificate](google-play-upload-certificate.pem).

Then click on "Show instructions" next to "For increased security, create a new upload key (optional)."

![Screenshot showing instructions for uploading an upload key certificate](03-signing-key-and-upload-key-3.png)

Since we already have an upload key we skip directly to step c., click on "Upload your upload key certificate" and upload KDE's upload key certificate.

Finally, click "Save" to save and close the "App signing preferences".


## Creating a first internal release of your app continued

After setting the signing key and the upload key we can continue publishing a first internal release of KTrip.

![Screenshot showing the 'Create internal testing release' form after setting the signing key with possibility to upload an app bundle](04-release-for-internal-testing-1.png)

Click on "Upload" and select the signed app bundle of KTrip we created in the previous part of this tutorial on [packaging an application for Google Play]({{< ref "packaging#signing-the-aab" >}}). When the upload is complete then the app bundle will be listed below the upload drop zone and the release name will be filled in with the version information of the app bundle.

Click on "Save as draft" to save the changes.

![Screenshot showing the 'Create internal testing release' form after uploading an app bundle](04-release-for-internal-testing-2.png)

Then click on the "Next" button to get to the "Preview and confirm" page.

![Screenshot showing the 'Preview and confirm' step of the 'Create internal testing release' workflow](04-release-for-internal-testing-3.png)

Before clicking on "Save and publish" we check the warnings (the two warnings were not relevant for KTrip). Moreover, we verify that the app bundle contains a working app. For this we click on the arrow button next to the app bundle to get to the Details page of the app bundle.

![Screenshot showing the details for the uploaded app bundle](04-release-for-internal-testing-4.png)

Then we switch to the Downloads page.

![Screenshot showing the available downloads for the uploaded app bundle](04-release-for-internal-testing-5.png)

On this page we click on the download button of the "Signed, universal APK" asset to download the APK of KTrip that Google Play created from the uploaded app bundle. This APK is pretty large because it contains the binaries for all native platforms we support. We could now upload this APK to some other store. Instead we copy the APK to our Android device and install it to give KTrip a quick sanity check. You will have to uninstall a KTrip installed from F-Droid.

After verifying that the APK works we click the "Save and publish" button and acknowledge the request for confirmation.

![Screenshot showing the 'Publish change on Google Play?' confirmation question](04-release-for-internal-testing-6.png)

This concludes the creation of the first internal release of KTrip.

![Screenshot showing the 'Internal testing' page listing the first release](04-release-for-internal-testing-7.png)


## Getting KTrip ready for review by Google

To get KTrip ready for review by Google we need to tell Google more about the content of the app and we need to set up how it should be presented on Google Play.

Go to the Dashboard and show the tasks of "Set up your app". We see a long list of tasks. We tackle them one by one. Most tasks are easy to complete because they don't apply to KTrip. Things may be more complicated for your app.

![Screenshot showing the 'Set up your app' task list on KTrip's dashboard](05-set-up-your-app-00.png)

### Letting Google Play know about the content of KTrip

#### Privacy policy

Click on "Set privacy policy".

On the Privacy Policy page we enter the URL of the [KDE Software Privacy Policy](https://kde.org/privacypolicy-apps/).

![Screenshot showing the 'Privacy Policy' form](05-set-up-your-app-01-1.png)

Then we click "Save" and go back to the Dashboard.

![Screenshot showing the 'Set up your app' task list on KTrip's dashboard where now 1 of 12 tasks is complete](05-set-up-your-app-01-2.png)

Yeah! The first task is complete. 11 more tasks to go.

#### App access

Google Play wants to know if some parts of the app can only be accessed after entering login credentials or after fulfilling other requirements. For KTrip that's not the case.

![Screenshot showing the 'App access' form](05-set-up-your-app-02.png)

{{< alert title="Note" color="info" >}}
For a chat app like NeoChat which cannot be reviewed without a Matrix account it's more complicated. For the Microsoft Store we provide Microsoft with credentials for a test account they can use to review NeoChat.
{{< /alert >}}

#### Ads

That one is easy. KDE apps don't contain ads.

![Screenshot showing the 'Ads' form](05-set-up-your-app-03.png)

#### Content rating

Now it gets a bit more interesting. Although for KTrip it's rather boring.

![Screenshot showing the starting page of the 'Content ratings' questionnaire](05-set-up-your-app-04-0.png)

Click "Start questionnaire".

As contact address for the content ratings we add our "KDE on Android" email address.

KTrip is neither a game nor a social or communication app so that we choose "All Other App Types" as category.

![Screenshot showing the Category form of the 'Content ratings' questionnaire](05-set-up-your-app-04-1.png)

On the next page we can quickly answer the first two questions with "No".

![Screenshot showing the first two questions of the 'Content ratings' questionnaire](05-set-up-your-app-04-2-1.png)

The question about "Online Content" we answer with "Yes" because KTrip does feature "content that isn't part of the initial app download": public transport connections. Information on public transport connections isn't ratings-relevant so that the questions about the content can quickly be answered with "No".

![Screenshot showing the questions about online content of the 'Content ratings' questionnaire](05-set-up-your-app-04-2-2.png)

The remaining questions can again quickly be answered with "No".

![Screenshot showing the remaining questions of the 'Content ratings' questionnaire](05-set-up-your-app-04-2-3.png)

After saving our answers and clicking "Next" we get to the summary.

![Screenshot showing the summary of the 'Content ratings' questionnaire](05-set-up-your-app-04-3.png)

The different age ratings for KTrip vary between "for all ages" and "at least 3 years old".

#### Target audience

The question about the target audience is again interesting. I checked "18 and over" because KTrip does not specifically target younger persons even if younger persons can certainly use KTrip to look up public transport connections.

![Screenshot showing the question about the target age of the 'Target audience and content' questionnaire](05-set-up-your-app-05-1.png)

On the next page which asks whether the store listing of KTrip could appeal to children I answered "No". I think KTrip's icon isn't cute enough to appeal to children and the description and the screenshots (see below) are rather the opposite of appealing to children.

![Screenshot showing the question about the store presence's appeal to children of the 'Target audience and content' questionnaire](05-set-up-your-app-05-4.png)

After clicking "Next" we get to the summary where we save our answers.

![Screenshot showing the summary of the 'Target audience and content' questionnaire](05-set-up-your-app-05-5.png)

#### News apps

No, KTrip isn't a news app.

![Screenshot showing the question whether KTrip is a news app](05-set-up-your-app-06.png)

#### COVID-19 contact tracing and status apps

Neither KTrip is a publicly available COVID-19 contact tracing or status app.

![Screenshot showing the question whether KTrip is a publicly available COVID-19 contact tracing or status app](05-set-up-your-app-07.png)

#### Data safety

Next we need to "help users understand how" KTrip "collects and shares their data".

![Screenshot showing the 'Overview' page of the 'Data safety' questionnaire](05-set-up-your-app-08-1.png)

KTrip shares the search criteria entered by the user with the public transport information providers. Additionally, the providers will see the user's IP address.
The IP address isn't a user data type that needs to be (and can be) mentioned in Google Play's Data safety section.
And the search criteria that are sent to the providers don't need to be disclosed as sharing because we can assume that "the user reasonably expects the data to be shared" when they click the "Search" button ("a specific user-initiated action").

Following these considerations we can safely answer "No" to the question whether KTrip collects or shares any of the required user data types.

![Screenshot showing the 'Data collection and security' page of the 'Data safety' questionnaire](05-set-up-your-app-08-2.png)

The preview shows what will be shown to users on Google Play for KTrip.

![Screenshot showing the 'Store listing preview' of KTrip's 'Data safety'](05-set-up-your-app-08-5.png)

#### Government apps

No, KTrip was not developed by or on behalf of a government.

![Screenshot showing the question whether KTrip was developed by or on behalf of a government](05-set-up-your-app-09.png)

#### Financial features

KTrip doesn't provide any financial features ...

![Screenshot showing the 'Financial features' form](05-set-up-your-app-10-1.png)

... so that we don't have to provide any additional documentation.

![Screenshot showing which additional documentation for the financial features we need to submit](05-set-up-your-app-10-2.png)

This completes the long list of tasks to let Google Play know about the content of KTrip.

![Screenshot showing the 'Set up your app' task list on KTrip's dashboard where now 10 of 12 tasks are complete](05-set-up-your-app-10-3.png)

### Completing the presentation of KTrip on Google Play

Now we set up how KTrip should be presented on Google Play.

#### Store settings

We choose "Travel & Local" as category for KTrip and from the long list of available tags we select "Public transport".

![Screenshot showing the 'App category' form of the 'Store settings'](05-set-up-your-app-11-1.png)

As contact details we enter the email address of the general KDE users mailing list kde@kde.org because there isn't a more specific mailing list for KTrip. As website we point to KTrip's page on our [KDE Applications](https://apps.kde.org) website.

![Screenshot showing the 'Store listing contact details' form of the 'Store settings'](05-set-up-your-app-11-2.png)

Finally, we leave external marketing enabled.

![Screenshot showing the 'External marketing' choice of the 'Store settings'](05-set-up-your-app-11-3.png)

#### Main store listing

Last but not least, we add some text and some images for KTrip's store listing. As short description and full description we use the summary and the description from KTrip's AppStream data. We add only the English descriptions. The translations provided by our great translation teams will be uploaded automatically by our CI/CD system.

![Screenshot showing the 'Listing assets' form of the 'Main store listing'](05-set-up-your-app-12-1.png)

As app icon we use the image [ic_launcher-playstore.png](https://invent.kde.org/utilities/ktrip/-/blob/master/android/ic_launcher-playstore.png?ref_type=heads) which is also put into the (fastlane) meta data for publication on F-Droid and Google Play.

For KTrip no image suitable as feature graphic existed. Inspired by the [feature graphic of Itinerary](https://invent.kde.org/pim/itinerary/-/blob/master/fastlane/metadata/org.kde.itinerary/en-US/images/featureGraphic.png?ref_type=heads) I derived a feature graphic for KTrip from its app icon.

![Screenshot showing the 'Graphics' form of the 'Main store listing'](05-set-up-your-app-12-2.png)

Finally, Google Play asks for at least 2 phone screenshots. In KTrip's repository there was only one screenshot and that screenshot was outdated. I took some new screenshots and added them to Google Play (and to KTrip's repository). Tablet screenshots and Chromebook screenshots are optional so that we don't provide those for now.

![Screenshot showing the 'Phone screenshots' form of the 'Main store listing'](05-set-up-your-app-12-3.png)

After saving our changes we are done with setting up KTrip to get it ready for review by Google.


## Preparing KTrip for submission of new releases by our CI/CD system

To allow our CI/CD system to update KTrip's store listing (e.g. to add the translated descriptions) and to upload new builds we need to create a draft release in the "Open testing" (aka beta) track (which the CI/CD system uploads new builds to) and a draft release in the "Production" track. These (draft) releases are needed to [work around shortcomings in the tools we use](https://invent.kde.org/sysadmin/ci-notary-service/-/blob/master/doc/googleplaypublisher.md?ref_type=heads#trouble-shooting).

### Creating a draft release in the Open testing track

To create a new (draft) release in the Open testing track we promote the release we created in the Internal testing track to Open testing.

Navigate to the Internal testing page, click on the "Promote release" drop down below the listed release and select "Open testing".

![Screenshot showing the 'Internal testing' page with 'Promote release' pop-up](06-create-draft-releases-1.png)

The new release is created immediately. Don't be confused that "Save as draft" is disabled. The new release has automatically been saved as draft so that there's nothing left to do for us.

![Screenshot showing the 'Create open testing release' form with the promoted internal release](06-create-draft-releases-2.png)

### Creating a draft release in the Production track

To create a new (draft) release in the Production track we promote the release we created in the Internal testing track to Production.

Navigate again to the Internal testing page, click on the "Promote release" drop down below the listed release and select "Production". Note that promoting the release to "Open testing" is not possible. That's because there is already a draft release in the Open testing track.

![Screenshot showing the 'Internal testing' page with 'Promote release' pop-up where 'Open testing' is disabled](06-create-draft-releases-3.png)

Again the new release is created immediately and has automatically been saved as draft.

![Screenshot showing the 'Create production release' form with the promoted internal release](06-create-draft-releases-4.png)


## Summary

We learned how to add an application like KTrip to Google Play. We made a first internal release and prepared everything to publish (beta) releases of KTrip on Google Play with the KDE CI/CD system.
