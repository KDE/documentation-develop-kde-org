List View
=========

Purpose
-------

A *list view* offers orientation, organization, and allows navigation
without the need for more controls. Additionally, a list view may be
used for single selection (users select one item from a list of mutually
exclusive values) or multiple selections (selections in combination with
the Shift key or Control key). However, because there is no common
visual clue whether a list box’ mode is single or multiple and since
other controls are more efficient for single selection, a list box
should be used for single selection only.

.. image:: /img/ListView.png
   :alt: ListView.png

Guidelines
----------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  Prefer a list view to show items that belong together and in case
   there is enough space.
-  Use the list view for selection when it is easy for users to know
   which items are selected at any given time, for one or more of these
   reasons:

   -  There are no more than twice the number of options then are
      visible at a time
   -  The options are well-known and familiar (for example months of a
      year or days of a week)
   -  Usually the selected options are close to each other in the list

-  Do *not* provide extended multiple selections with Shift+Click or
   Ctrl+Click to select groups of contiguous or non-adjacent values,
   respectively. Instead, use the :doc:`dual-list pattern <duallist>` if multiple items
   have to be selected, because it allows users to easily see which
   items are selected at any point, without having to scroll through the
   available options, and it can be used with only the mouse. (Once the
   list view is being revised this guideline is subject of change.)

Behavior
~~~~~~~~

-  Do not have blank list items; use meta-options, e.g. (None) instead.
-  Place options that represent general options (e.g. All, None) at the
   beginning of the list.
-  Sort list items in a logical order. Make sure sorting fits
   translation.
-  For lists with more than one column, use headers and allow sorting.
   Show these controls in the header.

Appearance
~~~~~~~~~~

-  Alternate row color (use theme settings). Use different keys (e.g.
   page up/down) when more lists should be accessible.
-  Show at least four list view items at any time without the need for
   scrolling.
-  Make windows and the list within a dialog or utility window
   resizeable so that users can choose how many list items are visible
   at a time without scrolling. Make these windows remember last used
   dimensions.
-  If selections affect the appearance or control states, place these
   controls next to the list view.
-  Disable controls in a dialog if not in use rather than hide, or
   remove them from the list (i.e. they are dependent controls),
-  Label the list view with a descriptive caption to the top left (cf.
   :doc:`alignment </layout/alignment>`).
-  Create a buddy relation so access keys are assigned.
-  End each label with a colon. ":"
-  Use :doc:`sentence style capitalization </style/writing/capitalization>`
   for list view items.
