---
title: Using separate files and signals
group: introduction
weight: 6
description: >
  Separating unwieldy code into different files, and attach signals to your components.
aliases:
  - /docs/getting-started/kirigami/introduction-separatefiles/
---

## But why?

For the first time, we will be separating some of our components into their own QML files. If we keep adding things to `main.qml`, it's going to quickly become hard to tell what does what, and we risk muddying our code.

First we need to add our new files into our `resources.qrc` which we created in the first part of this tutorial.

```qrc
<RCC>
    <qresource prefix="/">
        <file alias="main.qml">contents/ui/main.qml</file>
        <file alias="AddEditSheet.qml">contents/ui/AddEditSheet.qml</file>
        <file alias="KountdownDelegate.qml">contents/ui/KountdownDelegate.qml</file>
    </qresource>
</RCC>
```

## Using our new files

We'll need to find some way of using our new files in `main.qml`. Thankfully, all we need to do is include a declaration of these components in our `main.qml` like this:

```qml
AddEditSheet {
    id: addEditSheet
}
```

## Extending our add sheet into an add/edit sheet

While in the last tutorial we made our countdown-adding button do something, the edit button on our countdown cards is still inactive. We also created an adding sheet that we could now repurpose to also serve as an edit sheet... but before we get to that, we need to add a couple of extra things to our `main.qml`.

### main.qml

{{< readfile file="/content/docs/getting-started/kirigami/introduction-separatefiles/main.qml" highlight="qml" >}}

The key changes we have made involve the addition of our component definition `AddEditSheet` (and `KountdownDelegate` further down) and a new function called `openPopulatedSheet()`.

Lets go through our `AddEditSheet` definition:

```qml
AddEditSheet { 
    id: addEditSheet
    onEdited: kountdownModel.set(index, {
        name,
        description,
        date,
    });
    onAdded: kountdownModel.append({
        name,
        description,
        date,
    });
}
```

`onAdded` and `onEdited` are signal handlers. Just like `onTriggered` is called when we click an action, we can use handlers that respond to our custom signals.

### AddEditSheet.qml

Looking at our new `AddEditSheet.qml`—our repurposed adding sheet—we can see how these signals work:

{{< readfile file="/content/docs/getting-started/kirigami/introduction-separatefiles/AddEditSheet.qml" highlight="qml" >}}

Signals invoke their handlers when they are called. In this case, we have created two signals, `added` and `edited`, that we can invoke with different outcomes, and to which we can attach information about the countdown we are adding or creating. A neat thing about signals is that they expose the variables defined in them to the functions that are listening to them, which is why we can just call those variable names in our `onEdited` and `onAdded` handlers in `main.qml`. Our signals are invoked by the "Done" button depending on what the `mode` property, defined at the top of our AddEditSheet, is set to.

The `mode` property also controls several other things: mainly what the title of our sheet is set to, and what text is to be included in our textfields. However, by default, our `mode` property is just set to add...

Which brings us back to `main.qml` and our new `openPopulatedSheet()` function. You might have noticed that this is what it is called now when the countdown-adding action is triggered. This function takes in several arguments which have been provided with defaults. This is helpful when we simply want to add a new countdown, because we can have the concise function call `openPopulatedSheet("add")`. More importantly, this function sets all the relevant properties in AddEditSheet.

```qml
function openPopulatedSheet(mode, index = -1, listName = "", listDesc = "", listDate = "") {
    addEditSheet.mode = mode
    addEditSheet.index = index;
    addEditSheet.name = listName
    addEditSheet.description = listDesc
    addEditSheet.kdate = listDate

    addEditSheet.open()
}
```

- `mode` changes the add/edit sheet depending on whether this argument is set to `"add"` or to `"edit"`
- `index` is needed so that when we save our edited countdown, the correct one is modified
- `listName`, `listDesc`, and `listDate` are the relevant countdown details that need to be put in the sheet's fields

Of course, to actually use our sheet for anything besides adding countdowns first we need to make the edit button on our cards work. But if you look at our [Kirigami.CardsListView](docs:kirigami2;CardsListView) in `main.qml`...

```qml
Kirigami.CardsListView {
    id: layout
    model: kountdownModel
    delegate: KountdownDelegate {}
}
```

### KountdownDelegate.qml

We've replaced our [Kirigami.AbstractCard](docs:kirigami2;AbstractCard) with a delegate component definition from `KountdownDelegate.qml`.

{{< readfile file="/content/docs/getting-started/kirigami/introduction-separatefiles/KountdownDelegate.qml" highlight="qml" >}}

The [onClicked](docs:qtquickcontrols;QtQuick.Controls.AbstractButton::clicked) property of the "Edit" button on our cards now calls the `openPopulatedSheet()` function, with the card's fetched list element properties set as the arguments for this function. With these, the sheet can be populated with the correct text.

With that, we have a fully-functional sheet where we can add and edit our countdowns!

![](editsheet.png)





