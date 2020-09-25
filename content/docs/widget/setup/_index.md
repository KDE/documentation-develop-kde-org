---
title: "Setup"
weight: 1
description: >
  Create a new plasma widget from scratch.
---

## Folder Structure

{{< sections >}}
{{< section-left >}}

To start a new widget from scratch, first create a folder for your new widget somewhere in you coding directory (eg: `~/Code/plasmoid-helloworld`).

Inside it create another folder called `package`. Everything inside the `package` folder will be what we eventually install to `~/.local/share/plasma/plasmoids/com.github.zren.helloworld/`. Eventually we will zip the contents of `package` and share them online. We can keep text editor files, build scripts, screenshots, etc outside the `package` directory.

Inside the package folder will be a `metadata.desktop` file which is basically a Linux `.ini` file. This file will describe the name of the widget, the category it's in, and various other plasma specific keys like the main QML file.

Inside `contents`, we will create the `ui` and `config` folders. `ui` is the folder which should contain your layout files like the `main.qml` and the `configGeneral.qml`. `configGeneral.qml` is the layout of the first tab in the widget's configuration window.

Inside the `config` folder we have the `main.xml` which contains the schema of all our serialized configuration keys+values. The `config.qml` is used to define the tabs in the configuration window. Each tab will open a QML layout file (like `ui/configGeneral.qml`).

Note that you don't *need* the 3 config files. You can get away with just the `main.qml` and `metadata.desktop` for a barebones widget.
{{< /section-left >}}

{{< section-right highlight="bash">}}
└── ~/Code/plasmoid-helloworld/
    └── package
        ├── contents
        │   ├── ui
        │   │   ├── main.qml
        │   │   └── configGeneral.qml
        │   └── config
        │       ├── config.qml
        │       └── main.xml
        └── metadata.desktop
{{< /section-right >}}
{{< /sections >}}

## metadata.desktop

{{< sections >}}
{{< section-left >}}

Inside the `metadata.desktop` file we need to set the `Name` of the widget. The `Type` should be `Service` since the `.desktop` file is not an app launcher and we don't want this to appear in the app menu.

