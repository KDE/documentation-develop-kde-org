---
title: Using Python bindings for KDE Frameworks
weight: 10
group: bindings
description: >
    Extend your application with KDE libraries.
---

KDE provides Python bindings for some KDE libraries. The current list of available bindings can be seen on [Python support in KDE](https://invent.kde.org/teams/goals/streamlined-application-development-experience/-/issues/9). Most notably:

* [KCoreAddons](https://api.kde.org/kcoreaddons-index.html)
  * [KAboutData](https://api.kde.org/kaboutdata.html)
  * [KAboutLicense](https://api.kde.org/kaboutlicense.html)
  * [KSandbox](https://api.kde.org/ksandbox.html)
* [KGuiAddons](https://api.kde.org/kguiaddons-index.html)
  * [KSystemClipboard](https://api.kde.org/ksystemclipboard.html)
  * [KCursorSaver](https://api.kde.org/kcursorsaver.html)
  * [KColorUtils](https://api.kde.org/kcolorutils.html)
* [KWidgetsAddons](https://api.kde.org/kwidgetsaddons-index.html)
  * [KMessageDialog](https://api.kde.org/kmessagedialog.html)
  * [KMessageBox](https://api.kde.org/kmessagebox.html)
  * [KContextualHelpButton](https://api.kde.org/kcontextualhelpbutton.html)
  * [KFontChooser](https://api.kde.org/kfontchooser.html)
  * [KSeparator](https://api.kde.org/kseparator.html)
* [KStatusNotifierItem](https://api.kde.org/kstatusnotifieritem-index.html)
  * [KStatusNotifierItem](https://api.kde.org/kstatusnotifieritem.html)
* [KNotifications](https://api.kde.org/knotifications-index.html)
  * [KNotification](https://api.kde.org/knotification.html)
* [KUnitConversion](https://api.kde.org/kunitconversion-index.html)
* [KXmlGui](https://api.kde.org/kxmlgui-index.html)
  * [KXmlGuiWindow](https://api.kde.org/kxmlguiwindow.html)
  * [KActionCollection](https://api.kde.org/kactioncollection.html)
  * [KBugReport](https://api.kde.org/kbugreport.html)
  * [KToolBar](https://api.kde.org/ktoolbar.html)

## Bindings installation

Like with Kirigami and PySide6/PyQt6, the bindings need to be built against the same version of Qt used for PySide6/PyQt6.

Because of this, currently the easiest way to use KDE bindings is by using a distribution that has built KDE libraries with support for the Python bindings. As the bindings are still new, not all distributions will have bindings, so we recommend you to use [distrobox]({{< ref "containers-distrobox" >}}). Use either Fedora **Rawhide**, openSUSE **Tumbleweed**, or Arch Linux.

{{< installpackage
    fedora="python3-kf6-kcoreaddons python3-kf6-kguiaddons python3-kf6-knotifications python3-kf6-kunitconversion python3-kf6-kwidgetsaddons python3-kf6-kxmlgui python3-kf6-kstatusnotifieritem"
    opensuse="python3-kf6-kcoreaddons python3-kf6-kguiaddons python3-kf6-kjobwidgets python3-kf6-knotifications python3-kf6-kstatusnotifieritem python3-kf6-kunitconversion python3-kf6-kwidgetsaddons python3-kf6-kxmlgui"
    arch="kcoreaddons kguiaddons knotifications kunitconversion kwidgetsaddons kxmlgui kstatusnotifieritem" >}}

{{< alert color="info" title="Contributing to the bindings" >}}

<details>
<summary>Click here to read how to contribute or request for bindings</summary></br>

If you want a specific KDE library to be available as a Python binding, mention your interest in [<ins>Python support in KDE<ins>](https://invent.kde.org/teams/goals/streamlined-application-development-experience/-/issues/9) or on the [<ins>KDE Python Matrix group</ins>](https://go.kde.org/matrix/#/#kde-python:kde.org). If your distribution doesn't yet provide Python bindings for a KDE library that can already export them, you may request your distribution to do so. Lastly, feel free to [<ins>Send a merge request</ins>](https://community.kde.org/Infrastructure/GitLab) and make more libraries available as Python bindings!

To generate the KDE Frameworks bindings, their respective upstream libraries in C++ need to use [<ins>ECMGeneratePythonBindings</ins>](https://api.kde.org/ecm/module/ECMGeneratePythonBindings.html). When each project is built, it generates a CPython `.so` file that is typically installed under `/usr/lib64/python3.11/site-packages/` by Linux distributions. This makes it available to be used in Python scripts. If the `site-packages` files are installed elsewhere, you can force-use them in Python with `PYTHONPATH`.

</details>

{{< /alert >}}

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
