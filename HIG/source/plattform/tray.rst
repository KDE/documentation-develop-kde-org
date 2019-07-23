System Tray Icon
================

The system tray provides quick access to functionality integrated into the 
workspace that’s both highly visible to the user and frequently changed, like 
enabling/disabling WiFi and Bluetooth, or whether or not to show notifications.
See :doc:`architecture </introduction/architecture>` for an overview of plasma 
workspace components.

Examples
--------

.. figure:: /img/TrayWithPanel.png
   :alt: 
   
   Tray icons with an open volume control panel.

Guidelines
----------

Is this the right control?
~~~~~~~~~~~~~~~~~~~~~~~~~~

An application should only add an icon to the System Tray if the 
user needs to frequently access the application, or if the user is intrested in 
status changes within the application.

Behavior
~~~~~~~~

-  On left click, open the application itself, or a panel that allows quick 
   access to common features.
-  On right click, open a 
   :doc:`context menu </components/navigation/contextmenu>`.
-  For application like media players, enable the user to change the volume 
   while scrolling over the icon.


Appearance
~~~~~~~~~~

Use a :doc:`monochrome, Shade Black, icon </style/icon>` and use color only to 
communicate state.
