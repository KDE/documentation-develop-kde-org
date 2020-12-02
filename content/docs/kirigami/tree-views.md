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

```
import org.kde.kirigami.addons.treeview

TreeListView {

}
```
