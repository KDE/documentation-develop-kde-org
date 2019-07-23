Tooltip
=======

Purpose
-------

A tooltip is a small pop-up window that provides more information on
an element under the mouse cursor, such as toolbar controls without
caption or command buttons. Tooltips provide additional descriptive text
including formatting and icons. Tips eliminate the need to always have
descriptive text on the screen. Novice users will use hovering to show
tooltips to become familiar with the interface. This time-delay
mechanism makes tips very convenient, but it also reduces their
discoverability. When tips are used consistently they support user’s
expectation and foster predictability.

Guidelines
----------

Is this the right control?
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Use tips to label unlabeled controls and to provide additional
   information.
-  Don’t use tips for warnings.

Behavior
~~~~~~~~

-  Keep tips brief, typically five words or less for tool-tips. Whenever
   appropriate, provide keyboard short-cuts and default values.
-  Tooltips for a disabled control should include information regarding
   the disabled state of the control. Include this information even if
   the control is enabled. For instance: 'Go to the next unread message'
   in the case of enabled controls and 'Go to the next unread message
   (No unread messages left)' when disabled.
-  Consider adding small informational buttons for touch screen use.

Appearance
~~~~~~~~~~

-  Format and organize content in tooltips to make it easier to read and
   scan. The information should be:

   -  concise: large, unformatted blocks of text are difficult to read
      and overwhelming
   -  helpful: it should add information, not repeat information
   -  supplemental: important information should be communicated using
      self-explanatory control labels or in-place supplemental text
   -  static: tips should not change from one instance to the next

-  Don't use icons and formattings for tips of unlabeled controls.
-  Use tool-tips with icons and formatting

   -  if tips describe comprehensive functions,
   -  when content is lengthy and formatting improves readability
   -  for tips that are implemented primarily for joy of use.

Code
----

Kirigami
~~~~~~~~

 - :kirigamiapi:`Kirigami: ApplicationWindow <ApplicationWindow>`
 - `QML: MenuBar <https://doc.qt.io/qt-5/qml-qtquick-controls-menubar.html>`_

Plasma components
~~~~~~~~~~~~~~~~~

 - :plasmaapi:`Plasma ToolTip <ToolTip>`
