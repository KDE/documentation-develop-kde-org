Menu bar
========

Purpose
-------

A *menu bar* appears at the top of the main window of applications with
a :doc:`very complex command structure <complexcommand>`. It provides access to all commands
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
   :doc:`very complex command structure <complexcommand>`
-  Do not display a menu bar in secondary or internal windows.

Behavior
~~~~~~~~

-  Do not have more than nine menu categories within a menu bar. Too
   many categories are overwhelming and make the menu bar difficult to
   use.
-  Do not put more than 12 items within a single level of a menu. Add
   separators between logical groups within a menu. Organize the menu
   items into groups of seven or fewer strongly related items.
-  Use these standard menu categories if they apply to your application:
   File, Edit, View, Insert, Format, Tools, Settings, Window, Help.
-  If an application does not have options under one of the standard
   menu items, do not include it in the menu. At the minimum, all
   windows should have a File (or File equivalent, such as in the case
   if Konqueror and Amarok) and Help menu.
-  Do not hide the menu bar by default. If configurable, users should
   easily be able to make the menu bar viewable again.
-  Do not change labels of menu item dynamically.

Appearance
~~~~~~~~~~

-  Choose single word names for menu categories. Using multiple words
   makes the separation between categories confusing.
-  Disable menu items that don't apply to the current context, instead
   of removing them.
-  Assign :doc:`shortcut keys <shortcuts>` to the most frequently used menu items
   (Ctrl+). For well-known shortcut keys, use standard assignments. Use
   function keys for commands that have a small-scale effect (F2 =
   Rename) and ctrl key for large-scale effect (Ctrl+S = Save).
-  Indicate a function that needs additional information (including a
   confirmation) by adding an ellipsis at the end of the label (e.g.
   Save as…).
-  Provide menu item icons for the most commonly used menu items.
-  Turning on an item in the menu should always enable the option.
   Negative options create a double negative which can be confusing. For
   example, use 'Show hidden files' instead of 'Hide hidden files'.
-  Do not use compound words (e.g. ToolOptions), and hyphens (e.g. Tool-Options)
   in label names; they make words harder to read and recognize.
