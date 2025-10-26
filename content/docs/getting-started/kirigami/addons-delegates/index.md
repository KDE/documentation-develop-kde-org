---
title: Form delegates in your settings pages
description: Create elegant custom settings pages.
weight: 83
group: addons
---

Kirigami Addons is an additional set of visual components that work well on mobile and desktop and are guaranteed to be cross-platform. It uses Kirigami under the hood to create its components.

You have learned how to add [About and AboutKDE pages](/docs/getting-started/kirigami/addons-about) to your application. Now you will be able to use their same inner components to create your settings pages.

The project structure should look like this:

```bash
addonsexample
├── CMakeLists.txt
├── main.cpp 
├── Main.qml
├── MyAboutPage.qml
└── SettingsPage.qml
```

## Needed Changes

Change `Main.qml` to include our new Settings page:

```qml
import QtQuick
import QtQuick.Layouts

import org.kde.kirigami as Kirigami
import org.kde.kirigamiaddons.formcard as FormCard

import org.kde.about 1.0

Kirigami.ApplicationWindow {
    id: root
    width: 600
    height: 700

    Component {
        id: aboutkde
        FormCard.AboutKDE {}
    }

    Component {
        id: aboutpage
        MyAboutPage {}
    }

    Component {
        id: settingspage
        SettingsPage {}
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        ColumnLayout {
            FormCard.FormCard {
                FormCard.FormButtonDelegate {
                    id: aboutKDEButton
                    icon.name: "kde"
                    text: i18n("About KDE Page")
                    onClicked: root.pageStack.layers.push(aboutkde)
                }

                FormCard.FormButtonDelegate {
                    id: aboutPageButton
                    icon.name: "applications-utilities"
                    text: i18n("About Addons Example")
                    onClicked: root.pageStack.layers.push(aboutpage)
                }

                FormCard.FormButtonDelegate {
                    id: settingsButton
                    icon.name: "settings-configure"
                    text: i18n("Single Settings Page")
                    onClicked: root.pageStack.layers.push(settingspage)
                }
            }
        }
    }
}
```

We can now start checking out the components used to create our Settings page: the Form Card and its Delegates.

## Form Delegates

### FormCard and FormCardPage

[FormCard.FormCard](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formcard.html) is the main component we will be using to group all its child components, the Delegates.

We used a form card in the [Kirigami Addons introduction](/docs/getting-started/kirigami/addons-introduction) before. Its main purpose is to serve as a container for other components while following a color different from the background, in a similar manner to a [Kirigami.Card](docs:kirigami;org.kde.kirigami.Card).

Create a new `SettingsPage.qml` file:

```qml
import QtQuick
import org.kde.kirigamiaddons.formcard as FormCard

FormCard.FormCardPage {
    FormCard.FormCard {
        // This is where all our delegates go!
    }

    FormCard.FormCard {
        // This is where all our delegates go!
    }
}
```

Since we are making a separate QML file for our Settings page, and since we need to prepare for potential scrolling in our page, we use a [FormCard.FormCardPage](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formcardpage.html), which inherits [Kirigami.ScrollablePage](docs:kirigami;org.kde.kirigami.ScrollablePage).

The nice thing about the form card page is that it comes with an internal layout, so no additional ColumnLayout is needed and our delegates can be added directly to it.

{{< alert color="info" title="Note" >}}
It is possible to use FormCard delegates directly with a Kirigami.ScrollablePage, but in that case you will need to add your own layouts.
{{< /alert >}}

### FormHeader

For every [FormCard](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formcard.html) you want to create, you can create a [FormHeader](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formheader.html) just before it. The header uses bold text and shows up right above the form card.

```qml
import org.kde.kirigamiaddons.formcard as FormCard

FormCard.FormCardPage {
    FormCard.FormHeader {
        title: i18n("General")
    }

    FormCard.FormCard {
        // Our delegates go here...
    }

    FormCard.FormHeader {
        title: i18n("Accounts")
    }

    FormCard.FormCard {
        // Our delegates go here...
    }
}
```

### FormTextDelegate and FormSectionText

Let's start simple, with plain text.

[FormSectionText](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formsectiontext.html) simply adds a thin delegate containing a label. [FormTextDelegate](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formtextdelegate.html) has text and a grayed out description.

```qml
import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.kirigamiaddons.formcard as FormCard

FormCard.FormCardPage {
    FormCard.FormHeader {
        title: i18n("General")
    }

    FormCard.FormCard {
        FormCard.FormTextDelegate {
            text: i18n("Current Color Scheme")
            description: "Breeze"
        }
    }

    FormCard.FormHeader {
        title: i18n("Accounts")
    }

    FormCard.FormCard {
        FormCard.FormSectionText {
            text: i18n("Online Account Settings")
        }
        FormCard.FormTextDelegate {
            leading: Kirigami.Icon {source: "user"}
            text: "John Doe"
            description: i18n("The Maintainer ™️")
        }
    }
}
```

