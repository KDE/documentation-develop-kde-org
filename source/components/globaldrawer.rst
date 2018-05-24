Global drawer
=============

.. figure:: /img/Menu_Drawer.png
   :alt: Examples of different global drawers

   Examples of different global drawers

Purpose
-------

The Global Drawer is a standard element in KDE mobile applications. It
contains an application's main menu, and any functions which are not
part of the application's main usecases but are not specific to the
current context either.

Is this the right control?
--------------------------

Use a Global Drawer whenever your application has any functions which
are not central enough to the application's main purpose to put them in
the main user interface, and which are not dependent on the current
context. For context-specific actions (e.g. those affecting a selected
item), use the :doc:`Context Drawer <contextdrawer>`

Guidelines
----------

The Global Drawer is opened by swiping in from the left or right edge of
the screen (depending on a system-wide setting) and closed by swiping in
the other direction or tapping outside of it.

A Global Drawer may contain the following controls:

-  :doc:`Tabs <tab>`
-  A main menu
-  :doc:`Push Buttons <pushbutton>` to execute non-contextual actions
-  :doc:`Checkboxes <checkbox>` or :doc:`Radio Buttons <radiobutton>` 
   to change settings which are commonly changed

The main menu

-  Must not have more than three levels
-  Should if possible not contain more elements than fit on the screen
-  Should contain an entry :doc:`Settings </patterns/content/settings>` in the last position if the
   application has settings which are not commonly changed
-  Selecting an entry in the menu either executes an action or goes down
   one level, replacing the menu with the items in the selected submenu
-  In lower menu levels, below the entries there is a button to go up
   one level.

Do not use the Menu Drawer for navigation purposes.
