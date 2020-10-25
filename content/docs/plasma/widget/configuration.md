---
title: "Configuration"
weight: 5
description: >
  Adding user configured settings to your widget
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

`main.xml` is where you define the properties that will be serialized into `~/.config/plasma-org.kde.plasma.desktop-appletsrc`. All properties will be accesible with `plasmoid.configuration.variableName` reguardless of was group it's in.

[KConfig](docs:kconfig;annotated.html) has a variety of data types:

* `Int` for an Integer number
* `Double` for a double precision floating point number (Real)
* `String` for a string of characters to represent text
* `Color` for a hexidecimal color. The color defaults to `#000000` (black) if the default is left empty.
* `Path` is a string that is specially treated as a file-path. In particular paths in the home directory are prefixed with `$HOME` when being stored in the configuration file.
* `StringList` for a comma seperated list of Strings

I've listed the more common usecases. More can be found on the wiki:  
<https://techbase.kde.org/Development/Tutorials/Using_KConfig_XT>

---

I personally don't recommend using `Color` if you want to default to a color from the color scheme (eg: `PlasmaCore.ColorScope.textColor`). I would instead suggest using a `String` that is empty by default. You can then use the following in the QML:

```xml
<entry name="labelColor" type="String">
    <default></default>
</entry>
```

```qml
PlasmaComponents.Label {
    color: plasmoid.configruation.labelColor || PlasmaCore.ColorScope.textColor
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

`Kirigami.FormLayout` is used to layout the controls in the center of the page. The `Kirigami.FormData.label` attached property is used to place labels in front of the controls. CheckBoxes have their own labels, so you don't need to set a Kirigami label. You can use it for CheckBoxes as a section seperator though. You do not need to set a Kirigami label.

![](configgeneral.png)

{{< /section-left >}}
{{< section-right >}}
```qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

