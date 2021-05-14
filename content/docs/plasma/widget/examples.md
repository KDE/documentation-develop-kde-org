---
title: "Examples"
weight: 7
description: >
  Resizable popup, clock, bundle icon and other simple examples
---

There are also several examples in the `plasma-framework` repo:  
<https://invent.kde.org/frameworks/plasma-framework/-/tree/master/examples/applets>

## Configurable icon

{{< sections >}}
{{< section-left >}}

To get your panel icon to be configurable like the [Application Lancher widget](https://invent.kde.org/plasma/plasma-desktop/-/tree/master/applets/kickoff/package/contents/ui) we need to:

* Create a new string config key (`plasmoid.configuration.icon`)
* Set [`Plasmoid.icon`]({{< ref "plasma-qml-api.md#plasmoidicon" >}}) to `plasmoid.configuration.icon`
* Copy the icon selector control from the Application Lancher widget to a reuseable `ConfigIcon.qml` file.
* Add a `ConfigIcon` button to our `ConfigGeneral.qml` tab, and bind it to a `cfg_icon` property.

{{< /section-left >}}
{{< section-right >}}
```xml
<!-- config/main.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<kcfg xmlns="http://www.kde.org/standards/kcfg/1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.kde.org/standards/kcfg/1.0 http://www.kde.org/standards/kcfg/1.0/kcfg.xsd">
    <kcfgfile name=""/>

    <group name="General">
        <entry name="icon" type="string">
            <default>plasma</default>
        </entry>
    </group>
</kcfg>
```

-----

```qml
// ui/main.qml
import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0

Item {
    id: widget
    Plasmoid.icon: plasmoid.configuration.icon
}
```

-----

```qml
// ui/ConfigIcon.qml
import QtQuick 2.5
import QtQuick.Controls 2.5
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons

Button {
    id: configIcon

    property string defaultValue: ''
    property string value: ''

    implicitWidth: previewFrame.width + PlasmaCore.Units.smallSpacing * 2
    implicitHeight: previewFrame.height + PlasmaCore.Units.smallSpacing * 2

    KQuickAddons.IconDialog {
        id: iconDialog
        onIconNameChanged: configIcon.value = iconName || configIcon.defaultValue
    }

    onPressed: iconMenu.opened ? iconMenu.close() : iconMenu.open()

    PlasmaCore.FrameSvgItem {
        id: previewFrame
        anchors.centerIn: parent
        imagePath: plasmoid.location === PlasmaCore.Types.Vertical || plasmoid.location === PlasmaCore.Types.Horizontal
                 ? "widgets/panel-background" : "widgets/background"
        width: PlasmaCore.Units.iconSizes.large + fixedMargins.left + fixedMargins.right
        height: PlasmaCore.Units.iconSizes.large + fixedMargins.top + fixedMargins.bottom

        PlasmaCore.IconItem {
            anchors.centerIn: parent
            width: PlasmaCore.Units.iconSizes.large
            height: width
            source: configIcon.value
        }
    }

    Menu {
        id: iconMenu

        // Appear below the button
        y: +parent.height

        MenuItem {
            text: i18ndc("plasma_applet_org.kde.plasma.kickoff", "@item:inmenu Open icon chooser dialog", "Choose...")
            icon.name: "document-open-folder"
            onClicked: iconDialog.open()
        }
        MenuItem {
            text: i18ndc("plasma_applet_org.kde.plasma.kickoff", "@item:inmenu Reset icon to default", "Clear Icon")
            icon.name: "edit-clear"
            onClicked: configIcon.value = configIcon.defaultValue
        }
    }
}
```

-----

```qml
// ui/ConfigGeneral.qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import org.kde.kirigami 2.4 as Kirigami

Item {
    id: page
    width: childrenRect.width
    height: childrenRect.height

    property alias cfg_icon: configIcon.value

    Kirigami.FormLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        ConfigIcon {
            id: configIcon
            Kirigami.FormData.label: i18nd("plasma_applet_org.kde.plasma.kickoff", "Icon:")
        }
    }
}
```

-----

```qml
// config/config.qml
import QtQuick 2.0
import org.kde.plasma.configuration 2.0

ConfigModel {
    ConfigCategory {
        name: i18n("General")
        icon: "configure"
        source: "ConfigGeneral.qml"
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## Configurable panel widget width/height

{{< sections >}}
{{< section-left >}}
While the user can resize the popup window temporarily with `Alt+RightClick+Drag`, it will reset when the user relogs. To allow the user to permanently configure the popup size in a panel widget, or the size of the compact view in the panel, we'll need a store the width/height in the config.

So we change to our hardcoded sizes:

```qml
// ui/main.qml
Item {
    id: widget
    Plasmoid.fullRepresentation: Item {
        Layout.preferredWidth: 640 * PlasmaCore.Units.devicePixelRatio
        Layout.preferredHeight: 480 * PlasmaCore.Units.devicePixelRatio
    }
}
```

into this:

```qml
// ui/main.qml
Item {
    id: widget
    Plasmoid.fullRepresentation: Item {
        Layout.preferredWidth: plasmoid.configuration.width * PlasmaCore.Units.devicePixelRatio
        Layout.preferredHeight: plasmoid.configuration.height * PlasmaCore.Units.devicePixelRatio
    }
}
```

Make sure you still multiply the stored width/height by [`PlasmaCore.Units.devicePixelRatio`](docs:plasma;Units::devicePixelRatio), otherwise your popup will look smaller by default on HiDPI/4k monitors.

To simplify testing, I added `Plasmoid.hideOnWindowDeactivate: false` to prevent the popup from closing when you focus the config window.

Next we register the config keys and their default values in the `config/main.xml`.

Then create a configuration form in `ui/configGeneral.qml`. We use [`SpinBox`](https://doc.qt.io/qt-5/qml-qtquick-controls2-spinbox.html) and set the max value to [the maximum signed integer value in QML](https://stackoverflow.com/questions/41378583/qml-highest-number-float-integer-possible).

Lastly we register the General config tab in `config/config.qml`.

{{< /section-left >}}
{{< section-right >}}

```qml
// ui/main.qml
Item {
    id: widget
    Plasmoid.fullRepresentation: Item {
        id: popupView
        Layout.preferredWidth: plasmoid.configuration.width * PlasmaCore.Units.devicePixelRatio
        Layout.preferredHeight: plasmoid.configuration.height * PlasmaCore.Units.devicePixelRatio
        Plasmoid.hideOnWindowDeactivate: false
        ColumnLayout {
            id: layout
            anchors.fill: parent
            PlasmaComponents.Label {
                text: i18n("Size: %1 x %2", popupView.width, popupView.height)
            }
        }
    }
}
```

-----

```xml
<!-- config/main.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<kcfg xmlns="http://www.kde.org/standards/kcfg/1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.kde.org/standards/kcfg/1.0 http://www.kde.org/standards/kcfg/1.0/kcfg.xsd">
    <kcfgfile name=""/>

    <group name="General">
        <entry name="width" type="int">
            <default>640</default>
        </entry>
        <entry name="height" type="int">
            <default>480</default>
        </entry>
    </group>
</kcfg>
```

-----

```qml
// ui/configGeneral.qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

Item {
    id: page
    width: childrenRect.width
    height: childrenRect.height

    property alias cfg_width: widthSpinBox.value
    property alias cfg_height: heightSpinBox.value

    Kirigami.FormLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        RowLayout {
            Kirigami.FormData.label: i18n("Size:")
            SpinBox {
                id: widthSpinBox
                from: 0
                to: 2147483647 // 2^31-1
            }
            Label {
                text: " x "
            }
            SpinBox {
                id: heightSpinBox
                from: 0
                to: 2147483647 // 2^31-1
            }
        }
    }
}
```

-----

```qml
// config/config.qml
import QtQuick 2.0
import org.kde.plasma.configuration 2.0

