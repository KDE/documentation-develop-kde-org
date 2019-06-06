Icon Design
===========

Purpose
-------

Icons are pictorial representations of functions and objects. They convey
meaning that users perceive almost instantaneously and are an important part of
a program's visual identity.

Well-designed icons strongly impact users' overall impression of the design.
Consistent use of icons also improves usability by making programs, objects,
and actions easier to identify and learn.

If you would like to request help designing icons for your application, you can
ask the `KDE Visual Design Group <https://community.kde.org/Get_Involved/design#Communication_and_workflow>`_ for help.




General Guidelines
------------------

-  Use icons from the system icon theme whenever possible. Avoid using custom
   icons. New icons should be added to an icon theme.
-  Design icons with a small number of metaphors that are understandable
   independent of language and culture. Apply metaphors only once (e.g. do not
   use a brush twice for different actions).
-  Simplify, but don't go overboard. Breeze icons are **not** "flat".
-  Avoid using text in icon designs; it cannot be localized and tends to look
   bad at small sizes.
-  Many icons come in multiple sizes. Each version should be visually optimized
   and pixel-perfect for its particular size. Larger sizes offer more
   opportunity for detail and visual pizazz, while smaller version should be
   stripped of everything not absolutely necessary.






Monochrome icon style
---------------------
.. image:: /img/HIGMonoIcons.png
   :alt: Monochrome icons

Many Breeze icons employ a monochrome art style for their small 16px and 22px
versions. This style should be avoided for icons larger than 22px. The
monochrome style relies on distinct shapes and outlines instead of fine details
and vibrant colors, and employs an intentionally limited color palette:

   #. |shadeblack| :doc:`Shade Black <color/index>`: Used for icons in a
      normal state and non-destructive actions: back, forward, ok, home, etc.
      This is the most commonly used color. When in doubt, choose Shade Black.
   #. |iconred| :doc:`Icon Red<color/index>`: Used for icons that depict
      actions: delete, remove, stop, etc.
   #. |bewareorange| :doc:`Beware Orange <color/index>`: Used for icons that
      involve user input of some kind.
   #. |plasmablue| :doc:`Plasma Blue <color/index>`: Used for icons that
      involve the action "select" or "insert".
   #. |iconyellow| :doc:`Icon Yellow <color/index>`: Used for icons that
      involve a "warning" state or some sort.
   #. |noblefir| :doc:`Noble Fir <color/index>`: Used to for icons that
      involve "connected", "secure" or "successful" actions.

.. |shadeblack| image:: /img/Breeze-shade-black.svg

.. |iconred| image:: /img/Breeze-icon-red.svg

.. |bewareorange| image:: /img/Breeze-beware-orange.svg

.. |plasmablue| image:: /img/Breeze-plasma-blue.svg

.. |iconyellow| image:: /img/Breeze-icon-yellow.svg

.. |noblefir| image:: /img/Breeze-noble-fir.svg

Because monochrome icons are so small and simple, it is important that they be
pixel-perfect, with their lines and objects aligned to a regular grid:

.. image:: /img/Breeze-icon-design-3.png
   :alt: Newspaper icon

.. image:: /img/Breeze-icon-design-1.png
   :alt: A pixel-perfect icon on the canvas.

.. image:: /img/Breeze-icon-design-2.png
   :alt: A pixel-perfect icon in the app.

*Pixel-perfect icons: On the canvas and in the app*

Because monochrome icons usually depict actions, many include status or action
emblems. These are always located in the bottom-right corner. The emblem should
be a minimum of 5px wide and tall, and there must be 1px of blank space between
the emblem and the rest of the icon.

.. image:: /img/Breeze-icon-design-8.png
   :alt: Design for a 22px or 16px icon with an emblem in the bottom-right corner

*A perfect monochrome icon with an emblem in the corner*


Margins
~~~~~~~
.. image:: /img/icon_margins-monochrome-4x.png
   :alt: Canvas and graphic sizes

:download:`Larger size </img/icon_margins-monochrome-8x.png>`

Colorful icon style
-------------------
.. image:: /img/Sample_color_icons.png
   :alt: Colorful icons

Colorful Breeze icons make full use the
:doc:`Breeze color palette <color/index>`. They are **not** "flat" and
incorporate shadows and smooth linear gradients going from darker on the bottom
to lighter on top. Don't be afraid to add detail, vibrancy, and depth!

