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

## Controls ##
KDE apps mostly use standard input controls such as [buttons, menus, checkboxes, text fields, and sliders](https://develop.kde.org/docs/getting-started/kirigami/components-controls/). There are some rules to keep in mind beyond the basics:

- Use a flat [ToolButton](https://doc.qt.io/qt-6/qml-qtquick-controls-toolbutton.html) on a toolbar in a header or footer position, or in a Contextual Toolview—anywhere users expect to encounter UI elements that look like toolbars.
- Use a regular raised [Button](https://doc.qt.io/qt-6/qml-qtquick-controls-button.html) in the main content area, including settings pages and when overlaid on top of content items including list and grid items. In these contexts, the raised outline helps them to be be visibly recognizable as buttons.
- Use a [RoundButton](https://doc.qt.io/qt-6/qml-qtquick-controls-roundbutton.html) for covering up part of the content area not already covered by any kind of opaque or semi-transparent background. These kinds of buttons never have text, so choose an icon that [conveys the button's action perfectly](../icons/#icons-only-buttons).
- Use a [Switch](https://doc.qt.io/qt-6/qml-qtquick-controls-switch.html) or [CheckBox](https://doc.qt.io/qt-6/qml-qtquick-controls-checkbox.html) for settings where both states are obvious without needing to be separately explained. Use a Switch for “Instant apply” settings or state switchers that take effect immediately; otherwise, use a CheckBox.
- Use [RadioButtons](https://doc.qt.io/qt-6/qml-qtquick-controls2-radiobutton.html) or a [ComboBox](https://doc.qt.io/qt-6/qml-qtquick-controls-combobox.html) to present mutually-exclusive options where each one benefits from being spelled out textually. For sets of up to 3 options with short text where space is plentiful, use RadioButtons. If there will up to 10 items, use a ComboBox. For more than 10 options, use a [list view]({{< relref "displaying_content/#lists-and-grids" >}}). Arrange items in a logical order; if none exists, alphabetical is a good default.
- Use a [Slider](https://doc.qt.io/qt-6/qml-qtquick-controls-slider.html) for bounded input where fast interaction is more important than precision. Use a [SpinBox](https://doc.qt.io/qt-6/qml-qtquick-controls-spinbox.html) where precision is more important than speed of interaction. If both numerical precision and speed of interaction are important, then use a Slider with a SpinBox trailing it.


## Text input
Only ask for input using a text field when it's not possible to use a control that automatically validates input. For this reason, you must validate the input text yourself.

When the current text is invalid, indicate this using a [Kirigami.InlineMessage](https://develop.kde.org/docs/getting-started/kirigami/components-inlinemessages/) and disable the ability to confirm or send the input.

If possible, implement an auto-complete feature to help the user enter valid input.

If possible, use one of the pre-made Kirigami text fields:

- Use [Kirigami.ActionTextField](https://api.kde.org/qml-org-kde-kirigami-actiontextfield.html) when you need to add inline actions in the trailing position (e.g. a clear button).
- Use [Kirigami.SearchField](https://api.kde.org/qml-org-kde-kirigami-searchfield.html) to implement a search field.
- Use [Kirigami.PasswordField](https://api.kde.org/qml-org-kde-kirigami-passwordfield.html) to display password prompts.


## Dialogs
Only show a dialog when the normal workflow must be interrupted for one of two reasons:
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
