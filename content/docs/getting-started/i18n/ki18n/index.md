---
title: "KI18n"
weight: 2
description: >
  Using the KDE internationalization framework
---

[KI18n](https://api.kde.org/ki18n-index.html) is KDE's library for *internationalization*, where the "18" stands for the 18 letters between "i" and "n" in the word internationalization.

Internationalization in this context is the process of making software ready for translation, something the developer needs to do. Localization is what translators do.

As mentioned in [Overview: gettext and xgettext]({{< ref gettext >}}), the KI18n library wraps gettext's library, `libintl.h`, and provides more features on top of it.

KI18n's most notable feature is its [9 main i18n() functions](https://api.kde.org/klocalizedstring.html), which make it easy to add context, specify plurals, or even choose the message catalog to put strings in. Their use is described in the [KI18n Programmer's Guide](https://invent.kde.org/frameworks/ki18n/-/blob/master/docs/programmers-guide.md).

Its second most notable feature is its [User interface markers](https://invent.kde.org/frameworks/ki18n/-/blob/master/docs/programmers-guide.md#user-interface-markers), which provide quickly-typed keywords to signal to translators where in the application's user interface the string is located.

## Getting started with KI18n

The following requires that you have already read our [Kirigami tutorial]({{< ref "/docs/getting-started/kirigami" >}}), especially [Figuring out main.cpp]({{< ref "advanced-maincpp" >}}).

To make a KDE project using C++ translatable under KDE infrastructure:

1. Link the KI18n library in CMake
2. Include the [ki18n_install(po)](https://invent.kde.org/frameworks/ki18n/-/blob/master/cmake/KF6I18nMacros.cmake.in#L80) CMake macro
3. Initialize the KI18n library in code
4. Use i18n() functions in code
5. Create a [Messages.sh]({{< ref "scripty" >}}) file

Linking the library and including its CMake macro is done like so in your project's `CMakeLists.txt` file:

```cmake
find_package(KF6I18n REQUIRED)
# ...
target_link_libraries(yourapp PRIVATE KF6::I18n)
ki18n_install(po)
```

Or with extra-cmake-modules set up:

```cmake
find_package(KF6 REQUIRED COMPONENTS I18n)
# ...
target_link_libraries(yourapp PRIVATE KF6::I18n)
ki18n_install(po)
```

Initializing the library in code can be done using just [KLocalizedString::setApplicationDomain("yourappname")](https://api.kde.org/klocalizedstring.html#setApplicationDomain) for C++ only projects, with an additional [KLocalization::setupLocalizedContext(&engine)](https://api.kde.org/klocalizedqmlcontext.html#setupLocalizedContext) if your project uses QML:

```cpp
#include <QApplication>
#include <QQmlApplicationEngine>
#include <KLocalizedQmlContext>
#include <KLocalizedString>
#include <KAboutData>
#include <KirigamiAppDefaults>

int main(int argc, char* argv[])
{
    QApplication app(argc, argv);
    KirigamiAppDefaults::apply(&app);
    KLocalizedString::setApplicationDomain("yourappname"); // <-
    KAboutData about("yourappname",
                     i18n("Your user-facing translatable app name"),
                     "0.1",
                     i18n("Translatable app description shown in About page"),
                     KAboutLicense::GPL_V3,
                     i18n("© 2025 KDE Community"));
    // ...
    
    QQmlApplicationEngine engine;
    KLocalization::setupLocalizedContext(&engine); // <-
    engine.loadFromModule("org.kde.yourappname", "Main");
    QApplication::exec();
}
```

It is a good idea to set the KAboutData `yourappname` (the [componentName](https://api.kde.org/kaboutdata.html#componentName-prop)) to the same name used as the KLocalizedString `applicationDomain` for consistency. The former is the internal application name, while the latter will be the name of the translation catalog (POT file).

Lastly, for [Scripty and string extraction]({{< ref "scripty" >}}) to generate POT files, you will need to create a `Messages.sh` file in the root of your project's repository. For a typical QML project, this could look like:

```bash
#!/usr/bin/env bash
# SPDX-FileCopyrightText: None
# SPDX-License-Identifier: CC0-1.0
$XGETTEXT `find . \( -name \*.cpp -o -name \*.h \)` -o $podir/yourappname.pot
$XGETTEXT --join-existing --language=JavaScript $(find . -name \*.qml -o -name \*.js) -o "$podir"/yourappname.pot
```

Remember to replace the "yourappname" placeholder in all the examples mentioned above.

## i18n() functions

Once KI18n is initialized, it is then possible to use i18n() functions in the [C++ side](https://api.kde.org/klocalizedstring.html#related-non-members) and in the [QML side](https://api.kde.org/qml-org-kde-ki18n-ki18n.html). This is best described in the [KI18n Programmer's Guide](https://invent.kde.org/frameworks/ki18n/-/blob/master/docs/programmers-guide.md), but the essentials will be mentioned here.

The most relevant `i18n()` functions are:

* `i18n(string)`: only the translatable string
* `i18nc(context, string)`: string with **c**ontext
* `i18np(singular, plural)`: string with **p**lural
* `i18ncp(context, singular, plural)`: string with **c**ontext and **p**lural

In QML, while it is possible to use these functions as is, the functions will not be findable by language server providers (LSPs, like qmlls). Instead, you need to prefix these functions with `KI18n`, as mentioned next.

### i18n()

In C++, just call `i18n()` in your code.

In QML, import the `org.kde.ki18n` QML module. If a string needs to be translated, the bare minimum is for it to be wrapped in the `KI18n.i18n("string")` function. Whenever possible, prefer a function variant that provides context instead, like [i18nc()]({{< ref "#i18nc" >}}).

Always use double quotes even in QML code, otherwise xgettext/Scripty will not extract messages.

```qml
import QtQuick
import QtQuick.Controls
import org.kde.kirigami as Kirigami
import org.kde.ki18n

Kirigami.FormLayout {
    CheckBox {
        Kirigami.FormData.label: KI18n.i18n("Show popup:")
        text: KI18n.i18n("Enabled")
    }
}
```

### i18nc()

Always prefer this function and its variants over [i18n()]({{< ref "#i18n" >}}), unless the translated string is exceedingly obvious without context, and even then you should prefer this function.

In C++, just call `i18nc()` in your code.

In QML, import the `org.kde.ki18n` QML module.

The `KI18n.i18nc("context", "string")` function allows to specify context for translators. This context can be:

* a string you type to describe where in the user interface the message is, or what the component does
* a [User-interface marker](https://invent.kde.org/frameworks/ki18n/-/blob/master/docs/programmers-guide.md#user-interface-markers)
* both, with the user-interface marker coming first, still in the same function argument

Let's say the previous example was a checkbox for toggling convenience controls in a video player:

```qml
import QtQuick
import QtQuick.Controls
import org.kde.kirigami as Kirigami
import org.kde.ki18n

Kirigami.FormLayout {
    CheckBox {
        Kirigami.FormData.label: KI18n.i18nc("@label Play video", "Play:")
        text: KI18n.i18nc("@option:check Play video", "On single click")
    }
    CheckBox {
        text: KI18n.i18nc("@option:check Play video", "On double click")
    }
}
```

This communicates that all three controls are related, where the first is the grouping label for the other two checkboxes, and that they are used specifically to configure video player behavior, not audio or games. All without the translator having to open the application and hunt for that specific string to check its context.

For more details, see [KI18n Programmer's Guide: Writing Good Contexts](https://invent.kde.org/frameworks/ki18n/-/blob/master/docs/programmers-guide.md#writing-good-contexts).

### Variables in i18n() functions

Relevant `i18n()` functions have an overload that allows you to pass values into the translation with a variable *placeholder*: 

* [i18n(string, variable1, variable2)](https://api.kde.org/klocalizedstring.html#i18n): string with variables
* [i18nc(context, string, variable1, variable2)](https://api.kde.org/klocalizedstring.html#i18nc): string with context and variables
* [i18np(singular, plural, variable1, variable2)](https://api.kde.org/klocalizedstring.html#i18np): string with plural and variables
* [i18ncp(context, singular, plural, variable1, variable2)](https://api.kde.org/klocalizedstring.html#i18ncp): string with context, plural, and variables

Place `%1` where you want the first variable to be substituted, and `%2` where the second should go, up to a maximum of nine. However, [avoid overusing placeholders](https://invent.kde.org/frameworks/ki18n/-/blob/master/docs/programmers-guide.md#no-word-puzzles), and as a general rule, if you are using more than two placeholders, it may be possible that you need to use another `i18n()` function instead.

```qml
Item {
    id: showThing
    property int unreadEmailCount: 3
    Plasmoid.toolTipSubText: KI18n.i18n("%1 unread emails", unreadEmailCount)
}
```

Translators receive the string as it is in source code with the variable placeholder in their POT files, that is, "%1 unread emails". This way, if their target language requires rearranging the position of placeholders, translators can do this at translation time.

### Plurals in i18n() functions

In English, a translated sentence is different when there's just 1 item (singular) from when there is 2 or more items (plural). The functions `i18np()` and `i18ncp()` can be used in such a situation:

* `i18np(singular, plural)`: string with plural
* `i18ncp(context, singular, plural)`: string with context and plural

Improving the previous example, if `unreadEmailCount` were 1 at runtime, the tooltip would read "1 unread email". In this case it is 3, so the tooltip reads "3 unread emails":

```qml
Item {
    id: showThing
    property int unreadEmailCount: 3
    Plasmoid.toolTipSubText: KI18n.i18np("%1 unread email", "%1 unread emails", unreadEmailCount)
}
```

Translators receive both strings with placeholders in their POT files. Lokalize will show two tabs in its interface, one for singular ("%1 unread email") and another for plural ("%1 unread emails"), when selecting that message for translation.

Languages can have more plural forms than English does, and their plural forms may differ from the English plural form, but `i18np()` and `i18ncp()` should be able to cover them. 

For more details, see [KI18n Programmer's Guide: General Messages](https://invent.kde.org/frameworks/ki18n/-/blob/master/docs/programmers-guide.md#general-messages) and [KI18n Programmer's Guide: Specialized Messages](https://invent.kde.org/frameworks/ki18n/-/blob/master/docs/programmers-guide.md#specialized-messages). If you are struggling to figure out how to do plurals, ask questions in the [main Localization room](https://go.kde.org/matrix/#/#kde-i18n:kde.org) on [Matrix](https://community.kde.org/Matrix).

## ki18n_install()

The [ki18n_install(po)](https://invent.kde.org/frameworks/ki18n/-/blob/master/cmake/KF6I18nMacros.cmake.in#L80) CMake macro mentioned in [Getting started with KI18n]({{< ref "#getting-started-with-ki18n" >}}) is made available once you add KI18n to your CMakeLists.txt with `find_package()`, and its documentation is [available in the KI18n repository](https://invent.kde.org/frameworks/ki18n/-/blob/master/cmake/KF6I18nMacros.cmake.in#L80).

It searches for PO files present in `po/<langcode>/` in the translated project's repository, and then runs gettext's `msgfmt` to turn them into binary MO files. This is a necessary step, as outlined in [Overview: gettext and xgettext]({{< ref "gettext" >}}).

The list of language codes can be seen in `/usr/share/locale/`.

The MO files get installed to `/usr/share/locale/<langcode>/LC_MESSAGES` or equivalent on your Linux distribution, or `projectdir/data/locale/<langcode>/LC_MESSAGES` on Windows. When your application is run, it will search this path by default, looking for any translations.

If the operating system is using a specific locale, say `fr` (French), the application will load the relevant `fr` MO files and substitute the translatable English strings with French ones at runtime. On Linux, the relevant environment variables used to detect the operating system's locale are `LANG` and `LANGUAGE`, which are useful when [Testing translations locally]({{< ref "po-and-mo" >}}).

This processing and installation of PO files is enabled by default and will always trigger during compilation/installation. As mentioned in [Building KDE software: Tips and Tricks]({{< ref "kde-builder-tips" >}}), it is possible to disable running `msgfmt` at compile time using the CMake option `-DKF_SKIP_PO_PROCESSING=ON`, but other than that specific use case disabling PO processing should be avoided.
