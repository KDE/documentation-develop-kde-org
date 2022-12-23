---
title: Form
weight: 2
---

A form layout is used to help align and structure a layout that contains
many controls and input fields.

When to Use
-----------

-   Use a Form layout when there are many related controls and input
    fields.
-   Form layouts are often used for
    [settings]({{< relref "settings" >}}).

How to Use
----------

-   Use Qt's QFormLayout or Kirigami.FormLayout wherever possible.
-   Do not synthesize your own FormLayout-style layout using a grid.

{{< alert color="warning" title="Attention" >}}

If for some reason you must create your own FormLayout style layout
without using one of the aforementioned controls, there are several very
important things to take into account for
[accessibility](/accessibility/) reasons""

-   Form labels need to be connected with input fields.
-   Headlines for groupings need to be connected.
-   Make sure to test keyboard navigation with the form.
-   Ctrl + Tab should switch between logical groups of controls.
-   Make sure to set the focus to focused controls; don't just
    highlight them.

{{< /alert >}}

### Alignment

#### Desktop

-   On Desktop it is recommended to place the labels to the left of the
    connected widgets. Labels that are to the left of their connected
    widgets should be right-aligned and end with a colon (in case of
    right-to-left languages, mirror the alignment). This makes the whole
    group of form widgets appear to be center-aligned. In Qt 5, using a
    QFormLayout handles all of this for you automatically.
-   Align the form in the top center of the window or view in which it
    is located, but below the title.
-   See the pages on [radio buttons]({{< relref "radiobutton" >}})
    and [checkboxes]({{< relref "checkbox" >}}) for detailed
    information regarding how to align these tricky controls in a Form
    layout.

{{< compare >}}
{{< do src="/hig/Form_Align_KDE5.png" >}}
Use Plasma 5-style form alignment.
{{< /do >}}
{{< dont src="/hig/Form_Align_KDE3.png" >}}
 Don't use KDE3-style form alignment.
{{< /dont >}}
{{< /compare >}}

-   Position groups of items vertically rather than horizontally, as
    this makes them easier to scan visually. Use horizontal or
    rectangular positioning only if it would greatly improve the layout
    of the window.
-   Left align controls over multiple groups. This visual anchor
    facilitates scanning of content, and left-hand alignment fits as
    well forms that have been oversized individually.

{{< compare >}}
{{< do src="/hig/Form_Align_YES.png" >}}
Align controls to the left.
{{< /do >}}
{{< dont src="/hig/Form_Align_NO.png" >}}
Don't misalign controls.
{{< /dont >}}
{{< /compare >}}

-   Keep track of label sizes; avoid large differences in text length
    that could result in too much whitespace. Keep translation in mind
    too; existing length differences will be exaggerated for wordy
    languages such as German and Brazilian Portuguese.

    {{< dont src="/hig/Form_Align_Long.png" >}}
    Don't use very long captions.
    {{< /dont >}}

#### Mobile and narrow space

-   For mobile, or if only a very small amount of horizontal space is
    available, it is recommended to place the labels above the connected
    widgets.
-   When using labels on top, labels and widgets should be left-aligned.

![image](/hig/Form_Align_YES_Mobile.png)

#### Titles

![Notifications settings](/hig/Settings-Notification-dark.png)

### Spacing and Grouping

Use [spacing]({{< relref "metrics" >}}) to group
and separate controls in your forms.

![Spacing used to create three groups of controls](/hig/Form3.png)

Alternatively, you can use separators for a stronger separation.

![Using a separator to group controls](/hig/Form4.png)

To create even stronger separation, you can add subtitles for groups of
controls. Subtitles are left aligned with the longest label of their
group.

![Alignment of subtitles](/hig/Form5.png)

Code
----

### Kirigami

- [Kirigami: FormLayout](docs:kirigami2;FormLayout)

{{< readfile file="/content/hig/examples/kirigami/FormLayout.qml" highlight="qml" >}}
