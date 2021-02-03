---
title: Text Edit
weight: 12
group: editing
subgroup: unconstrained
---

![Control to enter multiple lines of text.](/hig/Textedit1.png)

Purpose
-------

The text edit control displays multiple lines of text to the user and
allow the user to enter unconstrained text. In contrast to a line edit
that is used to enter only one line of text the text edit is the right
control for more than one line.

Guidelines
----------

### Is this the right control?

-   Use text edits for input of unconstrained text with more than one
    line.
-   Don't use a text edit for input of a few words. Use a
    [line edit](./lineedit) to enter single
    lines of text.

### Behavior

-   Don't make users scroll unnecessarily; size text boxes to eliminate
    the need for scrolling.
-   Don't put horizontal scroll bars on multi-line text boxes.

### Appearance

-   When disabling the text edit, also disable any associated labels and
    buttons.
-   Label every text edit with a descriptive caption to the top left
    (cf. [alignment](/hig/layout/alignment)).
-   Create a buddy relation so access keys are assigned.
