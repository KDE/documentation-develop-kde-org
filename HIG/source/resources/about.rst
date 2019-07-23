About
=====

Human interface guidelines (HIG) are software development documents that
offer application developers a set of recommendations. Their aim is to
improve the experience for users by making application interfaces more
consistent and hence more intuitive and learnable.

The quality and acceptance of a guideline depends to a large extent on
its set-up. A good structure guarantees quick access to the information
the reader looks for. Additional, links to the rationales behind the
guideline as well as alternative solutions are helpful. A HIG should not
only include widgets and their appearance but also core usability goals,
generic design specifications, and user demands. To manage all these
aspects we have chosen to adopt the 
“\ `Universal Model of a User Interface`_\ ” by Bob Baxley (2003) as basis
for the new KDE HIG. This model has been slightly adjusted to account for 
more recent approaches to visual design guidelines.

The central aim of KDE HIG is to create a consistent experience across
the software compilation. This means to apply the same visual design and
user experience as well as consistent access and predictable behavior of
common elements in the interface – from simple ones such as buttons and
icons up to more complex constructions, such as dialog boxes.

The model consists of three tiers, each of which is made up of three
layers:

#. Structure

      Structure contains concept, design vision and principles, task
      flow and organization. It should answer question like: What
      constitutes KDE software?, Who is the user of KDE software?, and
      Where do we want to go in future?

   #. Design Vision and Principles

         There are almost always multiple solutions to any given user
         interface problem. Consistency in the choice of solutions and,
         ultimately, the experience of the user, is guided by a Design
         Vision. As such, the design vision is aspirational by
         definition; it is a high level description of the desired user
         experience in not just one application, but across multiple KDE
         applications and the KDE workspace. A set of Design Principles
         are derived from the design vision as a means to provide more
         specific guidance on how to achieve that desired user
         experience.

   #. Conceptual Model

         The conceptual model is the most fundamental aspect of the
         interface, describing the relationship between the interface
         and the outside world. The purpose of the conceptual model is
         to draw on the user’s past experiences so they can readily
         understand basic operations and accurately predict
         functionality.

   #. Organizational Model

         The organizational model describes how the system’s content and
         functionality are ordered and categorized. Also known as the
         information architecture, the organizational model encompasses
         both the classification scheme as well as the model of
         association, hierarchy versus index for example.

#. Behaviour

      Behaviour includes viewing and navigation, editing and
      manipulation and user assistance. All elements of the Behaviour
      layer must satisfy the Design Principles. This layer is more like
      ‘traditional’ guidelines, addressing questions like: How should a
      button behave in case of…?, or What widget do I have to use for a
      selection of one out of a few items?
      All HIGs assume that the controls referenced in the following
      "Implementation" sections are used. Therefore they only contain
      guidelines for aspects which can be changed by the developer, to
      keep them as concise as possible.
      If you feel your application needs something which the referenced
      standard KDE or Qt widget does not provide, don't create your own
      custom replacement, because it might violate the best practices which
      are implemented in the standard widget. Instead, ask the KDE HIG
      team for advice on how to solve your specific problem.

   #. Viewing and Navigation

         The Viewing and Navigation layer encompasses the wide variety
         of behaviors and operations that allow users to navigate the
         interface and affect its presentation.

   #. Editing and Manipulation

         The Editing and Manipulation layer contains the behaviors that
         result in permanent changes to user’s stored information. …
         Behaviors in this layer can often be recognized by the
         following traits: they result in permanent, stored changes;
         they require an implicit or explicit save operation; and they
         typically require validation of the input data.

   #. User Assistance

         Interface elements that inform users of the application’s
         activity and status, as well as elements dedicated to user
         education, are all contained in the User Assistance layer. This
         includes online help, error alerts, and status alerts.

#. Presentation

      Presentation deals with visual design of the user interface -
      layout, style and text. It’s all about the appearance of the
      application including the platform style’s margins and spacing,
      colours, fonts, icon designs, etc. These questions primarily
      concern designers, developers, translators and the promotion team.

   #. Layout

         The various design decisions governing the placement , ordering
         ans spacing of onscreen elements are expressed in the Layout
         layer. In addition to providing an ordered visual flow, the
         Layout layer also supports the Behavior tier by arranging
         elements in a manner that helps communicate behavior,
         importance, and usage.

   #. Style

         The Style layer is concerned with emotion, tone, and visual
         vocabulary. Because it is the most visible and concrete aspect
         of an interface, it typically accounts for people’s first
         impression of a product. Style is influenced by the use of
         color, the design of icons throughout the interface and the use
         of typography. All elements of the Style layer must satisfy the
         Design Principles. This allows the style to change as necessary
         while still preserving the user experience secured by the
         Design Principles.

   #. Text

         Contained within the Text layer are all the written,
         language-based elements of the interface. This includes the
         labels used to represent the organizational model, the names of
         the input and navigational controls contained in the Viewing
         and Navigation layer, and the alert messages and help text used
         by the User Assistance layer.

.. _Universal Model of a User Interface: http://www.baxleydesign.com/pdfs/dux03_baxleyUIModel.pdf

