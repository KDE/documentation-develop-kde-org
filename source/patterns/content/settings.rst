Settings
========

A *settings page* provides the ability to customize how an application or
Plasma widget should behave. It is intended for settings that are persistent but not changed very frequently. Following KDE's "Simple by
default, powerful when needed" :doc:`design mantra </introduction/vision>`,
settings are split into common and advanced groups. Advanced settings are
not important to most users but essential for some, and therefore can't be
removed. Those settings are hidden by default to reduce the mental overhead
of using the settings page, but with easy access.

When to use
-----------

-  Use the settings page to display settings that are persistent but not
   accessed or changed very frequently. The toolbar or the main menu (and optionally context menus) are more appropriate places for settings that
   are frequently accessed and changed, such as icon view style or sort order.
-  Do not use settings pages to change the properties of a selected item.
   Instead, use a properties dialog or a contextual editing panel.
-  Do not use the settings page for potentially dangerous developer settings
   like the name of an SQL table. Instead, use configuration files or separate
   dialogs.

How to use
----------

-  **Simple by default**: Define smart and polite defaults so that your target
   :doc:`personas </introduction/personas>` don't have to alter them at all.
-  **Powerful when needed**: Provide enough settings for the perfect
   customization according individual needs and preferences. But even
   though customizability is very important for KDE software, try to
   keep your settings page as small and simple as possible. Remember:
   every option requires more code and more testing, and makes the settings
   page slower to use.
-  Respect the privacy of the users: Always use opt-in, never an opt-out
   model for features that transmit potentially private data (e.g. usage
   statistics).

Implementation
--------------

-  For a desktop app, put your settings page inside a dialog window and do not
   allow it to have a vertical or horizontal scrollbar because all of the
   content will not fit. Instead, separate your controls into more groups and
   make use of :doc:`tabbed views </components/navigation/tab>`. This does not apply to scrollbars within inline tables and grid views, which are
   acceptable.
-  On mobile, use a full-screen view for your settings page. Vertical scrolling
   is acceptable.
-  Lay out your settings page according to the
   :doc:`alignment </layout/alignment>` guidelines. The overall layout
   should appear to be centered, with with section labels on the left side,
   and controls on the right. Tables and grid views are the exception, and
   should span the window width.
-  Organize your settings into logical groups, with more important groups
   appearing higher up on the page. Separate the groups with whitespace or
   put them into different tabs of a
   :doc:`tabbed view </components/navigation/tab>` (if appropriate).
   Try to avoid the use of group boxes to distinguish sections.
   (#1 in the example)
-  Separate common and advanced settings into different groups. If necessary,
   hide the advanced settings behind a collapsible group box. Make the
   standard settings comprehensible and easy to use. (#5)
-  Consider adding access to third-party add-ons via Get Hot New Stuff!,
   if available for this group. Use the label "Get New [term used for
   add-on content]s" (#4)

-  When a change is applied, the application should adopt it immediately
   without the need to restart it.
-  Do not change the settings page depending on the context. It
   should always start with the same landing page regardless of the
   application context.
-  Do not use a wizard to change settings. Only use a wizard if a group of
   settings are all interrelated and must be edited all at once, e.g.
   setting up an email account.
-  If some of the program's settings are only applicable in certain contexts,
   do not hide the inapplicable ones. Instead, disable them and hint to the
   user why they're disabled.
   **Exception:** it is acceptable to hide settings for non-existent hardware.
   For example, it's okay to hide the touchpad configuration when no touchpad
   is present.

Mockup
~~~~~~

.. image:: /img/HIG-Settings.png
   :alt: HIG-Settings.png


#. Access groups via sidebar.
#. The preview has to be on the top of the content area.
#. Offer a good number of pre-defined profiles/schmes to let the user
   choose one out of different factory settings. Anchor the profiles so
   that users can have more space for the area below using the
   horizontal splitter. Cut long captions with ellipsis and show the
   full name in a tooltip.
   (Remark 1: The mockup has very large splitters. The implementation
   should be visually less obtrusive.)
   (Remark 2: The profile selection replaces the former "reset (to
   default)" function.)
#. Allow users to add more profiles via Get Hot New Stuff (GHNS).
   Organize the setting in a way that GHNS access is per group and not
   global.
#. Provide access to the most relevant settings at the Standard section.
   Make sure that these settings are easy to understand.
#. Indicate that Advanced settings are available but keep this section
   collapsed by default. Use a descriptive label so that it reflects the
   functionality.
#. Allow users to export the current settings to a file that can be
   easily imported on any other machine.
#. Allow to Apply the current settings to the application without
   closing the dialog.
#. Provide access to functions for user-defined profiles per context
   menu and standard shortcuts.
#. Scroll the whole area of options but neither the preview not the
   profiles, if necessary.
