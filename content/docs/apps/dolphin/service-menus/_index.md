---
title: "Creating Dolphin service menus"
linkTitle: "Creating Dolphin Service Menus"
weight: 1
description: Learn how to create Dolphin service menus
aliases:
  - /docs/dolphin/service-menus/
---

_The ability to select mimetype-specific actions from a KDE file manager's context menu is an often requested feature. The pleasant surprise is that this is already possible. The even more pleasant surprise is that you don't need to be a software developer to create new actions. This article details step-by-step how to quickly and easily add new actions to KDE file manager context menus._

## Introduction

In KDE-speak a "servicemenu" is a special entry that appears in a context menu (or other context-based interfaces) for a file (or for directory), depending on the type of files that are selected.

For example, if you have the KDE file archive utility Ark installed you will see a menu entry to "Extract here..." whenever you right-click on a file archive. The option to "Extract here..." is a servicemenu.

Creating new servicemenus doesn't require to be a programmer or a KDE wizard to make them. In this tutorial, we will be creating a set of actions that allows us to set an image as our desktop wallpaper just by right-clicking on it and selecting "Use As Wallpaper". By the end of this tutorial, you should be able to create your own servicemenus with ease.

## Where the Servicemenus are Located

Servicemenus are defined using files with the extension `.desktop`, which are the same kind of files that are used to create entries in the Plasma launcher. These servicemenu files are found in the `kio/servicemenus` directory in the generic data locations. The following command prints the path used to find this directory. Multiple directories in this path are separated by a `:`. To find the servicemenus at run time, the directories are searched in the order in which they appear in the path.

```bash
qtpaths --locate-dirs GenericDataLocation kio/servicemenus
```

In the case of default setups, the path for locating servicemenus has directories the following order:

```bash
~/.local/share/kio/servicemenus
/usr/share/kio/servicemenus
```

When a service menu is installed from Dolphin using Get-Hot-New-Stuff, the local file location is used, because it does not require admin privileges. However, you need to mark the desktop file as executable for it to be considered authorized, because the location is not a standard location that is authorized by default.

```bash
touch myservicemenu.desktop
chmod +x myservicemenu.desktop
```

<details><summary>Location of servicemenus in older versions of KDE (deprecated):</summary>

In KDE Frameworks versions prior to 5.85, the servicemenu files are at the following default locations, which are deprecated. Each of these directories may also have a `ServiceMenus` subdirectory containing servicemenu files.

```bash
~/.local/share/kservices5
/usr/share/kservices5
```

The following command prints the path showing the order of these locations as explained above:

```bash
kf5-config --path services
```
Note that servicemenus in these locations require an additional key, `ServiceTypes=KonqPopupMenu/Plugin`, as explained below.
</details>


## The Start of Servicemenu

We will begin creating our wallpaper servicemenu by choosing a name for the file: setAsWallpaper.desktop sounds good. The only thing that really matters with regards to the name is that it is unique and that it ends with .desktop. Next we'll open up the file in a text editor. The first thing we will put in the file is the "Desktop Entry" section: 

```ini
[Desktop Entry]
Type=Service
MimeType=image/png;image/jpeg;
Actions=setAsWallpaper
```

Every servicemenu file must have these four lines. Let's examine each of these lines one at a time. 

<details><summary>Key required in older versions of KDE (deprecated):</summary>

As explained above, in KDE Frameworks older than version 5.85, the servicemenu files are in directories `kservices5` and `kservices5/ServiceMenus` in the generic data locations. In this case, the following key is required in addition to `Type`, `MimeType` and `Actions`.

```ini
ServiceTypes=KonqPopupMenu/Plugin
```
</details>

```ini
[Desktop Entry]
```

KDE configuration files, including .desktop files, separate the individual settings into sections. A section starts with a heading made up of letters, numbers, and spaces in between square brackets on a line by itself. This first line means that all the options that follow, up until the next heading, belong to the "Desktop Entry" group. 

