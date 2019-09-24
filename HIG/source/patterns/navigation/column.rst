Column-based navigation
=======================

.. container:: intend

   |desktopicon| |mobileicon|

.. container:: available plasma

   |nbsp|

Examples of column-based navigation in a phone and a desktop UI.

.. image:: /img/Desktop.png
   :alt: Column-based navigation on the desktop
   :scale: 40%

.. raw:: html

   <video autoplay src="https://cdn.kde.org/hig/video/20181031-1/Column1.webm" 
   loop="true" playsinline="true" width="320" controls="true" 
   onended="this.play()" class="border"></video>

When to Use
-----------

Column-based navigation is ideal for navigating through a hierarchically
organized information space, where users often go back and forth between
different levels of the hierarchy.
For example:

-  Accounts ->Folders -> (Sub-Folders) -> Mails -> Individual mail
-  Folders -> RSS Feeds -> Feed items -> Individual item
-  File system hierarchy

Kirigami implements this pattern in the form of a PageRow, which allows
users to scroll horizontally through pages and allows the application to
add and remove pages to and from the stack dynamically. This allows easy
back and forward navigation through the hierarchy by swiping left-right
on touch screens.

A header with the title of the current page doubles as a breadcrumb
trail which the user can scroll through and tap to go to a specific
page.

How to Use It
-------------

General
~~~~~~~

-  Use one page/column for each level of the hierarchy (or more
   generally, for each step of the navigation).
-  Pages can for example be :doc:`lists <list>` or :doc:`grids <grid>`, 
   or a detail view of a particular item.
-  Make sure to set meaningful but short page titles, so they can create
   a useful breadcrumb trail.
-  When on the lowest level, showing the content of an individual list
   item, use a swipe beyond the top/bottom of the content to jump to the
   previous/next item in the list.

-  For the command structure, see the :doc:`command patterns </patterns/command/index>`.

Implementation
--------------

If you use `ApplicationWindow 
<https://api.kde.org/frameworks/kirigami/html/
classorg_1_1kde_1_1kirigami_1_1ApplicationWindow.html>`_ for your
application, it automatically uses PageRow for its content.
