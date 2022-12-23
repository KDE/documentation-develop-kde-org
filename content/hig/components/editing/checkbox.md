---
title: Checkbox
weight: 2
group: editing
subgroup: selection
---

Purpose
-------

A checkbox is a control that permits the user to make multiple
selections from a number of options. Checkboxes are used to toggle an
option on or off, or to select or deselect an item. Users make a
decision between two clearly opposite choices, e.g. 'on vs. off',
'apply vs. don't apply', 'show vs. hide'.

Guidelines
----------

### Is this the right control?

-   Use checkboxes for non-exclusive options that have clear
    alternatives. Mutually exclusive options should use a set of
    [radio buttons]({{< relref "radiobutton" >}}) or a [combo box]({{< relref "combobox" >}}).

{{< compare >}}
{{< dont src="/hig/Ambiguous_Opposite_Bad.qml.png" >}}
Don't use a checkbox if the opposite is ambiguous.
{{< /dont >}}
{{< do src="/hig/Ambiguous_Opposite_Good.qml.png" >}}
Use two radio buttons to remove the need to guess.
{{< /do >}}
{{< /compare >}}

-   For more than five options, use either a
    [list view]({{< relref "list" >}}) or the [dual-list pattern]({{< relref "duallist" >}})
    in case of multiple selections.
-   Don't use the selection to perform commands.

{{< compare >}}
{{< dont src="/hig/No_Command_2_Bad.qml.png" >}}
Don't use the selection to perform commands.
{{< /dont >}}
{{< do src="/hig/No_Command_2_Good.qml.png" >}}
Consider using a [push button]({{< relref "pushbutton" >}})
{{< /do >}}
{{< /compare >}}

### Behavior

-   Checking a checkbox should always "enable" an option or change the
    state of an option to "on". Checking a negative or disabling
    option is a double negative and causes confusion and errors.

{{< compare >}}
{{< dont src="/hig/Checkbox_Enable_Bad.qml.png" >}}
Don't use checkboxes for negatives.
{{< /dont >}}
{{< do src="/hig/Checkbox_Enable_Good.qml.png" >}}
Use checkboxes for positives.
{{< /do >}}
{{< /compare >}}

-   Use the mixed state only to indicate that an option is set for some,
    but not all, child objects. Mixed state must not be used to
    represent a third state.

![Example for mixed state.](/hig/Checkbox_Mixed_State.qml.png)

-   Users must not be able to set a mixed state directly.
-   Clicking a mixed state checkbox enables all child objects.
-   Don't use sliding switches in Desktop applications. They only offer
    good user interaction on touch screens, so they should only be used
    in applications for mobile devices.

{{< compare >}}
{{< dont src="/hig/Checkbox_Switch_Desktop.qml.png" >}}
Don't use sliding switches on desktop.
{{< /dont >}}
{{< do src="/hig/Checkbox_Switch_Mobile.qml.png" >}}
Do use sliding switches on mobile.
{{< /do >}}
{{< /compare >}}

### Appearance

If you are using Qt Widgets you should use one of Qt's Layout classes,
which will take care of the layout and spacing of your controls.

-   The text of a checkbox is on the right of its tick rectangle, which
    can make it difficult to avoid blank areas on the left side of the
    form. To keep the layout of the form balanced you can use one of the
    following approaches:
    -   Group checkboxes together in the widget column and add a label
        describing the group in the label column.

        ![Grouped checkboxes](/hig/Grouped_checkboxes.qml.png)

    -   If all else fails, add a label describing the checkbox on the
        left side of the checkbox, then set the text of the checkbox to
        "Enabled", "On", or similar.

        ![Using a separate title label for the checkbox.](/hig/Checkbox_separate_label.qml.png)
-   When options are subordinate to a checkbox (e.g. Audio level can
    only be set if the Activate Audio option is selected), this relation
    should be visualized by indenting the sub-options. There are two
    options to do so:
    -   When you are using a left-aligned checkbox, indent the
        sub-options by using a horizontal spacer of SizeType
        "Minimum".

        ![Aligning sub-options with a horizontal spacer of SizeType 'Minimum'.](/hig/Suboption_spacer.qml.png)

    -   When you are using a checkbox that is placed right to its label,
        indent the sub-options in the same vertical axis as the
        checkbox.

        ![Aligning sub-options with the same vertical axis as the
        checkbox itself.](/hig/Suboption_right.qml.png)
-   If activating a choice affects the appearance or the enabled state
    of other controls, place them next to the checkbox (group).
-   Align checkboxes vertically rather than horizontally, as this makes
    them easier to scan visually. Use horizontal or rectangular
    alignments only if they greatly improve the layout of the window.
-   If certain controls in a configuration dialog are only relevant if a
    certain checkbox is checked (i.e. they are dependent controls),
    disable them instead of hiding them if that checkbox is unchecked.
-   Don't separate checkbox and label. Clicking on both the box and the
    label should toggle the option.
-   Don't add line breaks. If necessary, place an additional label
    below the checkbox.

{{< compare >}}
{{< dont src="/hig/Checkbox_Alignment_Bad.qml.png" >}}
Don't use linebreaks in a checkbox's label.
{{< /dont >}}
{{< do src="/hig/Checkbox_Alignment_Good.qml.png" >}}
Add another label if more explanation is required.
{{< /do >}}
{{< /compare >}}

-   Label a group of checkbox with a descriptive caption to the top left
    of the group (cf. [alignment]({{< relref "alignment" >}})).
-   Create a buddy relation so access keys are assigned.
-   Use [sentence style capitalization]({{< relref "capitalization" >}})
    for checkbox items.

Code
----

### Kirigami

- QML: [CheckBox](https://doc.qt.io/qt-5/qml-qtquick-controls-checkbox.html)

### Plasma components

- [Plasma CheckBox](docs:plasma;org::kde::plasma::components::CheckBox)
