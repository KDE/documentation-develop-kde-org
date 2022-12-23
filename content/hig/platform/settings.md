---
title: Settings
weight: 4
---

Settings provide the ability to customize the appearance and behavior of
an application, a Plasma widget, or the Plasma Workspace. Dedicated
settings views are intended for settings that are persistent but not
changed very frequently.

A settings page for the Plasma Desktop is referred to as a KCM (KDE
Config Module). KCMs can either appear in Plasma's System Settings app,
or as standalone configuration dialogs.

Example
-------

![](/hig/Settings-dark.png)

Guidelines
----------

### When to Use

-   Use a settings page to display settings that are persistent but
    infrequently accessed or changed. Settings that are frequently
    accessed and changed (e.g. an icon view style or list's sort order)
    should be located close to the views or tools that they affect, such
    as in the window's toolbar.
-   Don't use a settings page to change the properties of a selected
    item. Instead, use a properties dialog or a contextual editing
    panel.
-   Don't use a settings page for potentially dangerous developer
    settings like the name of an SQL table. Instead, use configuration
    files or separate dialogs.

### How to Use

-   **Simple by default**: Define smart and polite defaults so that your
    target users don't have to alter them at all.
-   **Powerful when needed**: Provide enough settings for the perfect
    customization according to individual needs and preferences. But
    even though customizability is very important for KDE software, try
    to keep your settings page as small and simple as possible.
    Remember: every option requires more code and more testing, and
    makes the settings page slower to use.
-   Respect the privacy of the users: Always use opt-in, never an
    opt-out model for features that transmit potentially private data
    (e.g. usage statistics). See KDE's [Telemetry
    Policy](https://community.kde.org/Policies/Telemetry_Policy) for
    details.
-   Following KDE's "Simple by default, powerful when needed"
    [design mantra](..), settings can
    be split into common and advanced groups. Advanced settings are not
    important to most users but essential for some. There therefore
    cannot be removed, but they can be de-emphasized in visual weight.

### Behavior

-   When a change is applied, the application should adopt it
    immediately without the need to restart it.
-   Don't change the settings page depending on the context. It should
    always start with the same landing page regardless of the
    application context.
-   Don't use a wizard to change settings. Only use a wizard if a group
    of settings are all interrelated and must be edited all at once,
    e.g. setting up an email account.
-   If some of the program's settings are only applicable in certain
    contexts, don't hide the inapplicable ones. Instead, disable them
    and hint to the user why they're disabled. **Exception:** it is
    acceptable to hide settings for non-existent hardware. For example,
    it's okay to hide the touchpad configuration when no touchpad is
    present, or hide multi-screen controls when only one screen is
    connected.
-   Consider adding access to third-party add-ons via
    [Get New Stuff!]({{< relref "getnew" >}}).
-   Ctrl + Tab should switch between logical groups of controls.

{{< alert title="Attention" color="warning" >}}
For [accessibility]({{< relref "accessibility" >}})
make sure to test keyboard navigation with the settings. Make sure to
set the focus to focused controls and don't just highlight it.
{{< /alert >}}

### Appearance

-   Place the main title at the top left corner of the window or view
    your form is placed in.

-   For a desktop app, put your settings page inside a dialog window.

-   Place Help, Defaults, Reset, OK, Apply, and Cancel buttons on the
    bottom of the dialog window.

-   If there is a [Get New Stuff!]({{< relref "getnew" >}}) button, place it above the bottom row of buttons.

    ![The Help, Defaults, Reset buttons on the left side.](/hig/SettingsButtons.png)

-   Avoid vertical and especially horizontal scrollbars. The dialog
    should be large enough to fit its contents without scrolling being
    necessary. As more controls are added, err on the side of adding
    additional pages or [tabbed views]({{< relref "/hig/components/navigation/tab" >}})
    rather than making the dialog window larger. This does
    not apply to scrollbars within inline tables, lists and grid views.

-   On mobile, use a full-screen view for your settings page.

**There are several well established layouts for settings that are used
throughout KDE software:**

#### Forms

![Notifications settings in a form
layout](/hig/Settings-Notification-dark.png)

Use a [form]({{< relref "form" >}}) if
your settings have many controls and input fields.

-   Lay out your settings page according to the
    [alignment]({{< relref "alignment" >}}) guidelines.
-   Organize your settings into logical groups, with more important
    groups appearing higher up on the page. Separate the groups with
    whitespace or put them into different tabs of a
    [tabbed view]({{< relref "/hig/components/navigation/tab" >}}) (if appropriate).
-   Separate common and advanced settings into different groups. If
    necessary, hide the advanced settings behind a collapsible group box
    or on another page or tab. Make the common settings comprehensible
    and easy to use.

#### Grid

![Choose a new wallpaper](/hig/Wallpaper-dark.png)

Use a [grid]({{< relref "/hig/components/editing/grid" >}})
for a selection of a single item when all items are visually
distinctive. To implement a grid in a KCM, use the
[KCMGrid]({{< relref "kcmgrid" >}}).

#### Lists

![Language settings](/hig/LanguagePicker.png)

Use a [picker]({{< relref "picker" >}})
for selection and configuration of list based settings where the items
are not visually distinctive.
