---
title: "Configuration for Plasmoids"
weight: 24
description: >
  Creating a Plasmoid
---

## Configuration Intro

{{< sections >}}
{{< section-left >}}

Every widget by default has a settings page when you right click the widget. By default it will contain a Keyboard Shortcuts tab to set a global shortcut to activate your widget and an About page containing the data specified in the `metadata.json` file.

When any setting in a plasmoid stored on the Plasma desktop is modified and saved, the change will be saved to `~/.config/plasma-org.kde.plasma.desktop-appletsrc`. If the plasmoid is being viewed with `plasmoidviewer`, it will instead be stored in `~/.config/plasmoidviewer-appletsrc/`.

{{< /section-left >}}
{{< section-right >}}

![](configwindow.webp)

{{< /section-right >}}
{{< /sections >}}


## contents/config/main.xml

{{< sections >}}
{{< section-left >}}

`main.xml` is where you define the default properties of the Plasmoid. All properties will be accessible with `plasmoid.configuration.variableName` regardless of what group it's in.

[KConfig](docs:kconfigcore;KConfig) has a variety of data types:

* `Int` for an Integer number
* `Double` for a double precision floating point number (Real)
* `String` for a string of characters to represent text
* `Color` for a hexadecimal color. The color defaults to `#000000` (black) if the default is left empty.
* `Path` is a string that is specially treated as a filepath. In particular paths in the home directory are prefixed with `$HOME` when being stored in the configuration file.
* `StringList` for a comma separated list of Strings

