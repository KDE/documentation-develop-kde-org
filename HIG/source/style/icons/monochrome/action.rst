Action Icons
============
Action icons are used to depict actions. They come in two sizes: 16px and 22px, and
always use the `monochrome style <index.html>`_.

Purpose
-------

Action icons indicate actions that a user is able to take on
on-screen elements. They allow a user to intuit the behavior of
controls.

Design
------

Color
~~~~~
Action icons should use a base color of Shade Black. 
Additional colors can indicate information about an
action to a user.

.. container:: flex

   .. container::

      .. figure:: /img/action-colour-do.png
         :figclass: do

         :noblefir:`Do.` |br|
         Use Shade Black as your icon's base—
         this color is neutral and has the most
         contrast against a white background.

   .. container::

      .. figure:: /img/action-colour-dont.png
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't use a bright color for your icon's 
         base—this distracts the user without
         adding extra information to your icon.

.. container:: flex

   .. container::

      .. figure:: /img/action-colour-destructive-do.png
         :figclass: do

         :noblefir:`Do.` |br|
         Use red to indicate destructive actions.

   .. container::

      .. figure:: /img/action-colour-destructive-dont.png
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't use red to indicate other types of actions—
         this will confuse the user as to what the actions do.

.. figure:: /img/action-colour-adaptable.png

   Action icons are able to dynamically change their color based on context.
   Implementation details can be found at `community.kde.org \
   <https://community.kde.org/Guidelines_and_HOWTOs/Icon_Workflow_Tips#Embedding_stylesheets_in_SVGs>`_.

Metaphor
~~~~~~~~

Appropriate and consistent metaphors should be used to inform
a user about the action an icon represents.

.. container:: flex

   .. container::

      .. figure:: /img/action-metaphor-do.png
         :figclass: do

         :noblefir:`Do.` |br|
         Use appropriate metaphors to indicate what
         an action does.

   .. container::

      .. figure:: /img/action-metaphor-dont.png
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't use inaccurate or conflicting metaphors—
         this will mislead your user and lead to frustration.

Accessibility
-------------

When using actions icons to indicate an action, a textual name and description
of the action should be provided for accessibility purposes. Screen readers
can take advantage of this information to allow more people to use your application.
Your local jurisdiction may also require that your application meet accessibility standards.
Care should also be taken to reinforce information conveyed by an icon in multiple ways—not everyone
is able to distinguish between all colors.

.. container:: flex

   .. container::

      .. figure:: /img/action-accessibility-do.png
         :figclass: do

         :noblefir:`Do.` |br|
         Provide a name and description that describe
         what an icon's action does.

   .. container::

      .. figure:: /img/action-accessibility-dont.png
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't describe the icon's appearance—this is
         useless information that will make your application
         harder to use.

.. container:: flex

   .. container::

      .. figure:: /img/action-accessibility-color-do.png
         :figclass: do

         :noblefir:`Do.` |br|
         Reinforce information in multiple ways to allow
         users with conditions such as colorblindness to
         get the message.

   .. container::

      .. figure:: /img/action-accessibility-color-dont.png
         :figclass: dont

         :iconred:`Don't.` |br|
         Don't only rely on color to convey information—
         this makes it harder for users with colorblindness
         to distinguish two like icons apart.