We add some dummy text for the hypothetical theme detection. If we wanted to have actual color scheme detection, in the future it could be done similarly to [Neochat](https://apps.kde.org/neochat) ([code here](https://invent.kde.org/network/neochat/-/blob/master/src/settings/colorschemer.cpp)), making use of a C++ model with [KColorSchemeManager](https://api.kde.org/kcolorschememanager.html).

In the Online Accounts section, we see an additional property, [leading](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formtextdelegate.html#leading-prop). We can add an [Item](https://doc.qt.io/qt-6/qml-qtquick-item.html) to it so that it appears before the text. Its opposite property, [trailing](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formtextdelegate.html#trailing-prop), would be able to show an Item after the text, but we won't use it in our program.

We use a [Kirigami.Icon](docs:kirigami;org.kde.kirigami.primitives.Icon) here for simplicity, but this could also be implemented using a Kirigami Addons [Avatar](https://api.kde.org/qml-org-kde-kirigamiaddons-components-avatar.html) that grabs the information from a model, [as is done in Neochat](https://invent.kde.org/network/neochat/-/blob/master/src/settings/AccountsPage.qml).

It should end up looking like this:

{{< figure src="formtextdelegate.webp" >}}

### FormButtonDelegate

The [FormButtonDelegate](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formbuttondelegate.html) is visually similar to a FormTextDelegate, but it is clickable and shows an arrow pointing to the right. We used it in the [Kirigami Addons introduction](/docs/getting-started/kirigami/addons-introduction) before.

While the FormTextDelegate had the [leading](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formtextdelegate.html#leading-prop) and [trailing](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formtextdelegate.html#trailing-prop) properties to show an item before and after the main content, the FormButtonDelegate only has the [leading](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formbuttondelegate.html#leading-prop) property, because the right side is occupied by the arrow.

```qml
import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.kirigamiaddons.formcard as FormCard

FormCard.FormCardPage {
    FormCard.FormHeader {
        title: i18n("General")
    }

    FormCard.FormCard {
        FormCard.FormTextDelegate {
            text: i18n("Current Color Scheme")
            description: "Breeze"
        }
    }

    FormCard.FormHeader {
        title: i18n("Accounts")
    }

    FormCard.FormCard {
        FormCard.FormSectionText {
            text: i18n("Online Account Settings")
        }
        FormCard.FormTextDelegate {
            leading: Kirigami.Icon {source: "user"}
            text: "John Doe"
            description: i18n("The Maintainer ™️")
        }
        FormCard.FormButtonDelegate {
            icon.name: "list-add"
            text: i18n("Add a new account")
            onClicked: console.info("Clicked!")
        }
    }
}
```

We use its [icon.name](https://doc.qt.io/Qt-6/qml-qtquick-controls-abstractbutton.html#icon.name-prop) property to set a plus (+) icon to appear after the space where the [leading](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formbuttondelegate.html#leading-prop) would appear, and before the main content. This is a common pattern to indicate your button will add something to a list.

Since this example is for simple illustrative purposes, we don't delve deep into what would be done once the button is clicked: it just prints "Clicked!" to the terminal. We _could_ make a new page for account creation that adds another user to a model, then push the page into view, similarly to what we did in `Main.qml`.

{{< figure src="formbuttondelegate.webp" >}}

### FormRadioDelegate, FormCheckDelegate and FormSwitchDelegate

The RadioButton, CheckBox and Switch are very commonly used components in any user interface. Kirigami Addons provides them as [FormRadioDelegate](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formradiodelegate.html), [FormCheckDelegate](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formcheckdelegate.html) and [FormSwitchDelegate](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formswitchdelegate.html).

Their only main properties are `text` and `description`. They are different in usage because they all inherit [AbstractButton](docs:qtquickcontrols;QtQuick.Controls.AbstractButton), and so you are expected to use its signals and handlers: checked and onChecked, toggled and onToggled, clicked and onClicked.

We want to create some autosave functionality in our application, and we want to only show its settings if the user has enabled this functionality. Create a new section using a [FormCard](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formcard.html) and a [FormHeader](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formheader.html), then add a [FormSwitchDelegate](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formswitchdelegate.html) and a [FormRadioDelegate](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formradiodelegate.html).

```qml
FormCard.FormHeader {
    title: i18n("Autosave")
}

FormCard.FormCard {
    FormCard.FormSwitchDelegate {
        id: autosave
        text: i18n("Enabled")
    }
    FormCard.FormRadioDelegate {
        text: i18n("After every change")
        visible: autosave.checked
    }
    FormCard.FormRadioDelegate {
        text: i18n("Every 10 minutes")
        visible: autosave.checked
    }
    FormCard.FormRadioDelegate {
        text: i18n("Every 30 minutes")
        visible: autosave.checked
    }
}
```

We bind the visibility of each radio button to a switch, so they only appear when the switch is enabled.

{{< alert title="Best Practices" color="success" >}}

<details><summary>Click here to read more</summary>

If you have some programming background in imperative languages such as C++, you might be tempted to set the [checked](https://doc.qt.io/qt-6/qml-qtquick-controls-abstractbutton.html#checked-prop) property of the switch to turn the visibility of the radio buttons to `true` with a JavaScript assignment such as:

```js
checked: {
    radio1.visible = true;
    radio2.visible = true;
    radio3.visible = true;
}
```

This is not very efficient for QML's declarative language and its signals and slots. Try to use QML bindings like in the case of `visible: autosave.checked` as much as possible instead of JavaScript expressions.

See [this page](https://doc.qt.io/qt-6/qtquick-bestpractices.html#prefer-declarative-bindings-over-imperative-assignments) for details.

</details>

{{< /alert >}}

{{< figure src="formradiodelegate.webp" >}}

To test our checkbox, we can add a new [FormCheckDelegate](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formcheckdelegate.html) to our General section.

```qml
FormCard.FormHeader {
    title: i18n("General")
}

FormCard.FormCard {
    FormCard.FormTextDelegate {
        text: i18n("Current Color Scheme")
        description: "Breeze"
    }
    FormCard.FormCheckDelegate {
        text: i18n("Show Tray Icon")
        onToggled: {
            if (checkState) {
                console.info("A tray icon appears on your system!")
            } else {
                console.info("The tray icon disappears!")
            }
        }
    }
}
```

Here we use the [signal handler](https://doc.qt.io/qt-6/qtqml-syntax-signals.html) called [onToggled](https://doc.qt.io/qt-6/qml-qtquick-controls-abstractbutton.html#toggled-signal) to show some dummy text to simulate a tray icon appearing in the system. If you really wanted to, you could easily implement a tray icon using KDE's [KStatusNotifierItem](https://api.kde.org/kstatusnotifieritem-index.html) or Qt's [SystemTrayIcon](https://doc.qt.io/qt-6/qml-qt-labs-platform-systemtrayicon.html).

So far our application should look like this:

{{< figure src="formcheckboxdelegate.webp" >}}

### FormComboBoxDelegate

The common ComboBox component can be created using a [FormComboBoxDelegate](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formcomboboxdelegate.html).

This combobox has several useful properties we can make use of: [editable](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formcomboboxdelegate.html#editable-prop), [displayText](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formcomboboxdelegate.html#displayText-prop) and [displayMode](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formcomboboxdelegate.html#displayMode-prop).

Setting `editable: true` allows the user to edit the text of the combobox, which is useful in case adding new combobox options is needed:

{{< figure src="formcombobox-editable.webp" >}}

Whenever you need to show additional text before each option, you can use something like `displayText: "Profile: " + currentText`:

{{< figure src="formcombobox-displaytext.webp" >}}

And the most interesting one, which we will be using in our example, is [displayMode](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formcomboboxdelegate.html#displayMode-prop). It can have three options:

* **FormComboBoxDelegate.ComboBox**: the standard small box showing a list of options.

{{< figure src="formcombobox-comboboxmode.webp" >}}

* **FormComboBoxDelegate.Dialog**: a dialog showing a list of options in the middle of the window, like a [Kirigami.OverlaySheet](docs:kirigami;org.kde.kirigami.OverlaySheet).

{{< figure src="formcombobox-dialogmode.webp" >}}

* **FormComboBoxDelegate.Page**: a new page containing a list of options shown in a separate window.

{{< figure src="formcombobox-pagemode.webp" >}}

Add the following between the "Current Color Scheme" and "Show Tray Icon" delegates in your "General" form card.

```qml
FormCard.FormComboBoxDelegate {
    text: i18n("Default Profile")
    description: i18n("The profile to be loaded by default.")
    displayMode: FormCard.FormComboBoxDelegate.ComboBox
    currentIndex: 0
    editable: false
    model: ["Work", "Personal"]
}
```

With the checkbox, our Settings page should look like this:

{{< figure src="formcombobox-result.webp" >}}

### FormDelegateSeparator

Our Settings page is taking shape, but each section is starting to get long. We can add a few [FormDelegateSeparator](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formdelegateseparator.html) instances to make our page tidier:

{{< snippet repo="libraries/kirigami-addons" file="examples/FormCardTutorial/SettingsPage.qml" lang="qml" >}}

Generally, you may use separators whenever you see major distinctions between components, although the choice of where to place them is ultimately yours. For example, in the General section, the checkbox differs from its previous components as it doesn't start with text; in the Autosave section, the separator groups the radio buttons together; and in the Accounts section, adding a separator between the last account and the button provides some additional focus to the button.

The [above](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formdelegateseparator.html#above-prop) and [below](https://api.kde.org/qml-org-kde-kirigamiaddons-formcard-formdelegateseparator.html#below-prop) properties are rather self-explanatory when it comes to their use: you pass the `id` of the components above and below the separator. When they are set, the separator will swiftly disappear whenever the above or below item is highlighted/hovered. They are most useful, for instance, when you need to generate components dynamically and you can't automatically assume which item will come immediately before or after the separator. That would be the case in the Accounts section of our application once the logic to add new accounts were actually implemented, in which case we could always grab the last item in the model to do so.

{{< figure src="formdelegateseparator.webp" >}}

Notice how the separator above the tray icon setting does not appear while it is hovered.
