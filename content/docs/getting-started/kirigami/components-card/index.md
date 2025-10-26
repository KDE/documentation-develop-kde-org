---
title: Cards
weight: 34
group: "components"
description: >
  A card serves as an overview and entry point for more detailed information and can offer direct access to the most important actions of an item.
aliases:
  - /docs/getting-started/kirigami/components-card/
---

The Kirigami types [AbstractCard](docs:kirigami;org.kde.kirigami.AbstractCard) and [Card](docs:kirigami;org.kde.kirigami.Card) are used to implement the popular card component used on many mobile and web platforms. Cards can be used to display a collection of information or actions in an attractive and distinctive way.

Kirigami also offers 3 kinds of [views](https://doc.qt.io/qt-6/qtquick-modelviewsdata-modelview.html) and [positioners](https://doc.qt.io/qt-6/qtquick-positioning-layouts.html) to aid you in presenting your cards with beautiful and responsive layouts.

## AbstractCard

A [Kirigami.AbstractCard](docs:kirigami;org.kde.kirigami.AbstractCard) is the simplest type of card. It's just a rectangle with a shadow, which can contain any [Item](docs:qtquick;QtQuick.Item) in it. It can also have Items assigned to its [header](https://api.kde.org/qml-org-kde-kirigami-abstractcard.html#header-prop) or [footer](https://api.kde.org/qml-org-kde-kirigami-abstractcard.html#footer-prop) properties. In this case a [Kirigami.Heading](docs:kirigami;org.kde.kirigami.Heading) is its `header` and a [Controls.Label](docs:qtquickcontrols;QtQuick.Controls.Label) is the card's [contentItem](https://doc.qt.io/Qt-6/qml-qtquick-controls-control.html#contentItem-prop).

{{< sections >}}

{{< section-left >}}

```qml
Kirigami.AbstractCard {
    Layout.fillHeight: true
    header: Kirigami.Heading {
        text: qsTr("AbstractCard")
        level: 2
    }
    contentItem: Controls.Label {
        wrapMode: Text.WordWrap
        text: "..."
    }
}
```

{{< /section-left >}}

{{< section-right >}}

![Screenshot of an Abstract Card, a simple rectangular button with left-aligned text](/docs/getting-started/kirigami/components-card/abstract-card.png)

{{< /section-right >}}

{{< /sections >}}


## Card

A [Kirigami.Card](docs:kirigami;org.kde.kirigami.Card) inherits from [AbstractCard](docs:kirigami;org.kde.kirigami.AbstractCard) and provides more features out of the box. Cards inherit the same [header](https://api.kde.org/qml-org-kde-kirigami-abstractcard.html#header-prop) and [footer](https://api.kde.org/qml-org-kde-kirigami-abstractcard.html#footer-prop) from an Abstract Card, but you are encouraged to use a [banner](https://api.kde.org/qml-org-kde-kirigami-card.html#banner-prop) and a set of [Kirigami.Action](docs:kirigami;org.kde.kirigami.Action) in the [actions](https://api.kde.org/qml-org-kde-kirigami-card.html#actions-prop) group instead.

{{< sections >}}

{{< section-left >}}

```qml
Kirigami.Card {
    actions: [
        Kirigami.Action {
            text: qsTr("Action1")
            icon.name: "add-placemark"
        },
        Kirigami.Action {
            text: qsTr("Action2")
            icon.name: "address-book-new-symbolic"
        },
        // ...
    ]
    banner {
        source: "../banner.jpg"
        title: "Title Alignment"
        // The title can be positioned in the banner
        titleAlignment: Qt.AlignLeft | Qt.AlignBottom
    }
    contentItem: Controls.Label {
        wrapMode: Text.WordWrap
        text: "My Text"
    }
}

```

{{< /section-left >}}

{{< section-right >}}

![Screenshot of a full-fledged Card with a banner background behind its title, white background behind its text, and two actions with icons and a hamburger menu at the bottom](/docs/getting-started/kirigami/components-card/card1.png)

{{< /section-right >}}

{{< /sections >}}

## CardsLayout

A [Kirigami.CardsLayout](docs:kirigami;org.kde.kirigami.CardsLayout) is most useful when the cards being presented are either not instantiated by a model or are instantiated by a model that always has very few items. They are presented as a grid of two columns which will remain centered if the application is really wide, or become a single column if there is not enough space for two columns, such as a mobile phone screen.

{{< alert title="Note" color="info" >}}

[`CardsListView`](docs:kirigami;org.kde.kirigami.CardsListView) is better suited for larger models.

{{< /alert >}}

{{< alert title="Important" color="warning" >}}

A [CardsLayout](docs:kirigami;org.kde.kirigami.CardsLayout) should always be contained within a [ColumnLayout](https://doc.qt.io/qt-6/qml-qtquick-layouts-columnlayout.html).

{{< /alert >}}

A card can optionally be oriented horizontally. In this case it will be wider than tall, and is better suited to being placed in a [ColumnLayout](https://doc.qt.io/qt-6/qml-qtquick-layouts-columnlayout.html). If you must put it in a [CardsLayout](docs:kirigami;org.kde.kirigami.CardsLayout), it will have a [maximumColumns](https://api.kde.org/qml-org-kde-kirigami-cardslayout.html#maximumColumns-prop) of `2` by default.

{{< sections >}}

{{< section-left >}}

```qml
ColumnLayout {
    Kirigami.CardsLayout {
        Kirigami.Card {
            contentItem: Controls.Label {
                wrapMode: Text.WordWrap
                text: "My Text2"
            }
        }
        Kirigami.AbstractCard { 
            contentItem: Controls.Label {
                wrapMode: Text.WordWrap
                text: "My Text"
            }
        }
        Kirigami.Card {
            headerOrientation: Qt.Horizontal
            contentItem: Controls.Label {
                wrapMode: Text.WordWrap
                text: "My Text2"
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

![Screenshot of a CardsLayout showing two side by side cards in portrait orientation on top of a card in landscape orientation, all with different components being used](/docs/getting-started/kirigami/components-card/cardslayout.png)

{{< /section-right >}}

{{< /sections >}}

## CardsListView

A [Kirigami.CardsListView](docs:kirigami;org.kde.kirigami.CardsListView) is a list view that can be used with [AbstractCard](docs:kirigami;org.kde.kirigami.AbstractCard) components.

A [CardsListView](docs:kirigami;org.kde.kirigami.CardsListView) will stretch child cards to its own width. This component should therefore only be used with cards which will look good at any horizontal size. Use of a [Card](docs:kirigami;org.kde.kirigami.Card) component inside it is discouraged, unless it has [Qt.Horizontal](docs:qtcore;Qt::Orientation) as its [headerOrientation](https://api.kde.org/qml-org-kde-kirigami-abstractcard.html#headerOrientation-prop) property.

{{< sections >}}

{{< section-left >}}

```qml
Kirigami.CardsListView {
    id: view
    model: 100

    delegate: Kirigami.AbstractCard {
        //NOTE: never put a Layout as contentItem as it will cause binding loops
        contentItem: Item {
            implicitWidth: delegateLayout.implicitWidth
            implicitHeight: delegateLayout.implicitHeight
            GridLayout {
                id: delegateLayout
                anchors {
                    left: parent.left
                    top: parent.top
                    right: parent.right
                    //IMPORTANT: never put the bottom margin
                }
                rowSpacing: Kirigami.Units.largeSpacing
                columnSpacing: Kirigami.Units.largeSpacing
                columns: width > Kirigami.Units.gridUnit * 20 ? 4 : 2
                Kirigami.Icon {
                    source: "applications-graphics"
                    Layout.fillHeight: true
                    Layout.maximumHeight: Kirigami.Units.iconSizes.huge
                    Layout.preferredWidth: height
                }
                Kirigami.Heading {
                    level: 2
                    text: qsTr("Product ")+ modelData
                }
                Controls.Button {
                    Layout.alignment: Qt.AlignRight
                    Layout.columnSpan: 2 
                    text: qsTr("Install")
                }
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

![Screenshot of a CardsListView, which is a simple vertical list of cards in landscape mode](/docs/getting-started/kirigami/components-card/cardslistview.png)

{{< /section-right >}}

{{< /sections >}}