```ini
Type=Service
MimeType=image/png;image/jpeg;
```
The first line indicates that this .desktop file is of type Service; this is necessary since the default type is Application (i.e. something with an Exec line). Service is anything else, like plugins.

The MimeType line defines the type of file for which this servicemenu applies. You can define more than one mimetype by providing a list separated by semicolons (but no spaces). In this case, our servicemenu will show up when we select PNG or JPEG images. The File Associations control panel is a good place to look for mimetype definitions. 

{{< alert title="Tip" color="success" >}}

To create a servicemenu for directories use the ```inode/directory```
mimetype. To create a servicemenu for all files, use the base ```application/octet-stream```
mimetype

{{< /alert >}}

 You can also specify an entire group of mimetypes using "typeglobs". To make our servicemenu apply not only to PNGs and JPEGs but to all images we would simply change the MimeType entry to be:

```ini
MimeType=image/*;
```
Now when we right-click on any image file in Dolphin we can select it as our background. 

```ini
Actions=setAsWallpaper
```
The Actions entry defines the actions we will create in our servicemenu. You can define more than one action by using a semicolon-separated list. Each of the actions listed will get a section of its own defining what that action does. In fact, that's our very next step.

## Creating an Action
So far we have defined one action in our servicemenu file: setAsWallpaper. Now we need to define what that action looks like and what it actually does. We begin by adding a new heading to the end of our file: 

```ini
[Desktop Action setAsWallpaper]
```
Note that it contains the setAsWallpaper action name. It is important to note that these files are case sensitive, so we need to watch the capitalization here. Now that we have a section for our action, let's give our action a name that the user will see. 

```ini
Name=Set As Background Image
```

To translate the name, we add another Name entry followed by the language code. For instance, the Finnish translation for the "Set As Background Image" service is provided by an entry that looks like this: 

```ini
Name[fi]=Aseta taustakuvaksi
```

Next let's add an icon: 

```ini
Icon=background
```

Notice that we didn't include the .png file extension, but just referred to the icon by name. You can find icons by name by looking in `/usr/share/icons/` or installing `plasma-sdk` and using the [Cuttlefish app](https://cdn.kde.org/screenshots/cuttlefish/cuttlefish.png). If we had left the `Icon` line out our action would still work, it just wouldn't look as fancy. Now that we've achieved fanciness, let's finish up by making it useful: 

```ini
Exec=qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'var allDesktops = desktops();print (allDesktops);for (i=0;i<allDesktops.length;i++) {d = allDesktops[i];d.wallpaperPlugin = "org.kde.image";d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");d.writeConfig("Image", "%u")}';
```

The Exec line defines what is run when the user selects the action from the menu. We can put any command we want there. The magic in this line is the "%u" which gets replaced with the URL of the image file before the command is run. If our command can accept more than one file at a time we can use "%U" instead. There are other special %values but %u and %U are probably the most useful for servicemenus.      

Our file now looks like this: 
```ini
[Desktop Entry]
Type=Service
MimeType=image/*;
Actions=setAsWallpaper

[Desktop Action setAsWallpaper]
Name=Use As Wallpaper
Icon=background
Exec=qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'var allDesktops = desktops();print (allDesktops);for (i=0;i<allDesktops.length;i++) {d = allDesktops[i];d.wallpaperPlugin = "org.kde.image";d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");d.writeConfig("Image", "%u")}';
```

If we save it and open up Dolphin, when we right-click on a PNG, JPEG or GIF image we should now have a "Set as background" item in the menu. Try it out! 

{{< alert title="Tip" color="success" >}}

If you have a complex task that requires more than one command (for example if we wanted to copy the image file somewhere first and then use D-Bus to set it as the background) use a shell:
```bash
Exec=/bin/sh -c ";<YOUR COMMANDS HERE>"
```

{{< /alert >}}

## And Now Back to Our Regularly Scheduled Broadcast...

Back from the land of D-Bus, we have produced a working servicemenu. Now what? We improve it, of course!