Colorful Breeze icons generally consist of three parts:

Background
~~~~~~~~~~
The background is a container and gives structure to the icon. It can have any
shape or color in the Breeze color palette. Don't be afraid to get creative with the background shape!

.. image:: /img/Breeze-icon-design-creative-backgrounds.png
   :alt: Creative backgrounds

Foreground symbol
~~~~~~~~~~~~~~~~~
The foreground symbol offers contrast with its background and works with it to
provide the bulk of the icon's meaning. The foreground symbol is optional; feel
free to omit it if the background provides enough meaning on its own.

Shadows
~~~~~~~
If present, the foreground symbol casts a long shadow angled 45°
towards the bottom-right corner. This shadow always has the same gradient and
takes up the whole object.

.. image:: /img/Breeze-icon-design-10.png
   :alt: Using the grid for shadows

In addition, colorful icons have a 1 px hard shadow on the bottom:

.. image:: /img/Breeze-icon-design-12.png
   :alt: 48px icons can have more details

Margins
~~~~~~~
.. image:: /img/icon_margins-color-4x.png
   :alt: Canvas and graphic sizes

:download:`Larger size </img/icon_margins-color-8x.png>`

Application icons
-----------------
Application icons come in a single size: 48px. They always use the colorful
style.

All application icons should have the same height: 40px tall, with four pixels
of padding on the top and bottom.

When creating a Breeze theme version of an existing app's icon, is critically
important that the icon's existing brand and visual style be preserved. The
goal is to create a Breeze version of the icon, not something completely new
and different.

.. image:: /img/Breeze-icon-design-15.png
   :alt: KDE app icon for Konsole

*KDE app icon for Konsole*

.. image:: /img/Breeze-icon-design-Kolourpaint.png
   :alt: KDE app icon for Kolourpaint

*KDE app icon for Kolourpaint*

.. image:: /img/Breeze-icon-design-11.png
   :alt: KDE app icon for Discover

*KDE app icon for Discover*

.. image:: /img/Breeze-icon-design-14.png
   :alt: 3rd party app icon for VLC

*3rd party app icon for VLC*

.. image:: /img/Breeze-icon-design-Telegram.png
   :alt: 3rd party app icon for Telegram

*3rd party app icon for Telegram*

.. image:: /img/Breeze-icon-design-Virtualbox.png
   :alt: 3rd party app icon for Virtualbox

*3rd party app icon for Virtualbox*




Places icons
------------
Places icons come in four sizes: 16px, 22px, 32px, and 64px. They use the
colorful style for 32px and 64px sizes and the monochrome style for 22px and
16px sizes.

Monochrome Places icons
~~~~~~~~~~~~~~~~~~~~~~~
Places icons are monochrome for their 16px and 22px versions. For these
versions, the whole icon depicts the place itself or its typical contents.
Beyond that, simply follow the general monochrome icon guidelines for 16px and
22px icons.

.. image:: /img/Breeze-icon-design-places-monochrome.png
   :alt: Small monochrome Places icons

*Small monochrome Places icons in Dolphin's Places panel*

Colorful places icons
~~~~~~~~~~~~~~~~~~~~~
.. image:: /img/Breeze-icon-design-places.png
   :alt: Colorful Places icons

For the colorful versions, the monochrome icon becomes the foreground symbol on
top of a background depicting a folder. The foreground symbol's color is a
darkened version of the background folder's color, and can consist of 1px lines,
or filled-in areas. The foreground symbol should be centered within the folder
background and take up 10x10px for the 32px icon size, and 20x20px for the 64px
size.

Note that for places icons, the foreground symbol does **not** cast a shadow.

.. image:: /img/Breeze-icon-design-places-colorful.png
   :alt: Large colorful Places icons

*20x20px foreground symbol in the center of a 64x64px Places icon*




MIME type icons
---------------
Like Places icons, MIME type icons come in four sizes: 16px, 22px, 32px, and
64px. They use the colorful style for 32px and 64px sizes, and the monochrome
style for 22px and 16px sizes.

Monochrome MIME type icons
~~~~~~~~~~~~~~~~~~~~~~~~~~
Like Places icons, the 16px and 22px monochrome versions of MIME type icons
have no background image and consist entirely of a monochrome line-art depiction
of the file type.

