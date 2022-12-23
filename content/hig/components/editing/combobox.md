---
title: Combo Box
group: editing
subgroup: selection
---

![A combination of a drop-down list and an edit
control.](/hig/Combobox1.png)

Purpose
-------

A combo box is a combination of a drop-down list and an edit control,
thus allowing users to enter a value that is not in the list. It behaves
like a drop-down list and allows the user to choose from a list of
existing items but adds the option to type a value directly into the
control. Newly typed items are usually added to the list and can be
selected next time. Combo boxes are typically applied to provide
auto-complete or auto-type functionality in a convenient way to the
user.

The list provides auto-complete feature for the whole string,
independently of the "editable" property. Given the items of "bike",
"boat", and "car":

-   If one types "b", the list selects "bike".
-   If one (rapidly) types "bo", it selects "boat".
-   If one types "c", it selects "car".

The input field of the combo box ("editable" is true) marks the
completed part of the item as selected, making it easy to change the
completion.

Guidelines
----------

### Is this the right control?

-   Use a combo box for single selection of one out of many items of
    lists that can be extended by the user. Prefer a simple
    [drop-down list]({{< relref "dropdown" >}}) in case of
    read-only interaction.
-   Consider to replace the combo box by a
    [list view]({{< relref "list" >}}) with a connected
    [line edit control]({{< relref "lineedit" >}}).

### Behavior

-   Show a maximum of eight items at once.
-   When possible apply changes immediately but don't initiate an
    action (like print, send, delete) when the user selects an item from
    the list.
-   Don't add controls to the drop-down (e.g. checkboxes for each
    item).
-   Place options that represent general options (e.g. all, none) at the
    beginning of the list.
-   Sort list items in a logical order. Make sure sorting fits
    translation.
-   Make sure the items are easily accessible via keyboard by moving
    distinctive letters to the beginning of each option. For example, in
    a list of countries on continents, write "Germany (Europe)"
    instead of "Europe/Germany".
-   Don't have blank list items; use meta-options, e.g. (None) instead.

### Appearance

-   Combo boxes are distinguished visually from drop-down lists
    (normally by the raised or lowered bevel). Don't override the
    common processing, e.g. by using a combo box and making it read only
    in order to simulate a simple drop-down list.
-   If activating a choice affects the appearance or the enabled state
    of other controls, place them next to the combo box.
-   If certain controls in a configuration dialog are only relevant if a
    certain item is selected (i.e. they are dependent controls), disable
    them instead of hiding.
-   Label the combo box with a descriptive caption to the left (cf.
    [alignment]({{< relref "alignment" >}})).
-   Create a buddy relation so access keys are assigned.
-   End each label with a colon.
-   Use [sentence style capitalization]({{< relref "capitalization" >}})
    for items.

Code
----

### Kirigami

- QML: [ComboBox](https://doc.qt.io/qt-5/qml-qtquick-controls-combobox.html)

### Plasma components

- [Plasma ComboBox](docs:plasma;org::kde::plasma::components::ComboBox)