More types can be found in [KConfigXT's documentation]({{< ref "/docs/features/configuration/kconfig_xt" >}}).

---

Don't use `Color` if you want to default to a color from the color scheme (like [Kirigami.Theme.textColor](https://api.kde.org/qml-org-kde-kirigami-platform-theme.html#textColor-attached-prop)). Use a `String` that is empty by default instead. You can then use the following in QML:

```xml
<entry name="labelColor" type="String">
    <default></default>
</entry>
```

```qml
PlasmaComponents.Label {
    color: plasmoid.configuration.labelColor || Kirigami.Theme.textColor
}
```

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/config/main.xml</div>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<kcfg xmlns="http://www.kde.org/standards/kcfg/1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.kde.org/standards/kcfg/1.0 http://www.kde.org/standards/kcfg/1.0/kcfg.xsd">
    <kcfgfile name=""/>

    <group name="General">
        <entry name="variableName" type="Bool">
            <default>true</default>
        </entry>
        <entry name="integerExample" type="Int">
            <default>6</default>
        </entry>
        <entry name="floatingPointExample" type="Double">
            <default>3.1459</default>
        </entry>
        <entry name="textExample" type="String">
            <default>Hello World</default>
        </entry>
        <entry name="listExample" type="StringList">
            <default>First Item,Second Item,Third Item</default>
        </entry>
        <entry name="colorExample" type="Color">
            <default>#336699</default>
        </entry>
    </group>
    <group name="AnotherGroup">
        <entry name="secondGroupExample" type="Bool">
            <default>false</default>
        </entry>
    </group>
</kcfg>
```
{{< /section-right >}}
{{< /sections >}}


## contents/config/config.qml

{{< sections >}}
{{< section-left >}}
`config.qml` (lowercase) is where we define the tabs in the configuration window.

We import the [ConfigModel](https://api.kde.org/qml-org-kde-plasma-configuration-configmodel.html) and [ConfigCategory](https://api.kde.org/qml-org-kde-plasma-configuration-configcategory.html), and define the tab name, icon, and QML file from `contents/ui/` that will be loaded.
{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/config/config.qml</div>

```qml
import QtQuick
import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
        name: i18n("General")
        icon: "configure"
        source: "configGeneral.qml"
    }
    ConfigCategory {
        name: i18n("Another Tab")
        icon: "color-management"
        source: "configAnotherTab.qml"
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## contents/ui/ConfigGeneral.qml

{{< sections >}}
{{< section-left >}}
`ConfigGeneral.qml` is where we can place all the checkboxes and textboxes. The name `ConfigGeneral` is simply a convention; the file *must* be specified as a `ConfigCategory` in `contents/config/config.qml`.

The root item for a configuration page must be one of the KCM components from the [org.kde.kcmutils import](https://api.kde.org/org-kde-kcmutils-qmlmodule.html).

Do not use [PlasmaComponents](https://api.kde.org/org-kde-plasma-components-qmlmodule.html) or [PlasmaExtras](https://api.kde.org/org-kde-plasma-extras-qmlmodule.html) controls in the config window. Use standard [QtQuick](https://doc.qt.io/qt-6/qtquickcontrols-index.html) and [Kirigami](https://api.kde.org/kirigami-index.html) controls instead.

[Kirigami.FormLayout](https://api.kde.org/qml-org-kde-kirigami-layouts-formlayout.html) is used to layout the controls in the center of the page. The [Kirigami.FormData.label](https://api.kde.org/qml-org-kde-kirigami-layouts-formdata.html#label-attached-prop) attached property is used to place labels in front of the controls. Kirigami labels are optional, so you do not need to use them for CheckBoxes which have their own labels on the right.

You can learn more about this UI design in [Getting started with Kirigami: Form layouts]({{< ref "components-formlayouts" >}}).

![](configgeneral.png)

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/configGeneral.qml</div>

```qml
import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: page
  
    property alias cfg_showLabel: showLabel.checked
    property alias cfg_showIcon: showIcon.checked
    property alias cfg_labelText: labelText.text

    QQC2.CheckBox {
        id: showLabel
        Kirigami.FormData.label: i18n("Section:")
        text: i18n("Show label")
    }
    QQC2.CheckBox {
        id: showIcon
        text: i18n("Show icon")
    }
    QQC2.TextField {
        id: labelText
        Kirigami.FormData.label: i18n("Label:")
        placeholderText: i18n("Placeholder")
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## configPage.cfg_variableName

By default, all values present in `main.xml` are available under `Plasmoid.configuration`.

If they are copied to the top level [SimpleKCM](https://api.kde.org/qml-org-kde-kcmutils-simplekcm.html) (or another KCMUtils component) and prefixed with `cfg_` (like `root.cfg_variableName`), the configuration page's `Apply` button will be connected automatically, allowing the user to discard or apply changes.

You will need to define each `cfg_` property so you can bind the value with a QML control. For example, if you have a config entry called `showIcon` in your `main.xml`, you may get its value from a `Plasmoid.configuration.showIcon` property, store it in a `property bool cfg_showIcon`, and change the `onChecked` signal handler of a checkbox to update the configuration setting:

```qml
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    id: root
    property bool cfg_showIcon: Plasmoid.configuration.showIcon
    
    Kirigami.FormLayout {
        Controls.CheckBox {
            id: showIcon
            text: i18n("Show icon")
            checked: root.cfg_showIcon
            onChecked: root.cfg_showIcon = checked
        }
    }
}
```

This provides some indirection that gives you more freedom to manipulate the configuration variables.

For simpler cases you may instead use a [property alias](http://doc.qt.io/qt-6/qtqml-syntax-objectattributes.html#property-aliases) to bind directly without needing to override a signal handler:

```qml
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    id: root
    property alias cfg_showIcon: showIcon.checked
    
    Kirigami.FormLayout {
        Controls.CheckBox {
            id: showIcon
            text: i18n("Show icon")
        }
    }
}
```


## CheckBox - Boolean

{{< sections >}}
{{< section-left >}}

A [CheckBox](https://doc.qt.io/qt-6/qml-qtquick-controls2-checkbox.html) is used for boolean on/off values.

<div class="filepath">contents/config/main.xml</div>

```xml
<entry name="variableName" type="Bool">
    <default>true</default>
</entry>
```

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/configGeneral.qml</div>

```qml
import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: page
    property alias cfg_variableName: variableName.checked

    QQC2.CheckBox {
        id: variableName
    }
}
```
{{< /section-right >}}
{{< /sections >}}



## SpinBox - Integer

{{< sections >}}
{{< section-left >}}

A [SpinBox](https://doc.qt.io/qt-6/qml-qtquick-controls2-spinbox.html) is used for numbers.

If you'd like to use floats/doubles instead, you may use [DoubleSpinBox](https://doc.qt.io/qt-6/qml-qtquick-controls-doublespinbox.html) instead.

<div class="filepath">contents/config/main.xml</div>

```xml
<entry name="variableName" type="Int">
    <default>6</default>
</entry>
```

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/configGeneral.qml</div>

```qml
import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: page
    property alias cfg_variableName: variableName.value

    QQC2.SpinBox {
        id: variableName
    }
}
```
{{< /section-right >}}
{{< /sections >}}

## TextField - String/Text

{{< sections >}}
{{< section-left >}}

A [TextField](https://doc.qt.io/qt-6/qml-qtquick-controls2-textfield.html) is used for a single line of text. It can be used as a base for many other data types as well. You will also want to look at the base [TextInput](https://doc.qt.io/qt-6/qml-qtquick-textinput.html) for more properties.

<div class="filepath">contents/config/main.xml</div>

```xml
<entry name="variableName" type="String">
    <default>Hello World</default>
