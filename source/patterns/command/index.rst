Command patterns
================

.. toctree::
   :maxdepth: 1
   :titlesonly:
   :hidden:

   content
   drawer
   menubar
   ondemand
   simple
   toolbar

Command patterns are determined by the command structure chosen for the
application. A command is any function performed by the application
based on user input. Commands that perform similar functions may be
grouped together. The collection of commands and command groups make up
the command structure of the application.

Command patterns can be combined with :doc:`navigation patterns </patterns/navigation/index>` and
:doc:`content patterns </patterns/content/index>` to design the complete layout for your application.

Guidelines
----------

When designing an application, it may be unclear what the command
structure should be.

-  Start by assuming a simple command structure and select an associated
   command pattern.
-  As the design evolves, if the selected pattern becomes inadequate for
   completing the primary tasks of the application, consider a pattern
   for a more complex command structure.
   
.. note:: 
   |mobileicon|
   Considering the limited space available in mobile applications, there is
   always a trade-off between accessibility of controls and space available
   for the content.

- :doc:`content`
- :doc:`drawer`
- :doc:`menubar`
- :doc:`ondemand`
- :doc:`simple`
- :doc:`toolbar`
