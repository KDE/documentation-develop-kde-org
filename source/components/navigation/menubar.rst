Menu bar
========

Purpose
-------

A *menu bar* appears at the top of the main window of applications with
a :doc:`very complex command structure </patterns/command/index>`. It provides access to all commands
and most of the settings available in an application. It contains of a
list of functions or options (respectively menu items), submenus or
cascading menus that is a secondary menu displayed on demand from within
a menu, and separators to organize the content for easy recognition.

Users refer frequently to the menu bar, especially when they are seeking
a function for which they know of no other interface. Ensuring that
menus are well organized, are worded clearly, and behave correctly is
crucial to the user’s ability to explore and access the functionality of
the application.

Examples
--------

Guidelines
----------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  Provide a menu bar in the main window of applications with a
   :doc:`very complex command structure </patterns/command/index>`
-  Do not display a menu bar in secondary or internal windows.

Behavior
~~~~~~~~

-  Do not have more than nine menu categories within a menu bar. Too
   many categories are overwhelming and makes the menu bar difficult to
   use.
-  Do not put more than 12 items within a single level of a menu. Add
   separators between logical groups within a menu. Organize the menu
   items into groups of seven or fewer strongly related items.
-  Use these standard menu categories if they apply to your application:
   File, Edit, View, Insert, Format, Tools, Settings, Window, Help.
-  If an application would not have any items options under one of the standard
   menu categories, do not include that category in the menu. At the minimum,
   all windows should have a File (or File equivalent, such as in the case
   if Konqueror and Amarok) and Help menu.
-  Assign shortcut keys to the most frequently used menu
   items. Use `KStandardAction <https://api.kde.org/frameworks/kconfigwidgets/html/namespaceKStandardAction.html>`_
   and `KStandardShortcut <https://api.kde.org/frameworks/kconfig/html/namespaceKStandardShortcut.html>`_ items for common functions, which will
   result in menu items automatically receiving consistent names, icons, and
   shortcut keys.
-  Any tool or function that is accessible using a keyboard shortcut must have
   an item in the menu bar so that people can discover the shortcut.
-  Do not hide the menu bar by default. If this is configurable, users should
   easily be able to make the menu bar viewable again.

Appearance
~~~~~~~~~~
-  Follow the general :doc:`label-writing guidelines </style/writing/labels>`
   for menu item labels.
-  Choose single word names for menu categories. Using multiple words
   makes the separation between categories confusing.
-  Disable menu items that don't apply to the current context instead of
   removing them.
-  For menu items that toggle some state on or off, always use the positive form 
   and do not change the text. For example, use the text 'Show hidden files'
   instead of 'Hide hidden files', and do not change the text when hidden files
   are shown.
-  Do not change menu items' labels dynamically.
-  Do not use compound words (e.g. ToolOptions) or hyphens (e.g. Tool-Options)
   in label names; they make words harder to read and recognize.
-  Provide icons wherever possible, but do not re-use the same icon for multiple
   menu items.
