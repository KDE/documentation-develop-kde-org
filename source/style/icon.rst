Icons
=====

Purpose
-------

Icons are pictorial representations of functions and objects. Icons are
important not only for aesthetic reasons as part of the visual identity of a
program, but also for utilitarian reasons. They are a shorthand for
conveying meaning that users perceive almost instantaneously.
Well-designed icons improve the visual communication and strongly impact
users' overall impression of visual design. Icons are space-saving
mechanisms and improve usability by making programs, objects, and
actions easier to identify and learn. Icon use should be consistent
throughout the interface.

Guidelines
----------

-  Design icons with a small number of metaphors [1].

   -  Apply metaphors only once (e.g. do not use a brush twice for
      different options).
   -  Rethink conventionally used metaphors (e.g. the clipboard icon of
      paste).
   -  Antiquated metaphors might work well (e.g. a floppy disk is not
      necessarily outdated to represent save).
   -  Adjust the degree of abstractness according to familiarity of the
      metaphor.
   -  Use arrows only if they can easily be related to spatial features
      such as *Previous/Next* in a sequence or *Up/Down* in a hierarchy.
      Avoid using arrows metaphorically (such as for *Reply/Forward* or
      *Undo/Redo*).
   -  Use metaphors understandable independent of language and culture.
   -  Simplify your icons.

-  Icons that lose details when shrunk may need a special version that
   preserves meaning even at smaller sizes. Critical details may become
   unrecognizable when scaled down.
-  Avoid using text in icon designs; it may not scale well to smaller
   sizes.
-  Icons of a similar type share a consistent visual language
   (mimetypes, folders, devices, etc.).
-  Follow the guidelines for presenting 
   :doc:`icons with text </patterns/content/iconandtext>`
-  Test your icon set on strength of association, discriminatory power,
   conspicuousness, and, if applicable, on accessibility.

Breeze Icon Design - Color
~~~~~~~~~~~~~~~~~~~~~~~~~~

**Monochrome Icons**

.. image:: /img/HIGMonoIcons.png
   :alt: Monochome icons

-  Used for application toolbar and button actions, menus, sidebars and
   status and notifications. Also may be used for small (16x16) devices
   and places icons (folders, usb drives, etc.).
-  Rely on a distinct shapes instead of fine details to distinguish
   between them.
-  Breeze monochrome icons use primarily color #1 and #2 but also use
   other colors to indicate a different state.

   #. |icongrey| :doc:`Icon Grey - Color <color/index>` used for icons in a normal
      state and non destructive actions e.g.: back, forward, ok, home.
   #. |iconred| :doc:`Icon Red - Color <color/index>` used for icons in a normal state
      and for destructive actions e.g.: close, delete, remove, stop. 
      Also used in addition with color #1.
   #. |iconorange| :doc:`Icon Orange - Color <color/index>` used in addition to 
      color #1. Used to distinguish icons that involve "user input", also
      used as the color for the "busy" state in IM software.
   #. |iconblue| :doc:`Icon Blue - Color <color/index>` used in addition to 
      color #1. Used to distinguish icons that involve the action "select"
      or "insert".
   #. |iconyellow| :doc:`Icon Yellow - Color <color/index>` used in addition to
      color #1. Used to distinguish icons that involve a "warning", also 
      used as the color for the "away" state in IM software.
   #. |icongreen| :doc:`Icon Green - Color <color/index>` used in addition to
      color #1. Used to distinguish icons that involve "connected", "secure"
      or "successful" actions.

.. |icongrey| image:: /img/Breeze-icon-grey.svg

.. |iconred| image:: /img/Breeze-icon-red.svg

.. |iconorange| image:: /img/Breeze-icon-orange.svg

.. |iconblue| image:: /img/Breeze-icon-blue.svg

.. |iconyellow| image:: /img/Breeze-icon-yellow.svg

.. |icongreen| image:: /img/Breeze-icon-green.svg

For more technical details of how to use colors in icons see 
`this blog post <http://notmart.org/blog/2016/05/icon-colors/>`_

**Colorful icons**

.. image:: /img/Sample_color_icons.png
   :alt: Colorful icons

-  Use colorful icons for applications, folders, mimetypes and devices.
-  For Breeze icons, use colors from the `full Breeze color palette`_ as
   a starting point.
-  Breeze icons use smooth linear gradients (bottom to top/dark to
   light); they are not flat.
-  Application icons should be unique and easily recognizable.
-  When creating an system icon theme, respect trademarks by avoiding
   significant alterations to application icons.

Breeze Icon Design - Sizes
~~~~~~~~~~~~~~~~~~~~~~~~~~