Our current servicemenu scales the image to the size of the desktop and sets it as the wallpaper. But this isn't appropriate for wallpaper tiles which not be scaled but should be, well, tiled. So let's add an action for tiles. First we'll need to change the Actions line to say something like this: 

```ini
Actions=setAsWallpaper;tileAsWallpaper;
```

Note the use of semicolons rather than commas in that line. Next, we'll add a new action section to the end of the file that looks something like this: 

```ini
[Desktop Action tileAsWallpaper]
Name=Use As Wallpaper Tile
Icon=background
Exec=qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'var allDesktops = desktops();print (allDesktops);for (i=0;i<allDesktops.length;i++) {d = allDesktops[i];d.wallpaperPlugin = "org.kde.image";d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");d.writeConfig("FillMode", "3")};d.writeConfig("Image", "%u")}';
```
Note that "tileAsWallpaper" appears in the action section's heading. This is what tells Dolphin which action it is. In addition, we have a slightly different Name and a very slightly different Exec line. Now when we right-click on an image we have another option, this time to tile the image across our desktop. We didn't even have to restart Dolphin, since it automatically rereads the file when it changes!

Plasma desktop offers several background image options, of which Scale and Tile are just two. Of course, if we start adding all those various background options, and then add those to all the other servicemenus that a typical KDE installation has it's easy to see how the Action menu can quickly get out of hand. We can create submenus for our servicemenus by adding a line like the following to the


```ini
[Desktop Entry]
```
group of the .desktop file: 

```ini
X-KDE-Submenu=Set As Background
```
This will create a submenu called "Set As Background" and put all of the servicemenu's actions into it. Our servicemenu .desktop file now looks like this: 

```ini
[Desktop Entry]
Type=Service
MimeType=image/*;
Actions=setAsWallpaper;tileAsWallpaper;
X-KDE-Submenu=Use As Wallpaper

[Desktop Action setAsWallpaper]
Name=Scaled
Icon=background
Exec=qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'var allDesktops = desktops();print (allDesktops);for (i=0;i<allDesktops.length;i++) {d = allDesktops[i];d.wallpaperPlugin = "org.kde.image";d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");d.writeConfig("Image", "%u")}';

[Desktop Action tileAsWallpaper]
Name=Tiled
Icon=background
Exec=qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'var allDesktops = desktops();print (allDesktops);for (i=0;i<allDesktops.length;i++) {d = allDesktops[i];d.wallpaperPlugin = "org.kde.image";d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");d.writeConfig("FillMode", "3")};d.writeConfig("Image", "%u")}';
```

If you want your menu to appear at the top level, you can add `X-KDE-Priority=TopLevel` to the `Desktop Entry` group.
By default, they are most likely to be shown in the "Actions" submenu. Only if there are very few entries will they appear at the top level without this entry being set.

## Advanced Properties
This is a collection of advanced properties. You might not need them for your project, but it is useful
to know that they exist.

| Property | Explanation |
| --------------- | --------------- |
| X-KDE-Protocol | Requires scheme of the Urls to be equal, for example on a samba share this would be `smb` |
| X-KDE-Protocols | Requires scheme of the Urls to be contained in the list, for example `file,smb` |
| X-KDE-RequiredNumberOfUrls | Number of Urls that can be selected in order for this menu to be displayed. To allow multiple combinations you can separate the numbers with a comma, for example `2,4,6` |
| X-KDE-MinNumberOfUrls | Minimum number of Urls that can be selected in order for this menu to be displayed. This property is available since version 5.76 |
| X-KDE-MaxNumberOfUrls | Maximum number of Urls that can be selected in order for this menu to be displayed. This property is available since version 5.76 |

If you need more dynamic options please check out [KAbstractFileItemActionPlugin](docs:kio;KAbstractFileItemActionPlugin) on how to write such plugins in C++.

## Examples

This is a list of user contributed service menus. Feel free to add your own custom service menus here, if you feel they could be used by others.

* [KDE Service Menus from Z-Ray Entertainment](https://gitlab.com/z-ray-entertainment/kde-service-menus)
