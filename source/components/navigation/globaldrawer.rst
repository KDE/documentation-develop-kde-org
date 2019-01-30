Global drawer
=============

.. container:: intend

   |desktopicon| |mobileicon|

.. container:: available plasma qwidgets

   |nbsp|


.. figure:: /img/Globaldrawer1.png
   :alt: Global drawer on mobile
   :figclass: border
   :scale: 40 %

   Global drawer on mobile

Purpose
-------

The Global Drawer is a standard element in KDE mobile applications. It
contains an application's main menu, and any functions which are not
part of the application's main usecases but are not specific to the
current context either.

Is this the right control?
--------------------------

.. figure:: /img/Globaldrawer3.png
   :figclass: border
   :alt: Global drawer on desktop
   :scale: 40 %

   Global drawer on desktop
   
Use a Global Drawer whenever your application has any functions which
are not central enough to the application's main purpose to put them in
the main user interface, and which are not dependent on the current
context. For context-specific actions (e.g. those affecting a selected
item), use the :doc:`Context Drawer <contextdrawer>`

Guidelines
----------

.. figure:: /img/Globaldrawer2.png
   :alt: Global drawer on desktop
   :scale: 40 %
   :figclass: border

   Hamburger button on the toolbar on desktop.

The Global Drawer is either opened by clicking on the hamburger button on the 
toolbar or by swiping from the left edge of the screen. It can be closed by 
swiping in the other direction, clicking the close button or tapping outside of 
it.

A Global Drawer may contain the following controls:

-  :doc:`Tabs <tab>`
-  A main menu
-  :doc:`Push Buttons <pushbutton>` to execute non-contextual actions
-  :doc:`Checkboxes <../editing/checkbox>` 
   or :doc:`Radio Buttons <../editing/radiobutton>` 
   to change settings which are commonly changed

The main menu

-  Must not have more than three levels
-  Should if possible not contain more elements than fit on the screen
-  Should contain an entry :doc:`Settings </patterns/content/settings>` in the last position if the
   application has settings which are not commonly changed
-  Selecting an entry in the menu either executes an action or goes down
   one level, replacing the menu with the items in the selected submenu
-  In lower menu levels, below the entries there is a button to go up
   one level.

Do not use the Menu Drawer for navigation purposes.

Code
----

Kirigami
^^^^^^^^

.. code-block:: qml

    ...
    import QtQuick.Controls 2.2 as Controls
    import org.kde.kirigami 2.4 as Kirigami
    ...
    
    Kirigami.ApplicationWindow {
        ...
        globalDrawer: Kirigami.GlobalDrawer {
            title: "..."
            titleIcon: "..."
            
            topContent: [
                ...
            ]
            
            actions: [
                Kirigami.Action {
                    iconName: "list-import-user"
                    text: i18n("&Import")
                },
                Kirigami.Action {
                    iconName: "list-export-user"
                    text: i18n("&Export")
                },
                Kirigami.Action {
                    iconName: "user-group-delete"
                    text: i18n("&Merge contacts")
                },
                Kirigami.Action {
                    iconName: "user-group-new"
                    text: i18n("&Search dupplicate contacts")
                },
                Kirigami.Action {
                    iconName: "configure"
                    text: i18n("&Settings")
                }
            ]
        }
        ...
    }
