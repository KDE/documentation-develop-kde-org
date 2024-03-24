---
title: Submitting your app to the Microsoft Store
author:
  - SPDX-FileCopyrightText: 2019 Christoph Cullmann <cullmann@kde.org>
  - SPDX-FileCopyrightText: 2023 Thiago Masato Costa Sueto <thiago.sueto@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
group: windows
weight: 3
description: Understand the Microsoft Store submission process and extend your application's audience.
---

To increase the visibility of KDE applications on the Windows operating system, the [KDE e.V.](https://ev.kde.org) has a Microsoft Store account to publish our applications.

This is not the only way to get a KDE application on Windows; you may also directly grab installers or portable ZIP files from [KDE's CDN](https://cdn.kde.org/ci-builds).

This tutorial will guide you on how the submission process works in detail.

Each step has a screenshot of the web interface you will need to use.

This requires that you have access to the KDE e.V. partner center on the Microsoft site shown below. You can request access by sending a ticket to our [KDE system administrators](https://community.kde.org/Sysadmin).

### Creating a new application

You start your submission of new applications on the "Windows -> Overview" page of the [partner center](https://partner.microsoft.com/en-us/dashboard/windows/overview). You will only see this page after getting access to the KDE e.V. partner center mentioned above.

Click on the "Create a new app" button.

{{< figure src="../windows-overview.png" >}}

### Choosing the application name

The next step is to select the application name.

For this guide, we will be using [Kile](https://apps.kde.org/kile).

Don't hesitate to reserve the name of your app even if you are not yet ready for the first submission to the Microsoft Store. Once a name is reserved nobody else can publish an app with this name.

{{< figure src="../application-name.png" >}}

### Starting a submission

Now we have a freshly generated application on the dashboard.

The next step is now to create our first submission. For this you will need to press the "Start your submission" button on the overview of the new application.

A submission is a bundle of both a new application version and the needed metadata for the store, like screenshots and descriptions.

{{< figure src="../start-submission.png" >}}

### Fill out the different submission parts

You will end up on the overview page of the new submission.

{{< figure src="../submission-overview.png" >}}

The important parts to fill out are the top five:

* Pricing and availability
* Properties
* Age ratings
* Packages
* Store listings

We will be visiting each section separately.

### Submission: Pricing and availability

The defaults here are sufficient for the most part.

{{< figure src="../pricing-availability-market.png" >}}

For your first submission, you may want to restrict the visibility to "Private audience" until everything is ready for public consumption. You can create a customer group "Foo Beta Testers" with the email address of a regular Microsoft Store account in the Microsoft Partner Center and then select this group under "Private audience". This way, after you are finished, you can test installing your app with the Microsoft Store app before anybody else can see it.

{{< figure src="../pricing-availability-visibility-reverse.png" >}}

The default release schedule is fine, too: as soon as possible and with no end time for availability.

{{< figure src="../pricing-availability-schedule.png" >}}

The only thing that needs adjustments here is the pricing, which was set to "Free" in this case.

{{< figure class="text-center" src="../pricing-availability-price.png" >}}

{{< alert title="Note" color="info" >}}

KDE e.V. is currently investigating the financial and technical matters necessary for app developers to provide paid versions of their apps on the Microsoft Store. Once this becomes possible, you will be able to use this as an additional means for users to donate and support the project.

{{< /alert >}}

The rest can be left as is.

{{< figure src="../pricing-availability-rest.png" >}}

Afterwards, you can press the "Save draft" button at the bottom of the page.

{{< figure src="../pricing-availability-save.png" >}}

### Submission: Properties

On this page, you should see the following:

{{< figure class="text-center" src="../properties-original.png" >}}

The most important section is at the top.

{{< figure src="../properties-category.png" >}}

Very important: The category/subcategory for the store! People will not be able to locate your stuff easily if you choose a category that does not match your application.

{{< alert title="Warning" color="warning" >}}

You won't be able to change the category after setting it the first time. Choose well.

{{< /alert >}}

For example, Kile should be in something like "Productivity", like other tools of that kind.
If unsure, just browse through the Microsoft store and take a look at which kind of applications are where.

{{< figure src="../properties-support.png" >}}

KDE provides a [privacy policy website](https://kde.org/privacypolicy-apps/) you can link to.

Below that text field, insert the homepage of your application and the best means for a user to get in contact with you. Most applications should have some contact or support page for this.

At the bottom you can configure some other things like system requirements.

{{< figure src="../properties-requirements.png" >}}

Keyboard or Mouse input is required to interact with Kile. Your application might recommend Touch input as well.

After you are done, scroll down and press the "Save" button.

### Submission: Age ratings

For age ratings, just follow the instructions.

{{< figure class="text-center" src="../age-ratings-original.png" >}}

This is more or less what you would expect. As the typical KDE application doesn't contain sex, violence, or other content of that kind, this should be straightforward. Below is the input used for Kile.

{{< figure class="text-center" src="../age-ratings-filled-original.png" >}}

Of these, there are a few fields that might be of note for your application. If we were to use a few existing KDE apps as examples, User Content could apply to a chat app like [Neochat](https://apps.kde.org/neochat) or [Tokodon](https://apps.kde.org/tokodon).

{{< figure src="../age-ratings-filled-usercontent.png" >}}

Online Content could apply to an app that fetches content from the internet like the feed reader [Alligator](https://apps.kde.org/alligator).

{{< figure src="../age-ratings-filled-onlinecontent.png" >}}

And a web browser like [Falkon](https://apps.kde.org/falkon) or educational software like [GCompris](https://apps.kde.org/gcompris) would need a few ticked options in Miscellaneous:

{{< figure src="../age-ratings-filled-miscellaneous.png" >}}

After filling the required fields, just press "Save and generate" and the results will show up. If you see no issues, press "Continue" to finalize it. As shown, Kile is applicable to pretty much all ages.

{{< figure src="../age-ratings-results.png" >}}

### Submission: Packages

Now we get to submit the real installer: the `.appxupload` package KDE's GitLab creates for you.

{{< figure class="text-center" src="../packages-original.png" >}}

For example, for NeoChat, you can grab the latest release build from [KDE's CDN](https://cdn.kde.org/ci-builds/network/neochat/release-24.02/windows/).

Before you upload your package, please really test this manually first! Broken versions make for a very bad impression.

You can locally test the generated sideload `.appx` file on Windows just by double clicking on it to install it locally. You will have to uninstall a previously installed version first.

{{< figure src="../packages-upload.png" >}}

For operating systems, select at least "Windows 10 Desktop".

{{< figure src="../packages-version.png" >}}

After the package has been successfully uploaded and validated, press "Save" to be done here.

### Submission: Store listings

Store listings are shown differently for each language.

We start with the default, "English (United States)".

If you'd like, you can later add more languages there.

But keep in mind: you will need to update them manually on each new version. If you don't want to have the different languages with completely different store descriptions or screenshots.

To start with the English variant, click on the "English (United States)" link on the submission overview as seen below.

{{< figure class="text-center" src="../overview-store-listings.png" >}}

You will now end up on a page that allows to insert the usual stuff for an application store page.

{{< figure src="../store-listings.png" >}}

Important here are the following sections:

* Description
* What's new in this version (important for later update submission)
* Product features (this is a list; you can add new fields by clicking "Add more")
* Screenshots (the interface is a bit buggy so always take a look if e.g. the captions for the screenshots you added are still all right at the end of your editing)

A good location to grab this stuff from is the `.appdata.xml` file for your application.

For example for Kile you can grab this from the [KDE applications page for Kile](https://kde.org/applications/office/org.kde.kile).

After you are done, as always, press "Save" at the bottom of the page.

### Done => Press the button!

After you are done with this, you can just press the "Submit to the Store" button on the submission overview!

The application icon will show up properly in the web interface after the first submission is done, too.

{{< figure class="text-center" src="../submit-to-the-store.png" >}}

### What's next?

If you have your initial submitted application version in the store, updates are just new submissions.

Just head to the overview page of your application on the partner page and hit the "Update" button in the "Submissions" section. The data from the last submission will be retained, with a new field in the Store Listings page saying "What's new in this version".

The last remaining step to get your app visible in the Microsoft Store is another manual submission which just changes the visibility to "Public audience".

This is a good moment to have a last look at the information about the app before it is published. In particular, you may have to fill out the "Notes for certification", e.g. if your app cannot be tested without a service or social media account. For instance, NeoChat requires a test account for Matrix.

### The following submissions

As you have seen, the Store Listings page applies to every language you support. Given that KDE software is able to support over 100 languages, that becomes impractical very fast!

To address this issue, KDE has a script that manages new submissions in a semi-automatic manner via the official Microsoft Submission API, [submit-to-microsoft-store.py](https://invent.kde.org/sysadmin/ci-utilities/-/tree/master/microsoft-store).

The idea is that the script is run by a (manual) CI job as part of a full CI/CD pipeline. The app's developers or release managers can trigger the job if they want to publish a new version on the Microsoft Store.

To run the script locally you need the credentials for an Azure AD application associated with KDE's Partner Center account. Anything else you need to know is documented in the script's [README.md](https://invent.kde.org/sysadmin/ci-utilities/-/blob/master/microsoft-store/README.md).

