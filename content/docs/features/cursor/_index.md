---
title: Create your own mouse cursor theme
linkTitle: Mouse cursor
group: features
weight: 4
description: >
    Learn how to create custom mouse cursors.
---

## Requirements {#requirements}

Before getting started, we must make sure that you have all the required
 packages installed and ready for use.

For this tutorial you will need the following packages:

|Package Name | Usage    |
|------------ |----------|
|xorg-xcursorgen | Required |

You can find the installation commands for some distributions below. 

{{< installpackage 
    arch="xorg-xcursorgen" 
>}}

## Step 00 - Getting Started {#getting-started}
---

In this tutorial, we will guide you on how to create your very own custom mouse cursor. 

This guide is compatible with [X11](https://en.wikipedia.org/wiki/X_Window_System) and 
[Wayland](https://en.wikipedia.org/wiki/Wayland_(protocol)), meaning that it's not mandatory to be using KDE, as long 
as your machine runs either of them.

Before continuing, make sure you have all the [requirements]({{< ref "#requirements" >}}) on your machine.

You can check if the required packages are installed by using the `which` command.
For this tutorial, you can check with the following command: `which xcursorgen`.

If the output says `xcursorgen not found`, then you don't have it installed on your machine,
and you should follow the installation steps for your distribution.

If the output has a directory, like `/usr/bin/xcursorgen`, then you have the package installed on your machine.

**Now, let's get ready to create your first cursor!**

## Step 01 - Creating the image file {#creating-the-image-file}
---

The first thing you will need to create your own cursor is the image file for it. You can start by
creating an empty PNG file. 

You must use square images, meaning that they share the same `width` and `height` dimensions.
Preferably, they should be at least 16x16 pixels in size, but you can also create multiple resolutions
and bundle those into one cursor file.

Make sure to keep the **transparency layer (alpha information)** on your file when saving,
or else your cursor will have a square background.

{{< alert title="Image Size Note" color="info">}}

You can download other cursor themes and inspect then to see some common resolutions. For instance, the default KDE 
Theme, `Breeze`, uses the following resolutions:
- 16x16
- 22x22
- 32x32
- 48x48
- 64x64
- 128x128
- 256x256.

At the end of the day, it's up to you to decide which resolution to use.

{{< /alert >}}

Once you have created the image file, it's time to draw. It's up to you if you want to draw
your cursor now or if you want to do it later. Regardless of your choice, you will need to 
save your file.

It's recommended to save the file with a name that will make it easier for you to infer its usage.
The structure should follow this pattern: `filename.png`. The `.png` is the extension part, while the
`filename` is the name you choose for your file.

For the sake of simplicity, let's proceed with the name `default` as this will represent the default
cursor. After you save your file, you should have something like `default.png`.

{{< alert title="Note" color="info" >}}

You will need to repeat this step for every other cursor you want to create and/or customize.
There is no standard naming scheme that you need to follow, but you should make your cursor filenames descriptive.
This will make things much easier later on, when we get to the symlinking step.

{{< /alert >}}



## Step 02 - Determining the Cursor hotspot {#determining-the-cursor-hotspot}
---

You might be asking yourself: *What is the hotspot?*

The hotspot of a cursor is the point where the click occurs. It's the position on your image that
the system will interpret and understand as the position of the cursor.

To determine the pixel where the hotspot should sit, it's necessary to use graphic editing 
software capable of determining the exact pixel for the hotspot. KDE's own 
[Krita](https://krita.org) is well suited for this task but, of course, other software works
just as well.

The origin point (0,0) it's in the **upper-left corner** of the image. The X-axis goes from left to right.
The Y-axis goes from top to bottom.

With that in mind, when you add an offset of 10 pixels on the X-axis, it will shift the hotspot 
10 pixels to the right from the upper-left corner. Likewise, an offset of 5 pixels on the Y-axis
will shift the hotspot 5 pixels down from the upper-left corner.

{{< alert title="Important!" color="warning">}}

If you have multiple resolutions for your new cursor, you have to do this step for each of them.

{{< /alert >}}

## Step 03 - Creating the *.cursor*   file {#creating-the-cursor-file}
---

Now that you have your image file, and you know where your cursor hotspot is, you can create your
`.cursor` file.

The `.cursor` file is the configuration file that will tell `xcursorgen` how to generate the cursor.

The `.cursor` file is structured as follows: `(resolution) (hotspot-x) (hotspot-y) (filename) (animation-time)`
, where:

| Parameter  | Description                                           | Static Cursors | Animated Cursors  |
|------------|-------------------------------------------------------|----------------|-------------------|
| resolution | The resolution from your file.                        |  Required | Required |
 | hotspot-x | The x coordinate of the hotspot on your cursor image. | Required | Required |
| hotspot-y | The y coordinate of the hotspot on your cursor image. | Required | Required |
| filename | The image filename for this cursor. |                 Required | Required|
| animation-time | The time for this frame in the animated cursor. |  Optional | Required |


There are a couple of ways to create your `.cursor` file. Mainly, any program that allows you to save
your file with a custom extension should do. For the sake of simplicity, in this example, we are going
to use the [`echo`](https://en.wikipedia.org/wiki/Echo_(command)) command on a terminal.

Let's check an example:

```shell
    echo "32 10 5 default.png" > default.cursor
```
When you execute the above command, it will create a `default.cursor` file with the content `32 10 5 default.png`
in the [working directory](https://en.wikipedia.org/wiki/Working_directory).
Let's look at it in detail, according to the `.cursor` file structure.

- *32* is for the **resolution**, so this represents a 32x32 pixels file.
- *10* is for the **hotspot-x** coordinate, so this represents an offset of 10 pixels in the X-axis.
- *5* is for the **hotspot-y** coordinate, so this represents an offset of 5 pixels in the Y-axis.
- *filename* is for the corresponding **image filename**, including its extension, for this cursor. So in this case, 
it will be using the `default.png` file. 
- *>* is for the echo command to dump the result into the following destination.
- *default.cursor* is the destination file that will receive the output from the echo command.

With that, you have your `.cursor` file ready for this cursor.

---

#### Animated Cursors

If you want to create animated cursors, like the `wait` cursor, the procedure is a bit different.

You need one PNG for each animation frame (`filename_#.png`).

Then add all of these as a list to the `filename.cursor` file with the following content:

`(resolution) (hotspot-x) (hotspot-y) (filename) (animationtime)`

For instance:
```cursor
32 16 16 wait_1.png 50 
32 16 16 wait_2.png 50
``` 
each of them in a separate line.

---


## Step 04 - Using xcursorgen {#using-xcursorgen}
---

In this step, we will use the `xcursorgen` command to generate the cursor for your system.

If you haven't already, open a terminal and navigate to the directory where your cursor image files are stored.

The `xcursorgen` command works on the following structure: `xcursorgen config-file output-file`

| Parameter   | Description                                           |
|-------------|-------------------------------------------------------|
| config-file | The configuration file for your cursor.               |
| output-file | The filename for your newly generated cursor.         |

Let's check an example: 
```shell
  xcursorgen default.cursor default
```

When you execute the above command, it will read the configuration from the `default.cursor` file and generate
a new cursor named `default` on your working directory.

{{< alert title="Note" color="info" >}}

Repeat steps 01 to 04 for all the different cursors you want to create.

{{< /alert >}}

## Step 05 - Creating a theme folder {#creating-a-theme-folder}
---

To be able to use your custom cursors, you need to structure your files properly to make them
available to you in your system settings.

Let's create a folder with your cursor pack name to put your cursors inside it before moving to the
proper location. In this tutorial, we will call our cursor pack `KoolKursors`. 

With that in mind, we must create a new
folder called `KoolKursors.` You can do that by executing the following command:

```shell
mkdir KoolKursors
```

This will create a new folder called `KoolKursors` in your working directory.
Once you have done that, change your working directory to the folder you just created.
You can do that with the following command:

```shell
cd KoolKursors
```

Now that you changed your working directory to your theme folder, `KoolKursors` in this tutorial, you need to create
a folder called `cursors` inside it.
You can do that with the following command:

```shell
mkdir cursors
```

The purpose of the `cursors` folder is to hold all the cursors files and the symlinks necessary for it to work.
Don't worry about the symlinks now, we will teach you how to create them at the next step.

Now that you have your folders ready, move all the cursors that you have created before at [Step 04](#using-xcursorgen) to 
the `cursors` folder. In this tutorial, you should have created at least one cursor named `default`, using the `xcursorgen` command.


## Step 06 - Creating the symlinks {#creating-the-symlinks}
---

When you hover your mouse over certain elements or perform certain actions on your desktop, your cursor state changes. 
For instance, hovering over a text field will show a text cursor, and hovering over a link typically shows a hand cursor.

To make our custom cursors match the cursor states available to the system, we need to create cursor files for each 
state inside our `cursors/` folder that have specific names. 
The names that can be used can be found in `/usr/include/X11/cursorfont.h`.

<details>
    <summary>Alternatively, you can click here to showcase the cursor list:</summary>

     XC_num_glyphs 154
     XC_X_cursor 0
     XC_arrow 2
     XC_based_arrow_down 4
     XC_based_arrow_up 6
     XC_boat 8
     XC_bogosity 10
     XC_bottom_left_corner 12
     XC_bottom_right_corner 14
     XC_bottom_side 16
     XC_bottom_tee 18
     XC_box_spiral 20
     XC_center_ptr 22
     XC_circle 24
     XC_clock 26
     XC_coffee_mug 28
     XC_cross 30
     XC_cross_reverse 32
     XC_crosshair 34
     XC_diamond_cross 36
     XC_dot 38
     XC_dotbox 40
     XC_double_arrow 42
     XC_draft_large 44
     XC_draft_small 46
     XC_draped_box 48
     XC_exchange 50
     XC_fleur 52
     XC_gobbler 54
     XC_gumby 56
     XC_hand1 58
     XC_hand2 60
     XC_heart 62
     XC_icon 64
     XC_iron_cross 66
     XC_left_ptr 68
     XC_left_side 70
     XC_left_tee 72
     XC_leftbutton 74
     XC_ll_angle 76
     XC_lr_angle 78
     XC_man 80
     XC_middlebutton 82
     XC_mouse 84
     XC_pencil 86
     XC_pirate 88
     XC_plus 90
     XC_question_arrow 92
     XC_right_ptr 94
     XC_right_side 96
     XC_right_tee 98
     XC_rightbutton 100
     XC_rtl_logo 102
     XC_sailboat 104
     XC_sb_down_arrow 106
     XC_sb_h_double_arrow 108
     XC_sb_left_arrow 110
     XC_sb_right_arrow 112
     XC_sb_up_arrow 114
     XC_sb_v_double_arrow 116
     XC_shuttle 118
     XC_sizing 120
     XC_spider 122
     XC_spraycan 124
     XC_star 126
     XC_target 128
     XC_tcross 130
     XC_top_left_arrow 132
     XC_top_left_corner 134
     XC_top_right_corner 136
     XC_top_side 138
     XC_top_tee 140
     XC_trek 142
     XC_ul_angle 144
     XC_umbrella 146
     XC_ur_angle 148
     XC_watch 150
     XC_xterm 152

</details>

>
More often than not, we only need a single cursor file for multiple cursor states. Since the requirement to make our 
custom cursors match is to have files named after each cursor state, 
we can use [symlinks](https://en.wikipedia.org/wiki/Symbolic_link#POSIX_and_Unix-like_operating_systems).

---
To create a symlink, you use the `ln` command with the following structure: `ln -s file-path symlink-path`, where:

| Paramenter    | Description                                                                                         |
|---------------|-----------------------------------------------------------------------------------------------------| 
| file-path     | The path, relative to your working directory, to the file that will be linked to.                   |
| symlink-path  | The path, relative to your working directory, to create the symlink that will point to `file-path`. |

For instance, to set the default cursor we created with `xcursorgen` to appear in most cases when using the mouse in 
right-handed mode (with the cursor pointing to the left), you can create a `left_ptr` symlink, following the name 
list above:

`ln -s default left_ptr`

At this point, the `default` cursor should already be at your `cursors` folder. Remember that we named our theme folder
as `KoolKursors`, so we have to make the `KoolKursors/cursors` folder our working directory.

Now, your `cursors` folder should have 2 files: 
- `default` : the default cursor file that we generated
- `left_ptr`: the symlink that we just created.

{{< alert title="Note" color="warning" >}}

This task can/should be scripted, provided that you have a
complete list of regular cursor names and their irregular aliases.
Note that this step might cause some frustration regarding
incomplete lists of cursor name aliases.

{{< /alert >}}

Now that we have our symlink ready, we can proceed to create the `index.theme` file. 

## Step 07 - Creating the `index.theme` file{#creating-the-index.theme-file}
---

The `index.theme` file is responsible for storing the information about the custom theme. In this tutorial, we are 
calling it `KoolKursors`. The minimal structure for the `index.theme` file is the one as follows:

```theme
[Icon Theme]
Name=KoolKursors
```

However, you can add more information to your `index.theme` file. For instance, you can add comments or make it inherit 
from other themes.

{{< alert title="Important Requirement" color="error">}}

The `Name` attribute of the `.theme` file must be **exactly** like the theme folder name. Make sure to double-check 
that in order to prevent issues.

{{< /alert >}}

The `index.theme` file should be placed in your main theme folder. Please, create an `index.theme` file with the following
contents:

```
[Icon Theme]
Name=KoolKursors
Comment=My very own cursor theme
Inherits=breeze_cursors
```
With that, you have your `.theme` file setup and ready to proceed.

{{< alert title="Translation Note" color="success" >}}

If you want to add translations for multiple languages, you can do
so by using language tags like `[en]`, `[de]`, `[fr]`, etc. for each
language. 

Put each of them in a separate line within the `index.theme` file.

For example:

```
[Icon Theme]
Name=KoolKursors
Inherits=breeze_cursors
Comment[en]=My very own cursor theme.
Comment[pt_BR]=Meu próprio tema de cursor.
```

If you are interested in the Localization process, please check out the
[KDE Localization](https://l10n.kde.org/) main page.

If you just want to check which tag is the appropriate one for your language comment,
you can check out all the currently available languages supported by KDE
on [this page](https://l10n.kde.org/teams-list.php), alongside their language tag.

{{< /alert >}}


## Step 08 - Moving the files {#moving-the-files}
---

Now that you have your cursors, your symlinks, the `.theme` file and the proper folder structure, we can copy them to
the proper folder on the system for testing.

To test our custom cursors, we need to place the whole `KoolKursors` folder in `~/.local/share/icons/` folder.

To do that, you can open a file explorer like [Dolphin](https://apps.kde.org/dolphin/) and copy the `KoolKursors`
folder to the `~/.local/share/icons` folder.

{{< alert title="Default \"icons\" folder location" color="warning" >}}

For ***user-specific*** installation, you should check the following folders:

1. `~/.icons` (Deprecated in favor of 2)
2. `~/.local/share/icons/` 

For ***system-wide*** installation, you should check

1. `/usr/share/icons/` 

You might still find some themes and cursors that make use of the `~/.icons` folder,
but this is no longer recommended. Use `~/.local/share/icons/` instead.

{{< /alert >}}

## Step 09 - Applying your custom cursor to your system{#applying-your-custom-cursor}
---

Select your new cursor theme in the system settings of your OS.

On Plasma you can follow these steps to select your new `KoolKursors` theme:

`System Settings > Appearance > Cursors > KoolKursors > Apply`

Done! Enjoy your new `KoolKursors` theme. :)

## Other Resources {#other-resources}
---

- [X.org xcursorgen documentation](https://www.x.org/releases/current/doc/man/man1/xcursorgen.1.xhtml)
- [xcursorgen Arch Wiki page](https://wiki.archlinux.org/title/Xcursorgen)
