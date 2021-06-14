---
title: Layouts, ListViews, and Cards
weight: 3
group: introduction
description: Figuring out the different ways of placing things on a page
---
# Laying out your content

Now that we understand how pages work, it is time to add stuff to ours. We will be going through a number of important layout components and elements that will be useful when designing our app. 

Don't be scared by the big chunks of code! We'll be going over everything that we haven't covered before, and by the end of this section you'll have a neat-looking app.

## ListViews

If you've ever used Discover, NeoChat, or Plasma's System Settings, you will have come across a ListView. Quite simply, ListViews let you display data on a list.

```qml
Kirigami.CardsListView {
    id: layout
    model: kountdownModel
    delegate: kountdownDelegate
}

```

That seems cryptic, but don't worry. Let's start from the top.

The first thing you'll notice is that we're using `Kirigami.CardsListView`. This is a ListView that allows us to easily display cards in a list. However, ListViews are made to show data taken from a model - to automatically populate itself from a set of data that we point it to. That's where the `model` property comes in: in this example, it's pointing to `kountdownModel`.

### Model

```qml
ListModel {
    id: kountdownModel
    // Each ListElement is an element on the list, containing information
    ListElement { name: "Dog birthday!!"; description: "Big doggo birthday blowout."; date: 100 }
}
```

A model defines the way that a data entry is structured. By looking at our ListElement above we can see how elements of kountdownModel are structured: they contain a name, a description, and a date. The first two are just strings, and the third is a number we're using as a placeholder. 

{{< alert title="Note" color="info" >}}
Since QML is built on top of JavaScript, many of this language's features are available for use in QML files. However, JavaScript variables have to be prefixed with `property` in QML.
{{< /alert >}}

Models are also useful in how they can be modified through the use of several methods. Some important ones are:
- ListModelName.append(jsobject yourobject) adds a JavaScript object you provide to the ListModel, and places it after the last item in the model. For this to happen correctly, you must provide a JavaScript Object with the correct properties and corresponding datatypes.
- ListModelName.get(int index) returns the JSObject at the index location you provide.
- ListModelName.remove(int index, int count) removes the JSObject at the provided index location, and as many after that index location as you wish (1 includes only the JSObject at the provided index)
- ListModelName.set(int index, jsobject yourobject) changes the item at the provided index location with the values provided in yourobject. Same rules as with `.append`.

### Delegate

The delegate handles how your ListModel's data will be displayed in the ListView. CardsListView elements are designed with card-type delegates in mind, and we have indeed used a `Kirigami.AbstractCard` element as our delegate in the excerpt above.

Delegates automatically receive the properties of the ListElements that we have specified in our model. We can therefore just refer to the `name`, `description`, and `date` properties of our ListElements as if they were a conventional variable within our delegate.

### Building our delegate card

```qml
Component {
    id: kountdownDelegate
    Kirigami.AbstractCard {
        contentItem: Item {
            // implicitWidth/Height define the natural width/height of an item if no width or height is specified.
            // The setting below defines a component's preferred size based on its content
            implicitWidth: delegateLayout.implicitWidth
            implicitHeight: delegateLayout.implicitHeight
            GridLayout {
                id: delegateLayout
                anchors {
                    left: parent.left
                    top: parent.top
                    right: parent.right
                }
                rowSpacing: Kirigami.Units.largeSpacing
                columnSpacing: Kirigami.Units.largeSpacing
                columns: root.wideScreen ? 4 : 2

                Kirigami.Heading {
                    Layout.fillHeight: true
                    level: 1
                    text: (date < 100000) ? date : i18n("%1 days", Math.round((date-Date.now())/86400000))
                }

                ColumnLayout {
                    Kirigami.Heading {
                        Layout.fillWidth: true
                        level: 2
                        text: name
                    }
                    Kirigami.Separator {
                        Layout.fillWidth: true
                        visible: description.length > 0
                    }
                    Controls.Label {
                        Layout.fillWidth: true
                        wrapMode: Text.WordWrap
                        text: description
                        visible: description.length > 0
                    }
                }
                Controls.Button {
                    Layout.alignment: Qt.AlignRight
                    Layout.columnSpan: 2
                    text: i18n("Edit")
                    // onClicked: to be done... soon!
                }
            }
        }
    }
}
```

