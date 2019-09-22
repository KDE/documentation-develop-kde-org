Color
=====

.. toctree::
   :caption: Contents:
   :titlesonly:
   :hidden:

   default
   dark
   light
   high

   
Purpose
-------

Color is a distinguishing quality of human perception. Color can be used
to communicate and draw attention efficiently. Color can assign
significance to an object. However, color is a historical and cultural
phenomenon and is subject to continuous aesthetical changes. It should
also be noted that a large part of the population cannot perceive color
in the same way that most people will.

A consistent color set helps create a familiar visual language
throughout the user interface.

.. container:: flex

   .. container::

      .. figure:: /img/Systemsettings.png
         :alt: System settings with Breeze color theme
         :scale: 30%

         System settings with Breeze color theme
         
   .. container::

      .. figure:: /img/Systemsettings-dark.png
         :alt: System settings with Breeze Dark color theme
         :scale: 30%

         System settings with Breeze Dark color theme
         
Guidelines
----------

-  While the system color theme can be selected by the user, the 
   :doc:`Breeze color palette <default>` is used for the reference 
   visual design of KDE Applications and Workspaces, and make up the 
   default system color theme.

   -  Primary colors are used throughout the main interface of the
      applications and workspaces. **Plasma Blue** is used as the
      primary highlight color.
   -  Secondary colors are used sparingly as accents throughout the
      visual design.
   -  Whenever transparency is used (e.g. shadows) consider using the
      opacities listed.

-  Avoid using color as a primary method of communication. Color is best
   used as a secondary method to reinforce meaning visually. You should
   not only rely on color to convey meaning but also typography, layout,
   sizes, etc.
-  Ensure sufficient contrast between foreground and background colors.
-  Keep in mind accessibility for users with color vision deficiency
   (~5% population). Use one of the many available online color
   blindness simulators to ensure colors intended to be distinguishable
   remain distinguishable for color-blind users.


   
Implementation
--------------

Qt Widgets
~~~~~~~~~~

-  When implementing colors in your application, select the appropriate
   theme color or system color from the palette provided by the Qt or
   KDE Platform/Frameworks library. You can use the `CheckColorRoles`_
   theme to detect bugs regarding the use of system colors in your
   application.
-  `KColorScheme`_ provides methods to pick the colors from the system
   color scheme to avoid hardcoding colors where possible.
   
Kirigami
~~~~~~~~

See :doc:`color in Kirigami <kirigami:style/color>` for details on how to use 
colors and palettes.

.. literalinclude:: /../../examples/kirigami/UseTheme.qml
   :language: qml


Plasma components
~~~~~~~~~~~~~~~~~

In Plasmoids use `PlasmaCore.Theme`_ to pick theme colors.

Color Mapping
-------------

The Breeze color palettes maps to the KColorScheme color roles as shown as 
follow:

   -  :doc:`Breeze <default>`
   -  :doc:`Breeze Dark <dark>`
   -  :doc:`Breeze Light <light>`
   -  :doc:`Breeze High Contrast <high>`


.. _CheckColorRoles: https://store.kde.org/p/1001640/
.. _KColorScheme: http://api.kde.org/frameworks-api/frameworks5-apidocs/kconfigwidgets/html/classKColorScheme.html
.. _PlasmaCore.Theme: https://api.kde.org/frameworks/plasma-framework/html/classPlasma_1_1QuickTheme.html
