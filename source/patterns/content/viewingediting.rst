Viewing vs editing 
==================

In most cases, information should be presented by default for viewing,
not editing. Presenting input controls to the user when they are not needed
creates unnecessary clutter and distraction, interfering with effective
presentation of the information.

When to use
-----------

Only show editing controls when appropriate. Examples include:

-  When an item is selected, contextually-appropriate editing controls can be
   shown in a toolbar or panel.
-  If an explicit editing mode is appropriate, then editing controls should
   not be shown until that mode is activated.

How to use
----------

.. image:: /img/ViewMode.png
   :alt: Viewing

-  Do not use input controls to show information unless there is an
   explicit request to edit the information.
-  Follow the typography, alignment, and spacing guidelines to layout
   information in a way that is easy to understand.
-  Provide a clear visual hierarchy (where to look first, where to look
   next). The example above uses a large contact photo to anchor the
   layout and the contact name is set in large type to direct the users
   eye to next piece of information.
-  Provide a separate mode for editing the data when requested by the
   user (via a button, toolbutton or menu item):

.. image:: /img/EditMode.png
   :alt: Editing

-  Alternatively, in-line editing can be provided to edit a single data
   element at a time when it is clicked on or selected:

.. image:: /img/PartialEditMode.png
   :alt: Line-in editing

Implementation
--------------
