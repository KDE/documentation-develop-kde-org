---
title: Desktop File
weight: 5
group: features
description: >
  Let your application show up in the Launcher and in application menus.
aliases:
  - /docs/desktop-file/
---

In order for your application to show up in menus and/or to be automatically associated with mime types in file browsers, you need to provide a `.desktop` file like follows: 

{{< highlight ini >}}
[Desktop Entry]
Type=Application
Exec=your-app %u
MimeType=application/x-your-mime-type;
Icon=some-icon
X-DocPath=yourapp/index.html
Terminal=false
Name=Your App
GenericName=Some Generic Name
Comment=Short Description Of Your App
Categories=Qt;KDE;
{{< /highlight >}}

Take a look at the [.desktop Free Desktop Spec](http://standards.freedesktop.org/desktop-entry-spec/latest/) to find our more about the key/value pairs above. It's important to pick a good set of Categories, see the spec for a list of valid values. 

## Translations

Like you can see on the example .desktop file, only a english version is available. To translate it in more languages, you can add a [lang] suffix to the keys, you want to translate. For example:

```ini
Name=Your Application
Name[fr]=Ton application
...
GenericName=Some Generic Name
GenericName[fr]=Un nom générique
```

If you are using KDE infrastructure, this is done automatically by `scripty`, the KDE translation script.

## Install the .desktop file

In you CMakeLists.txt file, you can add the following lines to install your .desktop file:

```cmake
install(FILES org.example.my-app.desktop DESTINATION ${KDE_INSTALL_APPDIR})
```
