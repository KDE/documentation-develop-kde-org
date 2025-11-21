---
title: "Getting input"
weight: 7
aliases:
- /hig/components/navigation/actionbutton/
- /hig/components/navigation/dialog/
- /hig/components/editing/
- /hig/components/editing/checkbox/
- /hig/components/editing/radiobutton/
- /hig/components/editing/togglebutton/
- /hig/components/editing/combobox/
- /hig/components/editing/dropdown/
- /hig/components/editing/lineedit/
- /hig/components/editing/tableview/
- /hig/components/editing/textedit/
- /hig/components/editing/date/
- /hig/components/editing/slider/
- /hig/components/editing/spinbox/
- /hig/patterns-command/simple/
---

KDE apps mostly use standard input controls such as [buttons, menus, checkboxes, text fields, and sliders](https://develop.kde.org/docs/getting-started/kirigami/components-controls/). Here's how to handle various situations:


## Initiating actions ##
The [Button](https://doc.qt.io/qt-6/qml-qtquick-controls-button.html), [ToolButton](https://doc.qt.io/qt-6/qml-qtquick-controls-toolbutton.html), and [RoundButton](https://doc.qt.io/qt-6/qml-qtquick-controls-roundbutton.html) controls all initiate a one-time action when pressed. This is where and how to use them:

- Use a ToolButton on a toolbar in the header or footer position or a window, page, or scrollable view.
- Use a RoundButton when a button needs to be overlaid in a “floating” position above a content view, especially an image view. This kind of button never has text, so choose an icon that [conveys the button's action perfectly](../icons/#icons-only-buttons), with no ambiguity.
- For all other cases, use a Button.

Follow the [standard labeling guidelines](../text_and_labels/#mood-and-tone) for buttons with visible text.


## Choosing between 2 obvious states or settings
The [Switch](https://doc.qt.io/qt-6/qml-qtquick-controls-switch.html) and [CheckBox](https://doc.qt.io/qt-6/qml-qtquick-controls-checkbox.html) controls are both used for two-state settings where both states are obvious with a single label.

Don’t change the label or icon when the state changes, and follow the [standard labeling guidelines](../text_and_labels/#mood-and-tone).

Use a Switch for “instant apply” controls that take effect immediately; otherwise, use a CheckBox.

{{< figure src="/hig/switch-with-obvious-opposite-state.png" class="text-center" caption="Switches take effect the moment they're clicked." width="500px">}}

{{< figure src="/hig/checkboxes-with-obvious-opposite-states.png" class="text-center" caption="CheckBoxes only take effect when the user clicks “OK” or “Apply”." width="600px">}}

Avoid making buttons checkable (by setting their `checkable` property to `true`), as their checkability isn’t obvious when unchecked (or even when checked, depending on the theme)

If the surrounding context nonetheless dictates that a checkable button is the right control, treat it as a checkbox that happens to look like a button, applying the above guidelines.

Alternatively, use a normal non-checkable button with text indicating what will happen when it’s pressed, and change the text and icon when the state changes. When doing so, follow the standard guidelines for [labels](../text_and_labels/#mood-and-tone) and [icons](../icons/).


## Choosing between non-obvious states or settings
The [Radio Button](https://doc.qt.io/qt-6/qml-qtquick-controls2-radiobutton.html) and [ComboBox](https://doc.qt.io/qt-6/qml-qtquick-controls-combobox.html) controls are both used to present a set of labeled, mutually-exclusive options.

{{< figure src="/hig/radio-buttons-with-non-obvious-opposite-states.png" class="text-center" caption="Each option's opposite state is not obvious without explanation, so Radio Buttons are used." width="350px">}}

- For 3 or fewer options with short text where vertical space is plentiful, use RadioButtons.
- For up to 10 items, or where vertical space is limited, use a ComboBox.
- For more than 10 options, use a scrollable [list view]({{< relref "displaying_content/#lists-and-grids" >}}).

In all cases, arrange items in a logical order; if none exists, alphabetical is a good default.


## Gross and fine input
Use a [Slider](https://doc.qt.io/qt-6/qml-qtquick-controls-slider.html) for bounded input where fast interaction is more important than precision.

Use a [SpinBox](https://doc.qt.io/qt-6/qml-qtquick-controls-spinbox.html) where precision is more important than speed of interaction.

If both factors are important at different times, then use a Slider with a SpinBox trailing it:

{{< figure src="/hig/slider-and-spinbox.png" class="text-center" caption="The user can drag the Slider's handle for quick changes, or enter a precise value in the SpinBox for fine adjustments." width="375px">}}


## Getting text input
Only ask for input using a text field when it's not possible to use a control that automatically validates input. For this reason, you must validate the input text yourself.

When the current text is invalid, indicate this using a [Kirigami.InlineMessage](https://develop.kde.org/docs/getting-started/kirigami/components-inlinemessages/) and disable the ability to confirm or send the input.

If possible, implement an auto-complete feature to help the user enter valid input.

If possible, use one of the pre-made Kirigami text fields:

- Use [Kirigami.ActionTextField](https://api.kde.org/qml-org-kde-kirigami-actiontextfield.html) when you need to add inline actions in the trailing position (e.g. a clear button).
- Use [Kirigami.SearchField](https://api.kde.org/qml-org-kde-kirigami-searchfield.html) to implement a search field.
- Use [Kirigami.PasswordField](https://api.kde.org/qml-org-kde-kirigami-passwordfield.html) to display password prompts.


## Interrupting the user to ask for input
Dialog windows interrupt the user to ask for input or confirmation. Minimize their use, as they can be considered annoying; many users click through them without reading anything.

Only interrupt the user with a dialog window for one of two reasons:
- When the user must make an immediate decision before the app can continue working normally.
- To display progress information about a task that must complete before the app can continue working normally.

For all other purposes, don't use a dialog; request input or display information inline in a non-modal fashion.

For opening and saving files, use [QtQuick.Dialogs.FileDialog](https://doc.qt.io/qt-6/qml-qtquick-dialogs-filedialog.html) with the [fileMode](https://doc.qt.io/qt-6/qml-qtquick-dialogs-filedialog.html#fileMode-prop) set appropriately. Don't implement a custom file-choosing UI.

For getting other kinds of input, use one of the Kirigami `Dialog` types:

- Use [Kirigami.PromptDialog](https://api.kde.org/qml-org-kde-kirigami-dialogs-promptdialog.html) for a “do it/don't do it” type of choice.
- Use [Kirigami.PromptDialog](https://api.kde.org/qml-org-kde-kirigami-dialogs-promptdialog.html) with a [QtQuick.Controls.TextField](https://doc.qt.io/qt-6/qml-qtquick-controls-textfield.html) inside it to get text input from the user.
- Use [Kirigami.MenuDialog](https://api.kde.org/qml-org-kde-kirigami-dialogs-menudialog.html) to let the user choose from among a set of actions.

Don't display more than one dialog at a time. Never use a dialog to create more dialogs.


<!--TODO: move this info into a more general page on style, once we have one -->
## Signaling interactivity ##
Standard Breeze styling for controls signals interactivity primary through hover effects—typically by changing the background or outline color. Keep these guidelines in mind:

- Use standard controls as much as possible to automatically inherit this style of visual interactivity.
- When custom controls must be used, prefer to override the `contentItem` property of standard controls so that only the content is custom, and the interactivity and styling of the background effect are preserved.
- If even that is not possible, re-implement interactivity signaling using hover effects.
- Only use the pointing finger cursor to signal interactivity for a clickable URL.
- Only use underlined web-style links for clickable URLs, never for internal navigation within your app.
