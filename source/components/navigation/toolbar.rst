Toolbar
=======

.. figure:: /img/Toolbar1.png
   :figclass: border
   :alt:  Primary Action Buttons on Desktop
   
   Toolbar with the most important actions :doc:`toolbar <toolbar>` and an 
   overflow menu
   
Purpose
-------

A *toolbar* is a graphical presentation of commands optimized for fast
access. A toolbar can be either be defined for a whole application or as
part of another component.

As an application toolbar it contains buttons that correspond to items
in the application's menu, providing direct access to application's most
frequently used functions.
A good menu bar is a comprehensive catalog of all the available
top-level commands, whereas a good toolbar gives quick, convenient
access to frequently used commands.

As part of another component, like a card or an inline mesage, it is used
to allow quick access to the most important commands for a single, focused
content item.

Guidelines for application
--------------------------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  For standard applications, show a toolbar by default.
-  Provide a toolbar in addition to the menu bar, but do not replace
   the menu bar. 

Behavior
~~~~~~~~

-  A toolbar should contain only a few, frequently used operations. If
   the number of operations is above 5 they have to be grouped with
   separators. Not more than 3 of those sections should be implemented.
-  Do not abuse the toolbar to expose application's features. Only the
   most frequently functions should be add to the toolbar.
-  Execute operations immediately; do not require additional input.
-  Try to avoid using :doc:`split buttons <pushbutton>` 
   or :doc:`toggle buttons <../editing/togglebutton>` in order to
   keep the interaction with all buttons in the toolbar consistent.
-  Do not hide toolbars by default. If configurable, users should
   easily be able to make the toolbar viewable again.
-  Disable buttons that do not apply to the current context.
-  Consider to provide customization for toolbars in respect to
   position and content.
-  Providing a label for each action is a good practice but define a meaningful icon too because the label could be hidden in mobile mode or if there isn't enough space when the window is resized.

   
Guidelines for components
-------------------------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  Use a toolbar only if an item has few actions or few frequently used
   actions.
-  Embed a toolbar only in another control that is clearly visually seperated
   like a card or an inline message.
   

Behavior
~~~~~~~~

-  A toolbar should contain only a few, frequently used operations. 
   The number of operations should not exceed 3.
-  Do not group with separators. 
-  Execute operations immediately; do not require additional input.
-  Do not hide toolbars or make them configurable.
-  Toolbars can be responsive. If there is not enough space to display all 
   the buttons, an overflow menu is shown instead.

.. raw:: html

   <video src="https://cdn.kde.org/hig/video/20180620-1/CardLayout1.webm" loop="true" playsinline="true" width="536" controls="true" onended="this.play()" class="border"></video>
   

Appearance
----------

-  Do not change the button style from the default, which is 
   :doc:`text beside icons </content/iconandtext>`.
-  Use and design toolbar icons with special care. Users remember
   location of an object but rely as well on icon properties.
-  A distinct association between the underlying function and its visual
   depiction is crucial. Follow the advices for :doc:`icon design </style/icon>`.
-  Do not simulate Microsoft's ribbon controls. KDE stays plain and
   simple.Microsoft's ribbon controls. KDE stays plain and simple.

Code
----

Kirigami
~~~~~~~~

 - :kirigamiapi:`Kirigami: Action <Action>`
 - :kirigamiapi:`Kirigami: ScrollablePage <ScrollablePage>`
 - :kirigamiapi:`Kirigami: ActionToolBar <ActionToolBar>`
 
 
Application toolbar
"""""""""""""""""""

.. code-block:: qml

    ...
    import QtQuick.Controls 2.2 as Controls
    import org.kde.kirigami 2.4 as Kirigami
    ...
    
    Kirigami.ApplicationWindow {
        ...
        pageStack.initialPage: Kirigami.ScrollablePage {
            ...
            actions {
                left: Kirigami.Action {
                    iconName: "mail-message"
                    text: i18n("&Write mail")
                }
                main: Kirigami.Action {
                    iconName: "call-start"
                    text: i18n("&Make call")
                }
                right: Kirigami.Action {
                    iconName: "kmouth-phrase-new"
                    text: i18n("&Write SMS")
                }
            }
        }
        ...
    }

Component toolbar
^^^^^^^^^^^^^^^^^

.. code-block:: qml

    ...
    import QtQuick.Controls 2.2 as Controls
    import org.kde.kirigami 2.4 as Kirigami
    ...
        Kirigami.ActionToolBar {
            ...
            actions: [
                Kirigami.Action {
                    iconName: "favorite"
                    text: i18n("&Select as favorite")
                },
                Kirigami.Action {
                    iconName: "document-share"
                    text: i18n("&Share")
                }
            ]
            ...
        }
    ...