Item {
    id: page
    width: childrenRect.width
    height: childrenRect.height

    property alias cfg_showLabel: showLabel.checked
    property alias cfg_showIcon: showIcon.checked
    property alias cfg_labelText: labelText.text

    Kirigami.FormLayout {
        anchors.left: parent.left
        anchors.right: parent.right

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
```qml
// configGeneral.qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0

Item {
    id: page
    property alias cfg_variableName: variableName.checked

    CheckBox {
        id: variableName
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## CheckBox - Boolean

{{< sections >}}
{{< section-left >}}

A [CheckBox](https://doc.qt.io/qt-5/qml-qtquick-controls2-checkbox.html) is used for boolean on/off values. See the [Visual Design Group's tips](https://community.kde.org/KDE_Visual_Design_Group/HIG/CheckBox) on using CheckBoxes.

```xml
<!-- config/main.xml -->
<entry name="variableName" type="Bool">
    <default>true</default>
</entry>
```

{{< /section-left >}}
{{< section-right >}}
```qml
// configGeneral.qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0

Item {
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

```xml
<!-- config/main.xml -->
<entry name="variableName" type="Int">
    <default>6</default>
</entry>
```

{{< /section-left >}}
{{< section-right >}}
```qml
// configGeneral.qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0

Item {
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

```xml
<!-- config/main.xml -->
<entry name="variableName" type="Double">
    <default>3.1459</default>
</entry>
```

{{< /section-left >}}
{{< section-right >}}
```qml
// configGeneral.qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls 1.0 as QtControls1
import QtQuick.Layouts 1.0

Item {
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

```xml
<!-- config/main.xml -->
<entry name="variableName" type="String">
    <default>Hello World</default>
</entry>
```

{{< /section-left >}}
{{< section-right >}}
```qml
// configGeneral.qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0

Item {
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

```xml
<!-- config/main.xml -->
<entry name="variableName" type="String">
    <default>Hello World</default>
</entry>
```

{{< /section-left >}}
{{< section-right >}}
```qml
// configGeneral.qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0

Item {
    id: page
    property alias cfg_variableName: variableName.value

    TextArea {
        id: variableName
    }
}
```
{{< /section-right >}}
{{< /sections >}}



## Assigning to plasmoid.configuration.varName

{{< sections >}}
{{< section-left >}}

You can also assign directly to `plasmoid.configuration.variableName` if necessary in the configruation window or anywhere else in your widget. If you do this in the configuration page, you will skip the "apply" process and the property will be applied right away. I leave this up to the reader wither this is a pro or con.

{{< /section-left >}}
{{< section-right >}}
```qml
// configGeneral.qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0

Item {
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
    * [`contents/ui/ConfigButtons.qml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/applets/kickoff/package/contents/ui/ConfigButtons.qml)
* Task Manager
    * [`contents/config/main.xml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/applets/taskmanager/package/contents/config/main.xml)
    * [`contents/config/config.qml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/applets/taskmanager/package/contents/config/config.qml)
    * [`contents/ui/ConfigAppearance.qml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/applets/taskmanager/package/contents/ui/ConfigAppearance.qml)
    * [`contents/ui/ConfigBehavior.qml`](https://invent.kde.org/plasma/plasma-desktop/-/blob/master/applets/taskmanager/package/contents/ui/ConfigBehavior.qml)


## No-Apply Control Library

{{< sections >}}
{{< section-left >}}

I have written a few files that apply the above pattern of skipping "Apply" and updating right after you change the value. It still uses the `QtQuick.Controls 1.0` controls at the moment however.

* [ConfigCheckBox.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/lib/ConfigCheckBox.qml) for on/off booleans values.
* [ConfigSpinBox.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/lib/ConfigSpinBox.qml) for Integer or Real numbers.
* [ConfigString.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/lib/ConfigString.qml) for a single line of text.
* [ConfigColor.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/lib/ConfigColor.qml) for use with a `String` or `Color` config data type. If you use use a `String` data type, you can treat an empty string as a certain color theme color. Eg:
  ```qml
  ConfigColor {
    configKey: 'labelColor'
    defaultColor: PlasmaCore.ColorScope.textColor
  }
  ```
* [ConfigIcon.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/lib/ConfigIcon.qml) based on the Application Launcher icon selector.
* [ConfigStringList.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/lib/ConfigStringList.qml) Instead of a [TextField](https://doc.qt.io/qt-5/qml-qtquick-controls-textfield.html), it uses a [TextArea](https://doc.qt.io/qt-5/qml-qtquick-controls-textarea.html) using a new line as the seperator.
* [ConfigComboBox.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/lib/ConfigComboBox.qml) is useful for creating enums using the `String` config data type. KConfig comes with a enum datatype as well, but you have to use hardcoded integers (with comments) in your QML code, rather than using strings.
    * [ConfigFontFamily.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/lib/ConfigFontFamily.qml) inherits `ConfigComboBox.qml` and is populated with all available fonts.
* [ConfigRadioButtonGroup.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/lib/ConfigRadioButtonGroup.qml) uses a similar model as `ConfigComboBox.qml` but displays the enum values differently.
* [ConfigTextAlign.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/lib/ConfigTextAlign.qml) for use with an `Int` config data type. It has your typical 4 buttons for left/center/right/justify alignment. It serializes the `Text.AlignHCenter` enum, which is an Integer.
    * [ConfigTextFormat.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/lib/ConfigTextFormat.qml) is used to config bold, italic, underline, and embeds the text alignment. For use with 3 `Bool` config keys and 1 `Int` config key (used for the embeded `ConfigTextAlign.qml`).

{{< /section-left >}}
{{< section-right >}}
```qml
// ConfigCheckBox.qml
import QtQuick 2.0
import QtQuick.Controls 1.0 as QtControls1
import QtQuick.Layouts 1.0

QtControls1.CheckBox {
    id: configCheckBox

    property string configKey: ''
    checked: plasmoid.configuration[configKey]
    onClicked: plasmoid.configuration[configKey] = !plasmoid.configuration[configKey]
}
```

```qml
// configGeneral.qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0

Item {
    id: page

    ConfigCheckBox {
        id: variableName
        configKey: 'variableName'
    }
}
```
{{< /section-right >}}
{{< /sections >}}

