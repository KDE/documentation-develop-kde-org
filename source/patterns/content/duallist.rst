Dual-list
=========

.. image:: /img/TwoLists.png
   :alt: twoLists.png

Multiple selection in lists with more than a few items might become
difficult because selected as well as available items are not visible at
once. As an alternative approach, the *dual-list pattern* (also known as
list builder, or paired lists) was introduced. It consists of two
standard list boxes with the option to move items from one list to the
other and back. Dual-lists are useful for extended multiple selection in
general, especially for huge sets of items or in case of elaborate
selections. The trade-off is the rather large amount of space that is
needed to show two adjoining lists.

When to use
-----------

-  Use a dual-list pattern for multiple selection and in case of large
   lists.
-  In case of limited screen real estate, consider changing the workflow
   into repeated selections of smaller lists or by applying a hierarchy
   to the data.
-  Do not use a dual-list to show data primarily.

How to use
----------

-  Label both lists view with a descriptive caption to the top. End each list
   label with a colon.
-  Use the left list  to contain all available options. The right list
   should hold all currently active or in use items.
-  Ensure that the list boxes are of equal height and width.
-  Place move/remove buttons (right and left arrows) centered and in
   between the two lists. Disable a button if the list it is pointing away
   from is empty.
-  If an instance of one item can be repeated (such as a spacer), copy
   (rather than move) the item from the available pool of items to the
   list of current items.
-  If the list of current items can be reordered, place up/down buttons
   to the right of the list of current items. Only enable the up/down
   buttons when an item is selected and can be moved.
-  Do not have blank list items; use meta-options, (e.g. "None") instead.
-  Place options that represent general options (e.g. "All", "None") at the
   beginning of the list.
-  Sort list items in a logical order. Alphabetical sorting should be able
   to change when the text is translated.

Implementation
--------------

-  Allow the user to drag-and-drop items between lists, or re-order items
   within a list (if applicable)
-  Double clicking on an item should add it to or remove it from the current
   list, respectively.
-  Allow multiple selection of items within one list.
-  Make both list controls large enough that it can show at least four
   items at a time without scrolling.
-  If the lists appears in a dialog or utility window, consider making
   the window and the lists within it resizeable so that the user can
   choose how many list items are visible at a time without scrolling.
   Each time the user opens this dialog, set its dimensions to those
   that the user last resized it to.
-  Create a buddy relation so access keys are assigned.
-  Use :doc:`sentence style capitalization </style/writing/capitalization>`
   for list view items.
