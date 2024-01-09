---
title: FormCard About pages
description: Learn to create About pages to credit your application.
weight: 402
group: addons
---

Kirigami Addons is an additional set of visual components that work well on mobile and desktop and are guaranteed to be cross-platform. It uses Kirigami under the hood to create its components.

Some of those components allow you to credit your work and the work of other contributors in your project, as well as mention the frameworks being used in your application: [AboutKDE](https://api.kde.org/frameworks/kirigami-addons/html/classAboutKDE.html) and AboutPage.

## About KDE

Each new button we created in the previous step should open a new page. You can add new pages by instantiating them as [Components](docs:qtqml;QtQml.Component) and then using `pageStack.layers.push()` for each button to load that page in our `main.qml`:

{{< readfile file="FirstAboutKDE.qml" highlight="qml" >}}

That's it really! All it takes is instantiating `FormCard.AboutKDE`. You should see something like this after clicking the AboutKDE button:

{{< figure src="aboutkde.webp" class="text-center" >}}

## About Page

The application's AboutPage is slightly more complex, but it's still very simple to use. We will be adding a new QML file that will contain the information needed for our about page. First in our `resources.qrc` file:

```
<RCC version="1.0">
<qresource prefix="/">
    <file alias="main.qml">contents/ui/main.qml</file>
    <file alias="MyAboutPage.qml">contents/ui/MyAboutPage.qml</file>
</qresource>
</RCC>
```

And our `contents/ui/MyAboutPage.qml` should have the following:

{{< snippet repo="libraries/kirigami-addons" file="examples/FormCardTutorial/contents/ui/MyAboutPage.qml" lang="cpp" >}}

Here we use the information we set using [KAboutData](docs:kcoreaddons;KAboutData) in our `main.cpp`. Here's a brief reminder of what is in `main.cpp`:

```cpp
qmlRegisterSingletonType(
    "org.kde.about",        // <========== used in the import
    1, 0, "About",          // <========== C++ object exported as a QML type
    [](QQmlEngine *engine, QJSEngine *) -> QJSValue {
        return engine->toScriptValue(KAboutData::applicationData());
    }
);
```

The `About` object we exported to the QML side using [qmlRegisterSingletonType()](docs:qtqml;QQmlEngine::qmlRegisterSingletonType) contains the data from [KAboutData::applicationData()](docs:kcoreaddons;KAboutData::applicationData), and that is what we pass to the `aboutData` property.

Lastly, we add our new MyAboutPage to our `main.qml`:

{{< readfile file="SecondAboutPage.qml" highlight="qml" >}}

The About page of our application should look like this:

{{< figure src="aboutpage.webp" class="text-center" >}}

### Using JSON instead of KAboutData

If you were wondering why the About page was kept separate rather than embedded in `main.qml`, that is because it allows to set a custom model for the `aboutData` property.

Instead of letting your about page get information from [KAboutData](docs:kcoreaddons;KAboutData), it is possible to pass a JSON object directly. You will still need to use [QApplication::setWindowIcon()](docs:qtwidgets;QApplication::setWindowIcon) in your `main.cpp` in order for your application icon to show up.

Change your `MyAboutPage.json` to something like this:

{{< snippet repo="libraries/kirigami-addons" file="examples/FormCardTutorial/contents/ui/JsonAboutPage.qml" lang="cpp" >}}

The main JSON object here contains the keys `displayName`, `productName`, `homepage` and so on. The keys `authors`, `credits`, `translators` and `licenses` can each be passed an array of objects. The objects passed to `authors`, `credits` and `translators` share the same keys so that they can be displayed each in their own section, while `licenses` includes the keys `name`, `text` and `spdx` for each license added, as it is not uncommon for the same project to include multiple licenses.

These keys are optional, but a reasonable minimum amount of keys is expected to make your application have no empty fields: `displayName`, `version`, `description`, `homepage`, `copyrightStatement` and `authors`. You are encouraged to fill as many key as possible, however.
