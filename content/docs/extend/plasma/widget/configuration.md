---
title: "Configuration"
weight: 5
description: >
  Adding user configured settings to your widget
aliases:
  - /docs/plasma/widget/configuration/
---

## Configuration Intro

{{< sections >}}
{{< section-left >}}

Every widget by default has a configure action when you right click the widget called `MyWidget Settings...`. By default it will contain a form to set a global shortcut to activate your widget.

{{< /section-left >}}
{{< section-right >}}

![](configwindow.png)

{{< /section-right >}}
{{< /sections >}}


## contents/config/main.xml

{{< sections >}}
{{< section-left >}}

`main.xml` is where you define the properties that will be serialized into `~/.config/plasma-org.kde.plasma.desktop-appletsrc`. All properties will be accessible with `plasmoid.configuration.variableName` reguardless of was group it's in.

[KConfig](docs:kconfig;annotated.html) has a variety of data types:

* `Int` for an Integer number
* `Double` for a double precision floating point number (Real)
* `String` for a string of characters to represent text
* `Color` for a hexadecimal color. The color defaults to `#000000` (black) if the default is left empty.
* `Path` is a string that is specially treated as a file-path. In particular paths in the home directory are prefixed with `$HOME` when being stored in the configuration file.
* `StringList` for a comma separated list of Strings

I've listed the more common use cases. More can be found in [KConfigXT's documentation]({{< ref "/docs/use/configuration/kconfig_xt" >}}).

---

I personally don't recommend using `Color` if you want to default to a color from the color scheme (eg: `PlasmaCore.ColorScope.textColor`). I would instead suggest using a `String` that is empty by default. You can then use the following in the QML:

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

{{< /section-left >}}
{{< section-right >}}
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
`config.qml` is where we define the tabs in the configuration window.

