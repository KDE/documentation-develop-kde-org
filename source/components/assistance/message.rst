Message
=======

Purpose
-------

If the processing has reached an unexpected condition that needs
interaction, a disruptive message alerts the user of a problem. Not any
disruptive message concerns a serious problem. Sometimes, the user is
just notified that proceeding is dangerous. A typical example is the
“Save changes before closing?” alert box that appears when a user tries
to close a module with modified content. The adequate presentation
method for disruptive information is a *modal message dialog*.

A modal dialog is a secondary window that interrupts user's current
activity and blocks interaction until user either simply acknowledge the
information by clicking Ok or decides how to proceed (e.g. Yes/No).
Effective error messages inform users that a problem occurred, explain
why it happened, and provide a solution so users can fix the problem.
Users should either perform an action or change their behavior as the
result of an error message.

Modal dialogs are error-prone. An alert dialog that appears unexpectedly
or which is dismissed automatically (because the user has developed a
habit) will not protect from the dangerous action.

Examples
--------

Guidelines
----------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  Avoid disruptive messages; workflow maintenance and, therefore, the
   prevention of errors should be the primary objective.
-  Use modal dialogs only for critical or infrequent, one-off tasks that
   require completion before continuing. Don’t use modal error message
   dialogs at the normal work flow to inform or warn the user.
-  Use an :doc:`inline message  <inline>` for non-critical messages which do not require
   any further user interaction (typically dialogs with a single "OK" or
   "Close" button).
-  Create specific, actionable, user-centered error messages. Users
   should either perform an action or change their behavior as the
   result of the message.
-  Provide only a short error message and complement it by a Details
   button that provides more a detailed explanation in the same error
   dialog.
-  Follow the guidelines of :doc:`dialogs <../navigation/dialog>` in general.

Behavior
~~~~~~~~

Messages should be:

-  Informative and constructive:

   -  Tell the user the reason for a problem and
   -  help on how to solve the problem.

-  Understandable:

   -  Phrase your messages clearly, in non-technical terms and avoid
      obscure error codes.

-  Readable:

   -  User has to be able to read the message in his/her own pace, think
      about it, understand it.
   -  It is not acceptable to add countdown timers (visible or not) or
      to force user to read and understand the message within a few
      seconds.

-  Specific instead of general:

   -  If the message is reporting a problem concerning a specific object
      or application, use the object or application name when referring
      to it.

-  Polite, non-terrifying and non-blaming:

   -  Avoid wording that terrifies the user ("fatal", "illegal"), blames
      him for his behavior, and be polite.

Appearance
~~~~~~~~~~

-  Apply confirmation button labels when no further input is required:

   -  To close a warning or error message that does not require further
      user interaction, provide a Close button. Do not use an OK button.
      Users may get confused if they are asked to confirm an error.

-  Apply confirmation button labels when further interaction is
   required:

   -  Use buttons which match the type of statement or question made in
      the warning or error message. For example, do no ask a Yes/No
      question but then provide OK/Cancel buttons.

-  Apply confirmation button labels when the user must choose between
   two actions to continue:

   -  Use descriptive button labels instead of standard Yes/No or
      OK/Cancel buttons. For example, if the user must choose to
      continue or stop an action, provide the buttons "Continue" and
      "Cancel".
