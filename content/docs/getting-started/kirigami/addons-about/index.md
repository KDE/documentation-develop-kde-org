---
title: FormCard About pages
description: Learn to create About pages to credit your application.
weight: 82
group: addons
---

Kirigami Addons is an additional set of visual components that work well on mobile and desktop and are guaranteed to be cross-platform. It uses Kirigami under the hood to create its components.

Some of those components allow you to credit your work and the work of other contributors in your project, as well as mention the frameworks being used in your application: [AboutKDE](https://api.kde.org/frameworks/kirigami-addons/html/classAboutKDE.html) and AboutPage.

## About KDE

Each new button we created in the previous step should open a new page. You can add new pages by instantiating them as [Components](docs:qtqml;QtQml.Component) and then using `pageStack.layers.push()` for each button to load that page in our `Main.qml`:

{{< readfile file="FirstAboutKDE.qml" highlight="qml" emphasize="16 26" >}}

That's it really! All it takes is instantiating `FormCard.AboutKDE`. You should see something like this after clicking the AboutKDE button:

{{< figure src="aboutkde.webp" class="text-center" >}}

## About Page

The application's AboutPage is slightly more complex, but it's still very simple to use.

For a simple about page that uses the data set in by `KAboutData::setApplicationData(aboutData);` in `main.cpp` add the following to your `Main.qml`:

{{< readfile file="SecondAboutPage.qml" highlight="qml" emphasize="21 38" >}}

The About page of our application should look like this:

{{< figure src="aboutpage.webp" class="text-center" >}}

### Using JSON instead of KAboutData

Instead of letting your about page get information from [KAboutData](docs:kcoreaddons;KAboutData), it is possible to pass a JSON object directly. You will still need to use [QApplication::setWindowIcon()](docs:qtwidgets;QApplication::setWindowIcon) in your `main.cpp` in order for your application icon to show up.

Create a `MyAboutPage.qml` like this:

{{< snippet repo="libraries/kirigami-addons" file="examples/FormCardTutorial/JsonAboutPage.qml" lang="cpp" >}}

And then adjust your `Main.qml` to include your new about page:

{{< readfile file="ThirdAboutPage.qml" highlight="qml" emphasize="21" >}}

The main JSON object here contains the keys `displayName`, `productName`, `homepage` and so on. The keys `authors`, `credits`, `translators` and `licenses` can each be passed an array of objects. The objects passed to `authors`, `credits` and `translators` share the same keys so that they can be displayed each in their own section, while `licenses` includes the keys `name`, `text` and `spdx` for each license added, as it is not uncommon for the same project to include multiple licenses.

These keys are optional, but a reasonable minimum amount of keys is expected to make your application have no empty fields: `displayName`, `version`, `description`, `homepage`, `copyrightStatement` and `authors`. You are encouraged to fill as many key as possible, however.