We import the `ConfigModel` and `ConfigCategory`, and define the tab name, icon, and qml file that will be loaded.
{{< /section-left >}}
{{< section-right >}}
```qml
import QtQuick 2.0
import org.kde.plasma.configuration 2.0

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


## contents/ui/configGeneral.qml

{{< sections >}}
{{< section-left >}}
`configGeneral.qml` is where we can place all the checkboxes and textboxes.

Please note that your should not use `PlasmaComponents.*` controls in the config window, as those are styled and colored for the panel. The normal `QtQuick.Controls` are styled using your application window style + colors.

`Kirigami.FormLayout` is used to layout the controls in the center of the page. The `Kirigami.FormData.label` attached property is used to place labels in front of the controls. Kirigami labels are optional, so you do not need to use them for CheckBoxes which have their own labels on the right.

![](configgeneral.png)

{{< /section-left >}}
{{< section-right >}}
```qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page
  
    property alias cfg_showLabel: showLabel.checked
    property alias cfg_showIcon: showIcon.checked
    property alias cfg_labelText: labelText.text

    CheckBox {
        id: showLabel
        Kirigami.FormData.label: i18n("Section:")
        text: i18n("Show label")
    }
    CheckBox {
        id: showIcon
        text: i18n("Show icon")
    }
    TextField {
        id: labelText
        Kirigami.FormData.label: i18n("Label:")
        placeholderText: i18n("Placeholder")
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## configPage.cfg_variableName

{{< sections >}}
{{< section-left >}}

By default, all values are copied to the top level `Item` of the file prefixed with `cfg_` like `page.cfg_variableName`. This is so the user can hit discard or apply the changes. You will need to define each `cfg_` property so you can bind the value with a QML control.

Note that you can use a property [alias](http://doc.qt.io/qt-5/qtqml-syntax-objectattributes.html#property-aliases) to a control's property like `checkBox.checked` or `textField.text`.

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/configGeneral.qml</div>

```qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page
    property alias cfg_variableName: variableName.checked

    CheckBox {
        id: variableName
        Kirigami.FormData.label: i18n("Icon:")
        text: i18n("Show")
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## CheckBox - Boolean

{{< sections >}}
{{< section-left >}}

A [CheckBox](https://doc.qt.io/qt-5/qml-qtquick-controls2-checkbox.html) is used for boolean on/off values. See the [Visual Design Group's tips](https://community.kde.org/KDE_Visual_Design_Group/HIG/CheckBox) on using CheckBoxes.

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
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page
    property alias cfg_variableName: variableName.checked

    CheckBox {
        id: variableName
    }
}
```
{{< /section-right >}}
{{< /sections >}}



## SpinBox - Integer

{{< sections >}}
{{< section-left >}}

A [SpinBox](https://doc.qt.io/qt-5/qml-qtquick-controls2-spinbox.html) is used for numbers.

If you want decimal places, a [`QtQuick.Controls 1.0` SpinBox](https://doc.qt.io/qt-5/qml-qtquick-controls-spinbox.html) is a little easier to use than the `QtQuick.Controls 2.0` version. `QtQuickControls1` has a `SpinBox.decimals` to easily switch from an Integer `decimals: 0` to `decimals: 3` to represent a Real number (the `Double` data type).

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
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page
    property alias cfg_variableName: variableName.value

    SpinBox {
        id: variableName
    }
}
```
{{< /section-right >}}
{{< /sections >}}



## SpinBox - Double/Real

{{< sections >}}
{{< section-left >}}

If you want decimal places, a [`QtQuick.Controls 1.0` SpinBox](https://doc.qt.io/qt-5/qml-qtquick-controls-spinbox.html) is a little easier to use than the `QtQuick.Controls 2.0` version. `QtControls1` has a `SpinBox.decimals` property to easily switch from an Integer `decimals: 0` to `decimals: 3` to represent a Real number (the `Double` config data type).

<div class="filepath">contents/config/main.xml</div>

```xml
<entry name="variableName" type="Double">
    <default>3.1459</default>
</entry>
```

If you really want to use `QtQuick.Controls 2.0`, look at Zren's [libconfig/SpinBox.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/SpinBox.qml) for an example on implementing the `decimals` property.

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/configGeneral.qml</div>

```qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls 1.0 as QtControls1
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page
    property alias cfg_variableName: variableName.value

    QtControls1.SpinBox {
        id: variableName
        decimals: 2
    }
}
```
{{< /section-right >}}
{{< /sections >}}



## TextField - String/Text

{{< sections >}}
{{< section-left >}}

A [TextField](https://doc.qt.io/qt-5/qml-qtquick-controls2-textfield.html) is used for a single line of text. It can be used as a base for many other data types as well. You will also want to look at the base [TextInput](https://doc.qt.io/qt-5/qml-qtquick-textinput.html) for more properties.

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
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page
    property alias cfg_variableName: variableName.text

    TextField {
        id: variableName
    }
}
```
{{< /section-right >}}
{{< /sections >}}



## TextArea - Multi-Line String/Text

{{< sections >}}
{{< section-left >}}

A [TextArea](https://doc.qt.io/qt-5/qml-qtquick-controls2-textarea.html) is used for paragraphs of text. You will also want to look at the base [TextEdit](https://doc.qt.io/qt-5/qml-qtquick-textedit-members.html) for more properties.

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
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page
    property alias cfg_variableName: variableName.value

    TextArea {
        id: variableName
    }
}
```
{{< /section-right >}}
{{< /sections >}}



## ColorButton - Color

{{< sections >}}
{{< section-left >}}

KDE Frameworks has [`ColorButton`](https://api.kde.org/frameworks/kdeclarative/html/classorg_1_1kde_1_1kquickcontrols_1_1ColorButton.html) which provides a preview of the selected color and will open QtQuick's [`ColorDialog`](https://doc.qt.io/qt-5/qml-qtquick-dialogs-colordialog.html) for selecting a color.

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
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.4 as Kirigami
import org.kde.kquickcontrols 2.0 as KQControls

Kirigami.FormLayout {
    id: page
    property alias cfg_variableName: variableName.value

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
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page
    property alias cfg_variableName: variableName.value

    RowLayout {
        Kirigami.FormData.label: i18n("Sound File:")

        TextField {
            id: variableName
            placeholderText: i18n("No file selected.")
        }
        Button {
            text: i18n("Browse")
            icon.name: "folder-symbolic"
            onClicked: fileDialogLoader.active = true

            Loader {
                id: fileDialogLoader
                active: false

                sourceComponent: FileDialog {
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
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page

    CheckBox {
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

[https://github.com/Zren/plasma-applet-lib/.../libconfig/](https://github.com/Zren/plasma-applet-lib/tree/master/package/contents/ui/libconfig)

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

```qml
// libconfig/CheckBox.qml
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
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.4 as Kirigami
import "./libconfig" as LibConfig

Kirigami.FormLayout {
    id: page

    LibConfig.CheckBox {
        configKey: 'showVariable'
    }

    LibConfig.ColorField {
        configKey: 'labelColor'
        defaultColor: PlasmaCore.ColorScope.textColor
    }

    LibConfig.ComboBox {
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




<style>
.filepath {
    font-family: SFMono-Regular,Menlo,Monaco,Consolas,liberation mono,courier new,monospace;
    background-color: #f0f0f0;
    color: #595858;

    /* .highlight     has 1px rgba(35,38,41,.125) */
    /* .highlight>pre has 1px rgba(0,0,0,.125) */
    border: 2px solid #e3e3e4;
    border-bottom: 0;
    border-radius: .25rem .25rem 0 0;

    /* .td-content .highlight pre { padding-left: .5rem } */
    padding: .3rem .5rem;
}
.filepath + .highlight,
.filepath + .highlight > pre {
    margin-top: 0;
    border-top-left-radius: 0;
    border-top-right-radius: 0;
}
@media (prefers-color-scheme: dark) {
    .filepath {
        color: #9d9d9d;
        background-color: #2a2e33;
        border-color: #2a2e33;
    }
    .filepath,
    .filepath + .highlight,
    .filepath + .highlight > pre {
        border-color: #2a2e33 !important;
        /*border: 1px solid red;*/
    }
}
</style>
