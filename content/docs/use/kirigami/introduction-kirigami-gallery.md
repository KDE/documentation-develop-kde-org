---
title: Using Kirigami Gallery
group: introduction
weight: 8
description: >
  Using Kirigami Gallery to find code patterns
aliases:
  - /docs/kirigami/introduction-kirigami-gallery/
---

[Kirigami Gallery](https://apps.kde.org/kirigami2.gallery/) is a helpful friend
when developing a Kirigami application. It is an application that uses core Kirigami features, provides links to the source code, tips on how to use Kirigami components, and links to the corresponding HIG pages.

{{< alert color="info" title="Tip" >}}

Before continuing please install Kirigami Gallery. It should already be in the
repository of your Linux distribution.

{{< /alert >}}

## Finding a card grid

Navigating through the Kirigami Gallery application, we will stumble upon the "Grid view with cards" gallery component. This is an example that can be applied to multiple use cases, such as contact cards.

![List of kirigami gallery components](components.webp)

After selecting the "Grid view of cards" gallery component, if we click the "Info" button on the top right, we will get some useful information about the Card and Abstract Card types.

![Kirigami gallery grid view](cards.webp)

In the bottom section of this information dialog we will also find a link to the source code of the "Cards Grid
View". Let's navigate to this page.

## Implementing a card grid

We will reuse most of the code found in the [source code of the CardsGridViewGallery component](https://invent.kde.org/sdk/kirigami-gallery/-/blob/master/src/data/contents/ui/gallery/CardsGridViewGallery.qml).
In particular, we will remove the extra parts of the [OverlaySheet](docs:kirigami2;OverlaySheet) (which is the pop-up we used to reach the kirigami-gallery source code repository).

So, we are going to substitute the [Page](docs:kirigami2;Page) component of `main.qml` of our skeleton app with the
below [ScrollablePage](docs:kirigami2;ScrollablePage):

```qml
Kirigami.ScrollablePage {
    title: i18n("Address book (prototype)")

    Kirigami.CardsGridView {
        id: view

        model: ListModel {
            id: mainModel
        }

        delegate: card
    }
}
```

What we have done so far is to create a [ScrollablePage](docs:kirigami2;ScrollablePage) and put
a [CardsGridView](docs:kirigami2;CardsGridView) into it, since we want to display a grid of Cards
generated from a model. The data of each contact is provided by a [ListModel](https://doc.qt.io/qt-6/qml-qtqml-models-listmodel.html)
while the card delegate is responsible for the presentation of the data. For more info about
models and views in Qt Quick, see [here](https://doc.qt.io/qt-5/qtquick-modelviewsdata-modelview.html).

Now let's populate the model that will feed our grid view with data. In the definition of [Kirigami.ScrollablePage](docs:kirigami2;ScrollablePage), just after:


```qml
      delegate: card
    }
```

add the following:

```qml
Component.onCompleted: {
    mainModel.append({
        "firstname": "Pablo",
        "lastname": "Doe",
        "cellphone": "6300000002",
        "email" : "jane-doe@example.com",
        "photo": "qrc:/konqi.jpg"
    });
    mainModel.append({
        "firstname": "Paul",
        "lastname": "Adams",
        "cellphone": "6300000003",
        "email" : "paul-adams@example.com",
        "photo": "qrc:/katie.jpg"
    });
    mainModel.append({
        "firstname": "John",
        "lastname": "Doe",
        "cellphone": "6300000001",
        "email" : "john-doe@example.com",
        "photo": "qrc:/konqi.jpg"
    });
    mainModel.append({
        "firstname": "Ken",
        "lastname": "Brown",
        "cellphone": "6300000004",
        "email" : "ken-brown@example.com",
        "photo": "qrc:/konqi.jpg"
    });
    mainModel.append({
        "firstname": "Al",
        "lastname": "Anderson",
        "cellphone": "6300000005",
        "email" : "al-anderson@example.com",
        "photo": "qrc:/katie.jpg"
    });
    mainModel.append({
        "firstname": "Kate",
        "lastname": "Adams",
        "cellphone": "6300000005",
        "email" : "kate-adams@example.com",
        "photo": "qrc:/konqi.jpg"
    });
}
```

{{< alert title="Note" color="info" >}}

Notice the `{}` that indicates we are appending a JavaScript object to our model.

{{< /alert >}}

The model part of our implementation is ready. Let's proceed to defining a delegate that will be responsible for displaying the data. So, we add the following code to the `main.qml` page, just after the [Component.onCompleted](docs:qtqml;QtQml.Component::completed) definition:

```qml
Component {
    id: card

    Kirigami.Card {

        height: view.cellHeight - Kirigami.Units.largeSpacing

        banner {
            title: model.firstname + " " + model.lastname
            titleIcon: "im-user"
        }

        contentItem: Column {
            id: content

            spacing: Kirigami.Units.smallSpacing

            Controls.Label {
                wrapMode: Text.WordWrap
                text: "Mobile: " + model.cellphone
            }

            Controls.Label {
                wrapMode: Text.WordWrap
                text: "Email: " + model.email
            }
        }
    }
}
```

Following the related information on the [Kirigami.Card API page](docs:kirigami2;Card), we populate a "[banner](docs:kirigami2;Card::banner)" that will act as a header to display the name of the contact as well as a contact icon.

The main content of the card has been populated with the cell phone number and the email of the contact, structured as a [Column](docs:qtquick;QtQuick.Column) of [Labels](docs:qtquickcontrols;QtQuick.Controls.Label).

The application should look like this:

![Simple grid of cards](implementation.png)

{{< alert color="info" title="Tip" >}}

You can find the full source code of the tutorial at [invent.kde.org](https://invent.kde.org/dkardarakos/kirigami-tutorial).

{{< /alert >}}

As a last step we will add some dummy functionality to each card. In particular, a `call` [Action](docs:kirigami2;Action) will be added.
Nevertheless, instead of a real call, a passive notification will be displayed. So, let's change the `card` component to the following:

{{< readfile file="/content/docs/use/kirigami/introduction-kirigami-gallery/main.qml" highlight="qml" start=69 lines=31 >}}

So, we added a [Kirigami.Action](docs:kirigami2;Action) that, as soon as it is triggered (by pressing the action button), displays a [passive notification](docs:kirigami2;AbstractApplicationWindow::showPassiveNotification).

## Result

Finally, our application should look like this:

{{< readfile file="/content/docs/use/kirigami/introduction-kirigami-gallery/main.qml" highlight="qml" >}}

![Grid with calling action triggered](implementation-actions.png)

   
