Responsiveness
==============

Introduction
------------

Responsiveness means that the user interface adjusts to changes in screen or 
window size. While Plasma and especially Kirigami are highly responsive, this is 
not a replacement for :doc:`optimized convegence <convergence>`. It is not 
supposed to be used as a replacement for different UI and UX for different 
​interaction methods (mouse, touch, pointer, remote, ...) or different ​form 
factors like mobiles and televisions. Instead, it means to adapt to different 
screen sizes in the same form factor class, like different window 
sizes and screen resolutions in ​desktops and laptops.

.. raw:: html

   <video src="https://cdn.kde.org/hig/video/20180620-1/CardLayout1.webm" 
   loop="true" playsinline="true" width="536" controls="true" 
   onended="this.play()" class="border"></video>

Examples of responsive behavior:

*  Components can display more or less content, depending on the available
   space.
*  Margins between elements can shrink and grow
*  Multi-column navigation layouts, grids and grid-like layouts can change the 
   number of displayed columns
*  Images can resize 

Although elements can resize vertically, horizontal or in both directions, it 
is recommended that row-like elements such as menu bars only 
shrink or grow horizontally. 

.. raw:: html

   <video src="https://cdn.kde.org/hig/video/20180620-1/Responsive1.webm" 
   loop="true" playsinline="true" width="536" controls="true" 
   onended="this.play()" class="border"></video>
   
Action bar shrinking only in the horizontal direction.

Keep in mind that not all controls or parts of a layout can and should be 
responsive. Often it is more important to retain the size for usability, 
familiarity and alignment and aim for :doc:`optimized convergence 
<convergence>` 
by selecting different 
:doc:`navigation <../patterns/navigation/index>`, 
:doc:`command </patterns/command/index>` and 
:doc:`content </patterns/content/index>` patterns for different formfactors.

It is recommended to test your user interface against the most common  
screen sizes of the targeted form factor.

Folding points
--------------

As window size changes, e.g. becauce screen orientation changes on mobile 
devices, windows are used in a splitt screen, or manual resizing from the user, 
it is recommended to react to the window width at special points, the 
predefined folding points. Depending on the application, it might make sense to 
change the user interface on one or on multiple folding points.

=== ======================= ===========================
FP  Window size             Examples
=== ======================= ===========================
xs  <= 360 px               A typical mobile phone, 
                            application in small splitt 
                            screen
s   <= 600 px               A large mobile phone, TVs
m   <= 800 px               A phablet, small tablet, 
                            a mobile phone in landscape
l   <= 1024 px              A large tablet, or tablet 
                            in landscape
xl  <= 1600 px              Laptop screen
xxl > 1600 px               Wide desktop screen
=== ======================= ===========================


.. caution::
   These are not physical pixels of a device or window, but DPI independent 
   pixels, see :doc:`/layout/units` for more information.