ConfigModel {
    ConfigCategory {
        name: i18n("General")
        icon: "configure"
        source: "configGeneral.qml"
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## Time DataSource

{{< sections >}}
{{< section-left >}}
An extremely simple example of this can be found in the "fuzzy clock" widget in the `kdeplasma-addons` repo ([link](https://github.com/KDE/kdeplasma-addons/blob/master/applets/fuzzy-clock/package/contents/ui/main.qml)).

The `new Date()` should be familiar if you come from a javascript background. We could use a Timer with the Date type, but we want to precisely sync all clock widgets so they all show the same time on all screens. This is where Plasma's DataEngines come in. They are used to share data between widgets. There are [various dataengines](https://github.com/KDE/plasma-workspace/tree/master/dataengines) for notifications, plugged in usb drives (hotplug), and event the weather data so it only has to fetch the data once to show it in all widgets on each screen.

To use the "time" data engine, we use [`PlasmaCore.DataSource`](https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/core/datasource.h) to connect to it. The "time" needs us to connect to our "Local" timezone. Once connected, it gives us a DateTime object we can access using `dataSource.data.Local.DateTime`. This property will update every 60000 milliseconds, or every 1 minute.

We also tell the data engine to align these updates to the next minute. If we want to modify this to update every second, we'd change the interval to `interval: 1000` (1 second), then remove the `intervalAlignment` assignment since there isn't an "AlignToSecond", just a [PlasmaCore.Types.NoAlignment](docs:plasma;Plasma::Types::IntervalAlignment).

A clock can then use Qt's `Qt.formatTime(currentDateTime)` to display the time in a human readable format. You can read more about that function on the Qt documentation for [`Qt.formatDateTime(...)`](http://doc.qt.io/qt-5/qml-qtqml-qt.html#formatDateTime-method).

{{< /section-left >}}
{{< section-right >}}
```qml
import QtQuick 2.0
import QtQuick.Layouts 1.1

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.calendar 2.0 as PlasmaCalendar

Item {
    id: root

    readonly property date currentDateTime: dataSource.data.Local ? dataSource.data.Local.DateTime : new Date()

    width: PlasmaCore.Units.gridUnit * 10
    height: PlasmaCore.Units.gridUnit * 4

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    Plasmoid.toolTipMainText: Qt.formatTime(currentDateTime)
    Plasmoid.toolTipSubText: Qt.formatDate(currentDateTime, Qt.locale().dateFormat(Locale.LongFormat))

    PlasmaCore.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 60000
        intervalAlignment: PlasmaCore.Types.AlignToMinute
    }

    Plasmoid.compactRepresentation: FuzzyClock { }

    Plasmoid.fullRepresentation: PlasmaCalendar.MonthView {
        Layout.minimumWidth: PlasmaCore.Units.gridUnit * 20
        Layout.minimumHeight: PlasmaCore.Units.gridUnit * 20

        today: currentDateTime
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## Solar DataSource

{{< sections >}}
{{< section-left >}}

Solar is part of the "time" dataengine. It provides the sun's [Azimuth](https://en.wikipedia.org/wiki/Azimuth), [Zenith](https://en.wikipedia.org/wiki/Zenith), and "Corrected Elevation" for a longitude and latitude at a specific time of day.

* Install `plasma-sdk` then open the Plasma Engine Explorer.
* Select the `time` dataengine.
* Enter something like the following into the source name:  
  `UTC-04:00|Solar|Latitude=43.68|Longitude=79.63|DateTime=2021-03-23T19:00:00`  
  The above example is for Toronto, Canada.
* Click "Request Source", then scroll down to the bottom to find the new data.

Examples: 

* The [EnvCanada Weather Source uses](https://invent.kde.org/plasma/plasma-workspace/-/blame/master/dataengines/weather/ions/envcan/ion_envcan.cpp#L733) the Solar dataengine to check if the "Corrected Elevation" [is below zero](https://invent.kde.org/plasma/plasma-workspace/-/blame/master/dataengines/weather/ions/envcan/ion_envcan.cpp#L1627) to start using nighttime icons.

{{< /section-left >}}
{{< section-right >}}

[![](plasmaengineexplorer-solar.png)](plasmaengineexplorer-solar.png)

| Type | Key | Value |
|------|-----|-------|
|`double`|`Azimuth`|69.6342657428925|
|`double`|`Corrected Elevation`|-18.092120068676486|
|`QDateTime`|`DateTime`|Tue Mar 23 19:00:00 2021|
|`int`|`Offset`|UTC-04:00|
|`QString`|`Timezone`|UTC-04:00|
|`QString`|`Timezone Abbreviation`|UTC-04:00|
|`QString`|`Timezone City`|UTC-04:00|
|`double`|`Zenith`|108.10976492154272|
{{< /section-right >}}
{{< /sections >}}



## Avoid widget resize on text change

{{< sections >}}
{{< section-left >}}
We use [`TextMetrics`](https://doc.qt.io/qt-5/qml-qtquick-textmetrics.html) to calculate the size of the [Text](https://doc.qt.io/qt-5/qml-qtquick-text.html) label when it is the widest/maximum value of `100%`.
{{< /section-left >}}
{{< section-right >}}
```qml
import QtQuick 2.4
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

Item {
    id: widget
    property int value: 0
    property int maxValue: 100
    function formatText(n) {
        return "" + n + "%"
    }

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    Plasmoid.compactRepresentation: PlasmaComponents.Label {
        id: label
        Layout.minimumWidth: textMetrics.width
        Layout.minimumHeight: textMetrics.height

        text: widget.formatText(value)

        font.pointSize: 40
        horizontalAlignment: Text.AlignHCenter

        TextMetrics {
            id: textMetrics
            font.family: label.font.family
            font.pointSize: label.font.pointSize
            text: widget.formatText(100)
        }

        // Since we overrode the default compactRepresentation,
        // we need to setup the click to toggle the popup.
        MouseArea {
            anchors.fill: parent
            onClicked: plasmoid.expanded = !plasmoid.expanded
        }
    }

    Plasmoid.fullRepresentation: Item {
        Layout.preferredWidth: 640 * PlasmaCore.Units.devicePixelRatio
        Layout.preferredHeight: 480 * PlasmaCore.Units.devicePixelRatio

        Rectangle {
            id: popup
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width * (widget.value / 100)
            color: PlasmaCore.Theme.highlightColor
        }
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: widget.value = (widget.value + 1) % (widget.maxValue+1)
    }
}
```
{{< /section-right >}}
{{< /sections >}}

