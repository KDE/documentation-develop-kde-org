Places Icons
============
Places icons are used to depict folders, network locations, and other places.
They come in four sizes: 16px, 22px, 32px, and 64px. Places icons use the
`monochrome style <index.html#monochrome-icon-style>`__ for 16px and 22px sizes,
and the `colorful style <index.html#colorful-icon-style>`__ for 32px and 64px 
sizes.

Purpose
-------

Places icons allow a user to quickly identify landmarks in their filesystems.
They indicate places that a user will visit frequently,
such as home, root, downloads, etc.

Design
------

Anatomy
~~~~~~~~~~~~~~~~~~~~~
Colorful places icons consist of two elements—the monochromatic counterpart of
the colorful places icon overlaid on a folder background. 

.. figure:: /img/place-anatomy.png
   :alt: Annotated places icon with parts of icon labelled.

1. Folder
2. Monochromatic Foreground

.. container:: flex

   .. container::

      .. figure:: /img/place-anatomy-base.png

         The base of a places icon indicates that
         it's a folder that can be navigated to.

   .. container::

      .. figure:: /img/place-anatomy-fg.png

         The foreground of a places icon indicates
         the folder's landmark location.

Base
~~~~
The base of a places icon is always a blue folder.

.. figure:: /img/place-blank.png
   :alt: A blank folder.

Foreground
~~~~~~~~~~

The foreground of a places icon indicates the landmark location an icon represents.
Its color is a darker variant of the base's color. For 32px icons, its size is 
10×10px. For 64px icons, its size is 20×20px. It is always centered within the 
folder, and does not cast a shadow.

.. container:: flex

   .. container::

      .. figure:: /img/place-fg-do.png
         :scale: 80%
         :figclass: do

         :noblefir:`Do.` |br|
         The foreground of a places icon does 
         not cast a shadow.

   .. container::

      .. figure:: /img/place-fg-dont.png
         :scale: 80%
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't have the foreground of a places
         icon cast a shadow.

Margins
~~~~~~~
64px places icons have a top and bottom margin of 6 pixels,
and 32px places icons have a top and bottom margin of 3 pixels.

.. container:: flex

   .. container::

      .. figure:: /img/place-margin-64.png
         :scale: 85%

         64px icons should have a top and bottom
         margin of 6 pixels.

   .. container::

      .. figure:: /img/place-margin-32.png
         :scale: 85%

         32px icons should have a top and bottom
         margin of 3 pixels.