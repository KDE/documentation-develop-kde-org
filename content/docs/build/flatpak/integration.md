---
title: Flatpak integration
description: Understanding the flatpak software stack
weight: 4
aliases:
  - /docs/flatpak/integration/
---

## Testing your flatpak

So far you have read about the [kdeapps](https://invent.kde.org/packaging/flatpak-kde-applications) repository, about remoteapps, and that it all integrates with [Binary Factory](https://binary-factory.kde.org/), which is a Jenkins instance to manage continuous integration (CI). In the case of Flathub, the place that hosts your application manifest is one of thousands of repositories belonging to the [Flathub organization on Github](https://github.com/flathub) that is managed by the package maintainer, the Flathub team, and in our case, the KDE Flatpak team. The CI management tool is called [Buildbot](https://buildbot.flathub.org/). Both CI tools will trigger new builds upon new commits to the respective repository.

It can be useful to check out specific commits of the Flatpak to figure out regressions in both packaging and the app. For such, flatpak allows you to downgrade your application to a specific commit or perform bisect on the flatpak commit log.

Downgrading your app is quite simple:

```bash
# Check the commit log
flatpak remote-info --log flathub org.kde.yourapp
# Checkout a certain commit
flatpak update --commit ab1234 org.kde.yourapp
```

And flatpak-bisect works similarly to git-bisect:

```bash
flatpak-bisect org.kde.yourapp start
flatpak-bisect org.kde.yourapp bad
# Check the log for a good commit
flatpak-bisect org.kde.yourapp log
flatpak-bisect org.kde.yourapp checkout ab1234
# Test your app and mark the commit as good or bad
```

For more information about downgrading, bisect and others, check out the [Flatpak Tips and Tricks](https://docs.flatpak.org/en/latest/tips-and-tricks.html).

### Debug and Locale

For every package that is created using `flatpak-builder`, a `.Debug` and a `.Locale` package are automatically generated. This is true for both local compilation and CI-compiled packages.

The `.Debug` package needs to be explicitly installed before it can be used, and it provides debug symbols for [debugging](https://docs.flatpak.org/en/latest/debugging.html) with tools like `gdb` inside the flatpak, like so:

```bash
flatpak install org.kde.yourapp.Debug
flatpak run --command=bash --devel org.kde.yourapp
gdb /app/bin/yourappbinary
```

The `.Locale` package comes with a default installation of your application, but can only be seen with `flatpak list --all`. It provides locale-specific files based on your default language or extra languages, which can be useful to check for internationalization issues like text wrapping, ellision and mistranslations. By default, flatpak will try to be smart and deduce the default language based on your locale settings, and the downloaded `.Locale` will only come with the languages listed in `languages` and `extra-languages` (if set), so a `flatpak update` is required to download more languages. For example:

```bash
# Make the default language German
flatpak config --set languages "de"
# List your current locale configuration
flatpak config # languages is set to de, extra-languages is unset
# This will update all .Locale packages to include German
flatpak update
# To run your application in German
flatpak run --env=LC_ALL=de_DE org.kde.yourapp
# Add Dutch and Spanish
flatpak config --set extra-languages "nl;es"
# Update all .Locale packages to include the new locales
flatpak update
# To run your application in Spanish
flatpak run --env=LC_ALL=es_ES org.kde.yourapp
```

### Flatpak Portals

Portals are high-level session bus APIs that provide selective access to resources to sandboxed applications, provided by libportal. The implicit expectation of portals is that the user will always be involved in granting or rejecting a portal request, thus most portal APIs will lead to user interaction in the form of dialogs.

Since such dialogs must fit into the user experience of the desktop shell, the portal APIs are implemented by a generic frontend called xdg-desktop-portal which calls out to desktop-specific implementations that provide the actual UI. The bus name through which the portal APIs are available is `org.freedesktop.portal.Desktop`, with the object path `/org/freedesktop/portal/desktop` implementing the various portal interfaces.

The KDE backend for Flatpak portals is called [xdg-desktop-portal-kde](https://invent.kde.org/plasma/xdg-desktop-portal-kde) and is now part of Plasma releases (starting with Plasma 5.10). Currently it supports most of the portals.

Generally speaking, portals will be important to you only if you are a Flatpak maintainer who also contributes with code, and in particular neither libportal or xdg-desktop-portal will matter much to you as a developer who uses Qt/KDE Frameworks, only xdg-desktop-portal-kde.

We provide [a simple test app to showcase the use of portals](https://invent.kde.org/libraries/xdg-portal-test-kde). It gets more updates as we implement more portals.

Qt apps should require very few tweaks to utilize portals, if any, and your app will probably already integrate correctly from the start, so simple it is.

Qt without portals already tries to use the native file dialog by default. For portals to be used in the flatpak, use the QtWidgets [QFileDialog](https://doc.qt.io/qt-6/qfiledialog.html) class and the QtQuick.Dialogs [FileDialog](https://doc.qt.io/qt-6/qml-qtquick-dialogs-filedialog.html) type.

For native notifications, you should use [KNotification](https://api.kde.org/frameworks/knotifications/html/classKNotification.html). Use [`QDesktopServices::openUrl(const QUrl &url)`](https://doc.qt.io/qt-6/qdesktopservices.html#openUrl) or [KIO::OpenUrlJob](https://api.kde.org/frameworks/kio/html/classKIO_1_1OpenUrlJob.html) to open URIs or send an email when using `mailto`.

For global menus to work, you simply use [QMenuBar](https://doc.qt.io/qt-6/qmenubar.html) or a helper class that manages them for you, as is the case with [QMainWindow](https://doc.qt.io/qt-6/qmainwindow.html) and [KXmlGuiWindow](https://api.kde.org/frameworks/kxmlgui/html/classKXmlGuiWindow.html).

In order to debug portals in your application, you must first kill the running `xdg-desktop-portal-kde` instance, then start `xdg-desktop-portal-kde` with:

```bash
QT_LOGGING_RULES='xdg-desktop*.debug=true' /usr/lib/$(uname -m)-linux-gnu/libexec/xdg-desktop-portal-kde
```

then in another terminal session restart xdg-desktop-portal with:

```bash
G_MESSAGES_DEBUG=all /usr/libexec/xdg-desktop-portal --verbose --replace
```

You should then see debug output similar to:

```bash
xdg-desktop-portal-kde: Desktop portal registered successfuly
xdg-desktop-portal-kde-file-chooser: OpenFile called with parameters:
xdg-desktop-portal-kde-file-chooser:     handle:  "/org/freedesktop/portal/desktop/request/1_255/t"
xdg-desktop-portal-kde-file-chooser:     parent_window:  "x11:1"
xdg-desktop-portal-kde-file-chooser:     title:  "Flatpak test - open dialog"
xdg-desktop-portal-kde-file-chooser:     options:  QMap(("accept_label", QVariant(QString, "Open (portal)"))("filters", QVariant(QDBusArgument, ))("modal", QVariant(bool, true))("multiple", QVariant(bool, true)))
```

You can see which portal has been called, whether it has been called or when you check output from xdg-desktop-portal then you should see a message in case of portal error (usually related to DBus). You can also monitor dbus messages using `dbus-monitor`, which indicates whether portals get involved at all as everything goes through DBus.

### Theming

By default, if your Flatpak does not forcibly ship very custom themes, it should integrate properly with the user's system, especially on Plasma; furthermore, Flatpak tries to be smart and install the required themes for the application to run well on your system if they are missing, such as the Breeze GTK Theme (`org.gtk.Gtk3theme.Breeze`) which is used by Electron apps. The user is expected *not* to set the flatpak's individual theme, but their system's theme, to integrate your application. Your flatpak will then attempt to match the installed flatpak theme to the system's theme.

However, it might still interest you to verify that your application looks good or whether it shows theming issues in other desktop environments. In such cases, you will want to search for KStyles or PlatformThemes on Flathub and test your Flatpak in that DE, for instance, the KStyle used to integrate your application to the GNOME High Contrast theme for accessibility, `org.kde.KStyle.HighContrast`.



