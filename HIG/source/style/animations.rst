Animations
==========

Purpose
~~~~~~~

Animation can be an effective tool in guiding user focus towards newly changed
elements, and to avoid sudden glaring changes.

Animations can exist also exclusively for visual flair. This is not covered by
this HIG.


Guidelines
~~~~~~~~~~

Default animations should be as follows:

 - Items animating from visible to invisible should be InCubic
 
   .. raw:: html

     <video autoplay src="https://cdn.kde.org/hig/video/20200122/Hide.webm" 
     loop="true" playsinline="true" width="540" controls="true" 
     onended="this.play()" class="border"></video>
   
 - Items animating from invisible to visible should be OutCubic
 
   .. raw:: html

     <video autoplay src="https://cdn.kde.org/hig/video/20200122/Show.webm" 
     loop="true" playsinline="true" width="540" controls="true" 
     onended="this.play()" class="border"></video>

 - Items animating from visible to visible should be InOutCubic

   .. raw:: html

     <video autoplay src="https://cdn.kde.org/hig/video/20200122/Move.webm" 
     loop="true" playsinline="true" width="480" controls="true" 
     onended="this.play()" class="border"></video>


Where going off screen or out of the window is considered as going invisible.

Code
~~~~

Kirigami
--------

 - `QML: Animation 
   <https://doc.qt.io/qt-5/qml-qtquick-animation.html>`_
 - `QML: Behavior 
   <https://doc.qt.io/qt-5/qml-qtquick-behavior.html>`_
   
.. literalinclude:: /../../examples/kirigami/Move.qml
   :language: qml
