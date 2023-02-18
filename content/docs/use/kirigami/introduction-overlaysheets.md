---
title: Creating overlay sheets
group: introduction
weight: 5
description: >
  Getting to grips with overlay sheets.
aliases:
  - /docs/kirigami/introduction-overlaysheets/
---

## Making our app useful

We have a window, we have cards, and we have actions. Yet, we still need to find some way of inputting a name, description, and date of our choice.

One way we could do this is by creating a new page where we place the required input elements. However, a whole page dedicated to providing a name, description, and date seems a bit excessive.

Instead, we'll be using an overlay sheet.

![Overlay sheet appearing in the middle of the application like a dialog window](addSheet.webp)

## Countdown-adding sheet

The new component we add is a [Kirigami.OverlaySheet](docs:kirigami2;OverlaySheet). Overlay sheets hover above the contents of the window and can be used for a variety of purposes, such as providing extra information relevant to the current content. They are like fancy pop-up windows, except they can't be moved.

```qml
Kirigami.OverlaySheet {
    id: addSheet
    header: Kirigami.Heading {
        text: i18nc("@title:window", "Add kountdown")
    }
    Kirigami.FormLayout {
        Controls.TextField {
            id: nameField
            Kirigami.FormData.label: i18nc("@label:textbox", "Name:")
            placeholderText: i18n("Event name (required)")
            onAccepted: descriptionField.forceActiveFocus()
        }
        Controls.TextField {
            id: descriptionField
            Kirigami.FormData.label: i18nc("@label:textbox", "Description:")
            placeholderText: i18n("Optional")
            onAccepted: dateField.forceActiveFocus()
        }
        Controls.TextField {
            id: dateField
            Kirigami.FormData.label: i18nc("@label:textbox", "Date:")
            placeholderText: i18n("YYYY-MM-DD")
            inputMask: "0000-00-00"
        }
        Controls.Button {
            id: doneButton
            Layout.fillWidth: true
            text: i18nc("@action:button", "Done")
            enabled: nameField.text.length > 0
            onClicked: {
                kountdownModel.append({
                    name: nameField.text,
                    description: descriptionField.text,
                    // The parse() method parses a string and returns the number of milliseconds
                    // since January 1, 1970, 00:00:00 UTC.
                    date: Date.parse(dateField.text)
                });
                nameField.text = ""
                descriptionField.text = ""
                dateField.text = ""
                addSheet.close();
            }
        }
    }
}
```

We can give overlay sheets a header. These are set with the [header](docs:kirigami2;templates::OverlaySheet::header) property. We have provided ours with a [Kirigami.Heading](docs:kirigami2;Heading) containing a relevant title: "Add Kountdown".

Then we come to a [Kirigami.FormLayout](docs:kirigami2;FormLayout). This allows us to easily create responsive input forms, which neatly display labels for inputs and the inputs themselves on both widescreen displays and narrower mobile devices. These form layouts are designed to work with a variety of different input types, though we're sticking to simple [Controls.Textfield](docs:qtquickcontrols;QtQuick.Controls.TextField) inputs that give us simple text boxes to write things in.

We have created Textfield elements that act as:

1. Input for the name of our countdown
2. Input for the description of our countdown
3. Input for the date we are counting down towards, which must be provided in a `YYYY-MM-DD` format.

Within each of these [Controls.Textfield](docs:qtquickcontrols;QtQuick.Controls.TextField) elements, we are setting a [Kirigami.FormData.label](docs:kirigami2;FormLayoutAttached::label) property that lets us define labels for them. The form will present the correct labels to the left of each of these text input fields. We are also setting placeholder text inside the fields with the [TextField.placeholderText](https://doc.qt.io/qt-5/qml-qtquick-controls2-textfield.html#placeholderText-prop) property, which will disappear as soon as the user begins typing in the field. Finally, we are also setting the [onAccepted](https://doc.qt.io/qt-6/qml-qtquick-textinput.html#accepted-signal) property to trigger the [forceActiveFocus()](https://doc.qt.io/qt-6/qml-qtquick-item.html#forceActiveFocus-method) method of the following field; this will switch the active field once the user hits the ENTER key, improving the usability of our form.

We have also set a property called [inputMask](https://doc.qt.io/qt-6/qml-qtquick-textinput.html#inputMask-prop) on the text field for our date. Setting this to `"0000-00-00"` prevents users from entering something that might break the functionality of the application (such as text), restricting them to only entering digits which we can then try to parse into a date object.

At the end of our form we are including a [Button](docs:qtquickcontrols;QtQuick.Controls.Button) that adds our new countdown to the list model. We have set its [enabled](https://doc.qt.io/qt-5/qml-qtquick-item.html#enabled-prop) property to a conditional statement that checks whether the name field is empty or not: if it is, the button is disabled, and vice versa. When the button is triggered, it triggers the [append](https://doc.qt.io/qt-6/qml-qtqml-models-listmodel.html#append-method) method of our `kountdownModel` list model, adding a JavaScript object including the properties we have provided. We also make sure to clear the text fields by setting their [text](https://doc.qt.io/qt-6/qml-qtquick-textinput.html#text-prop) properties to an empty string. We finally call a method on our overlay sheet, [close()](docs:kirigami2;templates::OverlaySheet::close), which closes it.

## Using our sheet

```qml
actions.main: Kirigami.Action {
    id: addAction
    icon.name: "list-add"
    text: i18nc("@action:button", "Add kountdown")
    onTriggered: addSheet.open()
}
```

Overlay sheets have two methods, [open()](docs:kirigami2;templates::OverlaySheet::open) and [close()](docs:kirigami2;templates::OverlaySheet::close), which control the opening and closing of this component. In this case, we have set the sheet to be opened when we trigger our action. Once we save our files and build our program, we'll be able to add our own custom countdowns!


## Our app so far

{{< readfile file="/content/docs/use/kirigami/introduction-overlaysheets/main.qml" highlight="qml" >}}

![Screenshot of the application with four example cards](addedKountdowns.webp)
