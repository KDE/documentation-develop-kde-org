---
title: "Plasmoid setup"
weight: 21
description: >
  Creating a Plasmoid
---

Plasmoids, otherwise called Plasma widgets or applets, are self-contained extensions that are specific to the KDE Plasma desktop.

They mainly consist of QML files, but may be extended to use C++ if more complex capabilities are required, like running a separate tool from it.

Plasmoids containing only QML files are installed to:

* `/usr/share/plasma/plasmoids/`
* `~/.local/share/plasma/plasmoids/`

Whereas Plasmoids compiled from QML to C++ are installed to:

* `/usr/lib64/plugins/plasma/applets/`
* `~/.local/lib64/plugins/plasma/applets/`.

In this tutorial, you will first create a QML-only plasmoid with a simple Hello World that you can later publish to the [KDE Store](https://store.kde.org/).

You will then learn how to make your plasmoid compile to C++ and how to test it in [Plasmoids compiled to C++](#).

After this, you should be able to follow the [Learning the Plasma API](#) page to make your plasmoid do something interesting.

## File structure

QML-only plasmoids require a very specific file structure inside `/usr/share/plasma/plasmoids/` or `~/.local/share/plasma/plasmoids/`:

```bash
org.kde.plasma.tutorial/
├── contents/
│   ├── config/
│   │   ├── config.qml # optional
│   │   └── main.xml # optional
│   └── ui/
│       ├── configGeneral.qml # optional
│       └── main.qml
└── metadata.json
```

{{< alert title="💡 Tip" color="success" >}}

You can create this file structure quickly with:

```bash
mkdir --parents org.kde.plasma.tutorial/contents/{ui,config}
touch org.kde.plasma.tutorial/metadata.json
touch org.kde.plasma.tutorial/contents/config/{config.qml,main.xml}
touch org.kde.plasma.tutorial/contents/ui/{main.qml,configGeneral.qml}
```

{{< /alert >}}

Your plasmoid should have an `id` that must follow a [reverse-DNS naming scheme](https://en.wikipedia.org/wiki/Reverse_domain_name_notation). Here we are using `org.kde.plasma.tutorial` which is designed for upstream Plasma widgets, but if you plan to make a third party widget you should change the `id` to something custom like `com.myname.tutorial`.

The entrypoint for the plasmoid will be `org.kde.plasma.tutorial/contents/ui/main.qml` and the metadata containing information about your plasmoid as delivered to users is stored in `org.kde.plasma.tutorial/metadata.json`.

Creating a configuration window is optional and covered in [Configuration for Plasmoids](#).


## metadata.json {#metadata-json}

The `metadata.json` file should be present in the root directory of your plasmoid and should contain contents similar to these:

```json
{
    "KPackageStructure": "Plasma/Applet",
    "KPlugin": {
        "Authors": [
            {
                "Email": "youremail@example.com",
                "Name": "Konqi the Konqueror"
            }
        ],
        "Category": "Miscellaneous",
        "Description": "Hello World",
        "Icon": "kde",
        "Id": "org.kde.plasma.tutorial",
        "License": "GPL",
        "Name": "Plasma Tutorial",
        "Version": "0.1",
        "Website": "https://www.kde.org/"
    },
    "X-Plasma-API-Minimum-Version": "6.0"
}
```

The metadata present in this file will show up in stores in case you release your plasmoid and, if you create a configuration window following [Configuration for Plasmoids](#), it will be reused for the About page of your plasmoid as well.

For the most part this is boilerplate, but the three main keys in the metadata that you should care about are `Name`, `Id`, `Authors` and `Category`.

The `Name` key corresponds to the application name that will be displayed in the plasmoid itself.

The `Id` key is a unique identifier following a [reverse-DNS naming scheme](https://en.wikipedia.org/wiki/Reverse_domain_name_notation). Without this `Id`, it will not be possible to run the plasmoid later. As a convention, the `Id` should match the root folder name and, if following [Plasmoids compiled to C++](#), it should match the [plasma_add_applet()](https://invent.kde.org/plasma/libplasma/-/blob/master/PlasmaMacros.cmake#L32) entry in `CMakeLists.txt`.

The `Authors` key is self-explanatory.

The `Category` key is used for categorizing your plasmoid in the list of plasmoids present when adding it to the desktop.

TODO add image here

The list of categories can be seen in the following collapsible:

<details>
<summary>Click here to view the list of category values</summary>
</br>


* `Accessibility`: tools that help those with special needs or disabilities use their computer
* `Application Launchers`: application starters and file openers.
* `Astronomy`: anything to do with the night sky or other celestial bodies.
* `Date and Time`: clocks, calendars, scheduling, etc
* `Development Tools`: tools and utilities to aid software developers
* `Education`: teaching and educational aides
* `Environment and Weather`: add-ons that display information regarding the weather or other environmentally related data
* `Examples`: samples that are not meant for production systems
* `File System`: anything that operates on files or the file system as its primary purpose, such as file watchers or directory listings. Simply using a file as storage does not qualify the add-on for this category.
* `Fun and Games`: for games and amusements
* `Graphics`: for add-ons where displaying images, photos or graphical eye candy is the primary purpose
* `Language`: add-ons whose primary purpose is language related, such as dictionaries and translators.
* `Mapping`: geography and geographic data add-ons
* `Multimedia`: music and video.
* `Online Services`: add-ons that provide an interface to online services such as social networking or blogging sites. If there is another more appropriate category for the add-on given the topic (e.g. mapping if the applet's purpose is to show maps), even if the data is retrieved from the Internet prefer that other category over this one.
* `System Information`: display and interaction with information about the computer such as network activity, hardware health, memory usage, etc
* `Utilities`: Useful tools like calculators
* `Windows and Tasks`: managers for application windows and/or tasks, such as taskbars

</details>

## main.qml {#main-qml}

Let's start with a simple hello world. Add the following to `org.kde.plasma.tutorial/contents/ui/main.qml`:

```qml
import QtQuick
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents

PlasmoidItem {
    id: root
    Plasmoid.title: "My first plasmoid"
    PlasmaComponents.Label {
        anchors.centerIn: parent
        text: "Hello World!"
    }
}
```

Plasmoids should always start with a root [PlasmoidItem](https://api.kde.org/qml-org-kde-plasma-plasmoid-plasmoiditem.html). We then use a custom Plasma component for labels to add a "Hello World" to our example. Plasma components are generally preferred to Kirigami ones because they are styled specifically to look good in plasmoids.

Try [adding it to the panel and desktop](#running). The fact the same contents is being shown for the panel and the desktop is because we didn't specify different visual *representations*.

TODO add image

There's a few different ways to represent a plasmoid:

* You can have a widget in the panel, which is just an icon that will show a popup window when clicked.
* You can also have it on the desktop as a desktop widget which can be resized by the user. As a desktop widget it can switch between the "icon view" when smaller (which opens a popup), and directly showing the contents of the popup on the desktop when there's enough room.
* You can also have the widget inside another widget (a containment) like the system tray or the panel itself.
* The widget can also be run like an application in its own window (Calculator).

This can mostly be split into two representations: [compactRepresentation](https://api.kde.org/qml-org-kde-plasma-plasmoid-plasmoiditem.html#compactRepresentation-prop) and [fullRepresentation](https://api.kde.org/qml-org-kde-plasma-plasmoid-plasmoiditem.html#fullRepresentation-prop).

The `compactRepresentation` is used for displaying the plasmoid in a panel, for example, while a `fullRepresentation` is used in case the plasmoid has enough space, such as on the desktop.

Plasmoids actually come with a default `compactRepresentation`: a cog icon, the default [Plasmoid.icon](https://api.kde.org/qml-org-kde-plasma-plasmoid-plasmoid.html#icon-attached-prop). For it to show up, all you need is to specify a `fullRepresentation`:

```qml
import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root
    switchWidth: Kirigami.Units.gridUnit * 10
    switchHeight: Kirigami.Units.gridUnit * 10

    fullRepresentation: Item {
        Layout.preferredWidth: root.switchWidth
        Layout.preferredHeight: root.switchHeight

        ColumnLayout {
            anchors.fill: parent
            PlasmaComponents.Label {
                id: label
                Layout.alignment: Qt.AlignCenter
                text: "Hello World!"
            }
        }
    }
}
```

To set the desired size of a representation, you need to use [Layout attached properties](https://doc.qt.io/qt-6/qml-qtquick-layouts-layout.html) inside the representation [Item](https://doc.qt.io/qt-6/qml-qtquick-item.html).

If you are confused about imports or Layout properties, you might want to see our [Kirigami tutorial](#) before proceeding.

If you set a [switchWidth](https://api.kde.org/qml-org-kde-plasma-plasmoid-plasmoiditem.html#switchWidth-prop) and [switchHeight](https://api.kde.org/qml-org-kde-plasma-plasmoid-plasmoiditem.html#switchHeight-prop), then up until that size the plasmoid will render in `compactRepresentation` and larger than that it will render in `fullRepresentation`. We set a reasonable size for the fullRepresentation, then set its preferred width and height to that of the size where the fullRepresentation will be rendered, then center the Label in the available plasmoid space.

If you want to force the full representation to show up even when in the panel, you can remove `switchWidth` and `switchHeight` and use `preferredRepresentation: fullRepresentation`:

```qml
import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root
    prefferedRepresentation: fullRepresentation
    
    fullRepresentation: Item {
        Layout.preferredWidth: switchWidth
        Layout.preferredHeight: switchHeight

        ColumnLayout {
            anchors.fill: parent
            PlasmaComponents.Label {
                id: label
                Layout.alignment: Qt.AlignCenter
                text: "Hello World!"
            }
        }
    }
}
```

If you want to make a custom compactRepresentation, you will need to use a [MouseArea](https://doc.qt.io/qt-6/qml-qtquick-mousearea.html) to toggle the `PlasmoidItem.expanded` property:

```qml
import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root
    switchWidth: Kirigami.Units.gridUnit * 10
    switchHeight: Kirigami.Units.gridUnit * 10

    compactRepresentation: MouseArea {
        property bool wasExpanded
        onPressed: wasExpanded = root.expanded
        onClicked: root.expanded = !wasExpanded

        ColumnLayout {
            anchors.fill: parent
            Kirigami.Icon {
                Layout.alignment: Qt.AlignCenter
                source: "kde"
            }
        }
    }

    fullRepresentation: Item {
        Layout.preferredWidth: root.switchWidth
        Layout.preferredHeight: root.switchHeight

        ColumnLayout {
            anchors.fill: parent
            PlasmaComponents.Label {
                id: label
                Layout.alignment: Qt.AlignCenter
                text: "Hello World!"
            }
        }
    }
}
```

See the [Compact Representation example](https://invent.kde.org/plasma/libplasma/-/blob/master/examples/applets/compactrepresentation/contents/ui/main.qml) as a reference.

## Installing and running {#running}

Create the folder `~/.local/share/plasma/plasmoids/`:

```bash
mkdir --parents ~/.local/share/plasma/plasmoids/
```

Install the whole directory to `~/.local/share/plasma/plasmoids/`:

```bash
kpackagetool6 --type "Plasma/Applet" --install org.kde.plasma.tutorial/
# or
cp --recursive org.kde.plasma.tutorial/ ~/.local/share/plasma/plasmoids/
```

Alternatively, you may create a `.plasmoid` archive for distribution. It is simply a Zip archive with the `.plasmoid` extension.
This can be done with [Ark](#):

```bash
ark org.kde.plasma.tutorial/ --add-to org.kde.plasma.tutorial.plasmoid
kpackagetool6 --type "Plasma/Applet" --install org.kde.plasma.tutorial.plasmoid
```

You can then use one of two tools to view your plasmoid:

* `plasmawindowed`, which comes by default with Plasma
* `plasmoidviewer`, which comes with the additional package [plasma-sdk](https://invent.kde.org/plasma/plasma-sdk)

The former provides a simple view of the plasmoid while the latter provides more advanced workflows for testing plasmoids.

You can run the plasmoid with either:

```bash
plasmawindowed org.kde.plasma.tutorial
## or
plasmoidviewer --applet org.kde.plasma.tutorial
```

Or by:

1. Right-clicking the desktop
2. Selecting "Enter edit mode"
3. Cliking on the "Add or manage widgets" on the top left corner of the screen
4. Adding your widget to the desktop or panel

When following this procedure, to update the plasmoid after making code changes, you may simply restart plasmashell:

```bash
systemctl restart --user plasma-plasmashell
# or
plasmashell --replace
```

You may then deploy a QML-only plasmoid to users through the [KDE Store](https://store.kde.org/).
