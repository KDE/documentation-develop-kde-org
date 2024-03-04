---
title: Flatpak integration
description: Understanding the Flatpak software stack
weight: 4
aliases:
  - /docs/flatpak/integration/
---

## Testing your Flatpak

So far you have read about the [kdeapps](https://invent.kde.org/packaging/flatpak-kde-applications) repository, about remoteapps, and that it all integrates with [KDE's GitLab](https://invent.kde.org/). In the case of Flathub, the place that hosts your application manifest is one of thousands of repositories belonging to the [Flathub organization on Github](https://github.com/flathub) that is managed by the package maintainer, the Flathub team, and in our case, the KDE Flatpak team. The CI management tool is called [Buildbot](https://buildbot.flathub.org/). Both CI tools will trigger a new build after every new commit in the respective repository.

It can be useful to check out specific commits of the Flatpak to figure out regressions in both packaging and the app. For this purpose, Flatpak allows you to downgrade your application to a specific commit or perform a bisect operation on the Flatpak commit log.

Downgrading your app is quite simple:

```bash
# Check the commit log
flatpak remote-info --log flathub org.kde.yourapp
# Checkout a certain commit
flatpak update --commit ab1234 org.kde.yourapp
```

And `flatpak-bisect` works similarly to `git bisect`:

```bash
flatpak-bisect org.kde.yourapp start
flatpak-bisect org.kde.yourapp bad
# Check the log for a good commit
flatpak-bisect org.kde.yourapp log
flatpak-bisect org.kde.yourapp checkout ab1234
# Test your app and mark the commit as good or bad
```

For more information about downgrading, bisecting, and other operations, check out the [Flatpak Tips and Tricks](https://docs.flatpak.org/en/latest/tips-and-tricks.html).

### Debug and Locale

For every package that is created using `flatpak-builder`, a `.Debug` and a `.Locale` package are automatically generated. This is true for both local compilation and CI-compiled packages.

The `.Debug` package needs to be explicitly installed before it can be used, and it provides debug symbols for [debugging](https://docs.flatpak.org/en/latest/debugging.html) with tools like `gdb` inside the Flatpak, like so:

```bash
flatpak install org.kde.yourapp.Debug
flatpak run --command=bash --devel org.kde.yourapp
gdb /app/bin/yourappbinary
```

The `.Locale` package is installed alongside a normal installation of your application, but can only be seen with `flatpak list --all`. It provides locale-specific files based on your default language or extra languages, which can be useful to check for internationalization issues like text wrapping, elision, and mistranslations. By default, Flatpak will try to be smart and deduce the default language based on your locale settings, and the downloaded `.Locale` will only include the languages listed in `languages` and `extra-languages` (if set), so a `flatpak update` is required to download more languages. For example:

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

Portals allow a sandboxed application to interact with the rest of the system in a way that is explicitly approved and directed by the user. They are high-level session bus APIs provided by the libportal. The implicit expectation of portals is that the user will always be involved in granting or rejecting a portal request; thus most portal APIs will lead to user interaction in the form of dialogs.

Since such dialogs must fit into the user experience of the desktop shell, the portal APIs are implemented by a generic frontend called xdg-desktop-portal which calls out to desktop-specific implementations that provide the actual UI. The bus name through which the portal APIs are available is `org.freedesktop.portal.Desktop`, with the object path `/org/freedesktop/portal/desktop` implementing the various portal interfaces.

The KDE backend for Flatpak portals is called [xdg-desktop-portal-kde](https://invent.kde.org/plasma/xdg-desktop-portal-kde) and has been included with Plasma since version 5.10. Currently it supports most of the portals.

Generally speaking, portals will be important to you only if you are a Flatpak maintainer who also contributes with code, and in particular neither libportal or xdg-desktop-portal will matter much to you as a developer who uses Qt/KDE Frameworks, only xdg-desktop-portal-kde.

KDE provides [a simple test app to showcase the use of portals](https://invent.kde.org/libraries/xdg-portal-test-kde). It gets more updates as support for more portals is implemented.

Qt-based apps should require few if any tweaks to utilize portals, and your app will probably already integrate correctly from the start. But it is important to test and verify this.

Qt without portals already tries to use the native file dialog by default&mdash;meaning the KDE file dialog when the app is run on Plasma, and the GTK file dialog when run on GNOME. This works for portalized Flatpak apps too, as long as you are using the correct APIs: QtWidgets' [QFileDialog](https://doc.qt.io/qt-6/qfiledialog.html) in C++ code, and the QtQuick.Dialogs [FileDialog](https://doc.qt.io/qt-6/qml-qtquick-dialogs-filedialog.html) component in QML code.

For native notifications, you should use [KNotification](https://api.kde.org/frameworks/knotifications/html/classKNotification.html). Use [QDesktopServices::openUrl(const QUrl &url)](https://doc.qt.io/qt-6/qdesktopservices.html#openUrl) or [KIO::OpenUrlJob](https://api.kde.org/frameworks/kio/html/classKIO_1_1OpenUrlJob.html) to open URIs or send an email when using `mailto`.

For global menus to work, you simply use [QMenuBar](https://doc.qt.io/qt-6/qmenubar.html) or a helper class that manages them for you, as is the case with [QMainWindow](https://doc.qt.io/qt-6/qmainwindow.html) and [KXmlGuiWindow](https://api.kde.org/frameworks/kxmlgui/html/classKXmlGuiWindow.html).

In order to get debug messages related to portals in your application, we first need to make a few changes to the services that manage portals:

* Run `systemctl edit --full --user plasma-xdg-desktop-portal-kde`
* Add the `Environment="QT_LOGGING_RULES=xdg-desktop*.debug=true"` line under the `[Service]` section
* Add the `StandardOutput=journal` line under the `[Service]` section
* Add the `StandardError=journal` line under the `[Service]` section
* Save and close the editor

* Run `systemctl edit --user --full xdg-desktop-portal`
* Add `--verbose` to the end of the `ExecStart` line
* Add the `StandardOutput=journal` line under the `[Service]` section
* Add the `StandardError=journal` line under the `[Service]` section
* Add the `Environment="G_MESSAGES_DEBUG=all"` line under the `[Service]` section
* Save and close the editor

* Run `systemctl restart --user plasma-xdg-desktop-portal-kde`
* Run `systemctl restart --user xdg-desktop-portal`

Then, by running `journalctl --follow` in a terminal window and running any portal-using application (such as Flatpak'd apps) it is possible to see which portals have been requested by the application, and any error messages (often related to DBus). Likewise, you may filter the log to only `xdg-desktop-portal` or `plasma-xdg-desktop-portal-kde` with `journalctl --user-unit <service here>`. You can also monitor DBus messages using `dbus-monitor`, which indicates whether portals get involved at all, as everything goes through DBus.

{{< alert title="Note" color="info" >}}
If the debug output gets overly polluted, you can disable standard output or standard error logging easily by editing the service again.
{{< /alert >}}

### Theming

If your Flatpak does not hardcode its own app-specific theme, it should integrate properly with the user's system, especially on Plasma, where user theming is common. Flatpak tries to be smart and install the required themes for the application to run well on your system if they are missing, such as the Breeze GTK Theme (`org.gtk.Gtk3theme.Breeze`) which is used by Electron apps. The user is expected *not* to set the Flatpak's individual theme, but their system's theme, to integrate your application. Your Flatpak will then attempt to match the installed Flatpak theme to the system's theme.

However, it is still a good idea to test your application in other desktop environments to ensure that it looks good and doesn't exhibit any theming issues. In such cases, you will want to search for KStyles or PlatformThemes on Flathub and test your Flatpak in that DE. For example, the `org.kde.KStyle.HighContrast` KStyle is used to integrate your application with the GNOME High Contrast theme.



