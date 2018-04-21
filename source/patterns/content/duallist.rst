Duallist
========

Purpose
-------

Multiple selection in lists with more than a few items might become
difficult because selected as well as available items are not visible at
once. As an alternative approach the *dual-list pattern* (also known as
list builder, or paired lists) was introduced. It consists of two
standard list boxes with the option to move items from one list to the
other and back. Dual-lists are useful for extended multiple selection in
general, especially for huge sets of items or in case of elaborate
selections. The trade-off is the rather large amount of space that is
needed to show two adjoined lists.

Example
-------

.. image:: /img/TwoLists.png
   :alt: twoLists.png

Guidelines
----------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  Use a dual-list pattern for multiple selection and in case of large
   lists.
-  In case of limited screen real estate consider to change the workflow
   into repeated selections of smaller lists or by applying a hierarchy
   to the data.
-  Do not use a dual list to show data primarily.

Behavior
~~~~~~~~

-  Make the left list the standard list containing all available
   options. The right list holds all currently selected items.
-  Place move/remove buttons (right and left arrows) centered and in
   between the two lists.
-  Disable a button if the respective list is empty.
-  Provide drag ‘n drop of items between lists.
-  Double click on an item adds it to the current list, or removes it
   respectively.
-  Allow multiple selection of items within one list.
-  If an instance of one item can be repeated (such as a spacer), copy
   (rather than move) the item from the available pool of items to the
   list of current items.
-  If the list of current items can be reordered, place up/down buttons
   to the right of the list of current items. Only enable the up/down
   buttons when an item is selected and can be moved. Drag and drop may
   also be used in addition to reorder the list.
-  Do not have blank list items; use meta-options, e.g. (None) instead.
-  Place options that represent general options (e.g. All, None) at the
   beginning of the list.
-  Sort list items in a logical order. Make sure sorting fits
   translation.

Appearance
~~~~~~~~~~

-  Ensure that the list boxes are of equal height and width.
-  Alternate row color (use theme settings).
-  Make both list controls large enough that it can show at least four
   items at a time without scrolling.
-  If the lists appears in a dialog or utility window, consider making
   the window and the lists within it resizeable so that the user can
   choose how many list items are visible at a time without scrolling.
   Each time the user opens this dialog, set its dimensions to those
   that the user last resized it to.
-  Label both lists view with a descriptive caption to the top.
-  Create a buddy relation so access keys are assigned.
-  End each list label with a colon.
-  Use :doc:`sentence style capitalization </style/writing/capitalization>`
   for list view items.
