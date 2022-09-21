---
title: List views
weight: 112
group: "components"
description: >
  A list view can help you easily display many components dynamically.
aliases:
  - /docs/kirigami/components-listview/
---

Listviews can help you display objects from a model in an attractive way. To use a list view, you have to keep track of three things:

1. The **model**, which contains the data you want your list view to display
2. The **delegate**, which defines how each element in the model will be displayed
3. The **list view** itself, which will display information from the model according to the delegate

If you would like further clarification, the Qt documentation has [an informative page](https://doc.qt.io/qt-5/qtquick-modelviewsdata-modelview.html) on the topic.

## Creating a basic listview

A list view has two essential properties we must pay attention to:

- `model`, which accepts the data or the `id` of the object that holds the data  
- `delegate`, which accepts the component we will use to display the data in the model

{{< sections >}}
{{< section-left >}}

```qml
import QtQuick 2.6
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami

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

In cases where your model data only contain a single piece of data, like in the example above, you can just grab the data in the model by referencing `modelData`. 

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

Kirigami offers a number of components that have been designed specifically for use in list views, such as `Kirigami.BasicListItem`, `Kirigami.CheckableListItem` and `Kirigami.SwipeListItem`, all of which build upon `Kirigami.AbstractListItem`. There are also `Kirigami.CheckDelegate`, `Kirigami.RadioDelegate`, and `Kirigami.SwitchDelegate`, which are designed to take advantage of those specific controls.

However, you are not limited to using these components and can choose whichever ones you wish - though this may mean some tweaking to your layout.

## Placeholder messages

In some cases, you might want to use a list view that is empty until the user does something. In these situations, using a `Kirigami.PlaceholderMessage` can be an attractive way of telling your user that the list is empty and that they can do something about it.

You will generally want to place a PlaceholderMessage in the center of the ListView and you will want it to not span the entire width of the ListView either. You will obviously also want it to not be visible once the ListView's model becomes populated with data: thankfully, ListViews have a property named `count` that makes doing this quite easy.

You might also want to add a helpful action to your placeholder message. This can be done by attaching an action to the `Kirigami.PlaceHolderMessage`'s `helpfulAction` property.

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

![A list view with a placeholder message](/docs/use/kirigami/components-listview/listview-placeholdermessage.png)

{{< /section-right >}}
{{< /sections >}}

## List headers

ListViews also support header components with the `header` property, and Kirigami provides an attractive component for this purpose: `Kirigami.ItemViewHeader`. We provide this component with text for the `title` property and with an image location for the `backgroundImage.source` property and we are set.

An interesting property of the list view is `headerPositioning`. This affects the way that our header will move when we are interacting with a long list view that expands beyond the height of the page. `headerPositioning` can be set to three different settings:

- `ListView.OverlayHeader`: In this setting, the header will contract once we start scrolling down but will remain visible in a more compact state.
- `ListView.PullBackHeader`: The header will disappear as we scroll down, but will reappear as we scroll back up, even if we haven't yet reached the top of the list view.
- `ListView.InlineHeader`: The header will act like a part of the listview and remain at the top of the listview.

{{< sections >}}
{{< section-left >}}

```qml
ListView {
  id: myList

  headerPositioning: ListView.OverlayHeader
  header: Kirigami.ItemViewHeader {
  backgroundImage.source: "../banner.jpg"
    title: "LongListView"
  }

  model: 200

  delegate: Kirigami.BasicListItem {
    label: "Item " + modelData
  }
}
```

{{< /section-left >}}
{{< section-right >}}

![A listview with a header](/docs/use/kirigami/components-listview/listview-header.png)

{{< /section-right >}}
{{< /sections >}}
