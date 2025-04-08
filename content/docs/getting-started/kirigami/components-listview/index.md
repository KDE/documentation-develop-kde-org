---
title: List views
weight: 43
group: "components"
description: >
  A list view can help you easily display many components dynamically.
aliases:
  - /docs/getting-started/kirigami/components-listview/
---

{{< kirigami-staging-api >}}

[Listviews](docs:qtquick;QtQuick.ListView) can help you display objects from a model in an attractive way. To use a list view, you have to keep track of three things:

1. The **model**, which contains the data you want your list view to display
2. The **delegate**, which defines how each element in the model will be displayed
3. The **list view** itself, which will display information from the model according to the delegate

If you would like further clarification, the Qt documentation has [an informative page](https://doc.qt.io/qt-6/qtquick-modelviewsdata-modelview.html) on the topic.

## Essentials of models and views

A list view has two essential properties we must pay attention to:

- [model](https://doc.qt.io/qt-6/qml-qtquick-listview.html#model-prop), which accepts the data or the `id` of the object that holds the data
- [delegate](https://doc.qt.io/qt-6/qml-qtquick-listview.html#delegate-prop), which accepts the component we will use to display the data in the model

The model is not visible, as it only contains data. Typically the delegate will be wrapped in a Component so that it is reusable: it serves as a blueprint for how to instantiate each delegate.

Here is an example that contains exactly one list view, one model and one delegate, using a [Kirigami.SubtitleDelegate](docs:kirigami2;SubtitleDelegate):

```qml
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "List of Plasma products"
    width: 600
    height: 400
    pageStack.initialPage: Kirigami.ScrollablePage {
        ListView {
            anchors.fill: parent
            model: plasmaProductsModel
            delegate: listDelegate
        }
        ListModel {
            id: plasmaProductsModel
            ListElement { product: "Plasma Desktop"; target: "desktop" }
            ListElement { product: "Plasma Mobile";  target: "mobile" }
            ListElement { product: "Plasma Bigscreen"; target: "TVs" }
        }
        Component {
            id: listDelegate
            Controls.ItemDelegate {
                width: ListView.view.width
                text: `${model.product} is KDE software developed for ${model.target} stored at index ${model.index} of this list`
            }
        }
    }
}
```

And the exact same example, inline:

```qml
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "List of Plasma products (inline)"
    width: 600
    height: 400
    pageStack.initialPage: Kirigami.ScrollablePage {
        ListView {
            anchors.fill: parent
            model: ListModel {
                id: plasmaProductsModel
                ListElement { product: "Plasma Desktop"; target: "desktop" }
                ListElement { product: "Plasma Mobile";  target: "mobile" }
                ListElement { product: "Plasma Bigscreen"; target: "TVs" }
            }
            delegate: Controls.ItemDelegate {
                width: ListView.view.width
                text: `${model.product} is KDE software developed for ${model.target} stored at index ${model.index} of this list`
            }
        }
    }
}
```


### Understanding models

The model contains the data that will be used to populate the list view. Different ways to use models have different ways to access the data:

| WAY TO USE                        | HOW TO ACCESS                                     | WHEN TO USE                     |
| --------------------------------- | ------------------------------------------------- | ------------------------------- |
| Qt models with more than one role | model.index, model.somerole                       | In most cases                   |
| Qt models with one role           | model.index, model.somerole, model.modelData      | In most cases, for prototyping  |
| JavaScript array model            | model.index, model.modelData                      | For prototyping                 |
| Integer model                     | model.index, model.modelData                      | For prototyping |

You can read about [other ways to use models in the Qt documentation](https://doc.qt.io/qt-6/qtquick-modelviewsdata-modelview.html).

In the table above, "Qt models" refers to both C++-specific models like [QAbstractListModel](https://doc.qt.io/qt-6/qabstractlistmodel.html) and QML-specific models like ListModel. This tutorial page will only focus on QML-specific models. Farther ahead we provide a tutorial for [Connecting C++ models to QML using QAbstractListModel](/docs/getting-started/kirigami/advanced-connect_models).

The `model.index` property is made available to every model and contains the index (the position) of each delegate. It can be shortened to `index` for convenience.

The `model.somerole` property mentioned above is just a placeholder, it is not a specific property that comes from QML: `somerole` can be any role that is defined by the model. In the first code example of this page shown above the table, the `plasmaProductsModel` model has the `product` and `target` roles, which can be accessed with `model.product` and `model.target`, respectively.

Just as `model.index` can be shortened to `index`, each `model.somerole` property can be shorted to just `somerole` (like `product`) for convenience, but it is recommended that they be turned into required properties:

```qml
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "List of Plasma products (shortened with required properties)"
    width: 600
    height: 400
    pageStack.initialPage: Kirigami.ScrollablePage {
        ListView {
            anchors.fill: parent
            model: plasmaProductsModel
            delegate: listDelegate
        }
        ListModel {
            id: plasmaProductsModel
            ListElement { product: "Plasma Desktop"; target: "desktop" }
            ListElement { product: "Plasma Mobile";  target: "mobile" }
            ListElement { product: "Plasma Bigscreen"; target: "TVs" }
        }
        Component {
            id: listDelegate
            Controls.ItemDelegate {
                width: ListView.view.width
                required property string product
                required property string target
                required property int index
                text: `${product} is KDE software developed for ${target} stored at index ${index} of this list`
            }
        }
    }
}
```

Additionally, if the model contains only one role or has no role at all, its data can also be accessed with the property `model.modelData`, which can also be shortened to `modelData` (and as such would also need to be a required property):

```qml
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami


Kirigami.ApplicationWindow {
    title: "List of KDE software"
    width: 400
    height: 400
    pageStack.initialPage: Kirigami.ScrollablePage {
        ListView {
            anchors.fill: parent
            model: kdeSoftwareModel
            delegate: listDelegate
        }
        ListModel {
            id: kdeSoftwareModel
            ListElement { software: "Dolphin" }
            ListElement { software: "Discover" }
            ListElement { software: "KHelpCenter" }
            ListElement { software: "KCalc" }
            ListElement { software: "Ark" }
        }
        Component {
            id: listDelegate
            Controls.ItemDelegate {
                width: ListView.view.width
                required property string modelData
                text: modelData // This matches model.software
            }
        }
    }
}
```

For comparison, here is how the above code would look like with a [JavaScript array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array), with no role:

```qml
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "List of KDE software (as JS array)"
    width: 400
    height: 400
    pageStack.initialPage: Kirigami.ScrollablePage {
        ListView {
            anchors.fill: parent
            model: ["Dolphin", "Discover", "KHelpCenter", "KCalc", "Ark"]
            delegate: listDelegate
        }
        Component {
            id: listDelegate
            Controls.ItemDelegate {
                width: ListView.view.width
                required property string modelData
                text: modelData
            }
        }
    }
}
```

Using an integer for the model can be useful for very specific cases, namely prototyping and tests:

```qml
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Simple list of indexes"
    width: 400
    height: 400
    pageStack.initialPage: Kirigami.ScrollablePage {
        ListView {
            anchors.fill: parent
            model: 30
            delegate: listDelegate
        }
        Component {
            id: listDelegate
            Controls.ItemDelegate {
                width: ListView.view.width
                required property string modelData
                text: `This delegate's index is: ${modelData}`
            }
        }
    }
}
```

### Understanding views and delegates

Let's go back to the original example:

```qml
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "List of Plasma products"
    width: 600
    height: 400
    pageStack.initialPage: Kirigami.ScrollablePage {
        ListView {
            // anchors.fill: parent
            model: plasmaProductsModel
            delegate: listDelegate
        }
        ListModel {
            id: plasmaProductsModel
            ListElement { product: "Plasma Desktop"; target: "desktop" }
            ListElement { product: "Plasma Mobile";  target: "mobile" }
            ListElement { product: "Plasma Bigscreen"; target: "TVs" }
        }
        Component {
            id: listDelegate
            Controls.ItemDelegate {
                width: ListView.view.width
                text: `${model.product} is KDE software developed for ${model.target} stored at index ${model.index} of this list`
            }
        }
    }
}
```

Unlike the model (which merely contains data) and a delegate [Component](docs:qtqml;QtQml.Component) (which only appears when instantiated), the view is a visual component immediately instantiated and so it needs to either have its dimensions set or use anchors or Layouts.

As views are commonly lists of content the user would want to scroll through, when they are added to a [Kirigami.ScrollablePage](docs:kirigami2;ScrollablePage), views become the main content with little padding around them, and there is no need to make it fill the page. When the view is added to a simple [Kirigami.Page](docs:kirigami2;Page), it will require to set its dimensions properly before it will show up. In other words: in the scrollable page above, `anchors.fill: parent` is not required; if a simple page was used, it would be required.

There are multiple views APIs can be used, some from Qt and some from Kirigami. Here are the most commonly used ones:

* Qt's [ListView](docs:qtquick;QtQuick.ListView)
* Qt's [GridView](docs:qtquick;QtQuick.GridView)
* Qt's [TableView](docs:qtquick;QtQuick.TableView)
* Qt's [TreeView](docs:qtquick;QtQuick.TreeView)
* Kirigami's [CardsListView](docs:kirigami2;CardsListView)
* Kirigami's [ColumnView](docs:kirigami2;ColumnView)

The delegate on the other hand always need to have its dimensions set. Generally its dimensions are set to use only the full width of the view.

{{< alert title="Common mistakes" color="warning">}}

The above means that delegates should not have bottom anchors, since the delegate doesn't need to have the same height as the view. In other words, you will probably never want to use `anchors.fill: parent`.

Additionally, while it is possible to set its dimensions using the parent and anchors, which is usually the view's contentItem, like so:

```qml
Controls.ItemDelegate {
    anchors.left: parent.left
    anchors.right: parent.right
    text: // ...
}
```

It is not guaranteed that the delegate's parent will be a view, and so it should be avoided. Instead, use the [ListView.view](https://doc.qt.io/qt-6/qml-qtquick-listview.html#view-attached-prop) attached property to point to the delegate's parent view:

```qml
Controls.ItemDelegate {
    width: ListView.view.width
    text: // ...
}
```

{{< /alert >}}

The most common use of a delegate is within a [Component](docs:qtqml;QtQml.Component), which does not instantiate the delegate immediately. When a view is constructed, the delegate is then used as a blueprint to make each item in the view.

While you can make your own custom components to be used as delegates without delegate-specific Qt APIs (for example, a Layout containing a few Items), QtQuick Controls does provide delegate APIs that are simpler to use:

* [ItemDelegate](docs:qtquickcontrols;QtQuick.Controls.ItemDelegate) (delegates with only text)
* [CheckDelegate](docs:qtquickcontrols;QtQuick.Controls.CheckDelegate) (delegates with a checkbox)
* [RadioDelegate](docs:qtquickcontrols;QtQuick.Controls.RadioDelegate) (delegates with a radio)
* [SwitchDelegate](docs:qtquickcontrols;QtQuick.Controls.SwitchDelegate) (delegates with a switch)
* [SwipeDelegate](docs:qtquickcontrols;QtQuick.Controls.SwipeDelegate) (delegates that can be swiped)

You should prefer using the upstream Qt delegates where possible.

On top of these Qt delegates, Kirigami provides its own equivalents, with the added functionality of subtitles and icons:

* [TitleSubtitle](docs:kirigami2;TitleSubtitle)
* [IconTitleSubtitle](docs:kirigami2;IconTitleSubtitle)
* [SubtitleDelegate](docs:kirigami2;SubtitleDelegate)
* [CheckSubtitleDelegate](docs:kirigami2;CheckSubtitleDelegate)
* [RadioSubtitleDelegate](docs:kirigami2;RadioSubtitleDelegate)
* [SwitchSubtitleDelegate](docs:kirigami2;SwitchSubtitleDelegate)

The API ending with "Delegate" can be set as a direct delegate of the view, just like the previous examples that used Controls.ItemDelegate:

```qml
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import org.kde.kirigami.delegates as KD

