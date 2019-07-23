Get New Stuff
=============

Get New Stuff (GNS) is an integrated data service which allows users to share 
and download themes, templates, wallpapers, and more through a single click of a 
button in the application. 

Examples
--------

.. figure:: /img/Systemsettings-LookAndFeel.png
   :scale: 40%
   
   Get New Stuff button in "Choose the Look and Feel theme" KCM

Guidelines
----------

Is this the right control?
~~~~~~~~~~~~~~~~~~~~~~~~~~

If the user can install additional content to customize the behavior or appearance of the software
(e.g. plugins, themes, scripts, etc.), use the GNS system and add a "Get New <Thing>" button. Consider 
adding a companion button to allow installation of additional content from the filesystem.

Appearance
~~~~~~~~~~

The text of a GNS button should be made of these parts:

-  Use the get-hot-new-stuff.png icon
   
   .. image:: /img/get-hot-new-stuff.svg
      :width: 32
      :height: 32

-  Label the button with "Get New" and the type of content the user will 
   download
-  Add an :doc:`ellipsis to the label </style/writing/labels>`, to indicate the 
   user must provide additional input to complete the task.

The button should always be placed on the bottom right of the list or grid that 
can be ammended. If you want a button to install from the local file system, 
place it to the left og the GNS button.

.. figure:: /img/Systemsettings-PlasmaTheme.png
   :scale: 40%
   
   Button placement at the bottom of the content grid
