Typography
==========
The guideline helps ensure that typography is always in harmony with the overall visual design.

Typeface Styles
---------------

KDE's default font is *Hack* for monospace and *Noto Sans* for everything else. 
The default font size is 10pt. KDE Plasma and Applications display seven 
variants of this typeface.

.. figure:: /img/Typography1.png
   :alt: Show different typefaces in KDE
   :figclass: border
   
   The seven default typeface styles
   
Typeface settings can be adjusted by the user and have 
:doc:`great influence on sizing and spacing  </layout/units>` in KDE's 
workspace and applications.

* The monospace typeface should be used for code content, filenames, file paths.
* Typography is treated like any other visual element when considering 
  :doc:`spacing </layout/metrics>` and 
  :doc:`alignment </layout/alignment>`.
* Multi-line blocks of text should be either left or right aligned; avoid center 
  alignment.
* Limit the range of any dynamic type resizing to preserve the intended visual 
  hierarchy. For example, don't resize body text to be bigger than 
  the heading text. Or don't resize the section heading text to fit more words 
  so that it's smaller than the body text. Or don't resize text of relatively 
  lesser importance so that it's bigger than text or other visual elements that 
  should be of relatively greater importance.

.. warning::
   |devicon| Never use **Text{}** in Kirigami or Plasma, because it  
   doesn't follow the system font rendering settings. See :ref:`typography-code` 
   for implemntation.
   
.. warning::
   |devicon| Never use a hardcoded value of px or pt to define a 
   font size. See the entry about :doc:`units </layout/units>` for more 
   information.

.. hint::
   |designicon| The px values are only for design and mockup; don't use them 
   for development.

    - Header 1: Noto Sans 18px
    - Header 2: Noto Sans 13px
    - Header 3: Noto Sans 12px
    - Header 4: Noto Sans 11px
    - Body: Noto Sans 10px
    - Code: Hack 10px
    - Small: Noto Sans 8px

Guidelines
----------

Components
^^^^^^^^^^

Most :doc:`components </components/index>` have a recommended typeface style. 
If you create a new component you should give it the same typeface style as 
similar existing components.

Content
^^^^^^^

You can use any typeface styles to structure your content, but try not to 
overuse the larger headings.

When the visual design calls for an area of exceptional focus, a larger 
typeface size may be used. In this case use a Light typeface weight to keep the 
stroke width similar to other styles throughout the interface. All other 
typeface characteristics for the typographic category should be maintained. For 
such exceptions to be effective, they must be very rare.

Text Color and Contrast
^^^^^^^^^^^^^^^^^^^^^^^

The text :doc:`color <./color/index>` and 
:doc:`background  color <./color/index>` can be varied to provide additional 
hierarchical hints (e.g. selected text). However, the contrast between the text 
and background color must be sufficient to preserve legibility of the text.

Words per line
^^^^^^^^^^^^^^

Unless the content is long-form text like a book or a report, try to keep line 
lengths to no more than about eight to ten words per line. For styles requiring 
the use of an all-caps typeface, try to keep line lengths to no more 
than about three to four words per line.

.. _typography-code:

Code
----

Kirigami
^^^^^^^^

.. code-block:: qml

    ...
    import QtQuick.Controls 2.2 as Controls
    import org.kde.kirigami 2.4 as Kirigami
    ...
    Kirigami.Heading {
        level: 1
        text: "Header 1"
    }
    Kirigami.Heading {
        level: 4
        text: "Header 4"
    }
    Controls.Label {
        font.pointSize: 24
        text: "Extra large title"
    }
    Controls.Label {
        text: "Normal text in your application"
    }
    Controls.Label {
        text: "Use this to label buttons, checkboxes, ..."
    }

    
Plasma
^^^^^^

.. code-block:: qml

    ...
    import org.kde.plasma.extras 2.0 as PlasmaExtras
    import org.kde.plasma.components 3.0 as PlasmaComponents
    ...
    PlasmaExtras.Heading {
        level: 1
        text: "Header 1"
    }
    PlasmaExtras.Heading {
        level: 4
        text: "Header 4"
    }
    PlasmaComponents.Label {
        font.pointSize: 24
        text: "Extra large title"
    }
    PlasmaComponents.Label {
        text: "Normal text in your application"
    }
    PlasmaComponents.Label {
        text: "Use this to label buttons, checkboxes, ..."
    }
