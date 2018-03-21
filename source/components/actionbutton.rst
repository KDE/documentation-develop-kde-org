Primary Action Button
=====================

.. image:: /img/Action_Buttons.png
   :alt:  Primary Action Button


When to use
-----------

Use a Primary Action Button whenever there is a primary action for a
certain page of your application or for the whole application, which is
executed frequently. Typical primary actions are "Create New", "Edit,",
"Save" or "Send".

The Primary Action Button also serves as an additional handle to open
the :doc:`Drawers </patterns/drawer>`.

If there is no primary action, you may opt to use the Primary Action
Button as a shortcut to navigate back to the application's main page
instead of omitting it completely. Do that if

-  navigating back to the main page is a frequent action in your
   application
-  or you use Primary Action buttons on some pages and would like to
   keep the layout consistent across pages
-  or drawers are frequently used
-  and the space occupied by the button is not urgently needed for the
   content

If the primary action is clearly associated with a specific element on
the user interface, place controls within the content instead.

How to use
----------

-  Provide a clear icon for the Primary Action Button since it has no
   text label
-  If the Primary Action Button changes its action within a page (for
   example switching to "save" when editing, change its icon as well
-  If you use the Primary Action Button as a shortcut for going to the
   main page, use the "go-home" icon from the actions category for it.

Desktop-specific
~~~~~~~~~~~~~~~~

If your application is using :doc:`Column-based navigation </patterns/columns>`

-  If there is a global Primary Action, associate it with the first
   column
-  If there is a Primary action for the context of a specific column,
   associated with the respective page
