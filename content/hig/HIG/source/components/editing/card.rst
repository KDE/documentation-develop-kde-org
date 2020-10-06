Card
====

Purpose
-------

A card serves as overview and an entry point for more detailed information and can
offer direct access to the most important actions on an item.

Guidelines
----------

Is this the right control?
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Don't use a card to display long texts.
-  Cards can be used to display items with different content types, e.g. images
   text, videos.
-  Don't use cards for content that should be directly comparable, use a 
   table view or a grid view for that.
-  If you would show more than 20 cards at a time, or if the user would have to scroll
   for more than three screen heights to see all of them, consider using a list instead.
-  Don't use cards with text input elements.
-  If your cards consist of just one image a grid with overlay actions 
   might be more suitable.

Behavior
~~~~~~~~

|desktopicon| Desktop
^^^^^^^^^^^^^^^^^^^^^

Cards are responsive. They resize to fit into the available
space.

.. raw:: html

   <video autoplay controls src="https://cdn.kde.org/hig/video/20180620-1/CardLayout1.webm" loop="true" playsinline="true" width="536" onended="this.play()" class="border"></video>


It is recommended that you adjust the number of cards displayed next to each other
depending on the available space.

.. raw:: html

   <video autoplay controls src="https://cdn.kde.org/hig/video/20180620-1/CardLayout2.webm" loop="true" playsinline="true" width="536" onended="this.play()" class="border"></video>

|mobileicon| Mobile
^^^^^^^^^^^^^^^^^^^

-  Cards only resize to orientation changes.
-  The number of columns only adjust to orientation changes.

Appearance
~~~~~~~~~~

It is recomended that you use the standard card layout for consistency, but cards can have 
a lot of different layouts.

   .. figure:: /img/Card6.qml.png
      :alt: Default card layout with a header image, text content, and optional 
            actions.
      
      Default card layout with a header image, text content, and optional 
      actions.

The only common requirement is the container around it. While cards can have a 
lot of
different layouts, each should focus only on one bit of information or content.

Here are some general recommendations for card layouts:

-  Use images, icons or video elements to create visually immersive cards. 
   Feel free to use different text sizes, cards are not a control for plain 
   text.

-  Use a well known aspect ratio for a header image
   
   .. figure:: /img/Card5.qml.png
      :alt: Cards with 16×9, 4×3, 1×1 header image aspect ratio.

      Cards with 16×9, 4×3, 1×1 header image aspect ratio.
      
-  Add a padding of at least largeSpacing to the card, except for videos 
   and images. These can ignore the padding and span the entire width or 
   height of a card.
   
   .. figure:: /img/Card2.qml.png
      :alt: Padding for text and buttons.

      Padding for text and buttons.


Code
----

Kirigami
~~~~~~~~

 - :kirigamiapi:`Kirigami: Card <Card>`
 - :kirigamiapi:`Kirigami: CardsGridView <CardsGridView>`
 - :kirigamiapi:`Kirigami: CardsLayout <CardsLayout>`
 - :kirigamiapi:`Kirigami: CardsListView <CardsListView>`
 
.. literalinclude:: /../../examples/kirigami/Card.qml
   :language: qml
