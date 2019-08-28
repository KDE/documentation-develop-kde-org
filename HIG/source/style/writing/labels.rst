Labels
======

Purpose
-------

Common controls should behave ‘common’ and look like everyday controls.
Therefore, it is much recommended to use standard font. Bold or italic
font should not be applied to control labels.

Guidelines
----------

-  Keep labels short; be aware that :doc:`translated <localization>` English
   text can expand up to 30% in some languages.
-  Don't shorten your labels to the point of losing meaning. A three-word
   label that provides clear information is better than a one-word label that
   is ambiguous or vague. Try to find the fewest possible words to
   satisfactorily convey the meaning of your label.
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
-  Don't use the title to explain what to do in the dialog – that is the
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
-  Don't use ending punctuation for labels.
-  Describe the action that the button performs in a tooltip.
-  End the label with an ellipsis if the command requires additional
   information to execute.
-  Assign access keys to all buttons (Alt+Letter).

Links
~~~~~

-  Choose a concise, self-explanatory label that clearly communicates
   and differentiates what the command link does.
-  Don't use ellipses.

Tabs
~~~~

-  Label tabs based on their pattern. Use nouns rather than verbs,
   without ending punctuation.
-  Don't assign an access key. Tabs are accessible through their
   shortcut keys (Ctrl+Tab, Ctrl+Shift+Tab).

Checkboxes and Radio buttons
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Label every checkbox or radio button. Don't leave checkboxes or
   radio buttons unlabeled.
-  Assign a unique access key to each label.
-  Labels must start with an active verb clearly defining the state to
   be enabled or disabled.
-  For a group, use parallel phrasing and try to keep the length about
   the same for all labels.
-  For a group, focus the label text on the differences among the
   options.
-  Use affirmative phrases. Don't use negative phrases such as "Don't
   enable wifi". Instead, write "Enable Wifi".
-  Describe just the option with the label. Keep labels brief so it is
   easy to refer to them in messages and documentation.

Group boxes
~~~~~~~~~~~

-  Use group labels to explain the purpose of the group, not how to make
   the selection.
-  End each label with a colon to show a relationship.
-  Don't assign an access key to the label.
-  For a selection of one or more dependent choices, explain the
   requirement on the label.

Using Ellipses in Labels
~~~~~~~~~~~~~~~~~~~~~~~~
Ellipses are used to indicate that a button or menu item will perform an action that always requires additional user input before completing. Use an ellipsis at the end of a menu item or button's label only when the following circumstances apply:

   - The menu item or button must perform an action. Actions always begin with a verb, (e.g. "Show", "Configure", "Adjust") and have a definite start and end
   - That action must always require additional user input to complete

Here are examples of menu items and buttons whose labels typically have ellipses:

   -  Find...
   -  Find and Replace...
   -  Open...
   -  Print...
   -  Replace...
   -  Save As...
   -  Send To...
   -  Configure [something]...

Here are examples of menu items and buttons whose labels typically don't have ellipses, along with the reason why:

   -  About — *not an action*
   -  Advanced Options — *not an action*
   -  Close or Quit — *action does not always require additional user input*
   -  Delete or Remove — *action does not always require additional user input*
   -  Help — *not an action*
   -  Print Preview — *not an action*
   -  Properties — *not an action*
   -  Toolboxes — *not an action*
