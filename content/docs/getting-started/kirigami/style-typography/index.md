---
title: Typography
weight: 22
group: style
description: Laying out your content
aliases:
  - /docs/getting-started/kirigami/style-typography/
---

{{< alert color="info" >}}

For demonstrative purposes, this tutorial uses an AbstractCard to make the text examples clearer. A better way to achieve the same results would be to use a [Kirigami Addons FormCard](/docs/getting-started/kirigami/addons-introduction).

{{< /alert >}}

## Headings

Kirigami provides a [Heading](docs:kirigami;org.kde.kirigami.Heading) that can
be used for page or section titles.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Kirigami Heading"
    height: 400
    width: 400

    pageStack.initialPage: Kirigami.Page {
        Kirigami.AbstractCard {
            anchors.fill: parent
            contentItem: ColumnLayout {
                anchors.fill: parent
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
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

{{< figure class="text-center" alt="Five headings with different levels for size comparison" src="heading.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Labels

Text elements should use the [Label](docs:qtquickcontrols;QtQuick.Controls.Label) component from QtQuick Controls 2.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Controls Label"
    height: 400
    width: 400

    pageStack.initialPage: Kirigami.Page {
        Kirigami.AbstractCard {
            anchors.fill: parent
            contentItem: Controls.Label {
                    text: "My text"
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

{{< figure class="text-center align-baseline" src="label.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Text Alignment

You can align your text elements using the [horizontalAlignment](https://doc.qt.io/qt-6/qml-qtquick-text.html#horizontalAlignment-prop) and [verticalAlignment](https://doc.qt.io/qt-6/qml-qtquick-text.html#verticalAlignment-prop) properties.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Controls Horizontal Center"
    height: 400
    width: 400

    pageStack.initialPage: Kirigami.Page {
        Kirigami.AbstractCard {
            anchors.fill: parent
            contentItem: ColumnLayout {
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
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

{{< figure class="text-center" alt="Heading and lorem ipsum text aligned to the horizontal center" src="alignment-horizontal1.webp" >}}

{{< /section-right >}}

{{< /sections >}}

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Horizontal Align Right"
    height: 400
    width: 400

    pageStack.initialPage: Kirigami.Page {
        Kirigami.AbstractCard {
            anchors.fill: parent
            contentItem: ColumnLayout {
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
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

{{< figure class="text-center" alt="Heading and lorem ipsum text using right-aligned text" src="alignment-horizontal2.webp" >}}

{{< /section-right >}}

{{< /sections >}}

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Bottom and Top"
    height: 400
    width: 400

    pageStack.initialPage: Kirigami.Page {
        Kirigami.AbstractCard {
            anchors.fill: parent
            contentItem: ColumnLayout {
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
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

{{< figure class="text-center" alt="Heading with bottom vertical alignment and lorem ipsum text with top vertical alignment" src="alignment-vertical1.webp" >}}

{{< /section-right >}}

{{< /sections >}}

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Top and Bottom"
    height: 400
    width: 400

    pageStack.initialPage: Kirigami.Page {
        Kirigami.AbstractCard {
            anchors.fill: parent
            contentItem: ColumnLayout {
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
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

{{< figure class="text-center" alt="Heading with top vertical alignment and lorem ipsum text with bottom vertical alignment" src="alignment-vertical2.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Rich Text

QML allows you to display (and edit) rich text. The behavior can be
controlled via the [textFormat](https://doc.qt.io/qt-6/qml-qtquick-text.html#textFormat-prop) property.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Controls Label with rich text"
    height: 400
    width: 400

    pageStack.initialPage: Kirigami.Page {
        Kirigami.AbstractCard {
            anchors.fill: parent
            contentItem: Controls.Label {
                text: "<p><strong>List of fruits to purchase</strong></p>
                <ul>
                <li>Apple</li>
                <li>Cherry</li>
                <li>Orange</li>
                <li><del>Banana</del></li>
                </ul>
                <p>Kris already got some bananas yesterday.</p>"
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

{{< figure  class="text-center" alt="A Label containing a list of fruits using HTML tags like paragraph, unordered lists and bold fonts" src="rich-text.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Theme

The font size of the [Kirigami.Theme](https://api-staging.kde.org/qml-org-kde-kirigami-platform-theme.html) is available
as `Kirigami.Theme.defaultFont.pointSize` in your application.
