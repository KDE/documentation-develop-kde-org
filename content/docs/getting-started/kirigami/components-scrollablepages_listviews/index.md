---
title: Scrollable pages and list views
weight: 203
group: components
description: Scrollable pages are useful when combined with vertical components or dynamic components such as List Views.
aliases:
  - /docs/getting-started/kirigami/components-scrollablepages_listviews/
---

{{< alert title="About Kirigami API documentation: use https://api-staging.kde.org/kirigami-index.html for now" color="warning" >}}

<details>
<summary>Click here to read more</summary></br>

We are aware of issues involving broken links to Kirigami API documentation. We are currently working on a better website to address these issues, porting the API docs where possible.

In its current state, the staging API website under development for Kirigami can be used to access all relevant Kirigami API pages, and it should already work better than the previous API website. You can access the staging API website through https://api-staging.kde.org/kirigami-index.html.

If you'd like to assist us in our efforts to port the API documentation, take a look at our [Port API documentation to QDoc](https://invent.kde.org/teams/goals/streamlined-application-development-experience/-/issues/10) metatask.

</details>

{{< /alert >}}

## Kirigami.ScrollablePage

A [Kirigami.ScrollablePage](docs:kirigami2;ScrollablePage)
is a page that holds scrollable content, such as a [ListView](docs:qtquick;QtQuick.ListView). Scrolling, as well as scrolling indicators, are automatically managed.

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

{{< alert color="warning" title="Warning" >}}

Do not put a [ScrollView](docs:qtquickcontrols;QtQuick.Controls.ScrollView) inside of a [Kirigami.ScrollablePage](docs:kirigami2;ScrollablePage); children of a
`Kirigami.ScrollablePage` are already inside a `ScrollView`.

{{< /alert >}}

## ListView in a ScrollablePage

When the direct children of a [Kirigami.ScrollablePage](docs:kirigami2;ScrollablePage) extend vertically beyond the size of the
page itself, a scrollbar appears at the right edge of the page and the page
will be scrollable.

{{< figure src="neochatscrollablepage.webp" caption="Two scrollable pages, both containing a ListView with custom contents (screenshot of NeoChat)" >}}

Often you have more than one child in your [Kirigami.ScrollablePage](docs:kirigami2;ScrollablePage), and positioning items
can be tricky—especially in combination with a [ListView](docs:qtquick;QtQuick.ListView).

* For non-visual components, having them inside the [ListView](docs:qtquick;QtQuick.ListView) component won't change
  the visuals of the page, so we can move them inside the scope of the list view. Same for
  elements anchored to the center of the page, such as placeholder messages for empty list views.
* For other items, it might make sense to move them to the header or footer
  of the [Kirigami.ScrollablePage](docs:kirigami2;ScrollablePage). This is often the case for search bars.

### PlaceholderMessage

It is possible to add a [Kirigami.PlaceholderMessage](docs:kirigami2;PlaceholderMessage)
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
                // More code...
            }
        }
        model: // Model code...
    }
}
```

### Search in the ListView

A search field is often added to a [Kirigami.ScrollablePage](docs:kirigami2;ScrollablePage) to filter the [ListView](docs:qtquick;QtQuick.ListView).
This can be done by changing the default [titleDelegate](docs:kirigami2;Page::titleDelegate) to use a
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
        // Rest of listview code...
    }
}
```

{{< alert title="Hint" color="info" >}}

You can use [KSortFilterProxyModel](docs:kitemmodels;SortFilterModel) from
[KItemModel](docs:kitemmodels) to easily add
filtering capability directly in QML without any need for C++ code.

{{< /alert >}}

### Pull to refresh

Another function provided by this component is a "pull-to-refresh" action.
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
        // it's purely an example on how it can be used together with
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
