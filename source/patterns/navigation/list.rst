List
====

.. container:: intend

   |desktopicon| |mobileicon|


Pattern for a flat content structure.

.. image:: /img/List.png
   :alt: List of items
   :scale: 30%

When to use
-----------

Use a list to present a set of elements which are best presented in a
textual manner (e.g. a list of emails).

-  The list pattern is useful when multiple pieces of content are
   intended to be shown at once.
-  All essential information about each piece of content is visible or
   accessible within the list without changing layout.
-  If list items may be longer than one quarter of the list height,
   consider using an expandable list


How to use it
-------------

-  Sort list items the way they make most sense for the user. For
   example, chronologically or alphabetically
-  If a list is populated from an online source, use the "Pull to
   refresh" feature that allows users to update it simply by pulling it
   down beyond the first (i.e. newest) list item
-  Make the whole area of each list item clickable to select the item
   (unless there is a "Slide to reveal" handle, see next bullet)
-  If you want actions to be available directly on a list item, use the
   :doc:`slide to reveal pattern </patterns/command/slide>`.
-  Add enough free space at the beginning and end of the list to allow
   users to scroll both the first and last item on the list to the
   center of the screen for easy interaction with it.

Implementation
--------------

-  Use a ListView within a Page or ScrollablePage (if the list can
   contain more items than fit on the screen) to implement this pattern
-  Set supportsRefreshing: true on the ScrollablePage to allow "Pull to
   refresh"
