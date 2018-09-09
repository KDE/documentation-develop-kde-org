Optimized convergence
=====================

Kirigami is made with convergent applications in mind. "Convergent" for
KDE means that one instance of an application can adapt its user
interface (UI) depending on the context, most importantly depending on:

-  Primary input method (for now "pointing device + keyboard" vs. touch,
   in the future possibly also simple directional inputs like TV
   remotes, game controllers, in-vehicle controls, ...)
-  Physical screen size (for now phone vs. tablet vs. laptop/desktop
   screen, in the future possibly also TV screens, smart watches, ...)
-  Screen orientation / aspect ratio (mostly portrait vs. landscape)

Kirigami is not about simple "responsive" user interfaces, though (i.e.
those which just adapt their layout a bit), but really optimized ones.
For example, "pointing device + keyboard" UIs should use
mouse-over/hover effects to reveal inline controls, whereas touch UIs
should use touch gestures.

When navigating through hierarchies, portrait mode mode shows only one
column/page at a time, whereas landscape shows multiple ones.

UIs for screens with different input methods show more controls permanently, whereas UIs for
small screens show only the most important controls always, while
showing secondary controls only on demand. The convergence for these 
screens will prefer to show only the most important controls when the
screen has become smaller. Developers and designers must determine which
elements on the screen are the most relevant for use.

Kirigami Components will do some of that adaptation/optimization work
for you, but be prepared to also manually adapt your user interface for
different devices.
