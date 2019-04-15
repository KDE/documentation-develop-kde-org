Metrics and placement
=====================

Purpose
-------

All controls have a default *height and width* to establish a harmonic
overall picture. Nevertheless, size is used to direct users' attention.
For instance, a list that captures most of screen’s space points to its
central role in the current work flow. And, size can be used to indicate
possible interactions. Smaller edits are probably constrained, for
instance.

Similar to size, the *space* between controls generates a visual
impression and supports layout. Space between controls indicates their
relatedness. Objects with smaller distances are mentally associated
according to the Gestalt theory. *Whitespace* is an important element of
design which enables the objects in it to exist at all. The balance
between content and whitespace is key to *grouping*.

Please read :doc:`units` for more information which and how
different units such as px, dpi independent pixels, smallSpacing and
largeSpacing are used.

Guidelines
----------

Size
~~~~

-  If the control appears in a dialog or utility window, consider making
   the window and the control within it resizeable so that the user can
   choose how many items are visible at a time without scrolling. Each
   time the user opens this dialog, set its dimensions to those that the
   user last resized it to.
-  Size controls with a minimum of
   - Icon:16x16px
   - Buttons: 72 x 32px
   - Line edits, Drop-downs, Combo boxes ≥80 x 32 px
   - Text edits: ≥80 x ≥36 px (text should not exceed 80 characters per
      line)
   -  Checkbox, Radio button including label: ≥80 x 24 px
   -  Group boxes: ≥120 x ≥96 px
   -  Tree view: ≥120 x ≥96 px
   -  List view: ≥80 px (per column) x ≥96

-  KDE seeks to support XGA (1024x768px) or WXGA (1280x768px) at least.

   -  Keep in mind that not everyone is provided with a high resolution
      display.
   -  Avoid to have a large number of controls visible at once, which in
      turn requires a huge minimal size.
   -  Keep in mind that the available screen area typically also will be
      shrunk by panels and the window titlebar. Also, user's font might
      be bigger than yours (e.g. for accessibility reason).
   -  You therefore should ideally preserve ~10% to catch those
      variables and try to not exceed 920x690px.

Space
~~~~~

Qt widgets
^^^^^^^^^^

If you are using Qt widgets you should use one of 
`Qt's Layout Classes <http://doc.qt.io/qt-5/layout.html>`_, 
which will take care of laying out and spacing of your controls.

QML
^^^

For consistency you should try to use Kirigami and Plasma's 
smallSpacing and largeSpacing for margins and paddings whenever possible. 
See :doc:`units` for more details.

Use multiples of smallSpacing or largeSpacing, where more spacing is required.

.. figure:: /img/Margin.qml.png
   :alt: Use of base units
   
   Use of base units

Recommended minimum paddings
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  A smallSpacing padding is the minimum recommended padding inside 
   elements (buttons, drop boxes, text fields, etc.)
-  An 2 * smallSpacing padding is the minimum recommended padding 
   inside grouping frames (group boxes, tabs, etc.)
-  Use default spacing of

   -  related items within groups: 2 * smallSpacing
   -  label and item: smallSpacing
   -  related controls with same type (checkboxes / radio buttons): smallSpacing
   -  related controls with different type (checkbox / button): smallSpacing
   -  unrelated controls: ≥ 3 * smallSpacing

.. figure:: /img/SpacingPadding.qml.png
   :alt: Sample spacing
   
   Sample spacing
   
-  In some cases it may be useful to visually separate groups of related
   options within one group to facilitate scanning of the dialog. In
   that case, put a vertical, fixed-size spacer of 18px height between
   the options.

.. figure:: /img/SpacingSeperate.qml.png
   :alt: Separating groups of related options with a vertical spacer.

   Separating groups of related options with a vertical spacer.

   
.. hint::
   |designicon| It often helps to use a soft grid of 18px (gridUnit), when creating
   mockups. But only use this as a visual hint, since plasma components and icon
   size are not multiples of the gridUnit, you won't be able to align everything to the
   grid.

Resize
~~~~~~

-  Provide resizing for all primary and mode-less windows.
-  If form resizing is not provided disable border icons and adjust form style.
-  Define a minimum size for resizable forms.
-  Make the content area scrollable if size is too small for all controls; 
   do not scale controls.

.. figure:: /img/Resize.qml.png
   :alt: Give hints how to resize
   
   Give hints how to resize