`Icon` is the icon name associated with the widget. You can search for icon names in the `/usr/share/icon` folder. You can also look for an icon name by right clicking your app launcher widget then editing the icon in it's settings. It uses a searchable interface and lists them by category. Plasma's SDK also has the Cuttlefish app ([screenshot](https://cdn.kde.org/screenshots/cuttlefish/cuttlefish.png)) which you can install with `sudo apt install plasma-sdk`.

`X-KDE-PluginInfo-Name` needs to be a unique name, since it's used for the folder name it's installed into. You could use `com.github.zren.helloworld` if you're on github, or use `org.kde.plasma.helloworld` if you're planning on contributing the widget to KDE.  

Widgets installed by the user (without root) like when you "Install New Widgets" will be installed to `~/.local/share/plasma/plasmoids/` (which may not yet exist). The default widgets shipped with KDE are installed to `/usr/share/plasma/plasmoids/`.

`X-KDE-PluginInfo-Category` is the category the widget can be filtered with in the widget list. A list of category names can be found [here](https://techbase.kde.org/Projects/Plasma/PIG).

`X-KDE-ServiceTypes`, `X-Plasma-API`, and `X-Plasma-MainScript` are also needed to just define that this package is a plasma widget, and where it's entry point is.

For more, read the [Getting Started](https://techbase.kde.org/Development/Tutorials/Plasma5/QML2/GettingStarted#The_.desktop_file) tutorial on the KDE wiki.
{{< /section-left >}}

{{< section-right highlight="ini">}}
[Desktop Entry]
Name=Hello World
Comment=A widget to take over the world!

Type=Service
Icon=battery
X-KDE-ServiceTypes=Plasma/Applet

X-Plasma-API=declarativeappletscript
X-Plasma-MainScript=ui/main.qml

X-KDE-PluginInfo-Author=My Name
X-KDE-PluginInfo-Email=myemail@gmail.com
X-KDE-PluginInfo-Name=com.github.zren.helloworld
X-KDE-PluginInfo-Version=1
X-KDE-PluginInfo-Website=https://github.com/Zren/plasmoid-helloworld
X-KDE-PluginInfo-Category=System Information
{{< /section-right >}}
{{< /sections >}}

## contents/ui/main.qml

This is the entry point. Various properties are available to be set. You should know that widgets have several ways of being represented. 

* You can have a widget in the panel, which is just an icon that will show a popup window when clicked.
* You can also have it on the desktop as a desktop widget which can be resized by the user. As a desktop widget it can switch between the "icon view" when smaller (which opens a popup), and directly showing the contents of the popup on the desktop when there's enough room.
* You can also have the widget inside another widget (a containment) like the system tray or the panel itself.
* The widget can also be run like an application in it's own window (Calculator).

`plasmoid.location` and `plasmoid.formFactor` can tell you how the widget is placed. `plasmoid` is a global variable which is defined when you `import org.kde.plasma.plasmoid 2.0`. Read more below.

`Plasmoid.compactRepresentation` (with a capital) and `Plasmoid.fullRepresentation` are used to define the layout of the small "icon" view and the full "popup" view. These are both properties of the main `Item`. If neither are set, by default the main `Item` is the full representation.

If you change the compact representation, you will need to use a [`MouseArea`](https://doc.qt.io/qt-5/qml-qtquick-mousearea.html) to toggle the `plasmoid.expanded` property. See the [`DefaultCompactRepresentation.qml`](https://github.com/KDE/plasma-desktop/blob/master/desktoppackage/contents/applet/DefaultCompactRepresentation.qml) for an example.

`Layout.preferredWidth` can be used to define the default width of a panel widget, or the size of the popup window (unless it is in the system tray). The system tray has a fixed hardcoded size for it's popups. `Layout.preferredWidth` can also define the width of the compact "icon" view in the horizontal panel, not just the full "popup" width. Note that the `Layout.preferredWidth`/`Layout.preferredHeight` of the `Plasmoid.compactRepresentation` will automatically scale to the thickness of the panel depending on if it's a vertical or horizontal panel.

`Layout.minimumWidth` can be used to define the minimum size for a desktop widget / popup.

`width`/`height` (not `Layout.__`) can be used to define the default size of a desktop widget. Desktop widgets currently ignore `Layout.preferredWidth` when calculating the default size.

You can set the tooltip contents and various other things in the `main.qml`.

### Examples of `main.qml`

* Various examples in the [Getting Started](https://techbase.kde.org/Development/Tutorials/Plasma5/QML2/GettingStarted#main.qml) tutorial on the KDE wiki.
* [colorpicker/package/contents/ui/main.qml](https://github.com/KDE/kdeplasma-addons/blob/master/applets/colorpicker/package/contents/ui/main.qml)
* [fifteenPuzzle/package/contents/ui/main.qml](https://github.com/KDE/kdeplasma-addons/blob/master/applets/fifteenPuzzle/package/contents/ui/main.qml)

```qml
// main.qml
import QtQuick 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

PlasmaComponents.Label {
    text: "Hello World!"
}
```

---

To show the text in the panel rather than in a popup:

```qml
// main.qml
import QtQuick 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

PlasmaComponents.Label {
    text: "Hello World!"

    // Always display the full view. Never show the compact icon view
    // like it does by default when shown in the panel.
    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
}
```

---

To set the popup size:

```qml
// main.qml
import QtQuick 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

Item {
    // Always display the compact view.
    // Never show the full popup view even if there is space for it.
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    Plasmoid.fullRepresentation: Item {
        Layout.minimumWidth: label.implicitWidth
        Layout.minimumHeight: label.implicitHeight
        Layout.preferredWidth: 640 * units.devicePixelRatio
        Layout.preferredHeight: 480 * units.devicePixelRatio
        
        PlasmaComponents.Label {
            id: label
            anchors.fill: parent
            text: "Hello World!"
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
```

