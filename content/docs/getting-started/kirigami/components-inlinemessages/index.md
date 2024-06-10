---
title: Inline messages
weight: 209
description: Display messages related to the content in your application
group: components
aliases:
  - /docs/getting-started/kirigami/components-inlinemessages/
---

Inline messages provide an immediate way for you to notify your users about something that happened while using the application.

## Basic inline message

[Kirigami.InlineMessage](docs:kirigami2;InlineMessage) components have two important properties to be mindful of:
- [visible](https://doc.qt.io/qt-6/qml-qtquick-item.html#visible-prop): by default this is set to false, so that the message only appears when you explicitly want it to. This can be overridden if you wish by setting it to true. When a hidden inline message is set to be visible, you get a nice animation.
- [text](docs:kirigami2;templates::InlineMessage::text): here is where you set the text of your inline message.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.Page {

    ColumnLayout {
        Kirigami.InlineMessage {
            id: inlineMessage
            Layout.fillWidth: true
            text: "Hello! I am a siiiiiiimple lil' inline message!"
        }

        Controls.Button {
            text: "Show inline message!"
            onClicked: inlineMessage.visible = !inlineMessage.visible
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

![A window showing a button which when clicked makes an inline message with light blue background pop up with text above it, near the top of the application](/docs/getting-started/kirigami/components-inlinemessages/inlinemessages-simple.png)

{{< /section-right >}}

{{< /sections >}}

## Different types

Standard inline messages are like the ones above: they have a blue background and a default icon. We can change that with the [type](docs:kirigami2;templates::InlineMessage::type) property, which lets us set our inline message to a different type. There are four types we can choose from:

- **Information** (`Kirigami.MessageType.Information`): the default. Has a blue background, an 'i' icon, and is used to announce a result or tell the user something general. It is not necessary to manually set it.
- **Positive** (`Kirigami.MessageType.Positive`): has a green background, tick icon, and indicates that something went well.
- **Warning** (`Kirigami.MessageType.Warning`): has an orange background, an exclamation-mark icon, and can be used to warn the user about something they should be mindful of.
- **Error** (`Kirigami.MessageType.Error`): has a red background, a cross icon, and can be used to tell the user that something has gone wrong.

{{< sections >}}

{{< section-left >}}

```qml
ColumnLayout {

    Kirigami.InlineMessage {
        Layout.fillWidth: true
        text: "Hello! Let me tell you something interesting!"
        visible: true
    }

    Kirigami.InlineMessage {
        Layout.fillWidth: true
        text: "Hey! Let me tell you something positive!"
        type: Kirigami.MessageType.Positive
        visible: true
    }

    Kirigami.InlineMessage {
        Layout.fillWidth: true
        text: "Hmm... You should keep this in mind!"
        type: Kirigami.MessageType.Warning
        visible: true
    }
    
    Kirigami.InlineMessage {
        Layout.fillWidth: true
        text: "Argh!!! Something went wrong!!"
        type: Kirigami.MessageType.Error
        visible: true
    }

}
```

{{< /section-left >}}

{{< section-right >}}

![A window showcasing all four inline message types in blue, green, orange and red](/docs/getting-started/kirigami/components-inlinemessages/inlinemessages-types.png)

{{< /section-right >}}

{{< /sections >}}

## Customising text and icons

Inline messages support rich text, which can be defined with simple HTML-like markup. This allows you to add some formatting to your inline message's text or even include an external web link if you want to.

{{< sections >}}

{{< section-left >}}

```qml
Kirigami.InlineMessage {
    Layout.fillWidth: true
    // Note that when you use quotes in a string you will have to escape them!
    text: "Check out <a href=\"https://kde.org\">KDE's website!<a/>"
    onLinkActivated: Qt.openUrlExternally(link)
    visible: true
}
```

{{< /section-left >}}

{{< section-right >}}

![An inline message with rich text and a hyperlink](/docs/getting-started/kirigami/components-inlinemessages/inlinemessages-richtext.png)

{{< /section-right >}}

{{< /sections >}}

You can also customise the icon that appears on the top left of your message by providing a system icon name for the [icon.source](docs:kirigami2;templates::InlineMessage::icon) property. These icon names should correspond to icons installed on your system; you can use an application such as Cuttlefish provided by [plasma-sdk](https://invent.kde.org/plasma/plasma-sdk) to browse and search the icons available on your system, and see what their names are.

{{< sections >}}

{{< section-left >}}

```qml
Kirigami.InlineMessage {
    Layout.fillWidth: true
    text: "Look at me! I look SPECIAL!"
    icon.source: "actor"
    visible: true
}
```

{{< /section-left >}}

{{< section-right >}}

![An inline message with a custom icon](/docs/getting-started/kirigami/components-inlinemessages/inlinemessages-icon.png)

{{< /section-right >}}

{{< /sections >}}

## Using actions in inline messages

If your messages need to be interactive, you can attach Kirigami actions to your inline messages. Like with pages, you can do this by setting the [InlineMessage.actions](docs:kirigami2;templates::InlineMessage::actions) property to either a [Kirigami.Action](docs:kirigami2;Action) or an array containing [Kirigami.Action](docs:kirigami2;Action) components.

{{< sections >}}

{{< section-left >}}

```qml
ColumnLayout {

    Kirigami.InlineMessage {
        id: actionsMessage
        Layout.fillWidth: true
        visible: true

        readonly property string initialText: "Something is hiding around here..."
        text: initialText

        actions: [
            Kirigami.Action {
                enabled: actionsMessage.text == actionsMessage.initialText
                text: qsTr("Add text")
                icon.name: "list-add"
                onTriggered: {
                    actionsMessage.text = actionsMessage.initialText + " Peekaboo!";
                }
            },
            Kirigami.Action {
                enabled: actionsMessage.text != actionsMessage.initialText
                text: qsTr("Reset text")
                icon.name: "list-remove"
                onTriggered: actionsMessage.text = actionsMessage.initialText
            }
        ]
    }
}
```

{{< /section-left >}}

{{< section-right >}}

![An inline message with two actions](/docs/getting-started/kirigami/components-inlinemessages/inlinemessages-actions.png)

{{< /section-right >}}

{{< /sections >}}

## Close buttons

Inline messages provide a close button that can be used to easily dismiss them. 

By default, this close button is hidden, but this can be overridden by setting the [showCloseButton](docs:kirigami2;templates::InlineMessage::showCloseButton) property to `true`.

{{< sections >}}

{{< section-left >}}

```qml
Kirigami.InlineMessage {
    Layout.fillWidth: true
    text: "Please don't dismiss me..."
    showCloseButton: true
    visible: true
}
```

{{< /section-left >}}

{{< section-right >}}

![An inline message with close button to its right side](/docs/getting-started/kirigami/components-inlinemessages/inlinemessages-closebutton.png)

{{< /section-right >}}

{{< /sections >}}