</entry>
```

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/configGeneral.qml</div>

```qml
import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: page
    property alias cfg_variableName: variableName.text

    QQC2.TextField {
        id: variableName
    }
}
```
{{< /section-right >}}
{{< /sections >}}

## TextArea - Multi-Line String/Text

{{< sections >}}
{{< section-left >}}

A [TextArea](https://doc.qt.io/qt-6/qml-qtquick-controls2-textarea.html) is used for paragraphs of text. You will also want to look at the base [TextEdit](https://doc.qt.io/qt-6/qml-qtquick-textedit-members.html) for more properties.

<div class="filepath">contents/config/main.xml</div>

```xml
<entry name="variableName" type="String">
    <default>Hello World</default>
</entry>
```

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/configGeneral.qml</div>

```qml
import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: page
    property alias cfg_variableName: variableName.text

    QQC2.TextArea {
        id: variableName
    }
}
```
{{< /section-right >}}
{{< /sections >}}



## ColorButton - Color

{{< sections >}}
{{< section-left >}}

The KDE Frameworks library KQuickControls has [ColorButton](https://api.kde.org/qml-org-kde-kquickcontrols-colorbutton.html) which provides a preview of the selected color and will open QtQuick's [`ColorDialog`](https://doc.qt.io/qt-6/qml-qtquick-dialogs-colordialog.html) for selecting a color.

<div class="filepath">contents/config/main.xml</div>

```xml
<entry name="variableName" type="Color">
    <default>#336699</default>
</entry>
```

I personally don't recommend using the `Color` data type in `main.xml` if you want the default color to be a color from the color scheme (eg: `PlasmaCore.ColorScope.textColor`). I would instead suggest using a `String` that is empty by default. You can then use the following:

```xml
<entry name="labelColor" type="String">
    <default></default>
</entry>
```

```qml
PlasmaComponents.Label {
    color: plasmoid.configuration.labelColor || PlasmaCore.ColorScope.textColor
}
```

Unfortunately KDE Framework's `ColorButton` doesn't easily support this pattern as it stores the value in a QML `color` property which will read the empty string and cast it as the default color `#000000` (black). I worked around this issue in the [No-Apply Control Library]({{< ref "#no-apply-control-library" >}})'s [`libconfig/ColorField.qml`](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/ColorField.qml). I used a `TextField` to store the value as a string, and displayed the default color scheme color as `placeholderText`.

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/configGeneral.qml</div>

```qml
import QtQuick 2.0
import org.kde.kirigami 2.4 as Kirigami
import org.kde.kquickcontrols 2.0 as KQControls

Kirigami.FormLayout {
    id: page
    property alias cfg_variableName: variableName.color

    KQControls.ColorButton {
        id: variableName
        showAlphaChannel: true
    }
}
```
{{< /section-right >}}
{{< /sections >}}



## FileDialog - Path

{{< sections >}}
{{< section-left >}}

