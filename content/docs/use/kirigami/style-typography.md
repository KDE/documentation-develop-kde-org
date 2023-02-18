---
title: Typography
weight: 102
group: style
description: Laying out your content
aliases:
  - /docs/kirigami/style-typography/
---

## Headings

Kirigami provides a [Heading](docs:kirigami2;Heading) that can
be used for page or section titles.

{{< sections >}}

{{< section-left >}}

```qml
import org.kde.kirigami 2.20 as Kirigami

Kirigami.Heading {
    text: "Heading level 1"
    level: 1
}
Kirigami.Heading {
    text: "Heading level 2"
    level: 2
}
Kirigami.Heading {
    text: "Heading level 3"
    level: 3
}
Kirigami.Heading {
    text: "Heading level 4"
    level: 4
}
Kirigami.Heading {
    text: "Heading level 5"
    level: 5
}
```
{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" alt="Five headings with different levels for size comparison" src="heading.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Labels

Text elements should use the [Label](docs:qtquickcontrols;QtQuick.Controls.Label) component from QtQuick Controls 2.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick.Controls 2.15 as Controls

Controls.Label {
    text: "My text"
}
```

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" src="label.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Text Alignment

You can align your text elements using the [horizontalAlignment](https://doc.qt.io/qt-6/qml-qtquick-text.html#horizontalAlignment-prop) and [verticalAlignment](https://doc.qt.io/qt-6/qml-qtquick-text.html#verticalAlignment-prop) properties.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.20 as Kirigami

ColumnLayout {
    Kirigami.Heading {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter 
        text: "Welcome to my application"
        wrapMode: Text.Wrap
    }
    Controls.Label {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante."
        wrapMode: Text.Wrap
    }
}
```
{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="Heading and lorem ipsum text aligned to the horizontal center" src="alignment-horizontal1.webp" >}}

{{< /section-right >}}

{{< /sections >}}

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.20 as Kirigami
ColumnLayout {
    Kirigami.Heading {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignRight
        text: "Welcome to my application"
        wrapMode: Text.Wrap
    }
    Controls.Label {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignRight
        text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante."
        wrapMode: Text.Wrap

    }
}
```

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="Heading and lorem ipsum text using right-aligned text" src="alignment-horizontal2.webp" >}}

{{< /section-right >}}

{{< /sections >}}

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.20 as Kirigami

ColumnLayout {
    Kirigami.Heading {
        Layout.fillWidth: true
        Layout.fillHeight: true
        verticalAlignment: Text.AlignBottom
        text: "Welcome to my application"
        wrapMode: Text.WordWrap
    }
    Controls.Label {
        Layout.fillWidth: true
        Layout.fillHeight: true
        verticalAlignment: Text.AlignTop
        text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante."
        wrapMode: Text.WordWrap
    }
}
```

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="Heading with bottom vertical alignment and lorem ipsum text with top vertical alignment" src="alignment-vertical1.webp" >}}

{{< /section-right >}}

{{< /sections >}}

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.20 as Kirigami

ColumnLayout {
    Kirigami.Heading {
        Layout.fillWidth: true
        Layout.fillHeight: true
        verticalAlignment: Text.AlignTop
        text: "Welcome to my application"
        wrapMode: Text.WordWrap
    }
    Controls.Label {
        Layout.fillWidth: true
        Layout.fillHeight: true
        verticalAlignment: Text.AlignBottom
        text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante."
        wrapMode: Text.WordWrap
    }
}

```

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="Heading with top vertical alignment and lorem ipsum text with bottom vertical alignment" src="alignment-vertical2.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Rich Text

QML allows you to display (and edit) rich text. The behavior can be
controlled via the [textFormat](https://doc.qt.io/qt-6/qml-qtquick-text.html#textFormat-prop) property.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls

Controls.Label {
    text: "<p>List of fruits</p>
    <ul>
        <li>Apple</li>
        <li>Cherry</li>
        <li>Orange</li>
        <li><del>Banana</del></li>
    </ul>
    <p>Don't eat Banana, they are <strong>evil</strong></p>"
}
```

{{< /section-left >}}

{{< section-right >}}

{{< figure  class="text-center" caption="A Label containing a list of fruits using HTML tags like paragraph, unordered lists and bold fonts" src="rich-text.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Theme

The font size of the [Kirigami.Theme](docs:kirigami2;Kirigami::PlatformTheme) is available
as `Kirigami.Theme.defaultFont.pointSize` in your application.
