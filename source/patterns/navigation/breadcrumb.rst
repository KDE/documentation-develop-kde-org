Breadcrumbs
===========

.. container:: intend

   |desktopicon| |mobileicon|

Pattern for n-deep content structure.

.. image:: /img/NP-n-deep.png
   :alt: Breadcrumb patterns

The *breadcrumbs* pattern is a navigation aid for hierarchical content
structures (e.g. home > documents > business). It provides information about
the current position within the hierarchy, and offers shortcut links to jump
to previous positions without using the Back button.

When to use
-----------

-  Use a breadcrumb control for orientation and navigation in strictly
   hierarchical content. Apply other controls like tags for flat or less
   organized content.
-  Make sure a breadcrumb control has only supportive functions. Do not use
   it as primary and exclusive navigation pattern.
-  Do not use a breadcrumb control to just identify or label the position;
   it must be interactive.
-  Do not make the breadcrumb control dynamic by showing the user's past
   interactions (known as 'path breadcrumbs'). Breadcrumbs should
   show the hierarchy, not the user's history.

How to use
----------

-  Link all breadcrumb steps to the appropriate page or position. Show the
   current position at the very end of the breadcrumb control.
-  Keep breadcrumbs plain and textual; do not use icons or other controls.
-  Place a breadcrumb control above the content area, but below other
   navigation controls.
-  Do not integrate a breadcrumb control into a toolbar or titlebar.

Implementation
--------------

-  Consider providing a dropdown context menu full of alternative options for
   each breadcrumb item. But always offer one-click access by default.
-  Think of ways to make the breadcrumb control interactive in other creative
   ways. For example, it might permit content to be dragged-and-dropped
   onto a breadcrumb item to quickly move it there.