#### implicitWidth and implicitHeight


```qml
Kirigami.AbstractCard {
    contentItem: Item {
        implicitWidth: delegateLayout.implicitWidth
        implicitHeight: delegateLayout.implicitHeight
        GridLayout {
            id: delegateLayout
            ...
        }
    }
}
```

Looking at our Kirigami.AbstractCard, the first properties we set are `implicitWidth` and `implicitHeight`. We have set these to the `delegateLayout.implicitWidth` and `delegateLayout.implicitHeight`, i.e. the `implicitWidth` and `implicitHeight` of the `GridLayout` element. Implicit widths and heights are properties that are set as a sort of default, i.e. if there is no explicit width or height set for these components. We have therefore set the `implicitWidth` and `implicitHeight` of our `Kirigami.AbstractCard` to that of the `GridLayout` below to ensure the `GridLayout` does not spill out of the card.

#### Layouts

The `GridLayout` is inside the `Item` component we have provided for the property `contentItem`. This is the item that contains what will be displayed in your card. 

We also need to choose a layout for our components so that they don't just pile on top of each other. There are three main types that we can choose from:
- `ColumnLayout` lays out your components vertically, in a single column
- `RowLayout` lays out your components horizontally, in a single row
- `GridLayout` lays out your components in a grid with a composition of your choosing

With ColumnLayout and RowLayout, all we have to do is write our components inside the Layout component. As you can see, we went with a grid layout, which entails a bit more handiwork. 


```qml
GridLayout {
	id: delegateLayout
	anchors {
		left: parent.left
		top: parent.top
		right: parent.right
	}
	rowSpacing: Kirigami.Units.largeSpacing
	columnSpacing: Kirigami.Units.largeSpacing
	columns: root.wideScreen ? 4 : 2
    ...
}

```

The first thing you see is our `anchor`. QtQuick's anchoring system provides a useful way of making sure your components are positioned on certain parts of a parent component. We have anchored our `GridLayout` to the left, top, and right of the parent card, ensuring our content stretches across the whole card.

Next we specify the spacing between the rows and columns within our grid, so that our components don't bunch up. Kirigami provides a number of handy pre-defined units to use for this purpose:

| Kirigami Unit | Pixels |
| ------ | ------ |
| smallSpacing | 4px |
| largeSpacing | 8px |
| gridUnit | 18px |

{{< alert title="Note" color="note" >}}
KDE's Visual Design Group (VDG) has a lot more information about different units defined within Plasma and Kirigami on the [Human Interface Guidelines site](/hig/layout/units/).
{{< /alert >}}

We have also used a conditional here to vary the number of columns in our grid depending on the screen we are using. If we are using a widescreen (i.e. a computer monitor or a phone in landscape) the grid will have 4 columns, else it will have 2.

#### Interior components

We could just create three labels within our delegate component and call it a day. But that wouldn't look particularly nice.

```qml
GridLayout {
    ...

    Kirigami.Heading {
        Layout.fillHeight: true
        level: 1
        text: date
    }

    ColumnLayout {
        Kirigami.Heading {
            Layout.fillWidth: true
            level: 2
            text: name
        }

        Kirigami.Separator {
            Layout.fillWidth: true
            visible: description.length > 0
        }

        Controls.Label {
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            text: description
            visible: description.length > 0
        }
    }

    Controls.Button {
        Layout.alignment: Qt.AlignRight
        Layout.columnSpan: 2
        text: i18n("Edit")
    }
}
```

![](CardDesign.png)

- Left, `Kirigami.Heading`: uses the `ListElement`'s `date` as a level 1 heading.

- Middle, `ColumnLayout`: has a `Kirigami.Heading` that displays the task name; a `Kirigami.Separator`, which provides the horizontal line; and a `Controls.Label`, that displays a task's optional description. The latter two components have a `visible` property, which checks if the description is empty or not and displays the components depending on the result of `description.length > 0`.

- Right, `Controls.Button`: a button that will do something... soon!

# Our app so far

![](Screenshot.png)

So there is our basic card!

With these steps, we have now laid the basic groundwork for adding all the functionality to our app.
