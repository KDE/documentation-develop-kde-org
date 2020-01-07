Animations
=======


Purpose
~~~~~~~~~~~~

Animation can be an effective tool in guiding user focus towards newly changed
elements, and to avoid sudden glaring changes.

Animations can exist also exclusively for visual flair. This is not covered by
this HIG.

Guidelines:
~~~~~~~~~~~~

Default animations should be as follows:

 - Items animating from visible to invisible should be InQuad
 - Items animating from invisible to visible should be OutQuad
 - Items animating from visible to visible should be InOutQuad

Where going off screen or out of the window is considered as going invisible.
