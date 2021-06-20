---
title: Scrollable Pages and List Views
weight: 103
group: components
description: Scrollable pages are useful when combined with vertical components or dynamic components such as List Views.
---

## `Kirigami.ScrollablePage`

A [`Kirigami.ScrollablePage`](docs:kirigami2;ScrollablePage)
is a page that holds scrollable content, such as `ListView`s. Scrolling and scrolling indicators are
automatically managed.

```qml
Kirigami.ScrollablePage {
    id: root
    //The rectangle will automatically be scrollable
    Rectangle {
        width: root.width
        height: 99999
    }
}
```

In almost every other way, a scrollable page is the same as a normal page.

{{< alert color="danger" title="Warning" >}}

Do not put a `ScrollView` inside of a `Kirigami.ScrollablePage`; children of a
`Kirigami.ScrollablePage` are already inside a `ScrollView`.

{{< /alert >}}

## ListView in a ScrollablePage

When a `Kirigami.ScrollablePage`'s direct children extend vertically beyond the size of the
page itself, a scrollbar appears at the right edge of the page and the page
will be scrollable.

{{< figure src="neochatscrollablepage.png" alt="NeoChat Scrollable Page Screenshot"
    caption="Two scrollable pages, both containing a ListView with custom contents (Screenshot of NeoChat)" >}}

Often you have more than one child in your `Kirigami.ScrollablePage`, and positioning items
can be tricky - especially in combination with a `ListView`.

* For non-visual components, having them inside the `ListView` element won't change
  the visuals of the page. So we can move them inside the `ListView`. Same for 
  elements anchored to the center of the page, such as placeholder messages for
  empty `ListView`s. 
* For other items, it might make sense to move them to the header or footer
  of the `Kirigami.ScrollablePage`. This is often the case for search bars.

### PlaceholderMessage

It is possible to add a [`Kirigami.PlaceholderMessage`](docs:kirigami2;PlaceholderMessage)
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

A search field is often added to a `Kirigami.ScrollablePage` to filter the `ListView`.
This can be done by changing the default `titleDelegate` to use a 
[`Kirigami.SearchField`](docs:kirigami2;SearchField) instead.

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
filtering capability directly in QML without any need for C++ code.

{{< /alert >}}

### Pull to refresh

Another function provided by this component is a "pull to refresh" action.
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

By pulling down, you can also activate a special mode with a larger top margin which
makes single-handed use of the application easier.