Breeze icons come in a variety of sizes depending on their context. The
following lists the current sizes in use:

-  Breeze/

   -  actions/

      -  toolbar/ - 22x22
      -  toolbar-small/ - 16x16

   -  apps/

      -  preferences/ - 32x32
      -  software/ - 48x48
      -  software-medium/ - 22x22
      -  software-small/ - 16x16
      -  system-power-actions/ - 48x48
      -  system-session-actions / - 48x48

   -  categories/

      -  start-menu/ - 32x32
      -  start-menu-small/ - not used in Plasma

   -  devices/

      -  hardware/ - 48x48
      -  sidebars/ - 16x16

   -  mimetypes/

      -  file-types/ - 64x64
      -  file-types-small/ - 16x16

   -  status/

      -  dialogs/ - 64x64
      -  im-status/ - 16x16
      -  panel/ - 22x22

   -  places/

      -  user-folders/ - 64x64
      -  user-folders-small/ - 16x16

Breeze Icon Design - Basics
~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are two main styles for Breeze icons. When creating a new icon for
Breeze make sure to follow these rules as it's important to keep
consistency within all the elements in the theme. With Breeze we'd like
to keep things simple, most monochromatic icons must fit within a
squared area set by guides though the graphics don't need to be squares
themselves. Icons should be pixel perfect, this simply means that all
objects must be aligned to the grid (as in the Inkscape grid), this
results in crisp icons once in use.

.. image:: /img/Breeze-icon-design-1.png
   :alt: A pixel perfect icon on the canvas.

.. image:: /img/Breeze-icon-design-2.png
   :alt: A pixel perfect icon in the app.

*A pixel perfect icon. On the canvas and in the app.*

In the above list, we have the sizes for the icons set up. However, the
icons, or rather, the graphics themselves do not fill the entirety of
the canvas (the document/workspace). Everyday objects may not always fit
the canvas area or be perfectly aligned to the canvas or pixels. As a
designer, you may choose to use everyday objects in your icons to make
them memorable and recognizable. However, keep a correct aspect ratio of
the final graphic and what it should represent.

.. image:: /img/Breeze-icon-design-3.png
   :alt: Newspaper icon

.. image:: /img/Breeze-icon-design-4.png
   :alt: Envelope icon

*A newspaper icon can perfectly fit within the set area of the guides.
But not an envelope.*

As you see in the images above we have guides in place, this is so that
the graphics you see in the apps are all at the same height though some
may have a different width. The guides are in place for all the icons,
the image below illustrates this:

.. image:: /img/Breeze-icon-design-5.png
   :alt: Canvas and graphic sizes

*Visual representation of the area defined by the guides. Icons don't
necessarily have to be squares, they simply need to have a proper aspect
ratio. Vertically aligned icons are narrower but have the same height as
wider icons.*

.. image:: /img/Breeze-icon-design-6.png
   :alt: Narrow icon

.. image:: /img/Breeze-icon-design-7.png
   :alt: Wide icon

*Whether the graphics are narrower they have the same height. Placed in
a taskbar or a dock this results in a seamless app list presentation.*

Breeze Icon Design - for 22 and 16 px
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These are the simplest of icons in terms of labor. When doing these
icons check the file index.theme located in the root of the Breeze
folder for hints of where the icon will be used.

-  These icons don't have any details other than their shapes.

Icons in these sizes use 1 px strokes and sometimes fill on some areas
depending on the graphic.

.. image:: /img/Breeze-icon-design-8.png
   :alt: Design for a 22px or 16px icon

*Mix of 1 px strokes and fill areas plus symbol indicating an action or
status.*

Generally when adding symbols to graphics such as "+", "-", etc. they
should be placed at the bottom right corner of the bigger graphic and
there must be 1 px of blank space between each element.

-  The symbol should have a size of 5 px minimum.

Breeze Icon Design - 32 and 48 px
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Most of the icons this size (32 px) were used for System Settings but
they're also used by Kickoff for the app categories. These icons make
use of smooth, vibrant, fresh and aligned elements colored by gradients
and they mostly consist of three parts: a background, a front symbol and
a long shadow.

.. image:: /img/Breeze-icon-design-9.png
   :alt: Different icons at a size of 32px

*These icons don't have a particular shape, they simply fit together
despite their differences. Shapes can be either squares, rectangles,
circles, have resemblance of real-life objects, etc.*

-  Icons do have a particular element in common: a long shadow.

The front symbol is what dictates the long shadow, the shadow always has
the same gradient, no exception. And it takes up the whole object even
if said object has only strokes and no fill.

