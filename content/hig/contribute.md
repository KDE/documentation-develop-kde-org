---
title: Contribute
weight: 10
---

The HIG is written in [markdown](https://commonmark.org/help/), a
lightweight markup language. For example the chapter heading together
with the first paragraph looks like this in markdown

```
---
title: Contribute
---

The HIG is written in [markdown](https://commonmark.org/help/), a
lightweight markup language. For example the chapter heading together
with the first paragraph looks like this in markdown
```


Submitting changes
------------------

The source files are hosted in a [Git
repo](https://invent.kde.org/documentation/develop-kde-org.git). Tasks and
changes are organized via
[https://invent.kde.org](https://invent.kde.org/documentation/develop-kde-org/-/issues).

On every page of the HIG, a *See source code* link in the top right corner will
take you to the exact file used to generate that page. To learn how to submit
changes, see
https://invent.kde.org/documentation/develop-kde-org/-/blob/master/README.md


Page Structure
--------------

This defines the structure that should be used for writing pattern and
component pages for the HIG.

### Pattern

    Pattern name
    ==============

    Give a short into into the pattern.

    Examples
    --------

    Showcase the pattern with videos or images.

    When to use
    -----------

    Describe when to use this pattern and when not to use it.

    How to use
    ----------

    Describe how to use this pattern.

Pages about patterns should not include any details on implementation,
about behavior or appearance, but rather link to the corresponding
components needed to implement a pattern.

Optional: you can add subsections for desktop and mobile.

    When to use
    -----------

    Desktop
    ^^^^^^^

    Mobile
    ^^^^^^

### Component

    Component name
    ==============

    Purpose
    -------

    A very short description on why and how to use the component. This should 
    primarily link to the corresponding pattern pages.

    Example
    -------

    Showcase the component with a video or image.

    Guidelines
    ----------

    Is this the right control?
    ~~~~~~~~~~~~~~~~~~~~~~~~~~

    Describe when to use a component and when not.

    Behavior
    ~~~~~~~~

    Describe the behavior of the component.

    Appearance
    ~~~~~~~~~~

    Describe the appearance of the component.

    Code
    ----

    Kirigami
    ~~~~~~~~

    Link to the API and example code how to use the component with QML and 
    Kirigami.

    Qt Widgets
    ~~~~~~~~~~

    Link to the API and example code how to use the component with Qt Widgets.

Optional: you can add subsections for desktop and mobile.

    Behavior
    ~~~~~~~~

    Desktop
    """""""

    Mobile
    """"""

Code Examples
-------------

Adding examples to the HIG is very easy.

1.  Add a file with source code in the `./examples/` folder.

2.  Add the following markup at the point you want to insert the
    example:

    ``` {.rst}
    .. literalinclude:: /../../examples/kirigami/InlineMessage.qml
       :language: qml
    ```

Creating media
--------------

See `media` on how to create media files
for the HIG.
