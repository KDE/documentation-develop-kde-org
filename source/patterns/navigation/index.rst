Navigation Pattern
==================

.. toctree::
   :maxdepth: 1
   :titlesonly:
   :hidden:

   single
   list
   expandable
   grid
   master
   combination
   tab
   unique
   combination-3
   breadcrumb
   column

Navigation Patterns depend on the structure of the application content.
Navigation patterns can be combined with 
:doc:`command patterns </patterns/command/index>` and content
patterns to design the complete layout for your application.

Patterns for desktop user interfaces
------------------------------------

Patterns for a flat content structure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. image:: /img/IS-flat.png
   :alt: Flat structure

When pieces of application content are not grouped, the content
structure is flat.

Examples include a playlist, a slideshow or a list of documents or
contacts.


-  :doc:`Single item <single>`
-  :doc:`List <list>`
-  :doc:`Expandable list <expandable>`
-  :doc:`Grid <grid>`
-  :doc:`Master detail <master>`

Patterns for a 2-deep content structure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. image:: /img/IS-2-deep.png
   :alt: Patterns for a 2-deep content structure

When all application content are grouped into top-level categories, the
content structure is 2-deep.

Examples include picture albums, music albums, email folders or tags.


-  :doc:`Combination patterns <combination>`
-  :doc:`Tabs <tab>`
-  :doc:`Unique 2-deep patterns <unique>`

Patterns for a 3-deep content structure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. image:: /img/IS-3-deep.png
   :alt: Patterns for a 3-deep content structure

When all application content are grouped into categories, which are
themselves be grouped into top-level categories, the content structure
is 3-deep.

.. caution::
   Content structures this deep should generally be avoided.

There are instances, however, where it may be difficult to avoid.
Examples include a full music or video library or system settings.


-  :doc:`Combination patterns <combination-3>`

Patterns for n-deep content structures
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. image:: /img/IS-n-deep.png
   :alt: Patterns for n-deep content structures

When content is infinitely groupable, the content is n-deep.

.. caution::
   Content structures this deep should be avoided. It is very difficult
   for the user to maintain awareness of their location in content
   structure relative to other content.

There are instances, however, where this structure cannot be avoided.
Examples include file systems and archives.


-  :doc:`Breadcrumb <breadcrumb>`
-  :doc:`Column-based navigation <column>`
