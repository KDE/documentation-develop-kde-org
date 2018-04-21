Breadcrumbs
===========

Purpose
-------

The *breadcrumbs* pattern is a navigation aid that helps to keep track
of the location within applications or documents by a) providing
information about the current position within the hierarchy, and b)
offering shortcut links to jump to previous positions without using the
Back button (e.g. home > documents > business). The breadcrumb trail
extends the address bar with (clear) access to subsections. It has the
advantage of distinctness in usage. As a drawback the breadcrumbs
usually needs more space.

Guidelines
----------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  Use a breadcrumb trail for orientation and navigation in strictly
   hierarchical data, :doc:`n-deep content structures </patterns/navigation/breadcrumb>`. 
   Apply other controls like tags for flat or less organized content (e.g. wizards).
-  Make sure the breadcrumbs has only supportive functions. Do not use
   it as primary and exclusive navigation pattern.
-  Do not use a breadcrumbs to just identify or label the position.
-  Do not make the breadcrumb navigation dynamic by adopting the last
   user's interactions (known as 'path breadcrumbs'). Breadcrumbs should
   show the hierarchy, not the user's history.

Behavior
~~~~~~~~

-  Link all breadcrumbs steps to the appropriate page or position
   respectively, except the current.
-  Add the current position to the breadcrumbs.
-  Consider to provide a dropdown list for alternative options on each
   level. But always offer one-click access by default.
-  Consider to make the breadcrumbs interactive via drag and drop, e.g.
   copy/move files by dragging them to a breadcrumb step or to an item
   of the dropdown list, apply a sequence of processing steps, etc.

Appearance
~~~~~~~~~~

-  Keep the breadcrumbs plain; do not use icons or other controls.
-  Place the breadcrumbs above the content control (e.g. file list).

-  Do not place it above the navigation control (e.g. directory
   structure)
-  Do not integrate it into the tool bar
-  Do not place it in an extra tool bar.
-  Do not integrate it into the title bar.
