---
title: Desktop file
weight: 5
group: features
description: >
  Let your application show up in the Launcher and in application menus.
aliases:
  - /docs/features/desktop-file/
---

In order for your application to show up in menus and/or be automatically associated with MIME types in file browsers, you need to provide a `.desktop` file like follows: 

{{< highlight ini >}}
[Desktop Entry]
Type=Application
Exec=your-app %u
TryExec=your-app
MimeType=application/x-your-mime-type;
Icon=some-icon
X-DocPath=yourapp/index.html
Terminal=false
Name=Your App
GenericName=Some Generic Name
Comment=Short Description Of Your App
Categories=Qt;KDE;
{{< /highlight >}}

Take a look at the [.desktop Freedesktop Spec](http://standards.freedesktop.org/desktop-entry-spec/latest/) to find out more about the key/value pairs above.

The `Name`, `Type`, and `Exec` fields are essential. `Name` is self explanatory. `Type=Application` defines your application as a program that shows up on the menu. `Exec` is the command used to run your application.

The command passed to `TryExec` is used to test to see if the application is actually installed on the system. That is to say, if a command cannot be accessed from the `$PATH` (usually the case when the user creates their own custom `.desktop` files and uninstalls the application), the entry will not show up on the menu.

`Icon` can use the path to an icon shipped with your application or a file name available in the system. `Terminal=false` states your application doesn't need to be run in a terminal before it is executed, and it is commonly used for GUI applications.

It's important to pick a good set of `Categories` to make your application discoverable. If this is left blank, your application will be put into a category called "Lost N Found". The list of categories is separated by colons `;`. 

The `MimeType` field describes the MIME types used by your application, meaning it will influence whether your app will show up as an available option to open or run a certain file. For example, a plain text editor would use `plain/text` to show up when right clicking a text file and selecting "Open With", and an email application could use `x-scheme-handler/mailto` to respond to `mailto:/` URIs. The list of MIME types is separated by colons `;`, and you can find a comprehensive list of MIME types used on Linux over the [shared-mime-info repository](https://gitlab.freedesktop.org/xdg/shared-mime-info).

## Translations

Like you can see on the example `.desktop` file, only an English version is available. To translate it to more languages, you can add a [lang] suffix to the keys you want to translate. A comprehensive list of suffixes is available [here](https://l10n.kde.org/teams-list.php). For example:

```ini
Name=Your Application
Name[fr]=Ton application
...
GenericName=Some Generic Name
GenericName[fr]=Un nom générique
```

If you are using KDE infrastructure, you should **not** translate your `.desktop` file yourself. We have a bot named "Scripty" that extracts the text from `.desktop` files into `.po` (gettext) files, which are then sent to KDE translators. In turn, once the translators have done their work, Scripty fetches the translated text back and inserts it into the `.desktop` file.

## Install the .desktop file

In your `CMakeLists.txt`, you can add the following lines to install your `.desktop` file:

```cmake
install(FILES org.example.my-app.desktop DESTINATION ${KDE_INSTALL_APPDIR})
```
