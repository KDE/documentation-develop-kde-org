Context menu
============

Purpose
-------

A *context menu* is a list of functions or options (respectively menu
items) available to users in the current context. A submenu or cascading
menu is a secondary menu displayed on demand from within a menu.

Menus are normally hidden from view (except :doc:`menu bars <menubar>`) and drop down
when users right-click an object or window region that supports a
context menu. They are an efficient means of conserving screen space,
therefore.

Examples
--------

Guidelines
----------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  Provide a context menu for inherent functions. For instance,
   functions that have only keyboard access like 'Copy' and 'Paste' for
   textual controls, or standard functions like 'Forward' and 'Backward
   in case of navigation.
-  Use context menus for well known functions only.
-  Do not use context menus as the only way to start a function. Always
   have a redundant access.

Behavior
~~~~~~~~

-  Do not put more than 10 items within a single level of a menu. Add
   separators between logical groups within a menu. Organize the menu
   items into groups of seven or fewer strongly related items.
-  If appropriate, use an access button to make contextual menu
   functionality easier to access.
-  Place the most frequently used items at the top of the menu.
-  Avoid combining actions and attributes in the same group.
-  Use submenus cautiously. Submenus add complexity to the interface and
   are physically more difficult to use, so you should take care not to
   overuse them.
-  Do not change labels of menu item dynamically.

Appearance
~~~~~~~~~~

-  Choose single word names for menu categories. Using multiple words
   makes the separation between categories confusing.
-  Disable menu items that don't apply to the current context, instead
   of removing them.
-  Hide menu items completely if they are permanently unavailable on the
   user's system (e.g. due to missing hardware capabilities or missing
   optional dependencies).
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
-  Do not use compound words (e.g. ToolOptions), and hyphens (e.g.
   Tool-Options) in label names; they make words harder to read and
   recognize.
-  Prefer verb-based menu names; Avoid generic, unhelpful verbs, such as
   'Change' and 'Manage'.
-  Use singular nouns for commands that apply to a single object,
   otherwise use plural no
