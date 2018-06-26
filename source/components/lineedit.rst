Line edit
=========

.. figure:: /img/Lineedit1.png
   :alt:  Lineedit
   :figclass: border
   
   Single line control to enter unconstrained text.


Purpose
-------

The *line edit* control displays a single line of text to the user and
allow the user to enter unconstrained text. If more than one line is
required a text edit is the right control. Because line edits are
unconstrained and don’t accept valid data only, input validation and
problem handling should be handled carefully.

Examples
--------

Guidelines
----------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  Use edits for input of single lines of unconstrained text.
-  In case of multiple lines of text or more than a few words, use a
   :doc:`text edit <textedit>`
-  Do not use a line edit if only a specific type of data is valid. Use
   a control for constrained input.

Behavior
~~~~~~~~

-  Mask letters if edit is used to enter passwords.

   -  When setting a new password, have it entered twice to prevent
      typos in passwords.
   -  Provide a "Show password" check box to unmask the password both
      when setting new and when entering existing passwords.

-  Consider to use auto-complete feature to help users when entering
   data that is likely to be used repeatedly.
-  If the user enters a character that is known to be invalid, ignore
   the character and display an input problem hint that explains the
   valid characters (e.g. numbers vs. characters).
-  If the input data has a value or format that is known to be invalid,
   display an input problem hint when the text box loses input focus
   (e.g. wrong zip code format).
-  If the input data is inconsistent with other controls on the window,
   give an error message when the entire input is complete, such as when
   users click OK for a modal dialog box.
-  Don't clear invalid input data unless users aren't able to correct
   errors easily. Doing so allows users to correct mistakes without
   starting over.

Appearance
~~~~~~~~~~

-  When disabling the line edit, also disable any associated labels and
   buttons.
-  Label every line edit with a descriptive caption to the left (cf.
   :doc:`/layout/alignment`).
-  Create a buddy relation so access keys are assigned.