The angle of the long shadow is 45° towards the bottom right of the
symbol.

.. image:: /img/Breeze-icon-design-10.png
   :alt: Using the grid for shadows

*Always use the grid when doing these shadows, this is very important.*

The difference between 32 and 48 px icons is a shadow at the bottom of
the 48 px icons and a bit more of detail. Since there more space for
more pixels we've used them. 48 px icons can have more long shadows, and
they also have a 1 px hard shadow at the bottom, whether they're
rectangular/squares or circles.

.. image:: /img/Breeze-icon-design-11.png
   :alt: 48px icons can have shadows

.. image:: /img/Breeze-icon-design-12.png
   :alt: 48px icons can have more details

*48 px icons have a bit more detail to them.*

Application icons are at 48x48 px, an important thing though is that
when doing an application icon you want to keep established brands
mostly intact or at least that they don't differ too much from the
original.

.. image:: /img/Breeze-icon-design-13.png
   :alt: Keep established brands for app icons

And for apps that are free software try to come up with something
creative, a better representation of what the software does, a feature
an UI element, etc. The last thing we want is to keep using the same old
unrepresentative icon.

.. image:: /img/Breeze-icon-design-14.png
   :alt: VLC refreshed
   
.. image:: /img/Breeze-icon-design-15.png
   :alt: Konsole refreshed

*VLC and Konsole. Classics, refreshed.*

Breeze Icon Design - 64 px
~~~~~~~~~~~~~~~~~~~~~~~~~~

Folders and mimetypes use this size the most but so do dialog icons.
Folders follow the same principle of a background and a symbol, but no
long shadow under the symbol. The symbol however does not use a gradient
but a contrasting color to that of the background. It's not transparent.

The symbol (when using a stroke-based design) uses 1 px strokes, it can
be mixed with fill areas or it can be completely fill.

.. image:: /img/Breeze-icon-design-16.png
   :alt: Different types of symbols on folders.

*Different types of symbols.*

The size of the symbol is 20x20 px and is centered to the front of the
folder.

.. image:: /img/Breeze-icon-design-17.png
   :alt: Design details of a folder icon

*Folder dimensions: 52x58 px - smooth gradient on the front, a long
shadow on the back, a darker gradient also on the back and light details
at the top of the front and back areas.*

Mimetypes have a common shape, these shapes and combinations are
included in the folder resources/mime_combinations. The symbols that
define each mimetype should be related to the files or the software that
generates these files.

.. image:: /img/Breeze-icon-design-18.png
   :alt: Design details of a XML file type icon

*An XML tag for XML type files.*


Symbols use 1 px strokes too, just like folders.

Small sized mimetypes use the same symbol (only redrawn for 16 px) as
the bigger icon. The color combination is also within the
resources/mime_combinations folder files. Rules for 16 px icons (as seen
above) apply for these too.

.. image:: /img/Breeze-icon-design-19.png
   :alt: Example of an 16px mimetype icon


*16 px mimetypes use 1 px strokes and follow the colors of the bigger
graphics.*

Dialog icons are used on .. well dialogs such as:

.. image:: /img/Breeze-icon-design-20.png
   :alt: Example of an icon in a dialog

Or occasionally in Dolphin's preview sidebar (dialog-information).

With the exception of *dialog-password* the other icons use the same
shape, 1 px strokes, long shadows and vibrant gradients.

The symbol is centered to the rectangular area of the speech bubble.

.. image:: /img/Breeze-icon-design-21.png
   :alt: Example of a speech bubble

Implementation
--------------

-  Use icons available from the system icon theme whenever possible.
   Avoid using custom icons.
-  Follow the :doc:`Icon theme usage guidelines <icontheme>`.
-  For standard actions (back forward, open, save, refresh, etc.) use an
   icon from the platform-provided set. The KDE Platform 4.x uses the
   `Oxygen icon set`_. The KDE Plasma 5.x desktop and applications use
   the Breeze icon set.
-  If you would like to request help designing icons unique to your
   application, you can ask for help on the 
   `KDE Visual Design Group Forum`_.

References
----------

[1]
http://user-prompt.com/semiotics-in-usability-guidelines-for-the-development-of-icon-metaphors/

.. _Icon theme usage guidelines: KDE_Visual_Design_Group/HIG/IconTheme
.. _Oxygen icon set: http://websvn.kde.org/trunk/kdesupport/oxygen-icons/
.. _KDE Visual Design Group Forum: http://forum.kde.org/viewforum.php?f=285
.. _full Breeze color palette: KDE_Visual_Design_Group/HIG/Color
