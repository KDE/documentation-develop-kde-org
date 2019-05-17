Inline message
==============

.. container:: intend

   |desktopicon| |mobileicon|


Purpose
-------

A *inline message* is a small panel that informs users of a non-critical problem 
or special condition. It is embedded in the content and should not overlap 
content or controls. The panel has four visual style options which can be used 
for neutral messages, success conditions, warnings, and errors. It can also be 
given buttons.

.. figure:: /img/Message5.png
   :alt: Different levels of inline messages.
   :scale: 80%
   
   The four different levels of inline messages.

Examples
--------

.. figure:: /img/Message-example.png
   :alt: 
   
   An inline message is used for feeback after an upload has been completed.

Guidelines
----------

-  Use inline messages in cases of non-critical problems that user can
   solve.

   -  Use *negative feedback* (aka error) as a secondary indicator of
      failure, e.g. if a transaction was not completed successfully
   -  Show the information on a warning level in case of relevant
      information that do not concern the current workflow, e.g. No
      Internet connection available.
   -  Use *positive feedback* to notify about user-initiated processes,
      e.g. to indicate completion of background tasks
   -  Use *opportunistic interaction* (aka notification) to acknowledge
      the user about options that he or she might be interested in, e.g.
      "Remember password?"

-  Display the information immediately.
-  When users dismiss the inline message, do not display any other UI or start
   any other side effect.
-  Do not add controls to the inline message other than action buttons
   for opportunistic interaction.
-  Consider to show a :doc:`notification` if information does not concern
   the current workflow.

Is this the right control? / Behavior
-------------------------------------

Negative feedback
~~~~~~~~~~~~~~~~~

The inline message should be used as a secondary indicator of failure:
the first indicator is for instance that the action the user expected to
happen did not happen.

Example: User fills a form, clicks "Submit".

-  Expected feedback: form closes
-  First indicator of failure: form stays there
-  Second indicator of failure: a inline message appears on top of the
   form, explaining the error condition

When used to provide negative feedback, an inline message should be placed
close to its context. In the case of a form, it should appear on top of
the form entries.

An inline message should get inserted in the existing layout. Space should
not be reserved for it, otherwise it becomes "dead space", ignored by
the user. An inline message should also not appear as an overlay to prevent
blocking access to elements the user needs to interact with to fix the
failure.

When used for negative feedback, do not offer a close button. The
message panel only closes when the problem it informs about (e.g. the
error) is fixed.

Positive feedback
~~~~~~~~~~~~~~~~~

An inline message can be used for positive feedback but it shouldn't be
overused. It is often enough to provide feedback by simply showing the
results of an action.

Examples of acceptable uses:

-  Confirm success of "critical" transactions
-  Indicate completion of background tasks

Example of wrong uses:

-  Indicate successful saving of a file
-  Indicate a file has been successfully removed

Opportunistic interaction
~~~~~~~~~~~~~~~~~~~~~~~~~

Opportunistic interaction is the situation where the application
suggests to the user an action he could be interested in perform, either
based on an action the user just triggered or an event which the
application noticed.

Example use cases:

-  A browser can propose remembering a recently entered password
-  A music collection can propose ripping a CD which just got inserted
-  A chat application may notify the user a "special friend" just
   connected

Appearance
----------

A basic inline messages consists of an icon and text. It can contain an 
optional 
close button and :doc:`buttons <../navigation/pushbutton>`. 

.. figure:: /img/Message1.png
   :alt: Inline message with a custom icon and a close button.
   :scale: 80%
   
   Inline message with a custom icon and a close button.

.. figure:: /img/Message2.png
   :alt: Inline message with two buttons.
   :scale: 80%
   
   Inline message with two buttons.
   
If there is not enough space to display all the buttons, an overflow menu is 
shown instead.

.. figure:: /img/Message3.png
   :alt: Inline message with overflow menu.
   :scale: 80%
   
   Inline message with overflow menu.

Code 
----

Kirigami
~~~~~~~~

 - :kirigamiapi:`Kirigami: InlineMessage <InlineMessage>`

 .. literalinclude:: /../../examples/kirigami/InlineMessage.qml
   :language: qml
   

Qt Widgets
~~~~~~~~~~

 - :kwidgetsaddonsapi:`QtWidgets:  KMessageWidget <KMessageWidget>`
