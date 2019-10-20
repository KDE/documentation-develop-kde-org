Accessibility Checklist
=======================

Introduction
------------

This is a list of common things you should check for to have great 
:doc:`accessibility <index>` for your application or widgets.

Keyboard Navigation
-------------------

-  Efficient keyboard access is provided for all application features.
-  All windows have a logical keyboard navigation order.
-  The correct tab order is used for controls whose enabled state is 
   dependent on checkboxes, radio buttons or toggle buttons.
-  Keyboard access to application-specific functions does not override 
   existing system accessibility features.
-  The application provides more than one method to perform keyboard tasks 
   whenever possible.
-  There are alternative keyboard shortcuts wherever possible.
-  Frequently-accessed keyboard shortcuts should be physically easy to access 
   and not require awkwardly bending the wrist or fingers.
-  The application does not require repetitive, simultaneous keypresses.
-  The application provides keyboard equivalents for all mouse functions.
-  The application provides keyboard equivalents for all mouse-based functions, 
   including selecting, moving, and resizing items.
-  The application does not use any general navigation functions to 
   trigger operations.
-  All keyboard-invoked menus, windows, and tooltips appear near the object 
   they relate to.

Testing
^^^^^^^

The following keyboard operations should be tested. Don't use the mouse in any 
part of this test.

-  Using only keyboard commands, move the focus through all menu bars in the 
   application.
-  Confirm that:
   
   -  Context-sensitive menus display correctly.
   -  Any functions listed on the toolbar can be triggered using the keyboard.
   -  Every control in the client area of the application can be focused and 
      activated.
   -  Text and objects within the client area can be selected.
   -  Any keyboard enhancements or shortcuts are working as designed.


Mouse Interaction
-----------------

-  No operations depend on input from the right or middle mouse buttons.
-  All mouse operations can be cancelled before they are complete.
-  Visual feedback is provided throughout drag and drop operations
-  The mouse pointer is never moved by the application, or its 
   movement restricted to part of the screen by the application.

Graphical Elements
------------------

-  There are no hard-coded graphical attributes such as line, border or 
   shadow thickness.
-  All multi-color graphical elements can be shown in monochrome only, 
   where possible.
-  All interactive GUI elements are easily distinguishable from static GUI 
   elements.
-  An option to hide non-essential graphics is provided.

See :doc:`units </layout/units>` for more information on how to use KDE's base 
units to avoid hardcoded size values.

Testing
^^^^^^^

Test the application using a screen reader and confirm that:

-  Labels and text are being read correctly, including menus and toolbars.
-  Object information is read correctly.


Fonts and Text
--------------

-  No font styles or sizes are hard-coded.
-  An option to turn off graphical backdrops behind text is provided.
-  All labels have names that make sense when taken out of context.
-  No label names are used more than once in the same window.
-  Label positioning is consistent throughout the application.
-  All static text labels that identify other controls end in a colon (:).
-  Static text labels that identify other controls immediately precede 
   those controls in the tab order.
-  An alternative to WYSIWYG is provided. For example, the ability to 
   specify different screen and printer fonts in a text editor. 

See :doc:`typography </style/typography>` for more information on how to 
avoid hardcoded font sizes and :doc:`labels </style/writing/labels>` for more 
details about labels.
   
Testing
^^^^^^^

-  Change the font in the application and confirm that the settings are 
   maintained.
-  Test the application by changing colors and confirm that all settings are 
   maintained.
-  If magnification is available, test the font, color, and size using the 
   magnification option.

   
Color and Contrast
------------------

-  Application colors are not hard-coded, but either use colors from 
   current desktop theme or an application setting.
-  Color is only used as an enhancement, and not as the only means to 
   convey information or actions.
-  The application supports all available 
   :doc:`high contrast themes </style/color/high>` and settings.
-  The software is not dependent on any particular 
   :doc:`high contrast themes </style/color/high>` or settings.
   
See :doc:`the HIG's page about color </style/color/index>` and
:doc:`colors in Kirigami <kirigami:style/color>` for more information.
   
Testing
^^^^^^^