.. image:: /img/Breeze-icon-design-19.png
   :alt: Small monochrome MIME type icon

Monochrome MIME type icons are drawn with the primary color of the large
colorful version rather than following the general monochrome icon color
guidelines.

.. image:: /img/Breeze-icon-design-mimetype-small.png
   :alt: Small monochrome document MIME types

*Small MIME type icons use 1 px strokes and follow the colors of the larger
versions*

Colorful MIME type icons
~~~~~~~~~~~~~~~~~~~~~~~~
Like Places icons, the colorful versions consist of the monochrome icon used as
a foreground symbol on top of a background.

For archives, packages, compressed files, and disk images, the background is a
square with a zipper going halfway down:

.. image:: /img/Breeze-icon-design-mimetype-archive.png
   :alt: Large colorful archive MIME types

For images, the background is a horizontal rectangle with the top-right corner
folded over, and the fold casts a shadow:

.. image:: /img/Breeze-icon-design-mimetype-image.png
   :alt: Large colorful image MIME types

For video files, the background is a horizontal rectangle that looks like a
filmstrip:

.. image:: /img/Breeze-icon-design-mimetype-video.png
   :alt: Large colorful video MIME types

For audio files, the background is a CD sleeve with a CD partially visible:

.. image:: /img/Breeze-icon-design-mimetype-audio.png
   :alt: Large colorful video MIME types

For documents and everything else, the background is a vertical rectangle with
the top-right corner folded over, and the fold casts a shadow:

.. image:: /img/Breeze-icon-design-mimetype-document.png
   :alt: Large colorful document MIME types

As with the Places icons, the foreground symbol does not cast a shadow.




Action and status icons
-----------------------
Action and status icons come in two sizes: 16px and 22px. They always use the
monochrome style. Action items should use Shade Black as much as possible:

.. image:: /img/Breeze-icon-design-action.png
   :alt: Action icons

Status icons can use a bit more color in their composition to connote status
information:

.. image:: /img/Breeze-icon-design-status.png
   :alt: Status icons


Action and status icons dynamically change their colors when the user changes
the system's color. To accomplish this, a special CSS stylesheet is embedded
in the SVG, and then the actual shape definitions are tagged with the
appropriate class. It looks like this: ::

    <svg xmlns="http://www.w3.org/2000/svg" height="16" width="16">
        <style
        type="text/css"
        id="current-color-scheme">
        .ColorScheme-Text {
            color:#232629;
        }
        .ColorScheme-Background {
            color:#eff0f1;
        }
        .ColorScheme-Highlight {
            color:#3daee9;
        }
        .ColorScheme-HighlightedText {
            color:#eff0f1;
        }
        .ColorScheme-PositiveText {
            color:#27ae60;
        }
        .ColorScheme-NeutralText {
            color:#f67400;
        }
        .ColorScheme-NegativeText {
            color:#da4453;
        }
        </style>
        <g style="fill:currentColor;fill-opacity:1;stroke:none" class="ColorScheme-Text">
            <path d="M10 2h-2L2 14h2z"/>
            <rect height="1" width="6" x="8" y="13"/>
        </g>
    </svg>

For more technical details, see `this blog post <http://notmart.org/blog/2016/05/icon-colors/>`_.




Emblems
-------
Emblems come in three sizes: 8px, 16px, and 22px and always use the colorful
style. However, their color palette is limited to that of the monochromatic
style. Unlike other icons, they are drawn with zero margins and touch the edges
of the canvas.

Emblem icons always have a colored background shape and a monochrome foreground
symbol. Because of the extremely limited space available, it is critical that
the foreground symbol be aligned to the pixel grid:

.. image:: /img/Breeze-icon-design-emblem.png
   :alt: Pixel-perfect emblem icon

16px and 22px Emblems get a 60% opacity outline to ensure adequate contrast
against whatever icon they are drawn on top of:

.. image:: /img/Breeze-icon-design-emblem-16px.png
   :alt: 16px emblem icons

*16px emblems*

.. image:: /img/Breeze-icon-design-emblem-22px.png
   :alt: 22px emblem icons

*22px emblems*

8px emblems do not have an outline, because there simply isn't enough room:

.. image:: /img/Breeze-icon-design-emblem-8px.png
   :alt: 8px emblem icons

*8px emblems*
