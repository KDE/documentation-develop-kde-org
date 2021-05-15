---
title: Card
group: editing
subgroup: selection
weight: 1
---

Purpose
-------

A card serves as overview and an entry point for more detailed
information and can offer direct access to the most important actions on
an item.

Guidelines
----------

### Is this the right control?

-   Don't use a card to display long texts.
-   Cards can be used to display items with different content types,
    e.g. images text, videos.
-   Don't use cards for content that should be directly comparable, use
    a table view or a grid view for that.
-   If you would show more than 20 cards at a time, or if the user would
    have to scroll for more than three screen heights to see all of
    them, consider using a list instead.
-   Don't use cards with text input elements.
-   If your cards consist of just one image a grid with overlay actions
    might be more suitable.

### Behavior

#### Desktop

Cards are responsive. They resize to fit into the available space.

<video autoplay controls 
   src="https://cdn.kde.org/hig/video/20201125/CardLayout1.webm" loop="true" 
   playsinline="true" width="536" onended="this.play()" class="border"></video>


It is recommended that you adjust the number of cards displayed next to
each other depending on the available space.

<video autoplay controls 
   src="https://cdn.kde.org/hig/video/20201125/CardLayout2.webm" loop="true" 
   playsinline="true" width="536" onended="this.play()" class="border"></video>

#### Mobile

-   Cards only resize to orientation changes.
-   The number of columns only adjust to orientation changes.

### Appearance

It is recommended that you use the standard card layout for consistency,
but cards can have a lot of different layouts.

![](/hig/Card6.png)

The only common requirement is the container around it. While cards can
have a lot of different layouts, each should focus only on one bit of
information or content.

Here are some general recommendations for card layouts:

-   Use images, icons or video elements to create visually immersive
    cards. Feel free to use different text sizes, cards are not a
    control for plain text.

-   Use a well known aspect ratio for a header image

    ![Cards with 16×9, 4×3, 1×1 header image aspect
    ratio.](/hig/Card5.png)

-   Add a padding of at least largeSpacing to the card, except for
    videos and images. These can ignore the padding and span the entire
    width or height of a card.

    ![Padding for text and buttons.](/hig/Card2.png)

    ![Spacing between banner image, text and buttons.](/img/Card7.png)

Code
----

### Kirigami

- Kirigami: [Card](docs:kirigami2;Card)
- Kirigami: [CardsGridView](docs:kirigami2;CardsGridView)
- Kirigami: [CardsLayout](docs:kirigami2;CardsLayout)
- Kirigami: [CardsListView](docs:kirigami2;CardsListView)

{{< readfile file="/content/hig/examples/kirigami/Card.qml" highlight="qml" >}}
