Emblem
======

Purpose
-------

An emblem displays unusual or non-default status information about an icon
or image. For example, an emblem could indicate that a folder is shared, that a
disk is unmounted, or that an app has unread notifications.

Examples
--------

.. figure:: /img/emblem-public-on-folder.png
   :alt:

   An emblem indicating that a folder is shared on the network

.. figure:: /img/emblem-notification-kmail.png
   :alt:

   An emblem indicating that a mail program has 15 unread emails

Guidelines
----------

-  Emblems are used to badge icons, images, or other visually discrete elements
   in a file manager, system tray, task manager, dock, image view, etc. Emblems
   should not be applied to textual content.
-  Use emblems to display that an icon or image has some unusual status
   associated with it, or that there are unread notifications. Don't use
   emblems to display an element's normal, common, or typical status. For
   example, an emblem could indicate that a folder is read-only or is a symlink,
   or that a disk is unmounted or encrypted. An emblem should not be used to
   indicate that a folder is read-write or that a disk is mounted.
-  Emblems that indicate status should be placed in the bottom-right corner. If
   additional status emblems are needed, they should be placed in other corners
   in a clockwise order.
-  Emblems that indicate unread notifications should be located in the
   top-right corner.
-  Use the minimum number of emblems and don't overwhelm the icon itself.
   Three is usually too many.

Appearance
----------
An emblem that indicates unread notifications should take the form of a
light-colored number inside a blue circle. The circle can become "pill-shaped"
if the number is very large.

.. figure:: /img/emblem-notification-small.png
   :alt:

   Notification emblem

.. figure:: /img/emblem-notification-large.png
   :alt:

   Notification emblem with a large number

For symbolic icon emblems, see the :doc:`Breeze icon guidelines </style/icon>`.

