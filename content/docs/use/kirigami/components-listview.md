---
title: List views
weight: 212
group: "components"
description: >
  A list view can help you easily display many components dynamically.
aliases:
  - /docs/kirigami/components-listview/
---

[Listviews](docs:qtquick;QtQuick.ListView) can help you display objects from a model in an attractive way. To use a list view, you have to keep track of three things:

1. The **model**, which contains the data you want your list view to display
2. The **delegate**, which defines how each element in the model will be displayed
3. The **list view** itself, which will display information from the model according to the delegate

If you would like further clarification, the Qt documentation has [an informative page](https://doc.qt.io/qt-5/qtquick-modelviewsdata-modelview.html) on the topic.

## Creating a basic listview

A list view has two essential properties we must pay attention to:

- [model](https://doc.qt.io/qt-6/qml-qtquick-listview.html#model-prop), which accepts the data or the `id` of the object that holds the data
- [delegate](https://doc.qt.io/qt-6/qml-qtquick-listview.html#delegate-prop), which accepts the component we will use to display the data in the model

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami

Kirigami.Page {

    ListView {
        id: myList

        // Providing a number for the model property
        // will generate that number of data entries
        // starting from 0.
        model: 200

        delegate: Kirigami.BasicListItem {
            label: "Item " + modelData
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

![A simple listview](/docs/use/kirigami/components-listview/listview-simple.png)

{{< /section-right >}}

{{< /sections >}}

In cases where your model data only contain a single piece of data, like in the example above, you can just grab the data in the model by referencing [modelData](https://doc.qt.io/qt-6/qtquick-modelviewsdata-modelview.html#models).

A note on delegates: if your model contains objects with data in named properties, the name of these properties will be automatically exposed to your delegate and you will only need to use these names in your delegate.

```qml
ListModel {
    id: myModel
    ListElement { type: "Item"; number: 0 }
    ListElement { type: "Item"; number: 1 }
    ListElement { type: "Item"; number: 2 }
    ListElement { type: "Item"; number: 3 }
}

ListView {
    id: myList

    model: myModel

    delegate: Kirigami.BasicListItem {
        label: type + " " + number
    }
}
```

Kirigami offers a number of components that have been designed specifically for use in list views, such as [Kirigami.BasicListItem](docs:kirigami2;BasicListItem), [Kirigami.CheckableListItem](docs:kirigami2;CheckableListItem) and [Kirigami.SwipeListItem](docs:kirigami2;SwipeListItem), all of which build upon [Kirigami.AbstractListItem](docs:kirigami2;AbstractListItem). There are also [Kirigami.CheckDelegate](docs:kirigami2;CheckDelegate), [Kirigami.RadioDelegate](docs:kirigami2;RadioDelegate), and [Kirigami.SwitchDelegate](docs:kirigami2;SwitchDelegate), which are designed to take advantage of those specific controls.

However, you are not limited to using these components and you can choose whichever ones you wish. This may require some tweaking of your layout.

## Placeholder messages

In some cases, you might want to use a list view that is empty until the user does something. In these situations, using a [Kirigami.PlaceholderMessage](docs:kirigami2;PlaceholderMessage) can be an attractive way of telling your user that the list is empty and that they can do something about it.

You will generally want to place a placeholder message in the center of the ListView and you will likely not want it to span the entire width of the ListView. You will obviously also want it to be hidden once the ListView's model becomes populated with data. Thankfully, ListViews have a property named [count](https://doc.qt.io/qt-6/qml-qtquick-listview.html#count-prop) that makes doing this quite easy.

You might also want to add a helpful action to your placeholder message. This can be done by attaching an action to the [PlaceholderMessage.helpfulAction](docs:kirigami2;PlaceholderMessage::helpfulAction) property.

{{< sections >}}

{{< section-left >}}

```qml
ListView {
    id: myList

    model: ListModel { id: myModel }

    delegate: Kirigami.BasicListItem {
        label: text
    }

    Kirigami.PlaceholderMessage {
        anchors.centerIn: parent
        width: parent.width - (Kirigami.Units.largeSpacing * 4)
        visible: myList.count === 0
        text: "Add something to me!"

        helpfulAction: Kirigami.Action {
        icon.name: "list-add"
        text: "Add"
        onTriggered: myModel.append({"text": "Hello!!"})
        }
    }
}

```

{{< /section-left >}}

{{< section-right >}}

![An empty list view which displays a placeholder message in the middle of the application together with an action to add new data to the model](/docs/use/kirigami/components-listview/listview-placeholdermessage.png)

{{< /section-right >}}

{{< /sections >}}
