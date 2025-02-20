---
title: Using Python bindings for KDE Frameworks
weight: 10
group: bindings
description: >
    Extend your application with KDE libraries.
---

KDE provides Python bindings for some KDE libraries. The current list of available bindings can be seen on [Python support in KDE](https://invent.kde.org/teams/goals/streamlined-application-development-experience/-/issues/9). Most notably:

* [KCoreAddons](https://api.kde.org/frameworks/kcoreaddons/html/index.html)
  * [KAboutData](https://api.kde.org/frameworks/kcoreaddons/html/classKAboutData.html)
  * [KAboutLicense](https://api.kde.org/frameworks/kcoreaddons/html/classKAboutLicense.html)
  * [KSandbox](https://api.kde.org/frameworks/kcoreaddons/html/namespaceKSandbox.html)
* [KGuiAddons](https://api.kde.org/frameworks/kguiaddons/html/index.html)
  * [KSystemClipboard](https://api.kde.org/frameworks/kguiaddons/html/classKSystemClipboard.html)
  * [KCursorSaver](https://api.kde.org/frameworks/kguiaddons/html/classKCursorSaver.html)
  * [KColorUtils](https://api.kde.org/frameworks/kguiaddons/html/namespaceKColorUtils.html)
* [KWidgetsAddons](https://api.kde.org/frameworks/kwidgetsaddons/html/index.html)
  * [KMessageDialog](https://api.kde.org/frameworks/kwidgetsaddons/html/classKMessageDialog.html)
  * [KMessageBox](https://api.kde.org/frameworks/kwidgetsaddons/html/namespaceKMessageBox.html)
  * [KContextualHelpButton](https://api.kde.org/frameworks/kwidgetsaddons/html/classKContextualHelpButton.html)
  * [KFontChooser](https://api.kde.org/frameworks/kwidgetsaddons/html/classKFontChooser.html)
  * [KSeparator](https://api.kde.org/frameworks/kwidgetsaddons/html/classKSeparator.html)
* [KService](https://api.kde.org/frameworks/kservice/html/index.html)
  * [KService](https://api.kde.org/frameworks/kservice/html/classKService.html)
  * [KApplicationTrader](https://api.kde.org/frameworks/kservice/html/namespaceKApplicationTrader.html)
* [KNotifications](https://api.kde.org/frameworks/knotifications/html/index.html)
  * [KNotification](https://api.kde.org/frameworks/knotifications/html/classKNotification.html)
* [KUnitConversion](https://api.kde.org/frameworks/kunitconversion/html/index.html)
* [KXmlGui](https://api.kde.org/frameworks/kxmlgui/html/index.html)
  * [KXmlGuiWindow](https://api.kde.org/frameworks/kxmlgui/html/classKXmlGuiWindow.html)
  * [KActionCollection](https://api.kde.org/frameworks/kxmlgui/html/classKActionCollection.html)
  * [KBugReport](https://api.kde.org/frameworks/kxmlgui/html/classKBugReport.html)
  * [KToolBar](https://api.kde.org/frameworks/kxmlgui/html/classKToolBar.html)

## Bindings installation

To generate the KDE Frameworks bindings, their respective upstream libraries in C++ need to use [ECMGeneratePythonBindings](https://api.kde.org/ecm/module/ECMGeneratePythonBindings.html). When each project is built, it generates a CPython `.so` file that is typically installed under `/usr/lib64/python3.11/site-packages/` by Linux distributions. This makes it available to be used in Python scripts. If the `site-packages` files are installed elsewhere, you can force-use them in Python with `PYTHONPATH`.

In addition to that, the bindings need to be built against the same version of Qt as PySide.

Because of that, currently the easiest way to use KDE bindings is by using a distribution that has built KDE libraries with support for the Python bindings. As the bindings are still new, not all distributions will have bindings, so we recommend you to use [distrobox]({{< ref "containers-distrobox" >}}).

Currently only one distribution provides these bindings:

```bash
distrobox create --image archlinux --name arch
distrobox enter
sudo pacman -Syu
sudo pacman -S pyside6 kcoreaddons # Or any other required library
```

If you want a specific KDE library to be available as a Python binding, mention your interest in [Python support in KDE](https://invent.kde.org/teams/goals/streamlined-application-development-experience/-/issues/9) or on the [KDE Python Matrix group](https://go.kde.org/matrix/#/#kde-python:kde.org). If your distribution doesn't yet provide Python bindings for a KDE library that can already export them, you may request your distribution to do so. Lastly, feel free to contribute and make more libraries available as Python bindings!

## Reading C++ documentation for use in Python

Over the [KDE API documentation website](https://api.kde.org), when viewing a class, the top section of the page should list any includes as well as the project to which it belongs:

```txt
KDE API Reference / The KDE Frameworks / KCoreAddons
```

```cpp
#include <KAboutData>
```

In Python one would translate this to the following import:

```python
from KCoreAddons import KAboutData
```

---

Where in C++ you'd use:

```cpp
KAboutData aboutData(
    "foo", "Foo", "0.1",
    "To Foo or not To Foo",
    KAboutLicense::GPL,
    "Copyright 2017 Bar Foundation"), QString(),
    "https://www.foo-the-app.net");
aboutData.setDesktopFileName("org.barfoundation.foo"); 
KAboutData::setApplicationData(aboutData);

auto kdeIcon = QIcon::fromTheme(QStringLiteral("kde")
QApplication::setWindowIcon(kdeIcon);
```

In Python you'd write:

```python
aboutData = KAboutData(
    "foo", "Foo", "0.1",
    "To Foo or not To Foo",
    KAboutLicense.GPL,
    "Copyright 2017 Bar Foundation", "",
    "https://www.foo-the-app.net");
aboutData.setDesktopFileName("org.barfoundation.foo");
KAboutData.setApplicationData(aboutData);
 
kdeIcon = QIcon.fromTheme("kde")
QApplication.setWindowIcon(kdeIcon);
```

PySide6 [has no QString or QStringLiteral](https://wiki.qt.io/Qt_for_Python/Considerations), instead opting for the native Python [str type](https://docs.python.org/3/library/stdtypes.html#textseq). As such, the default `QString()` constructor which creates an empty QString can be replaced with `""`, and any `QStringLiteral()` can just be disconsidered.

Static functions which have `::` (like `QIcon::fromTheme()`) can be called instead with `.` in Python. The same applies to enums (like `KAboutLicense::GPL`).
