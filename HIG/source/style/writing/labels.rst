Labels
======

Purpose
-------

Labels clarify technical features of the software. It is therefore of paramount
importance that they be human-readable, comprehensible, and descriptive.

Guidelines
----------

-  Craft labels based on user goals and tasks, not on the underlying technology.
-  Keep labels short; be aware that :doc:`translated <localization>` English
   text can expand up to 50% in some languages.
-  ...But don't shorten your labels to the point of losing meaning. A three-word
   label that provides clear information is better than a one-word label that
   is ambiguous or vague. Try to find the fewest possible words to
   satisfactorily convey the meaning of your label.
-  Use the default systemwide font, size, and styling. Avoid using bold or
   italic text in controls' labels. Nonstandard styling is only ever appropriate
   for title or header text, and even then, must be used sparingly to avoid
   overwhelming the content.
-  When the label is associated with another control, like a line edit,
   be sure to set the the line edit as the
   `buddy <https://doc.qt.io/qt-5/qlabel.html#setBuddy>`_ of
   the label.
-  Avoid *static text*: long instructions or explanations within the user
   interface. Being tempted to add static text is a good sign that the
   software's user interface is too complex and should be simplified.

Labels in Dialogs
~~~~~~~~~~~~~~~~~

-  If a dialog is user-initiated, title it using the command or
   feature name.
-  If it is application- or system-initiated (and therefore out of
   context), title it using the program or feature name to provide
   context.
-  Don't use the title to explain what to do in the dialog. Ideally this should
   be self-explanatory; if it is not, consider simplifying the dialog's user
   interface. If absolutely necessary, instructions should be provided with
   labels in the dialog itself.

Labels in Menus
~~~~~~~~~~~~~~~

-  Begin menu items that perform actions with imperative verbs, followed up with
   a noun if additional clarity is warranted. Examples: *Save*, *Change User*,
   or *Manage Services*.
   Menu items that contain sub-menus may begin with a noun instead, if
   appropriate.
-  Use singular nouns for commands that apply to a single object; otherwise
   use plural nouns.
-  For pairs of complementary commands, choose clearly complementary
   verbs. Examples: *Add/Remove*, *Show/Hide*, or *Insert/Delete*.
-  Don't assign accelerator keys; Qt assigns them automatically based on the
   contents of the whole menu.

Labels on Buttons
~~~~~~~~~~~~~~~~~

-  Begin button labels with an imperative verb. It is appropriate to use a
   single-word label if the context dictates that this is clear enough.
-  Don't use ending punctuation for button labels.
-  Describe the action that the button performs in a tooltip.
-  End the label with an ellipsis if the command requires additional
   user interaction to complete.
-  Manually assign accelerator keys.

Labels for Links
~~~~~~~~~~~~~~~~

-  Choose a concise, self-explanatory label that clearly communicates
   where the command link will take the user when clicked on.
-  Don't use ellipses.
-  Manually assign accelerator keys.

Labels on Tabs
~~~~~~~~~~~~~~

-  Tab labels should be identical to the title of their contents, if any.
   Otherwise, craft an appropriate title using nouns rather than verbs, and
   without any ending punctuation.
-  Don't assign accelerator keys; tabs are already accessible through their
   shortcut keys (Ctrl+Tab & Ctrl+Shift+Tab).

Labels for Checkboxes and Radio buttons
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Label every checkbox or radio button.
-  Assign a unique access key to each label.
-  Start the label with an active verb clearly defining the state to
   be enabled or disabled, and use affirmative phrases rather than use negative
   phrases. For example, "Enable Wifi" is better than "Don't enable Wifi" or
   "Disable Wifi"
-  When there are multiple adjacent related checkboxes or radio buttons, focus
   their label text on the differences between the options, and try to keep the
   labels all roughly the same length.
-  Manually assign accelerator keys.
-  When using a FormLayout-style user interface, give each logical group of
   checkboxes or radio buttons a label to the left of the first one that to
   provide a title or action directive for the group.

.. figure:: /img/dolphin-settings-dialog.png
   :alt: Appropriately-labeled logical groups of radio buttons and checkboxes

   Appropriately-labeled logical groups of radio buttons and checkboxes

Labels for Group boxes
~~~~~~~~~~~~~~~~~~~~~~

-  Use group labels to explain the purpose of the group, ended with a colon to
   show a relationship.
-  Don't assign accelerator keys.

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