When we need to store a filepath in the config, we should use the `Path` or `PathList` config type. It will substitute `/home/user/...` with `$HOME/...`. To properly layout the file selector, we need a `RowLayout` with a `TextField` and `Button` which opens a [`FileDialog`](https://doc.qt.io/qt-5/qml-qtquick-dialogs-filedialog.html). We can specify the default folder the dialog opens to with `FileDialog`'s [`shortcuts` property](https://doc.qt.io/qt-5/qml-qtquick-dialogs-filedialog.html#shortcuts-prop) (eg: `shortcuts.pictures`).

Note that we place the `Kirigami.FormData.label` in the `RowLayout` as it is the direct child of `Kirigami.FormLayout`.

<div class="filepath">contents/config/main.xml</div>

```xml
<entry name="variableName" type="Path">
    <default>/usr/share/sounds/freedesktop/stereo/message.oga</default>
</entry>
```

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/configGeneral.qml</div>

```qml
import QtQuick 2.0
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Dialogs 1.0 as QQD
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page
    property alias cfg_variableName: variableName.text

    RowLayout {
        Kirigami.FormData.label: i18n("Sound File:")

        QQC2.TextField {
            id: variableName
            placeholderText: i18n("No file selected.")
        }
        QQC2.Button {
            text: i18n("Browse")
            icon.name: "folder-symbolic"
            onClicked: fileDialogLoader.active = true

            Loader {
                id: fileDialogLoader
                active: false

                sourceComponent: QQD.FileDialog {
                    id: fileDialog
                    folder: shortcuts.music
                    nameFilters: [
                        i18n("Sound files (%1)", "*.wav *.mp3 *.oga *.ogg"),
                        i18n("All files (%1)", "*"),
                    ]
                    onAccepted: {
                        variableName.text = fileUrl
                        fileDialogLoader.active = false
                    }
                    onRejected: {
                        fileDialogLoader.active = false
                    }
                    Component.onCompleted: open()
                }
            }
        }
    }
}
```
{{< /section-right >}}
{{< /sections >}}



## IconDialog - Icon

{{< sections >}}
{{< section-left >}}

[`KQuickAddons.IconDialog`](https://invent.kde.org/frameworks/kdeclarative/-/blob/master/src/qmlcontrols/kquickcontrolsaddons/icondialog.h) makes it easy to search and preview icons.

See the [configurable icon example]({{< ref "examples.md#configurable-icon" >}}) for an example of [KQuickAddons.IconDialog](https://invent.kde.org/frameworks/kdeclarative/-/blob/master/src/qmlcontrols/kquickcontrolsaddons/icondialog.h) based on the Application Launcher's (aka kickoff) [icon selector code](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/applets/kickoff/package/contents/ui/ConfigGeneral.qml#L39-87).

{{< /section-left >}}
{{< section-right >}}

{{< /section-right >}}
{{< /sections >}}



## Assigning to plasmoid.configuration.varName

{{< sections >}}
{{< section-left >}}

You can also assign directly to `plasmoid.configuration.variableName` if necessary in the configuration window or anywhere else in your widget. If you do this in the configuration page, you will skip the "apply" process and the property will be applied right away. I leave this up to the reader whether this is a pro or con.

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/configGeneral.qml</div>

```qml
import QtQuick 2.0
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page

    QQC2.CheckBox {
        id: variableName
        checked: plasmoid.configuration.variableName
        onCheckedChanged: plasmoid.configuration.variableName = checked
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## Configuration Examples

To learn by example, we can look at a couple widgets:

* Application Launcher
    * [`contents/config/main.xml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/applets/kickoff/package/contents/config/main.xml)
    * [`contents/config/config.qml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/applets/kickoff/package/contents/config/config.qml)
    * [`contents/ui/ConfigGeneral.qml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/applets/kickoff/package/contents/ui/ConfigGeneral.qml)
* Task Manager
    * [`contents/config/main.xml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/applets/taskmanager/package/contents/config/main.xml)
    * [`contents/config/config.qml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/applets/taskmanager/package/contents/config/config.qml)
    * [`contents/ui/ConfigAppearance.qml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/applets/taskmanager/package/contents/ui/ConfigAppearance.qml)
    * [`contents/ui/ConfigBehavior.qml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/applets/taskmanager/package/contents/ui/ConfigBehavior.qml)


## No-Apply Control Library

{{< sections >}}
{{< section-left >}}

Zren has written a few files that apply the above pattern of skipping "Apply" and updating right after you change the value.

[https://github.com/Zren/plasma-applet-lib/tree/master/package/contents/ui/libconfig](https://github.com/Zren/plasma-applet-lib/tree/master/package/contents/ui/libconfig)

* [libconfig/CheckBox.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/CheckBox.qml) for on/off booleans values.
* [libconfig/ColorField.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/ColorField.qml) for use with a `String` or `Color` config data type. If you use use a `String` data type, you can treat an empty string as a certain color theme color. Eg:
* [libconfig/ComboBox.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/ComboBox.qml) is useful for creating enums using the `String` config data type. KConfig comes with a enum datatype as well, but you have to either use hardcoded integers (with comments), or [declare the enum](https://stackoverflow.com/a/48460159/947742) in your QML code and keep it in sync. String comparison is less efficient but is easier to program with.
    * [FontFamily.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/FontFamily.qml) inherits `ComboBox.qml` and is populated with all available fonts.
* [libconfig/IconField.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/IconField.qml) based on the Application Launcher icon selector.
* [libconfig/RadioButtonGroup.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/RadioButtonGroup.qml) takes a similar model as `ComboBox.qml` but will display the options as [`RadioButton`](https://doc.qt.io/qt-5/qml-qtquick-controls2-radiobutton.html).
* [libconfig/SpinBox.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/SpinBox.qml) for Integer or Real numbers.
* [libconfig/TextAlign.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/TextAlign.qml) for use with an `Int` config data type. It has your typical 4 buttons for left/center/right/justify alignment. It serializes the `Text.AlignHCenter` enum.
    * [TextFormat.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/TextFormat.qml) is used to toggle bold, italic, underline, and embeds the text alignment. For use with 3 `Bool` config keys and 1 `Int` config key (used for the embedded `TextAlign.qml`).
* [libconfig/TextArea.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/TextArea.qml) for a string with multiple lines of text.
    * [TextAreaStringList.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/TextAreaStringList.qml) overloads `TextArea.qml`'s `valueToText(value)` and `textToValue(text)` functions to treat a new line as the separator for the `StringList` type.
* [libconfig/TextField.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/TextField.qml) for a single line of text.

{{< /section-left >}}
{{< section-right >}}
```bash
cd ~/Code/plasmoid-helloworld/package/contents/ui
mkdir -p ./libconfig
cd ./libconfig
wget https://github.com/Zren/plasma-applet-lib/archive/master.zip
unzip -j master.zip plasma-applet-lib-master/package/contents/ui/libconfig/*
rm master.zip
```

<div class="filepath">contents/ui/libconfig/CheckBox.qml</div>

```qml
import QtQuick 2.0
import QtQuick.Controls 2.0 as QQC2

QQC2.CheckBox {
    id: configCheckBox

    property string configKey: ''
    checked: plasmoid.configuration[configKey]
    onClicked: plasmoid.configuration[configKey] = !plasmoid.configuration[configKey]
}
```

<div class="filepath">contents/ui/configGeneral.qml</div>

```qml
import QtQuick 2.0
import org.kde.kirigami 2.4 as Kirigami
import "./libconfig" as LibConfig

Kirigami.FormLayout {
    id: page

    LibConfig.CheckBox {
        Kirigami.FormData.label: i18n("CheckBox:")
        configKey: 'showVariable'
    }

    LibConfig.ColorField {
        Kirigami.FormData.label: i18n("ColorField:")
        configKey: 'labelColor'
        defaultColor: PlasmaCore.ColorScope.textColor
    }

    LibConfig.ComboBox {
        Kirigami.FormData.label: i18n("ComboBox:")
        configKey: "variableName"
        model: [
            { value: "a", text: i18n("A") },
            { value: "b", text: i18n("B") },
            { value: "c", text: i18n("C") },
        ]
    }
}
```
{{< /section-right >}}
{{< /sections >}}




{{< readfile file="/content/docs/plasma/widget/snippet/plasma-doc-style.html" >}}
