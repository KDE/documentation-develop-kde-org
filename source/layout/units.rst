Units & measurements
====================


Purpose
-------

This pages gives an overview about different units used in KDE and
Plasma

Pixel
-----

A (physical) pixel or dot is a physical point in a raster image, or the
smallest addressable element in an all points addressable display
device.

.. caution::
   Be careful not to confuse it with DPI independent pixels

DPI - pixels per inch
---------------------

Pixel density is the number of (physical) pixels or dots that fit into an inch. Different screens have different DPI. screen density = screen width (or height) in pixels / screen width (or height) in inches

.. figure:: /img/Pixel.qml.png
   :scale: 50 %
   :alt: Different DPIs on desktop and mobile

   Different DPIs on desktop and mobile


DPI is often used interchangeably with PPI, pixel per inch.

.. hint::
   |designicon| Don't confuse this with the DPI setting in photoshop, krita, ... . For mockups you can just ignore this setting or choose a what ever value you like.


PPI / DPI independent pixels
----------------------------

A DPI independet pixel is scaled to look uniform on any screen
regardless of the DPI. A lot of platforms, eg iOS, Android, the Web,
replaced the old (physical) px with a DPI px. So most the time you read
about pixel/px they actually talk about DPI independent pixels. Qt (and
QML) support DPI independent pixels in newer versions, but because KDE
and Plasma support older versions of Qt too, one can not assume that
pixels used in Qt or QML apps are DPI independent.

.. figure:: /img/DPI.qml.png
   :scale: 50 %
   :alt: Different DPIs on desktop and mobile

   Different DPIs on desktop and mobile

A rectangle defined with physical pixels and DPI independent pixels.

.. hint::
   |devicon| Except explicilty stated otherwise, all HIG pages, draft, mockups, ... pixels/px are always DPI independent pixels.


DPI independent pixels in KDE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. hint::
   |devicon| As a developer, if you want to use DPI independent pixels use units.devicePixelRatio as a multiplier on physical pixels. Since units.devicePixelRatio is a float, make sure to round the results. Most of the time you want to floor it.

Fonts
~~~~~

Since KDE allows the user to change the font settings any dimensions
defined with px, no matter if they are DPI independent or not, make
problems together with text.

.. figure:: /img/Font.qml.png
   :scale: 50 %
   :alt: Using DPI independet pixel with different font setting

   Using DPI independet pixel with different font setting

base units in plasma
--------------------

There are special base units in plasma:

-  units.smallSpacing
-  units.largeSpacing
-  units.gridUnit

These are not only DPI independent but scale according to the font
settings too. While designing, be careful not to rely on the ratio
between units.smallSpacing and units.largeSpacing because these change
depending on font setting

.. hint::
   |designicon| For mockup and design you can use these values:

   * units.smallSpacing = 4px
   * units.largeSpacing = 18px
   * units.gridUnit = 18px

From design to code
-------------------

For any mockup, please help the developers by specifying all
measurements, either in the mockup itself or in an extra guide to the
mockup. It is a lot of work and it is error prone for developers trying
to measure everything from a mockup. Even if the mockup is in a file
format that would allow exact measurements, don't expect the developer
to know how to do it.

.. container:: flex

   .. container::

      .. figure:: /img/Design.qml.png

         *BAD*

         There are no measures.

   .. container::

      .. figure:: /img/Design_Good.qml.png

         *GOOD*

         Try to be as detailed as necessary, but you don't have to provide measurement for objects that can be easily calculated. For example the size of the dark rectangle can be easily obtained.


recomended spacings
~~~~~~~~~~~~~~~~~~~

If you design try to use the recomended values for margin and paddings,
to ensure a uniform appearance. See `Placement and Spacing`_ for more
details.

.. figure:: /img/Margin.qml.png
   :alt: Use of base units

   Use of base units

.. code:: qml
   :number-lines:

    Row {
        spacing: units.largeSpacing
        Rectangle {
            ...
        }
        Rectangle {
            ...
        }
    }

.. code:: qml
   :number-lines:

    Row {
        spacing: 2 * units.smallSpacing
        Rectangle {
            ...
        }
        Rectangle {
            ...
        }
    }

arbitrary px values
~~~~~~~~~~~~~~~~~~~

When needed, you can use arbitrary px values for your mockups. As a
developer you need to use units.devicePixelRatio to make these values
DPI independent.

.. figure:: /img/Arbitrary.qml.png
   :alt: Use of arbitrary px values

   Use of arbitrary px values

.. code:: qml
   :number-lines:

    Row {
        spacing: units.smallSpacing
        Rectangle {
            height: units.largeSpacing
            width: Math.floor(2 * units.devicePixelRatio)
        }
        Text {
            ...
        }
    }

ratio
~~~~~

Sometimes the ratio between dimensions is more important then the
actually values.

.. figure:: /img/Ratio.qml.png

.. code:: qml
   :number-lines:

    Grid {
        columns: 3
        ...
        Repeater {
            model: 9
            ...
            Rectangle {
                width: grid.width / 3
                height: grid.height / 3
                ...
            }
        }
    }