Kirigami.ApplicationWindow {
    title: "List of Plasma products"
    width: 600
    height: 400
    pageStack.initialPage: Kirigami.ScrollablePage {
        ListView {
            model: plasmaProductsModel
            delegate: listDelegate
        }
        ListModel {
            id: plasmaProductsModel
            ListElement { product: "Plasma Desktop"; target: "desktop" }
            ListElement { product: "Plasma Mobile";  target: "mobile" }
            ListElement { product: "Plasma Bigscreen"; target: "TVs" }
        }
        Component {
            id: listDelegate
            KD.CheckSubtitleDelegate {
                width: ListView.view.width
                text: `${model.product} is KDE software developed for ${model.target}.`
                subtitle: `This delegate is stored at index ${model.index} of this list`
                icon.name: "kde"
            }
        }
    }
}
```

Both TitleSubtitle and IconTitleSubtitle are expected to be used to override a Qt delegate's contentItem, for example:

```qml
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import org.kde.kirigami.delegates as KD

Kirigami.ApplicationWindow {
    title: "List of Plasma products"
    width: 600
    height: 400
    pageStack.initialPage: Kirigami.ScrollablePage {
        ListView {
            // anchors.fill: parent
            model: plasmaProductsModel
            delegate: listDelegate
        }
        ListModel {
            id: plasmaProductsModel
            ListElement { product: "Plasma Desktop"; target: "desktop" }
            ListElement { product: "Plasma Mobile";  target: "mobile" }
            ListElement { product: "Plasma Bigscreen"; target: "TVs" }
        }
        Component {
            id: listDelegate
            Controls.ItemDelegate {
                width: ListView.view.width
                text: `${model.product} is KDE software developed for ${model.target}.`
                contentItem: KD.IconTitleSubtitle {
                    title: parent.text
                    subtitle: `This delegate is stored at index ${model.index} of this list`
                    icon.name: "kde"
                }
            }
        }
    }
}
```

A practical example of using Kirigami delegates can be seen in the [ListItemTest file in the Kirigami Repository](https://invent.kde.org/frameworks/kirigami/-/blob/master/tests/ListItemTest.qml).
