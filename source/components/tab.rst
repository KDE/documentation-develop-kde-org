Tabs
====

Purpose
-------

A *tab control* is a way to present related information on separate
pages. Tabs are used for dynamic window surface to increase the surface,
to manage multiple documents within a single window, or as a view of
exclusive options.

.. image:: /img/Tabs-HIG.png
   :alt: Tabs-HIG.png

Tabs have several advantages. Users can easily access available options
or see which forms have been opened. Because foreground tabs are
visually differentiated from background tabs the user knows what item is
currently in use. Having tabs beyond the screen size may lead to visual
clutter.

General Guidelines
------------------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  Use tabs

   -  for many controls that can be organized within a few categories,
      like extended configuration settings
   -  for a variable number of sections, like browser pages
   -  to manage multiple documents

-  Do not use tabs

   -  for only one page (but do not hide the tab when more pages are
      expected, for example in web browser).
   -  for global application controls.
   -  for sequential steps, like wizards.

Guidelines for desktop user interfaces
--------------------------------------

Behavior
~~~~~~~~

-  Do not abuse other controls to simulate tab behavior.
-  Use horizontal tabs with seven or fewer tabs and all the tabs fit on
   one row.
-  Do not use vertically stacked tabs. Tabs are drawn above the pages
   only (QTabWidget::TabPosition = North).
-  Do not use too many tabs. Use a :doc:`list view <list>` with icons and
   associated pages if there are many pages or if you want to group
   static pages, e.g. in case of configuration content. This also gives
   ability to present hierarchy of pages as a tree.
-  Do not use multiple tab rows. It leads to disorientation.
-  Do not disable a tab when it doesn't apply to the current context;
   disable the controls on the page.
-  Make content from one page independent and differentiated from
   another through the use of tabs.
-  Do not nest tabs.
-  Make tabs movable (possible to reorder), if their pages contain
   documents, but not if their pages contain static application's user
   interface.
-  Make tabs closable, if their pages contain documents, but not if
   their pages contain application's user interface.
-  Make the tabs use scroll buttons, to scroll tabs when there are too
   many tabs.
-  Provide a context menu on each tab if their pages contain documents.
   This menu should only include actions for manipulating the tab
   itself, such as Move Left, Move Right, Move to New Window, Close,
   Close All, Reload.

-  Consider to provide 'add new tab' function if their pages contain
   documents, not for static content. In this case the 'Add Tab' button 
   should be used as a corner widget placed on the right hand of the tab bar.
   Have keyboard shortcuts or menu items for easy access, but do not displayed
   the 'add tab' function in the application toolbar.

Appearance
~~~~~~~~~~

-  Make last used tab persistent. Otherwise, select the first page by
   default.
-  Do not assign effects to changing tabs; tabs must be accessible in
   any order.
-  Only use text in horizontal tabs and not icons.
-  Provide a label with an access key for each tab. Use nouns with
   :doc:`title capitalization </style/writing/capitalization>` to 
   describe the content.
-  Do not expand tabs to use empty space of the widget (see `expanding`_
   property of the Qt tab bar, unfortunately true by default).
-  Avoid long tab names. Use a compelling, easy to understand label.
   Phrases not sentences.
-  Do not use :doc:`abbreviations </style/writing/abbreviation>` 
   (acronyms such as HTML are allowed).
-  Do not use triangular shape of tabs.

Guidelines for phone user interfaces
------------------------------------

.. image:: /img/Tabs_in_drawer.png
   :alt:  Tabs in global drawer

Behavior
~~~~~~~~

-  Do not abuse other controls to simulate tab behavior.
-  Do not nest tabs.
-  When the tabs are used to group controls, put them at the top of the
   screen. Do not use more than three tabs.

   -  Do not disable a tab when it doesn't apply to the current context;
      disable the controls on the page.
   -  Keep interdependent elements in the same tab.

-  When using tabs to open multiple documents (e.g. websites) in the
   same instance of an application, show them as a list at the top of
   the :doc:`global drawer <globaldrawer>`

   -  Offer the user the option to choose between "Use tabs" and "Use
      separate windows", the default of which is specified by the gobal
      setting, if it is set, otherwise the default is new windows
      unless users are used to tabs from existing apps of the same type
      (e.g. for web browsers)
   -  Swiping on a tab away from the screen edge that the menu drawer is
      attached to (e.g. to the right if the drawer is on the left side)
      closes the tab

Appearance
~~~~~~~~~~

-  Use short labels for tabs that group controls
-  Use descriptive names for tabs, e.g. page titles for browser tabs

   -  Put a control to open a new tab below the list of tabs
   
