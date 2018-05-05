Tree view
=========

Purpose
-------

Tree view allows users to view and interact with objects arranged in
hierarchical mode. Users can make single selections or multiple
selections. Objects containing data are called *leaf nodes* and objects
contianing sub-objects are called *container nodes*. The top-most
container node is called the *root node*.

.. image:: /img/TreeView.png
   :alt: TreeView.png

A tree view is an appropriate control for items that have a single,
natural, hierarchical categorization that's familiar to most users with
more than two levels (not including the root node). But having
hierarchical data doesn't mean a tree view must be used. Very often a
list view or a combination of list view and drop-down list is a simpler
and a more powerful choice. Tree views can present a challenge for users
when the level of complexity is not visually understood and users may
take longer to familiarize themselves with the tree and each item's
location. This can to confusion. Designers and developers must balance
the user's ability to easily discover contact with a predictable tree
view model that minimizes confusion.

Guidelines
----------

Ask yourself "Is this the right control?"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Apply a tree view to large data sets that can be categorized into two
   or more levels.
-  A tree view should not have more than four sub-levels (not including
   the root node). The most commonly accessed objects should appear in
   the first two levels.
-  Use a natural hierarchical structure that is familiar to most users.
   Balance discoverability with a predictable user model that minimizes
   confusion.
-  Consider breaking down the hierarchical data. For example, into a
   selection by a :doc:`drop-down list <dropdown>` with an associated 
   :doc:`list view <list>`.

Behavior
~~~~~~~~

-  Use double click to unfold items from the first item in the tree view
   list. Make double-click behavior redundant via button or context
   menu.
-  Use directional arrows to provide key-based navigation. Also enable
   the use of Home, End, Page Up, and Page Down.
-  Provide a context menu with relevant commands.
-  Provide a root node only if users need the ability to perform
   commands on the entire tree.
-  Users should always be able to expand and collapse container nodes by
   clicking expander buttons.
-  Use headers with a meaningful caption for each column.
-  Avoid using empty trees.
-  If the tree has alternative access methods such as a word search or
   an index, optimize the tree for browsing by focusing on the most
   useful content.

   Multi selection:

-  Use check boxes to indicate multiple selections.
-  For check boxes, use the mixed state to indicate that an option is
   set for some, but not all, child objects. Users should not be able to
   set a mixed state directly (cf. :doc:`check boxes <checkbox>`).
-  Clicking a mixed state check box selects all child objects and the
   parent check box.
-  Don’t use check boxes in single selection trees.

Appearance
~~~~~~~~~~

-  If high-level containers have similar contents, but have different
   purposes, consider using visual clues, e.g. icons to differentiate
   between them.
-  Use persistent tree view states so that users find the list the same
   way they left it.
-  Make controls large enough that it can show at least eight list items
   at a time without scrolling.
-  Label the tree view with a descriptive caption to the top left (cf.
   :doc:`alignment </layout/alignment>`).
-  Create a buddy relation so access keys are assigned.
-  Make use of punctuation (Except for dot "." or colon ":") for a
   caption.
-  Use :doc:`sentence style capitalization </style/writing/capitalization>`
   for tree view items.
