---
title: Tree Views
group: components
weight: 103
description: >
  Tree views are an effitient way to display hierachical data to the users.
---

A tree view component is compossed of two parts:

* A proxy mode in [KItemModels](https://api.kde.org/frameworks/kitemmodels/html/classKDescendantsProxyModel.html),
  that transforms the tree model in a list model with some additional roles.
* And a QML component in [Kirigami Addons](https://invent.kde.org/libraries/kirigami-addons/),
  a library containing additional QML components that are not part
  of Kirigami because they require additional dependencies.

The QML component provides the visual implementation and can be easily switched
with your own visual representation, so that it follows your application style.

The library also provides two delegates:

* `AbstractTreeItem`: This element inherit from a
   [Kirigami.AbstractListItem](docs:kirigami2;AbstractListItem) and allow the API user
   to define a custom `contentItem`.
* `BasicTreeItem`: This item inherit from the `AbstractTreeItem` and is the tree item
   equivalent to the [Kirigami.BasicListItem](docs:kirigami2;BasicListItem) and provide
   a consistent look for list item with an `icon` (optional), `label` and `subtitle`
   (optional) property.

Using the TreeListView is simple since internally the tree view is just a list
view.

```qml
import QtQuick 2.2
import QtQuick.Controls 2.14
import org.kde.filesystembrowser 1.0
import org.kde.kirigami 2.14 as Kirigami
import org.kde.kirigamiaddons.treeview 1.0

ScrollView {
    TreeListView {
        clip: true
        // FileSystemModel here is an instanciation of a QFileSystemModel
        model: FileSystemModel {}
        expandsByDefault: false
        delegate: BasicTreeItem {
            label: display
        }
    }
}
```

```qml

ScrollView {
    property int itemHeight: Kirigami.Units.gridUnit + Kirigami.Units.smallSpacing * 2
    SplitView.preferredWidth: 600
    TreeTableView {
        clip: true
        // HACK: QQC2 table view doesn't set a reasonable contentHeight by default
        contentHeight : root.rowHeight * rows
        model: FileSystemModel { }
        expandsByDefault: false
        rowHeightProvider: (index) => itemHeight
        columnWidthProvider: function (column) { return column === 0 ? 220 : 120 }
        delegate: DelegateChooser {
            DelegateChoice {
                column: 0
                BasicTreeItem {
                    label: display
                }
            }
            DelegateChoice {
                Label {
                    text: display
                }
            }
        }
    }
}
