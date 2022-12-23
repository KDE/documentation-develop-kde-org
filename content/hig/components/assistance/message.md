---
title: Modal Message Dialog
group: assistance
subgroup: notifications
weight: 3
---

Purpose
-------

If the processing has reached an unexpected or potentially dangerous
condition, the user must make a decision. The correct presentation for
this kind of disruptive question is a modal message dialog: a secondary
window that interrupts user's current activity and blocks interaction
until the user decides how to proceed.

Use modal message dialogs sparingly. Users will learn to reflexively
dismiss commonly-encountered modal message dialog without even reading
them, defeating the purpose.

Guidelines
----------

### Is this the right control?

-   Use modal message dialogs only for critical or infrequent tasks that
    require completion before continuing. Avoid disrupting the user;
    workflow maintenance and, therefore, the prevention of errors should
    be the primary objective.
-   Modal message dialogs must offer choices regarding how to proceed;
    don't use them dialogs simply to inform or warn the user. Instead,
    use an [inline message ]({{< relref "inline" >}}).

### Behavior

-   Dialogs should be modal, and block user interaction with the rest of
    the application until a choice has been made. Don't block the
    entire user interface for the whole system, though.
-   Create specific, actionable, user-centered error messages. Users
    should either perform an action or change their behavior as a
    result.
-   Never add a countdown timers or otherwise force user to read and
    understand the message within a few seconds.
-   For very long or complicated conditions, provide a short error
    message and complement it with a Details button that provides a
    lengthier explanation in the same dialog.
-   If the dialog offers any destructive actions, such as "Delete" or
    "Remove", make sure that the button for one of the safe actions is
    marked as the default.

### Appearance

-   Tell the user the reason for the problem and offer help regarding
    how to solve the problem.
-   Phrase your messages clearly, in non-technical terms. Avoid obscure
    error codes.
-   Avoid wording that terrifies the user ("killed", "fatal",
    "illegal") or blames them for their behavior. Be polite.
-   Buttons should clearly indicate the available options using action
    verbs ("Delete", "Rename", "Close", "Accept", etc.) and
    allow the user to make an informed decision even if they have not
    read the message text. Never use "Yes" and "No" as button
    titles.
-   Follow the general guidelines for
    [dialogs]({{< relref "dialog" >}}).
