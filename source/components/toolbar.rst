Tool bar
========

Purpose
-------

A *tool bar* is a graphical presentation of commands optimized for fast
access. Typically, a toolbar contains buttons that correspond to items
in an application's menu, providing direct access to application's most
frequently used functions.

A good menu bar is a comprehensive catalog of all the available
top-level commands, whereas a good tool bar gives quick, convenient
access to frequently used commands.

Guidelines
----------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  For standard applications, apply a tool bar by default.
-  Provide a tool bar in addition to the menu bar, but do not replace
   the menu bar.

Behavior
~~~~~~~~

-  A tool bar should contain only a few, frequently used operations. If
   the number of operations is above 5 they have to be grouped with
   separators. Not more than 3 of those sections should be implemented.
-  Do not abuse the tool bar to expose application's features. Only the
   most frequently functions should be add to the tool bar.
-  Execute operations immediately; do not require additional input from
   user.
-  Do not use :doc:`menu buttons <pushbutton>` in tool bars. 
   They do not fit well the concept of fast access.
-  Try to avoid using :doc:`split buttons <pushbutton>` 
   or :doc:`toggle buttons <togglebutton>` in order to
   keep the interaction with all buttons in the tool bar consistent.
-  Do not hide tool bars by default. If configurable, users should
   easily be able to make the tool bar viewable again.
-  Disable buttons that do not apply to the current context.
-  Consider to provide customization for tool bars in respect to
   position and content.

Appearance
~~~~~~~~~~

-  Do not change the button style (QToolbar::toolButtonStyle) from the
   default. The default is currently text beside icons.
-  Use and design tool bar icons with special care. Users remember
   location of an object but rely as well on icon properties.
-  A distinct association between the underlying function and its visual
   depiction is crucial. Follow the advices for :doc:`icon design </style/icon>`.
-  Do not simulate Microsoft's ribbon controls. KDE stays plain and
   simple.Microsoft's ribbon controls. KDE stays plain and simple.
