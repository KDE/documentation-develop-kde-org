---
title: Radio Button
weight: 8
group: editing
subgroup: selection
---

Purpose
-------

Radio buttons offer the user a choice of two or more mutually exclusive
options. Try to limit the number of radio buttons and radio button
groups in a dialog. Offering a high number of radio buttons consumes
screen space and adds to visual clutter. At the same time, showing all
available options at once is an advantage if users are likely not to
know possible alternatives.

Guidelines
----------

### Is this the right control?

-   Use radio buttons for a few mutually exclusive options. If there are
    more than five options (or if there is not enough space to arrange
    four or five options), use a combo box or list instead.

{{< compare >}}
{{< dont src="/hig/Radiobutton_Many_Bad.qml.png" >}}
Don't use radio buttons for more than five options.
{{< /dont >}}
{{< do src="/hig/Radiobutton_Many_Good.qml.png" >}}
Use a combobox instead.
{{< /do >}}
{{< /compare >}}

-   If there are only two options where one is the negation of the other
    (e.g. "apply" vs. "don't apply"), consider replacing the radio
    buttons by one `checkbox <checkbox>`.

{{< compare >}}
{{< dont src="/hig/Radiobutton_Negation_Bad.qml.png" >}}
Don't use radio buttons for do/don't operations.
{{< /dont >}}
{{< do src="/hig/Radiobutton_Negation_Good.qml.png" >}}
Use a checkbox instead.
{{< /do >}}
{{< /compare >}}

-   Use radio buttons if the user should see the choices without further
    interaction.

{{< compare >}}
{{< dont src="/hig/Radiobutton_Visible_Bad.qml.png" >}}
Don't hide choices that the user should see from the start in comboboxes.
{{< /dont >}}
{{< do src="/hig/Radiobutton_Visible_Good.qml.png" >}}
Use radio buttons instead.
{{< /do >}}
{{< /compare >}}

-   Don't use a radio button to initiate an action. Consider using a
    `push button <../navigation/pushbutton>`{.interpreted-text
    role="doc"} instead.

{{< compare >}}
{{< dont src="/hig/Radiobutton_Command_Bad.qml.png" >}}
Don't use the selection to perform commands.
{{< /dont >}}
{{< do src="/hig/No_Command_2_Good.qml.png" >}}
Consider using a [push button](../../navigation/pushbutton).
{{< /do >}}
{{< /compare >}}

### Behavior

-   Radio buttons are not dynamic; their content or labels should not
    change depending on the context.
-   Always have one radio button selected.

{{< compare >}}
{{< dont src="/hig/Radiobutton_Default_Bad.qml.png" >}}
Don't forget a default option.
{{< /dont >}}
{{< do src="/hig/Radiobutton_Default_Good.qml.png" >}}
Set a default option.
{{< /do >}}
{{< /compare >}}

-   Make the first item the default option.

{{< compare >}}
{{< dont src="/hig/Radiobutton_First_Bad.qml.png" >}}
Don't have an option besides the first as the default.
{{< /dont >}}
{{< do src="/hig/Radiobutton_First_Good.qml.png" >}}
Set the first option as default. Reorder your items if
necessary.
{{< /do >}}
{{< /compare >}}

-   When using a radio button and none of the options is a valid choice,
    add another option to reflect this choice, such as None or Does not
    apply.

### Appearance

If you are using Qt widgets you should use one of [Qt's Layout
Classes](http://doc.qt.io/qt-5/layout.html), which will take care of the
layout and spacing of your controls.

-   When options are subordinate to a radio box, this relation should be
    visualized by indenting the sub-options by using a horizontal spacer
    of SizeType "Minimum".
-   If activating a choice affects the appearance or the enabled state
    of other controls, place them next to the radio button (group).
-   Align radio buttons vertically rather than horizontally, as this
    makes them easier to scan visually. Use horizontal or rectangular
    alignments only if they greatly improve the layout of the window.
-   If certain controls in a configuration dialog are only relevant if a
    certain radio button is toggled on (i.e. they are dependent
    controls), disable them instead of hiding them if that radio button
    is toggled off.
-   Don't separate radio button and label. Clicking on both the button
    and the label should toggle the option.
-   Don't add line breaks. If necessary place an additional label below
    the checkbox.
-   Label a group of radio buttons with a descriptive caption to the top
    left of the group (cf.
    [alignment](/hig/layout/alignment)).
-   Create a buddy relation so access keys are assigned.
-   Use
    [sentence style capitalization](/hig/style/writing/capitalization)
    for radio buttons.
-   Don't use ending punctuation (neither dot nor colon) for group
    label.

Code
----

### Kirigami

- QML: [RadioButton](https://doc.qt.io/qt-5/qml-qtquick-controls-radiobutton.html)

### Plasma components

- [Plasma RadioButton](docs:plasma;org::kde::plasma::components::RadioButton)
