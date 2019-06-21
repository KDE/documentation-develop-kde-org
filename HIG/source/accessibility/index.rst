Accessibility
=============

.. toctree::
   :maxdepth: 1
   :titlesonly:
   :hidden:

   checklist
   
Introduction
------------

    Accessibility is the design of products, devices, services, or environments 
    for people with disabilities. The concept of accessible design and 
    practice of accessible development ensures both "direct access" (i.e. 
    unassisted) and "indirect access" meaning compatibility with a person's 
    assistive technology.
    
    *Source*: `<https://en.wikipedia.org/wiki/Accessibility>`_

But good accessibility benefits all users. A working keyboard navigation and 
well choosen colors and fonts setting not only help people with low vision, 
blindness, deafness, cognitive or motor impairments or 
situational disabilities, like a broken hand, but also improve the workflow and 
usability for all users.

Fonts and Colors
----------------

Many users have some deficiencies when it comes to seeing. This doesn't always 
mean that they are blind. For some people it is enough when 
:doc:`fonts </style/typography>` are clear and the 
:doc:`color scheme </style/color/index>` can be adjusted. This is something 
every application should do in any case, so here is the list:

-  Follow the user interface guidelines! This will get you quite far.
-  Check that color scheme changes apply |br|
   Try switching to a :doc:`dark color scheme </style/color/dark>` and see that 
   your application is still usable 

-  Test changing the :doc:`font size </style/typography>`

   -  Switch to different fonts and see that they apply
   -  Increase the font size and make sure that the application layout still 
      works


Keyboard
--------

When you have problems seeing, the mouse is quite hard to use. The keyboard is a 
lot more reliable. Therefor it is important that applications can be used with 
the keyboard. For some users, using a mouse is difficult because of motor skill 
issues. Making applications keyboard accessible benefits everyone, since it 
allows us to use shortcuts to use the applications more efficiently.

-  Try to operate your application with the TAB key

   -  Make sure that the tab order is correct
   -  Start your application and do a common task without using the mouse
      
      Note where you had trouble and think about possible improvements in the
      UI or keyboard shortcuts that are missing

Screen Reader
-------------

There is a lot you can help with to make applications accessible to screen 
reader users. We refer to screen readers and other assistive technology often as 
AT.

.. TODO::

   Setup Screen Readers with KDE
   Gives detailed setup instructions for screen readers.

    
Testing
-------

This section gives a quick intro what to look for when testing an application 
with a screen reader.


Once you have an application running with the screen reader: Make sure Orca says 
something intelligible for all elements. When it reads a GUI element it should 
say the label and type, eg: "File, Menu" or "OK, Button". When you have a button 
that does not have a label, maybe because it shows a picture only, add 
accessibility hints. Try navigating the more troublesome elements - comboboxes 
and lists and such.


Fixing missing information
--------------------------

For many things there are usually easy fixes involving no advanced programming 
skills but just fixing some details.

For this tutorial we assume that you are dealing with a QWidget that is seen by 
the AT but does for example give not enough information.

There are two important properties that every QWidget has: an "Accessible Name" 
and an "Accessible Description". The name is short, for example the label on a 
button. It should always be short. The description on the other hand is the more 
verbose "this button does foo and then bar". Qt will try hard to return 
something for the name. In case of a button, usually the text on the button is 
returned. But if your button has text that makes only sense when seeing the 
arrangement of buttons, or only has an image as label, you need to help the AT 
read the button. If you don't, it will only say the type of the widget, "Button" 
is not a very helpful information.


Fixing Accessible Name and Description
--------------------------------------

Fire up Qt designer if the app uses .ui files. You'll find the properties and 
can type the name/description right in. After saving the file, rebuild and 
install the application. You are done, submit a patch to fix the ui file.

If the widget is created in the code, just need to find where. Once you found 
the widget, usually where it's created, add some code to it:

.. code-block:: c++
   
   button->setAccessibleName(i18n("Open"));
   button->setAccessibleDescription(i18n("Opens a file dialog to select a new 
   foo"));

Send your patch.

Sometimes you also want to override the label for a different reason. One of my 
test apps was the calculator example from Qt. It has a memory recall button 
labelled "MR". Orca will insist on this being the "Mister" button, unless told 
otherwise.


Complex Widgets
---------------

For some widgets the above is not enough. You will have to create 
QAccessibleInterfaces for widgets that you create yourself. For example Kate has 
an interface for its text editing area. Sometimes you need to inherit 
QAccessibleTextInterface or QAccessibleValueInterface in order to make the 
widgets properly accessible. Refer to the Qt documentation how to do this.


QGraphicsView
-------------

Currently there is no support for accessibility in QGraphicsView.


Qt Quick (QML)
--------------

For Qt 5, refer to the 
`documentation <https://doc.qt.io/qt-5/accessible.html>`_ on how to create 
accessible QML applications. The concepts are generally the same as for QWidget 
based applications.
