---
title: Next steps
group: introduction
weight: 7
description: >
  What to do after finishing your first simple Kirigami application
aliases:
  - /docs/kirigami/introduction-next_steps/
---

## What we have built

Over the past few tutorials you have built a basic but functional Kirigami application that lets you add, edit, and delete date countdowns. In doing so we have learned about Kirigami and QtQuick components, some of QML's systems, basic application layouts, and more. Not bad at all! 

You now have a grasp of the basics that make up many of KDE's most popular applications. You might be asking yourself: what now? 

Well, don't worry: we have taken the time to provide some pointers as to where you can go from here.

## Contributing to KDE projects

One of the best ways to improve your development skills is by putting them into practice. KDE's community is welcoming and always looking for more passionate developers!

We have several pieces of documentation that can help guide you towards becoming a contributor. We recommend you take a look at the developer-specific section of [our 'Get Involved' guide](https://community.kde.org/Get_Involved/development) which can help you learn more about the KDE Community's development workflow. We also recommend you take a look at our documentation for KDE's GitLab instance, called [Invent](https://community.kde.org/Infrastructure/GitLab), as you will likely need to interact with it during the development process. The KDE Community interacts mainly through Matrix, and we also have [a page on the community wiki](https://community.kde.org/Matrix) that will guide you with setting up with your very own account.

{{< alert title="Note" color="info" >}}
While interacting with others in the KDE Community, please make sure you abide by the [Code of Conduct](https://kde.org/code-of-conduct/).
{{< /alert >}}

With your newfound skills you are in a good position to begin contributing to Kirigami projects. Thankfully, many of KDE's most popular applications and components are built with this framework. Here are a list of projects you are welcome to help with.

### Beginner-friendly Kirigami projects

| Project                             | What it is                                              | Links                             |
| ---                                 | ---                                                     | ---                               |
| <img src="https://apps.kde.org/app-icons/org.kde.calindori.svg" width="50" height="50"><br />Calindori | A touch friendly calendar application designed for mobile devices |  [KDE Apps page](https://apps.kde.org/en/calindori)<br />[KDE Invent page](https://invent.kde.org/plasma-mobile/calindori) |
| <img src="https://apps.kde.org/app-icons/org.kde.kdeconnect.kcm.svg" width="50" height="50"><br />KDE Connect  | A multi-platform app that allows your devices to communicate (eg: your phone and your computer).  | [Home page](https://kdeconnect.kde.org/)<br />[KDE Community Wiki page](https://community.kde.org/KDEConnect)<br />[KDE Invent page](https://invent.kde.org/network/kdeconnect-kde) |
| <img src="https://invent.kde.org/graphics/koko/-/raw/master/logo.png" width="50" height="50"><br />Koko | An image viewer designed for desktop and touch devices. | [Userbase page](https://userbase.kde.org/Koko)<br />[KDE Invent page](https://invent.kde.org/graphics/koko) |
| <img src="https://apps.kde.org/app-icons/org.kde.kontrast.svg" width="50" height="50"><br />Kontrast | A color contrast checker that tells you if your color combinations are accessible for people with color vision deficiencies. | [KDE Apps page](https://apps.kde.org/en/kontrast)<br />[KDE Invent page](https://invent.kde.org/accessibility/kontrast)  |

### More complex Kirigami projects

| Project                                  | What it is                                         | Links                             |
| ---                                      | ---                                                | ---                               |
| <img src="https://apps.kde.org/app-icons/org.kde.discover.svg" width="50" height="50"><br />Discover | An application that helps you find and install applications, games, and tools. | [KDE Apps page](https://apps.kde.org/en/discover)<br />[KDE Userbase page](https://userbase.kde.org/Discover)<br />[KDE Invent page](https://invent.kde.org/plasma/discover)  |
| <img src="https://apps.kde.org/app-icons/org.kde.elisa.svg" width="50" height="50"><br />Elisa | A music player that strives to be simple and nice to use. | [Home page](https://elisa.kde.org/)<br />[KDE Apps page](https://apps.kde.org/en/elisa)<br />[KDE Community Wiki page](https://community.kde.org/KDEConnect)<br />[KDE Invent page](https://invent.kde.org/multimedia/elisa)  |
| <img src="https://invent.kde.org/utilities/kongress/-/raw/master/org.kde.kongress.svg" width="50" height="50"><br />Kongress  | A companion application for conference attendees. | [KDE Invent page](https://invent.kde.org/utilities/kongress)  |
| <img src="https://apps.kde.org/app-icons/org.kde.neochat.svg" width="50" height="50"><br />NeoChat | A client for Matrix, the decentralized communication protocol for instant messaging.  | [KDE Apps page](https://apps.kde.org/en/neochat)<br />[KDE Invent page](https://invent.kde.org/network/neochat) |

## Learning more

Not feeling quite ready yet? That's okay too. 

Many of the projects listed above are invaluable learning resources. You can poke through the code and see how experienced developers have created fully-featured applications, and use these techniques yourself.

If you feel you need a more gentle approach, we have also compiled some resources we think you might find useful.

### The backend and C++

While we have learned a lot about QML, we haven't really touched upon how to handle backend code all that much. This is, however, an essential facet of KDE application development.

#### C++/Qt with Kirigami

In the advanced section of this Kirigami documentation we have some pages that can help you get started:

| Page  | Topic |
| ---   | ---   |
| [Understanding CMakeLists](/docs/kirigami/advanced-understanding_cmakelists)  | Learn all about CMake and how to compile your applications. |
| [Figuring out main.cpp](/docs/kirigami/advanced-maincpp)  | Getting to grips with the central C++ file that handles your applications' initialisation. |
| [Connect logic to your QML user interface](/docs/kirigami/advanced-connect_backend) | Add advanced functionality to your Kirigami application and connect it to your UI.  |

#### Beginner C++ resources

If you are completely new to C++ there are numerous resources available throughout the web. Here are some that may be useful.

| Resource  | Topic |
| ---       | ---   |
| [Wikibooks C++](https://en.wikibooks.org/wiki/C%2B%2B_Programming)  | A comprehensive wikibook with C++ lessons and exercises |
| [W3Schools C++](https://www.w3schools.com/cpp/cpp_intro.asp) | A set of C++ tutorials and other resources aimed at beginners |
| [LearnCpp](https://www.learncpp.com/) | Tutorials to get to grips with C++ |
| [cppreference](https://en.cppreference.com/w/)  | A reference site for C++ |

### Creating classic KDE applications using QtWidgets

If you'd like to work on more complex KDE applications such as Dolphin, Kontact, or Kate, you will need to learn more about how to use QtWidgets, which encompass a completely different way of developing user interfaces with Qt. While not interchangeable with QML/Kirigami - they each have a different set of tradeoffs - older and more complex KDE applications tend to be built with QtWidgets.

QtWidgets are somewhat more daunting to work with than QML (and *much* more C++ intensive!). Luckily, we have [a set of tutorials](/content/docs/getting_started) in the KDE Docs that will help you become more familiar with them.

### More QML and QtQuick

The Qt project is extensive, and so are QML and QtQuick. There is a lot of functionality we haven't covered, but there is a lot of documentation we can pull from to find out more.

- If you want to look up what specific components do, look no further than [Qt's official QML documentation.](https://doc.qt.io/qt-5/qtquick-index.html)
- If you are looking for a more guided approach to learning, [the QMLBook](https://qmlbook.github.io/) is a great place to start.

### More Kirigami

This documentation includes a lot more about Kirigami. You can poke through some of the Components pages to find out more about some of the QML components that Kirigami provides for you to use.

We recommend you also take a look at Kirigami Gallery (`kirigami2gallery`), an application designed by KDE developers to demonstrate Kirigami's tools and capabilities. It provides both interactive examples of Kirigami components as well as links to the source code of these examples so you can see how they were built. You can read more about Kirigami Gallery in our [specific Kirigami Gallery tutorial](/docs/kirigami/introduction-kirigami-gallery).

# The sky is the limit!

Don't be intimidated by all the material on here! No one starts off being able to create something like Plasma from scratch. But KDE is no multi-billion dollar company with a high barrier for entry - we have no five-round coding interviews! - and as long as you are nice, you will be welcomed.

Good luck!
