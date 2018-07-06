Lables
======

Purpose
-------

Common controls should behave ‘common’ and look like everyday controls.
Therefore, it is much recommended to use standard font. Bold or italic
font should not be applied to control labels.

Guidelines
----------

-  Keep labels short; be aware that :doc:`translated <localization>` English text can
   expand up to 30% in some languages.
-  Do not shorten your labels to the point of losing meaning. However, a
   three-word label that provides clear information is better than a
   one-word label that is ambiguous or vague. Try to find the fewest
   possible words to satisfactorily convey the meaning of your label.
-  When the label is associated with another control, like a line edit,
   be sure to set the the line edit as the
   `buddy <https://doc.qt.io/qt-5/qlabel.html#setBuddy>`_ of
   the label.

Dialogs
~~~~~~~

-  If a dialog is user-initiated, identify it using the command or
   feature name.
-  If it is application- or system-initiated (and therefore out of
   context), label it using the program or feature name to provide
   context.
-  Do not use the title to explain what to do in the dialog – that's the
   purpose of the main instruction.

Menus
~~~~~

-  Prefer verb-based names; Avoid generic, unhelpful verbs, such as
   *Change* or *Manage*.
-  Use singular nouns for commands that apply to a single object,
   otherwise use plural nouns.
-  For pairs of complementary commands, choose clearly complementary
   names. Examples: *Add/Remove*, *Show/Hide*, or *Insert/Delete*.
-  Choose menu item names based on user goals and tasks, not on
   technology.
-  Assign access keys to all menu items (Alt+Letter).

Buttons
~~~~~~~

-  Label command buttons with an imperative verb.
-  Do not use ending punctuation for labels.
-  Describe the action that the button performs in a tooltip.
-  End the label with an ellipsis if the command requires additional
   information to execute.
-  Assign access keys to all buttons (Alt+Letter).

Links
~~~~~

-  Choose a concise, self-explanatory label that clearly communicates
   and differentiates what the command link does.
-  Do not use ellipses.

Tabs
~~~~

-  Label tabs based on their pattern. Use nouns rather than verbs,
   without ending punctuation.
-  Do not assign an access key. Tabs are accessible through their
   shortcut keys (Ctrl+Tab, Ctrl+Shift+Tab).

Checkboxes and Radio buttons
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Label every checkbox or radio button. Do not leave checkboxes or
   radio buttons unlabeled.
-  Assign a unique access key to each label.
-  Labels must start with an active verb clearly defining the state to
   be enabled or disabled.
-  For a group, use parallel phrasing and try to keep the length about
   the same for all labels.
-  For a group, focus the label text on the differences among the
   options.
-  Use affirmative phrases. Do not use negative phrases such as "Don't
   enable wifi". Use rather "Enable wifi".
-  Describe just the option with the label. Keep labels brief so it's
   easy to refer to them in messages and documentation.

Group box
~~~~~~~~~

-  Use group labels to explain the purpose of the group, not how to make
   the selection.
-  End each label with a colon to show a relationship.
-  Do not assign an access key to the label.
-  For a selection of one or more dependent choices, explain the
   requirement on the label.

Using Ellipses in Labels
~~~~~~~~~~~~~~~~~~~~~~~~

-  Use an ellipsis (...) after menu items and button labels which
   require user’s input before completing their action.
-  Do not use an ellipsis if no further user input is required to
   complete the action
-  Do not use an ellipsis for selections which result in actions (such
   as Save or Print Preview) or do not require user input (such as
   configuration dialogs).
-  Do not use an ellipsis for an action which may require confirmation
   before it is completed (such as a Deletion confirmation), but no
   other input.
-  Use an ellipsis for the following menu items and buttons:

   -  Find...
   -  Find and Replace...
   -  Open...
   -  Print...
   -  Replace...
   -  Save As...
   -  Send To...

-  Do not use an ellipsis for the following menu items and buttons:

   -  About
   -  Advanced Options
   -  Check Spelling
   -  Close or Quit
   -  Configure [something]
   -  Delete or Remove
   -  Help
   -  Preferences
   -  Print Preview
   -  Properties
   -  Toolboxes
