---
title: Typography
weight: 102
group: style
description: Laying out your content
aliases:
  - /docs/kirigami/style-typography/
---

## Headings

Kirigami provides an [heading element](docs:kirigami2;Heading) that can
be used for page or section titles.

```qml
import org.kde.kirigami 2.14 as Kirigami

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

{{< img alt="Heading" src="heading.png" >}}

## Labels

Text elements should use the Label element from QtQuick Controls 2.

```qml
import QtQuick.Controls 2.15 as QQC2
QQC2.Label {
    text: "My text"
}
```

## Text Alignment

You can align your text elements using the horizontalAlignment property
of the text element.

```qml
import QtQuick.Layouts 1.15 
import QtQuick.Controls 2.15 as QQC2
import org.kde.kirigami 2.14 as Kirigami

ColumnLayout {
    Kirigami.Heading {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter 
        text: "Welcome to my application"
        wrapMode: Text.Wrap
    }
    QQC2.Label {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante."
        wrapMode: Text.Wrap
    }
}
```

{{< img alt="Text centered" src="center-text.png" >}}

```qml
import QtQuick.Layouts 1.15 
import QtQuick.Controls 2.15 as QQC2
import org.kde.kirigami 2.14 as Kirigami

ColumnLayout {
    Kirigami.Heading {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignRight
        text: "Welcome to my application"
        wrapMode: Text.Wrap
    }
    QQC2.Label {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignRight
        text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante."
        wrapMode: Text.Wrap
    }
}
```

{{< img alt="Text right aligned" src="right-text.png" >}}

## Rich Text

QML allows you to display (and edit) rich text. The behavior can be
controlled via the [textFormat](https://doc.qt.io/qt-5/qml-qtquick-text.html#textFormat-prop) property.

```qml
import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2

QQC2.Label {
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

{{< img alt="Displaying rich text" src="rich-text.png" >}}

## Theme

The font size of the Kirigami [Theme](docs:kirigami2;Theme) is available
as `Kirigami.Theme.defaultFont.pointSize` in your application.
