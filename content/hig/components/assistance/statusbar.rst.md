---
title: Status Bars
---
===========

Purpose
-------

A status bar is an area at the bottom of a primary window that displays
information about the current window\'s state, background tasks, or
other contextual information.

KDE applications should not use a conventional status bar by default in
favor of maximized space for content.

Guidelines
----------

### Is this the right control?

-   Omit the status bar in the main window to maximize vertical space
    for content.
    -   Don\'t show meaningless information like \'Ready\'.
    -   Use a floating panel or `tooltips <tooltip>`{.interpreted-text
        role="doc"} for short-term status information like full length
        text of links.
    -   Move controls to the toolbar.
    -   If you cannot find good replacements for status bar functions,
        please ask the usability team for support.
-   Don\'t display a status bar in secondary or internal windows.
-   If a status bar is really necessary in your application consider to
    use a `toolbar <../navigation/toolbar>`{.interpreted-text
    role="doc"} with all customization features.

### Behavior

-   Don\'t use the status bars or any kind of replacement for crucial
    information. Users should never have to know what is in the status
    bar.
-   Don\'t use the status bar or any kind of replacement to display
    advisory messages in place of standard
    `tooltips <tooltip>`.
-   Keep the status information plain; e.g. don\'t add icons.
