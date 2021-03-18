---
title: Cards
weight: 104
group: "components"
description: >
  A card serves as overview and an entry point for more detailed information and can offer direct access to the most important actions on an item.
---

The Kirigami types [`Kirigami.AbstractCard`](docs:kirigami2;org::kde::kirigami::AbstractCard) and [`Kirigami.Card`](docs:kirigami2;org::kde::kirigami::Card) are used to implement the popular card component used on many mobile and web platforms. Cards can be used to display a collection of information or actions in an attractive and distinctive way.

Kirigami also offers 3 kinds of views and positioners to aid you in presenting your cards with beautiful and responsive layouts.

## AbstractCard

A [`Kirigami.AbstractCard`](docs:kirigami2;Card) is the simplest type of card. It's just a rectangle with a shadow, which can contain any `Item` in it. It can also have items assigned to its `header` or `footer` properties. In this case a [`Kirigami.Heading`](docs:kirigami2;Heading) is its header and a [`Controls.Label`](docs:qtquickcontrols;QtQuick.Controls.Label) with `wrapMode` set to `Text.WordWrap` is the card's `contentItem`.

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

A [`Kirigami.Card`](docs:kirigami2;Card) inherits from [`Kirigami.AbstractCard`](docs:kirigami2;AbstractCard) and provides more features out of the box. A card has a header composed of a `banner` and a footer composed of [`Kirigami.Action`](docs:kirigami2;Action) objects alongside its main content.

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

A [`Kirigami.CardsLayout`](docs:kirigami2;CardsLayout) is most useful when the cards being presented are not instantiated by a model or by a model which always has very few items. They are presented as a grid of two columns which will remain centered if the application is really wide, or become a single column if there is not enough space for two columns, such as a mobile phone screen.

{{< alert title="Note" color="info" >}}
[`Kirigami.CardsListView`](docs:kirigami2;CardsListView) or [`Kirigami.CardsGridView`](docs:kirigami2;CardsGridView) are better suited for larger models.
{{< /alert >}}

**A CardsLayout should always be contained within a ColumnLayout.**

A card can optionally be oriented horizontally. In this case it will be wider than tall, and is better suited to being placed in a ColumnLayout. If you must put it in a CardsLayout, it will have a columnSpan of 2 by default.

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

A [`Kirigami.CardsListView`](docs:kirigami2;CardsListView) is a list view that can be used with [`Kirigami.AbstractCard`](docs:kirigami2;AbstractCard) components.

A `Kirigami.CardsListView` will stretch child cards to its own width. This component should therefore only be used with cards which will look good at any horizontal size. Using a `Kirigami.CardsListView` the `Kirigami.Card` component is discouraged, unless it has `Qt.Horizontal` as its `headerOrientation` property.

The choice between using this view with `Kirigami.AbstractCard` components or a conventional `ListView` with [`AbstractListItem`](docs:kirigami2;AbstractListItem)/[BasicListItem](docs:kirigami2;BasicListItem) components is purely an aesthetic one.

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

Use a [`Kirigami.CardsGridView`](docs:kirigami2;org::kde::kirigami::CardsGridView) to display cards in a grid.

Its behavior is the same as a `Kirigami.CardsLayout`, and it allows cards to be put in one or two columns depending on the available width.

CardsGridView has the limitation that every card must have the same exact height, so `cellHeight` must be manually set to a value for which the content must fit for every child card.

If possible use `Kirigami.CardsGridView` only when you need to instantiate many cards. If you are only going to instantiate a few cards, opt for a `Kirigami.CardsLayout` with a `Repeater` instead.

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