-  Print screenshots to a black and white printer and confirm that all 
   information is visible.
-  Test applications using only black and white high-contrast settings and 
   confirm that all information is conveyed correctly.
-  Test that the application provides at least three combinations of color 
   schemes and that high-contrast schemes are available (e.g. white on black or 
   yellow on blue).
-  Turn on high-contrast settings in the System Settings and confirm that 
   the application respects these settings.
-  Test various themes to ensure that the software is working for all the 
   available settings.


Magnification
-------------

-  The application provides the ability to scale or magnify the work area.
-  The application's functionality is not affected by changing the 
   magnification or scale settings. 

Audio
-----

-  Sound is not used as the only means of conveying any items of 
   information.
-  The user can configure the frequency and volume of all sounds and 
   warning beeps.

Testing
^^^^^^^

There should be an option in the application to show audio alerts visually.

Test that the audio is working correctly by enabling sound in the System 
Settings and then perform the following actions:

-  Perform an action that should generate an audio alert and confirm that the 
   application is working as designed.
-  Verify that the application works correctly when increasing or decreasing 
   the volume.
-  Confirm that warning messages and alerts can be heard correctly in a noisy 
   work environment.


Animation
---------

-  There are no flashing or blinking elements with a frequency greater than 
   2Hz or lower than 55Hz.
-  Any flashing or blinking is confined to small areas of the screen.
-  If animation is used, an option is available to turn it off before it is 
   first shown.
   
Testing
^^^^^^^

Verify that an option is available to stop animation and that it is working as 
designed.

Turn the animation off. Confirm that all information is still conveyed 
correctly. 

Keyboard Focus
--------------

-  When a window is opened, focus starts at the most commonly-used control.
-  Current input focus position is clearly displayed at all times.
-  Input focus is shown in exactly one window or view at all times.
-  Appropriate audio or visual feedback is provided when the user attempts 
   to navigate past either end of a group of related objects.
-  The default audio or visual warning signal is played when the user 
   presses an inappropriate key.
-  There is sufficient audio information for the visual focus that the user 
   can figure out what to do next.
-  Set the focus to the actual control. Don't just highlight an area.
-  When using assistive technologies, such as a screen reader or braille 
   device, the current program indicates the position and content of the visual 
   focus indicator.

Testing
^^^^^^^

-  Verify when moving among objects that the visual focus indicator is 
   easy to identify.
-  Keyboard navigation through the software and menus should be clearly visible 
   when the focus moves.
-  Confirm that the screen reader is tracking the visual focus indicator as you 
   navigate using a keyboard.
-  Run a screen magnification program (if available) and verify that the 
   magnifier can track the visual focus indicator as you navigate using the 
   keyboard and mouse.


Timing
------

-  There are no hard-coded time-outs or time-based features in the 
   application.
-  The display or hiding of important information is not triggered solely 
   by movement of the mouse pointer. 

Testing
^^^^^^^

-  Test all messages to confirm that the user is notified before a message 
   times out and is given the option to indicate that more time is needed.
-  Make sure an option has been included to adjust the response time and 
   confirm that it is working as designed.
   
Documentation
-------------

-  All documentation is in an accessible format, with textual alternate 
   descriptions provided for all figures and diagrams.
-  The documentation includes a section that covers all the application's 
   accessibility features. 

Testing
^^^^^^^

Test ASCII text documentation with a screen reader to confirm that it is clear 
and precise and can be read by assistive technologies.

Test HTML applications using a web browser and screen reader to confirm that the 
documentation is accessible to assistive technologies.

Note: There are web accessibility guidelines available at 
`<http://www.w3.org/TR/WAI-WEBCONTENT/>`_.

Confirm the following information is included in the documentation:

-  State if the application does not support the standard keyboard access used 
   by the OS.
-  Identify if there are unique keyboard commands.
-  Identify any unique accessibility features.
-  If an action is documented for the mouse, make sure there is an alternative 
   for using the keyboard.

.. note::

   The content of this page is based on 
   `<https://developer.gnome.org/accessibility-devel-guide/3.32/\
   accessibility-devel-guide.html>`_
