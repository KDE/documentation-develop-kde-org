Swipe list item
===============

.. container:: intend

   |desktopicon| |mobileicon|

.. container:: available plasma qwidgets

   |nbsp|

Purpose
-------

This uses an :doc:`on-demand pattern </patterns/command/ondemand>` as
alternative to always visible controls in lists. If the user
often performs tasks on single items of a list, add a handle on the side
the list item (next to the context drawer's edge, defined by a
system-wide configuration) which.

Example
-------

.. image:: /img/Slide_to_reveal.jpg
   :alt:  Slide to reveal actions
   :scale: 30 %

Guidelines
----------

Is this the right control
~~~~~~~~~~~~~~~~~~~~~~~~~

-  See :doc:`on-demand pattern </patterns/command/ondemand>` for
   general recomendations.
-  |desktopicon| If only one action is available, most the time it's better 
   to not use the on-demand pattern, but show the action right away.

Behavior
~~~~~~~~

|desktopicon| Desktop
"""""""""""""""""""""

.. image:: /img/desktop-listview.png
   :alt:  Hover to reveal
   :scale: 60 %

On-demand controls are shown when hovering over the item with the cursor.
A handle is shown to support devices with touch screens. Swiping the handle 
right to left reveals the actions. 
As soon as the user taps anywhere else or the pointer is not any longer 
hovering the item, the handle is slid back.

|mobileicon| Mobile
"""""""""""""""""""

.. raw:: html

   <video src="https://cdn.kde.org/hig/video/20181031-1/Swipelistitem1.webm" 
   loop="true" playsinline="true" width="320" controls="true" 
   onended="this.play()" class="border"></video>

On-demand controls are revealed by sliding a handle from right to left
to reveal them. As soon as the user taps anywhere else, the
handle is slid back.

Appearance
~~~~~~~~~~

|desktopicon| Desktop
"""""""""""""""""""""

   .. figure:: /img/Listview3.png
      :alt: Default padding of an item
      :scale: 60 %
      :figclass: border
      
      Default padding of a swipelistitem on desktop

Items have a padding of :doc:`Units.smallSpacing </layout/units>` on the top 
and bottom and a padding of :doc:`2 * Units.smallSpacing </layout/units>` on 
the left.

   .. figure:: /img/Listview4.png
      :alt: Label is vertically centered
      :scale: 60 %
      :figclass: border
      
      Label is vertically centered

Labels are vertically centered within the list item. If the list item includes 
an icon, add a :doc:`2 * Units.smallSpacing </layout/units>` margin between 
the icon and the label.


|mobileicon| Mobile
"""""""""""""""""""

   .. figure:: /img/Listview1.png
      :alt: Default padding of an item
      :scale: 60 %
      :figclass: border
      
      Default padding of a swipelistitem on mobile

Items have a padding of :doc:`Units.largeSpacing </layout/units>` on the top 
and bottom and a padding of :doc:`2 * Units.largeSpacing </layout/units>` on 
the left.

   .. figure:: /img/Listview2.png
      :alt: Label is vertically centered
      :scale: 60 %
      :figclass: border
      
      Label is vertically centered

Labels are vertically centered within the list item. If the list item includes 
an icon, add a :doc:`2 * Units.largeSpacing </layout/units>` margin between 
the icon and the label.

Code
----

Kirigami
~~~~~~~~

.. code-block:: qml

    ...
    ListView {
        ...

        delegate: Kirigami.SwipeListItem {
            id: lineItem
            
            contentItem: Row {
                spacing: lineItem.leftPadding

                Item {
                    width: Kirigami.Units.iconSizes.medium
                    height: width

                    Image {
                        id: avatar
                        width: parent.width
                        height: width
                        source: "..."
                        visible: false
                    }
                    OpacityMask {
                        anchors.fill: avatar
                        source: avatar
                        maskSource: Rectangle {
                            height: avatar.width
                            width: height
                            radius: height / 2
                        }
                    }
                }
                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "..."
                }
            }
            actions: [
                Kirigami.Action {
                    text: i18n("&Make call")
                    iconName: "call-start"
                },
                Kirigami.Action {
                    text: i18n("&Write mail")
                    iconName: "mail-message"
                }
            ]
        }
        
        ...
    }
    ...
