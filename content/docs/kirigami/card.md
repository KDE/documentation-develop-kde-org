---
title: Cards
weight: 102
group: "components"
description: >
  A card serves as overview and an entry point for more detailed information and can offer direct access to the most important actions on an item.
---


The Kirigami types [AbstractCard](docs:kirigami2;org::kde::kirigami::AbstractCard) and [Card](docs:kirigami2;org::kde::kirigami::Card) are used to implement the popular Card pattern used on many mobile and web platforms that is used to display a collection of information or actions.

Besides the Card components, Kirigami offers also 3 kinds of views and positioners to help to present cards with beautiful and responsive layouts.

## AbstractCard

An [AbstractCard](docs:kirigami2;org::kde::kirigami::Card) is the simplest form of card. It's just a rectangle with a shadow, which can contain any Item in it. It can also have items assigned to the Header or Footer properties. In this case a [Heading](docs:kirigami2;org::kde::kirigami::Heading) is its header and a [Label](docs:qtquickcontrols;QtQuick.Controls.Label) with WordWrap is the contentItem.

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
![Screenshot of an Abstract Card](abstract-card.png)
{{< /section-right >}}
{{< /sections >}}


## Card

A [Card](docs:kirigami2;org::kde::kirigami::Card) inherits from [AbstractCard](docs:kirigami2;org::kde::kirigami::AbstractCard) and provides more features out of the box. A card has a header composed of a banner, a footer composed of [Actions](docs:kirigami2;org::kde::kirigami::Action) and the main content.

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
![](card1.png)
{{< /section-right >}}
{{< /sections >}}

## CardsLayout

Use a [CardsLayout](docs:kirigami2;org::kde::kirigami::CardsLayout) when the cards are not instantiated by a model or by a model which has always very few items (In the case of a big model [CardsListView](docs:kirigami2;org::kde::kirigami::CardsListView) or [CardsGridView](docs:kirigami2;org::kde::kirigami::CardsGridView) should be used instead). They are presented as a grid of two columns which will remain centered if the application is really wide, or become a single column if there is not enough space for two columns, such as a mobile phone screen.

A CardsLayout should always be contained within a ColumnLayout.

A card can optionally be oriented horizontally. In this case it will be wider than tall, so is fit to be used in a ColumnLayout. If you need to put it in a CardsLayout, it will have a columnSpan of 2 by default.

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
![Screenshot of a CardsLayout](cardslayout.png)
{{< /section-right >}}
{{< /sections >}}

## CardsListView

A [CardsListView](docs:kirigami2;org::kde::kirigami::CardsListView) is a list view of [AbstractCard](docs:kirigami2;org::kde::kirigami::AbstractCard) subclasses with a custom layout inside is needed.

CardsListView should be used only with cards which can look good at any horizontal size, so it is recommended to use directly AbstractCard with an appropriate layout inside, because they are stretching for the whole list width.

Therefore it's discouraged to use it with the Card type, unless it has `Horizontal` as `headerOrientation`.

The choice between using this view with AbstractCard or a normal ListView with [AbstractListItem](docs:kirigami2;org::kde::kirigami::AbstractListItem)/[BasicListItem](docs:kirigami2;org::kde::kirigami::BasicListItem) is purely aesthetical.

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
![Screenshot of a CardsListView](cardslistview.png)
{{< /section-right >}}
{{< /sections >}}

## CardsGridView

Use a [CardsGridView](docs:kirigami;org::kde::kirigami::CardsGridView) for displaying cards in a grid.

The behavior is the same as a CardsLayout, and it allows cards to be put in one or two columns depending on the available width.

CardsGridView has the limitation that every Card must have the same exact height, so `cellHeight` must be manually set to a value for which the content fits for every item.

If possible use CardsGridView only when you need to instantiate many cards. If you only instantiate a few cards, use CardsLayout with a Repeater instead.

{{< sections >}}
{{< section-left >}}
```qml
Kirigami.CardsGridView {
    id: view
    model: ListModel {
        id: mainModel
        // Model with the following roles: text,
        // actions and image
    }
    delegate:Kirigami.Card {
        id: card
        banner {
            title: model.title
            source: model.image
        }
        contentItem: Controls.Label {
            wrapMode: Text.WordWrap
            text: model.text
        }
        actions: [
            Kirigami.Action {
                text: model.actions.get(0).text
                icon.name: model.actions.get(0).icon
            },
            Kirigami.Action {
                text: model.actions.get(1).text
                icon.name: model.actions.get(1).icon
            }
        ]
    }
}

```
{{< /section-left >}}

{{< section-right >}}
![Screenshot of a CardsGridView](cardsgridview.png)
{{< /section-right >}}
{{< /sections >}}
