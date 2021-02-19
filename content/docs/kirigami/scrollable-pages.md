---
title: Scrollable Pages
weight: 104
group: components
description: Scrollable page are special Kirigami Pages that can contains scrollable content.
---

## `Kirigami.ScrollablePage`

A [ScrollablePage](docs:kirigami2;ScrollablePage)
is a Page that holds scrollable content, such as ListViews. Scrolling and scrolling indicators will
be automatically managed.

```qml
ScrollablePage {
    id: root
    //The rectangle will automatically be scrollable
    Rectangle {
        width: root.width
        height: 99999
    }
}
```

{{< alert color="danger" title="Warning" >}}
Do not put a ScrollView inside of a ScrollablePage; children of a
ScrollablePage are already inside a ScrollView.
{{< /alert >}}

## ListView in ScrollPage

If a ScrollablePage contains a single direct child item and this child item
is a ListView when the ListView covers the entire page and adds a scrollbar
to the right.

{{< figure src="neochatscrollablepage.png" alt="NeoChat Scrollable Page Screenshot"
    caption="Two scrollable pages containing both a ListView with custom contents (Screenshot of NeoChat)" >}}

Often you have more than one child in your ScrollablePage, there are two
ways to fix this.

* For non-visual objects having them inside the ListView element won't change
  the visual of the page. So we can move them inside the ListView. Same for 
  elements anchored to the center of the page.
* For other items, it might make sense to move them to the header or footer
  of the ScrollablePage. This is often the case for search bars.

### PlaceholderMessage

It is possible to add a [Placeholder Message](docs:kirigami2;PlaceholderMessage)
with some instructions in case the list view is empty. 

```qml
Kirigami.ScrollablePage {
    ListView {
        id: listView
        Kirigami.PlaceholderMessage {
            anchors.centerIn: parent
            width: parent.width - (Kirigami.Units.largeSpacing * 4)
            visible: listView.count === 0
            text: i18n("No data found")
            helpfulAction: Kirigami.Action {
	        text: i18n("Load data")
                ...
            }
        }
        model: ...
    }
}
```

### Search in the ListView

A search field is often added to a ScrollablePage to filter the ListView.
This can be done by changing the default `titleDelegate` to use a 
[Kirigami.SearchField](docs:kirigami2;SearchField) instead.

```qml
Kirigami.ScrollablePage {
    titleDelegate: Kirigami.SearchField {
        Layout.topMargin: Kirigami.Units.smallSpacing
        Layout.bottomMargin: Kirigami.Units.smallSpacing
        Layout.fillHeight: true
        Layout.fillWidth: true
        onTextChanged: mySortFilterModel.filterText = text
        KeyNavigation.tab: listView
    }

    ListView {
        id: listView
        ...
    }
}
```

{{< alert title="Hint" color="info" >}}
You can use [KSortFilterProxyModel](docs:kitemmodels;SortFilterModel) from
[KItemModel](https://api.kde.org/frameworks/kitemmodels/html/) to easily add
filtering capability directly in QML without any need for C++.
{{< /alert >}}

### Pull to refresh

Another behavior added by this class is a "pull to refresh" behavior.
To use this, activate it as follows:


```qml
Kirigami.ScrollablePage {
    id: view
    supportsRefreshing: true
    onRefreshingChanged: {
        if (refreshing) {
            myModel.refresh();
        }
    }
    ListView {
        // NOTE: MyModel doesn't come from the components,
        // it's purely an example on how it can be used together
        // some application logic that can update the list model
        // and signals when it's done.
        model: MyModel {
            onRefreshDone: view.refreshing = false;
        }
        delegate: BasicListItem {}
    }
}
```

By pulling down, you can also activate a special mode with a larger top margin
making single-handed usage of the application easier.
