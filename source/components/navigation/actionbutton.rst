Primary Action Button
=====================

.. figure:: /img/Actionbutton1.png
   :figclass: border
   :alt:  Primary Action Button
   
   Primary action, create a new address book entry.


When to use
-----------

Use a Primary Action Button whenever there is a primary action for a
certain page of your application or for the whole application, which is
executed frequently. Typical primary actions are "Create New", "Edit,",
"Save" or "Send".

Aditionally you can opt to define two secondary primary actions that are 
placed left and right to the main primary button.

.. figure:: /img/Actionbutton2.png
   :figclass: border
   :alt:  Primary Action Button with two secondary buttons
   
   Call, message and write an email as primary actions.

If there is no primary action, you may opt to use the Primary Action
Button as a shortcut to navigate back to the application's main page
instead of omitting it completely. Do that if

-  navigating back to the main page is a frequent action in your
   application
-  or you use Primary Action buttons on some pages and would like to
   keep the layout consistent across pages
-  or drawers are frequently used
-  and the space occupied by the button is not urgently needed for the
   content

If the primary action is clearly associated with a specific element on
the user interface, place controls within the content instead.

How to use
----------

-  Provide a clear icon for the Primary Action Button since it has no
   text label
-  If the Primary Action Button changes its action within a page (for
   example switching to "save" when editing, change its icon as well
-  If you use the Primary Action Button as a shortcut for going to the
   main page, use the "go-home" icon from the actions category for it.

Desktop-specific
~~~~~~~~~~~~~~~~

If your application is using :doc:`column-based navigation </patterns/navigation/column>`

-  If there is a global Primary Action, associate it with the first
   column
-  If there is a Primary action for the context of a specific column,
   associated with the respective page

.. figure:: /img/Actionbutton3.png
   :figclass: border
   :alt:  Primary Action Buttons on Desktop
   
   Primary Action Buttons are placed in a :doc:`toolbar <toolbar>`

Code
----

Kirigami
~~~~~~~~

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
