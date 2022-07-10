---
title: 
---

This tutorial will describe how to create your own plugin ("add comics") for the comic plasmoid. You will need kdeplasma-addons.

In general you can create plugins in any language supported by Kross, though this tutorial will focus on QtScript (JavaScript, ECMAScript), as this is supported by any KDE installation out of the box.

## Type of comics

There are three different types of comics that are supported by the comic dataengine.

1. date
2. number
3. string

That is the way the comics are identified, like "garfield:2000-01-01" or "xkcd:100", string can be anything.

Sometimes the website your comic is published on neither have an easy way to get a date or a number to a comic strip or that would not help to access the strip, in that case you should use string.

The idea of this is that the type should be enough to get the comic e.g. "xkcd:100". The first part tells what plugin should be loaded and the last part tells your plugin what comic strip should be loaded. Your plugin won't get more information from the dataengine on the request than that.


## Package Structure

The comic plugins are provided as packages that can be uploaded to https://store.kde.org and easily downloaded from that place directly from the applet.

First create a folder you want to work in. You need a structure like the following:

```
├── contents
│   └── code
│       └── main.js
├── icon.png
└── metadata.desktop
```

Later you need to zip the files to a ".comic"-package, you can do that with e.g.

```bash
zip -r my_comic.comic contents/code/main.es metadata.desktop icon.png
```

where "my_comic" is the name of the comic you want to add.

## The metadata.desktop file

Every comic plugin needs a metadata.desktop file like the following:

```ini
[Desktop Entry]
Name=My Comic
Comment=My Comic
Type=Service
X-KDE-ServiceTypes=Plasma/Comic
Icon=icon.png

X-KDE-Library=plasma_comic_krossprovider
X-KDE-PluginInfo-Author=Your Name
X-KDE-PluginInfo-Email=Your email-adress
X-KDE-PluginInfo-Name=my_comic
X-KDE-PluginInfo-Version=0.1
X-KDE-PluginInfo-Website=http://plasma.kde.org/
X-KDE-PluginInfo-License=GPLv2
X-KDE-PluginInfo-EnabledByDefault=true
X-KDE-PlasmaComicProvider-SuffixType=Date
```

In the "Name" and "Comment" section add the name of the comic you want to add. It will show up in the comic list (that is not the "Get New Comics..."-dialog) under that name. You could also translate the name of the comic to different languages e.g.

```ini
Name[de]=Mein Comic
Comment[de]=Mein Comic
```

You only need "Icon" if you have an icon for your comic -- like a favicon. In this example, the file is called "icon.png".

**X-KDE-PluginInfo-Name** is very important, as that is the name of your plugin. The comic dataengine will use this name to identify what comic plugin should be loaded. You also need this name if you test your plugin with the plasmaengineexplorer. There is no white space allowed in the name.

**X-KDE-PlasmaComicProvider-SuffixType** is the type of the comic as discussed the section above ('date', 'number', or 'string').

## The Code

In the first two sections I am discussing what functions and objects are available, if you want you can skip these sections and use them only as reference if needed.

### Available functions

There are different functions that you can use or can (have to) add:

```js
function init()
comic.pageRequest(url, id)
function pageRetrieved(id, data, metadata)
comic.combine(image, position)
```

Additionally to that there are some date-handling functions similar to [http://doc.trolltech.com/4.4/qdate.html QDate].

Of course, you can add other functions if you need them.

#### init()

'''init()''' is called by the dataengine, so you need to include it. The dataengine will only load your plugin and thus call init() if the asked for comic strip has not been cached.

#### comic.requestPage(url, id, metadata)

Ask the dataengine to download '''url''' for you. '''id''' specifies of what type the download is. There are three predefined different ids:
* comic.Page
* comic.User
* comic.Image
Both ''comic.Page'' and ''comic.User'' (and any integer that is not ''comic.Image'') are intended to be used for downloading web-pages (so only text), while ''comic.Image'' is used for the actual comic image. In

You can also specify '''metadata''' like the referrer. See [http://websvn.kde.org:80/trunk/KDE/kdelibs/kio/DESIGN.metadata?view=markup DESIGN.metadata] for what types are in general supported.

```js
var infos = {
    accept: "text/html, image/jpeg, image/png, text/*, image/*, */*",
    referrer: "www.example.com/index.html"
}
comic.requestPage( "www.example.com/image.jpg", comic.image, info );
comic.requestPage( "www.example.com/image.jpg", comic.image ); //would also work, but send no metadata
```

If the download was successful the dataengine will call pageRetrieved.

#### pageRetrieved(id, data)

'''pageRetrieved''' is only called if you asked the dataengine to download something for you.

What data is depends on the id.
If the id is ''comic.Image'' then ''data'' is the image, making any changes to data will change the image being displayed by the comic plugin. In all other cases ''data'' is the downloaded data in a byte stream converted to unicode -- in some cases not see comic.textCodec at [Available Objects] -- while ''id'' defines what kind of download it was. You can convert the byte stream to a String if ''needed'':
```js
var dataString = data.toString();
var begin = dataString.indexOf( "test" ); //would not work without the conversion
```

Here you could search in the data for the URL to the comic strip, the title of the comic, the comic's author, the identifier for the next comic, etc.
So you only need to implement that function if you want to find something in a webpage or if you want to modify the image.

#### comic.combine(image, position)

As the comic dataengine can not handle multiple pictures itself you have to combine several pictures to one occasionally.

For this you can use comic.combine(image, position). ''image'' needs to be an image, while ''position'' can be one of the following:

* comic.Left
* comic.Top # that is the default
* comic.Right
* comic.Bottom

''image'' will be combined with the last downloaded image -- comic.pageRequest(url, comic.Image). The position defines, where ''image'' will be placed. That way you can combine multiple images.

The following code is taken from the [Deo Ignito](http://www.kde-files.org/content/show.php/Deo+Ignito+(fr)?content=92428) comic plugin. I removed parts that are not nescessary for explaining this function, added some comments and pseudo code.

```js
var firstImage = 0;
//the variable we will temporaly store the combined images in,
//so this is the image that all other pictures will be combined with
//e.g. 4 different pictures 1,2,3,4
//1. 4
//2. 3 and 4 --> 34
//3. 2 and 34 --> 234
//4. 1 and 234 --> 1234
//as you might have guessed, we are using comic.Bottom here, as that
//works good with Array::pop()

var urlArray = new Array();
//the array that will store the urls to the pictures

...

function pageRetrieved(id, data) {
    if (id === comic.Page) {
        urlArray.push(url_1);//url_1 to url_4 is pseudo code, you need actual urls
        urlArray.push(url_2);
        urlArray.push(url_3);
        urlArray.push(url_4);
        ...

        //download the last url in the array
        comic.requestPage(urlArray.pop(), comic.Image);

        ...
    }
    if (id == comic.Image) {
        if (firstImage != 0) {
            //combines the most recent downloaded picture with firstImage,
            //while firstImage will be placed at the bottom
            comic.combine(firstImage, comic.Bottom);
        }


        if (urlArray.length > 0) {
            //asking for another image-download will overwrite the previous
            //image, that is why we store the current image(-combination)
            //before requesting another image
            firstImage = comic.image();

            comic.requestPage(urlArray.pop(), comic.Image);
        }
    }
}
```

Another comic plugin that currently uses this feature is [http://www.kde-files.org/content/show.php/Shit+Happens!+(de)?content=92045 Shit Happens!], though in this case an image provided by the comic-package is combined with the comics.

#### date-functions

Here I'm showing only two examples of the date-object and its member functions. If you want more information look at the sourcecode of [https://projects.kde.org/projects/kde/kdeplasma-addons/repository/revisions/master/entry/dataengines/comic/comicproviderwrapper.h comicproviderwrapper.h], [https://projects.kde.org/projects/kde/kdeplasma-addons/repository/revisions/master/entry/dataengines/comic/comicproviderwrapper.cpp comicproviderwrapper.cpp] and look at the [http://qt-project.org/doc/qt-5.0/qtcore/qdate.html Qt-documentation] as this object was designed to work similar to QDate. In some cases there might be differences though!

```js
comic.identifier = date.fromString("2008,03,07", "yyyy,MM,dd");
comic.website += comic.identifier.toString("dd-MM-yyyy");
```

#### comic.requestRedirectedUrl(url, id, metadata)

Introduced with API version 4450.

Sometimes you only have a relative url, e.g. next would be current url + "/?relid=X&go=+1". This function helps you to get the real url this relative url points to. This is useful for cases where you don't know the next or previous identifier, while this information is embded in the "real" url.

Ask the dataengine to retrieve the real (redirected) url for '''url'''. '''id''' specifies of what type the download is. There are some predefined ids:
* comic.PreviousUrl
* comic.NextUrl
* comic.CurrentUrl
* comic.FirstUrl
* comic.LastUrl
* comic.UserUrl
Those are for convenience only, you could use any integer you want.

You can also add '''metdata''' though that is optionial. For more information on metadata see [http://techbase.kde.org/Development/Tutorials/Plasma/ComicPlugin#comic.requestPage.28url.2C_id.2C_metadata.29]

This method will always call redirected(id, url). If there was no redirection, then it will be called with the original url.

Example:

```js
function init() {
  //... do something
  comic.requestRedirectedUrl("www.example.com/aComicId?go=-1", comic.PreviousUrl);
  //... do something
}

function redirected(id: string, url: string) {
  if (id === comic.PreviousUrl) {
    comic.previousIdentifier = //... transform the url to an identifier
  }
}
```

#### redirected(id, url)


Only called when you called ''comic.requestRedirectedUrl''.
Will either contain a redirected url or the original url.

### Available objects

In this section the available objects that you can assign something are listed and described.
Only comic.identifier and some other identifiers in special
cases -- as discussed below -- have something assigned to them initially.

```js
comic.comicAuthor = "Randall Munroe";      //the author or authors of the comic strip
comic.websiteUrl = "http://xkcd.com/42/";  //the address to the page where the strip is
comic.shopUrl = "http://store.xkcd.com/";  //if there is a shop for the comic
comic.title = "Geico";                     //the title of the comic strip, can be also the chapter etc.
comic.additionalText = "David did this";   //additional text, that will be shown as tooltip in the comic applet.
comic.textCodec = "Windows-1251";          //Only set the codec of the web content if it is not automatically recognized! So test first if it works without setting it.
comic.isLeftToRight = false;               //true is the default, only set if the comic is not LTR (introduced with 4.3)
comic.isTopToBottom = false;               //true is the default, only set if the comic is not from TopToBottom (introduced with 4.3)
```

Refer the Qt documentation for a [list of codecs you can use in comic.textCodec](https://doc.qt.io/qt-5/qtextcodec.html).

#### comic.apiVersion

Will return the version of the api as an integer. That is the earliest KDE SC release that contains all features of the currently running api. E.g. if the API of KDE SC 4.5.0 is the same as of 4.4.5 then the api version would be 4450 for both.

The number is done the follwing way 'series of KDE' + 'major version' + 'minor version' + 'placeholder'. So 4.4.5 would become 4450, the last digit -- the place-holder -- is there if the need arises to modify the api inbetween minor releases, e.g. security fixes.

You can call this function also if your API version was older than 4450, in that case ''undefined'' would be returned, comparing it to an integer would always return false.

```js
if (comic.apiVersion >= 4450) {
  comic.requestRedirectedUrl(url, id);
} else {
  //... do something
}
```


#### Identifier

There are six "identifier" objects, that react differently depending on the type of the comic.

```js
comic.identifier          // the identifier of the recent comic strip
comic.firstIdentifier     // the first comic strip e.g. number 1
comic.lastIdentifier      // the last (most recent) comic strip e.g. number 42
comic.previousIdentifier  // the previous identifier of the current strip e.g. number 40
comic.nextIdentifier      // the next identifier of the current strip e.g. 41
comic.identifierSpecified // if the caller of the dataEngine specified an (bool) identifier
```

'''comic.identifier''' is the identifier the dataengine is being asked for, so it is already set, though you can assign something different to it if needed.

If '''comic.identifierSpecified''' is false you should download the most recent comic strip. Note: This is introduced in KDE 4.2.1 and KDE 4.3, it fixes some problems.

For some types what ''you'' assigned to comic.identifier, comic.lastIdentifier, or comic.firstIdentifier will be checked and comic.identifier will be modified accordingly.

If there is a nextIdentifier then the dataengine will cache the comic strip, it does not need to be downloaded again in the future.

#### date

comic.identifier will always be an actual date that exists, if no exact date has been specified by the caller of the dataengine it will be today.

```js
comic.firstIdentifier   //has to be manually specified
comic.lastIdentifier    //is today by default
```

If you are assigning something to comic.lastIdentifier, then comic.identifier will be reassigned that day automatically, but only if comic.identifier was a day after comic.lastIdentifier, or if comic.identifierSpecified is false e.g.:

```js
comic.identifier = date.fromString("2009-01-12");
print(comic.identifier);    //2009-01-12
comic.lastIdentifier = date.fromString("2009-01-10");
print(comic.identifier);    //would be 2009-01-10 now

comic.lastIdentifier = date.fromString("2009-02-01");
print(comic.identifier);    //still 2009-01-10
```

In any case comic.identifier will be in the specified range you defined.

comic.previousIdentifier and comic.nextIdentifier will also be checked (KDE 4.2.2+):
* if comic.identifier is comic.firstIdentifier there won't be a comic.previousIdentifier
* if comic.identifier is comic.lastIdentifier there won't be a comic.nextIdentifier


If you do not set both (!) comic.previousIdentifier and comic.nextIdentifier
then they will be set automatically according to this rules:
* comic.previousIdentifier = comic.identifier - 1 day;
* comic.previousIdentifier never will be a day before comic.firstIdentifier
* comic.nextIdentifier = comic.identifier + 1 day;
* comic.nextIdentifier never will be a day after comic.lastIdentifier

You should set the identifiers yourself if the comic is _not_ end-to-end e.g.
2009-01-12, 2009-01-14, 2009-02-01, ... If you are not sure also set the identifiers yourself.

#### number

comic.identifier will either be a specific number, or if no number has been
specified by the caller of the dataengine it will be "0".

Using comic.identifierSpecified (recommended!) you can have a comic that is identified by the number "0", if you don't use comic.identifierSpecified you have to shift everything see [http://kde-files.org/content/show.php/Digital+Purgatory+(en)?content=98222 Digital Purgatory] as an example.

```js
comic.firstIdentifier   // is 1 by default
comic.lastIdentifier    // has to be manually specified
```

Note: The following part is for 4.2 only
If comic.identifier is "0" and you assign something to comic.lastIdentifier,
then comic.identifier will be reassigned that number automatically e.g.:

```js
comic.identifier = 0;
print(comic.identifier);    //0
comic.lastIdentifier = 42;
print(comic.identifier);    //would be 42 now

comic.lastIdentifier = 100;
print(comic.identifier);    //still 42
```

```js
print(comic.identifierSpecified);   //suppose that it is false
comic.lastIdentifier = 20;
print(comic.identifier);            //would be 20 now
```

In any case comic.identifier will be in the specified range.

comic.previousIdentifier and comic.nextIdentifier will also be checked (KDE 4.2.2+):
* if comic.identifier is comic.firstIdentifier there won't be a comic.previousIdentifier
* if comic.identifier is comic.lastIdentifier there won't be a comic.nextIdentifier

If you do not set both (!) comic.previousIdentifier and comic.nextIdentifier
then they will be set automatically according to this rules:
* comic.previousIdentifier = comic.identifier - 1;
* comic.previousIdentifier never will be smaller than comic.firstIdentifier
* comic.nextIdentifier = comic.identifier + 1;
* comic.nextIdentifier never will be larger than comic.lastIdentifier

You should set the identifiers yourself if the comic is _not_ end-to-end e.g.
1,4,5,9 ... If you are not sure also set the identifiers yourself.

#### string

Here you have to set nearly everything you want to use yourself, only one thing is set
automatically.
comic.identifier will either be a specific string, or if no string has been
specified by the caller of the dataengine it will be an empty string (length = 0).


```js
print(comic.identifierSpecified);   //suppose that it is false
comic.lastIdentifier = "muahaha";
print(comic.identifier);            //would be "muahaha" now
```

#### comic.image()

Accesses the image object.

Following is an example that works with apiVersion 4600. It sets the last frame of an animation as used image. In fact before this can work data has to be set e.g. via ''comic.requestPage(url, comic.Image)''.

```js
var img = comic.image();
if (comic.apiVersion >= 4600) {
  var count = img.imageCount();//The number of frames if it is an anmiation, otherwise 0 or -1 if there was an error
  if (count >= 0) {
    var temp;
    for (i = 0; i < count; i++) {
      temp = img.read();//reads the next frame and stores it in temp
    }
    img.image = temp;//sets the last frame as image
  }
}
```

### Examples

In this section there are some working examples -- for every type of comic one -- that should give you more insight of what comic plugins look like. You can look at other examples by downloading comic plugins either directly from kde-files.org or by installing further comics by using the "Get New Comics..."-dialog, then you find the installed comics and their code at `~/.local/share/apps/plasma/comics/`.

Note: These examples are based on 4.2, for 4.2.1+ some would need modification according as described in the previous section.

#### date

This example shows the implementation of the comic plugin for [Jesus and Mo.](http://www.kde-files.org/content/show.php/Jesus+and+Mo+(en)?content=98594).

It also shows how to deal with a special case where [jesusandmo.net/2009/01/28/](http://www.jesusandmo.net/2009/01/28/)
does not lead to the image itself, but rather a smaller version. One need to follow the provided link there to get to that information as well as the next and previous identifiers.

There are some other comic websites that use the same structure.

```js
// SPDX-FileCopyrightText: 2009 Matthias Fuchs <mat69 AT YOU KNOW DELETE THAT gmx.net>
// SPDX-License-Identifier: LGPL-2.0-or-later

let findNewDate = new Boolean();
const mainPage = "http://www.jesusandmo.net/";

function init() {
    comic.comicAuthor = "\"Mohammed Jones\"";
    comic.firstIdentifier = "2005-11-24";
    comic.shopUrl = "http://www.jesusandmo.net/the-shop/";

    var today = date.currentDate();
    findNewDate = (comic.identifier.date >= today.date);
    var url = mainPage;

    if (!findNewDate) {
        url += comic.identifier.toString("yyyy/MM/dd/");
    }

    comic.requestPage(url, comic.User);
}

function pageRetrieved(id, data) {
    //find the url to the comic website
    if (id == comic.User) {
        //find the most recent date
        if (findNewDate) {
            var re = new RegExp("(http://www.jesusandmo.net/(\\d{4}/\\d{2}/\\d{2}/)[^/]+/)#comments\"");
            var match = re.exec(data);
            if (match != null) {
                comic.identifier = date.fromString(match[2], "yyyy/MM/dd");
                comic.websiteUrl = match[1];
            } else {
                comic.error();
                return;
            }
        } else {
            var re = new RegExp("<a href=\"(" + mainPage + comic.identifier.toString("yyyy/MM/dd/") + "[^\"]+)\"><img");
            var match = re.exec(data);
            if (match != null) {
                comic.websiteUrl = match[1];
            } else {
                comic.error();
                return;
            }
        }

        comic.requestPage(comic.websiteUrl, comic.Page);
    }
    if (id == comic.Page) {
        var url = mainPage + "strips/";
        var re = new RegExp("<img src=\"(" + url + comic.identifier.toString(date.ISODate) + "[^\"]+)\" alt=\"([^\"]+)\"");
        var match = re.exec(data);
        if (match != null) {
            url = match[1];
            comic.title = match[2];
            comic.requestPage(url, comic.Image);
        } else {
            comic.error();
        }

        re = new RegExp("<a href=\"" + mainPage + "(\\d{4}/\\d{2}/\\d{2}/)[^\"]+\"><span class=\"prev\">");
        match = re.exec(data);
        if (match != null) {
            comic.previousIdentifier = date.fromString(match[1], "yyyy/MM/dd/");
        }

        re = new RegExp("<a href=\"" + mainPage + "(\\d{4}/\\d{2}/\\d{2}/)[^\"]+\"><span class=\"next\">");
        match = re.exec(data);
        if (match != null) {
            comic.nextIdentifier = date.fromString(match[1], "yyyy/MM/dd/");
        }
    }
}
```

#### number

This example shows the implementation of the comic plugin for [http://www.kde-files.org/content/show.php/xkcd+(en)?content=91803 xkcd]

```js
// SPDX-FileCopyrightText: 2007 Tobias Koenig <tokoe AT YOU KNOW DELETE THAT kde.org>
// SPDX-FileCopyrightText: 2009 Matthias Fuchs <mat69 AT YOU KNOW DELETE THAT gmx.net>
// SPDX-License-Identifier: LGPL-2.0-or-later

function init() {
    comic.comicAuthor = "Randall Munroe";
    comic.websiteUrl = "http://xkcd.com/";
    comic.shopUrl = "http://store.xkcd.com/";

    comic.requestPage(comic.websiteUrl, comic.User);
}

function pageRetrieved(id: string, data: string) {
    // find the most recent strip
    if (id == comic.User) {
        var re = new RegExp("Permanent link to this comic: http://xkcd.com/(\\d+)/");
        var match = re.exec(data);
        if ( match != null ) {
            comic.lastIdentifier = match[1];
            comic.websiteUrl += comic.identifier + "/";
            comic.requestPage(comic.websiteUrl, comic.Page);
        } else {
            comic.error();
        }
    }
    if (id == comic.Page) {
        var re = new RegExp("<img src=\"(http://imgs.xkcd.com/comics/[^\"]+)\"");
        var match = re.exec(data);
        if (match != null) {
            comic.requestPage(match[1], comic.Image);
        } else {
            comic.error();
            return;
        }

        //find the tooltip and the strip title of the comic
        re = new RegExp("src=\"http://imgs.xkcd.com/comics/.+\" title=\"([^\"]+)\" alt=\"([^\"]+)\"");
        match = re.exec(data);
        if (match != null) {
            comic.additionalText = match[1];
            comic.title = match[2];
        }
    }
}
```

#### string

This example shows the implementation of the [http://www.kde-files.org/content/show.php/Help+Desk+(en)?content=93090 Help Desk] comic plugin.

```js
// SPDX-FileCopyrightText: 2008 Matthias Fuchs <mat69 AT YOU KNOW DELETE THAT gmx.net>
// SPDX-License-Identifier: GPL-2.0-or-later

function init() {
    comic.comicAuthor = "Christopher Wright";
    comic.firstIdentifier = "1996/03/alex-loss-words";
    comic.websiteUrl = "http://www.ubersoft.net/comic/hd/";
    comic.shopUrl = "http://www.cafepress.com/evisceratistore";

    //cehck if the comic.identifier is empty, there are other ways as well like checking its length
    if (comic.identifier != new String()) {
        comic.websiteUrl += comic.identifier;
        comic.requestPage(comic.websiteUrl, comic.Page);
    } else {
        comic.requestPage(comic.websiteUrl + comic.firstIdentifier, comic.User);
    }
}

function pageRetrieved(id: string, data: string) {
    //find the most recent comic
    if (id === comic.User) {
        const re = new RegExp("<a href=\"/comic/hd/([^\"]+)\">last");
        const match = re.exec(data);
        if (match !== null) {
            comic.lastIdentifier = match[1];
            comic.identifier = comic.lastIdentifier;
            comic.websiteUrl += comic.identifier;
            comic.requestPage(comic.websiteUrl, comic.Page);
        } else {
            comic.error();
        }
    }
    //get the comic image and all other available information
    if (id === comic.Page) {
        //here the title of the strip is spread across two places on the website
        let re = new RegExp("<a href=\"/comic/hd/storyline/[^\"]+\" rel=\"tag\" title=\"\">([^<]+)</a>");
        let match = re.exec(data);
        if (match !== null) {
            comic.title = match[1];
        }

        //getting the image and the second part of the title
        re = new RegExp("<img src=\"(http://www\\.ubersoft\\.net/files/comics/hd/[^\"]+)\" alt=\"[^\"]*\" title=\"([^\"]*)");
        match = re.exec(data);
        if (match !== null) {
            comic.title += (comic.title.length && match[2].length) ? ": " + match[2] : match[2];
            comic.requestPage(match[1], comic.Image);
        } else {
            comic.error();
            return;
        }

        //getting the previous identifier
        re = new RegExp("<a href=\"/comic/hd/([^\"]+)\">. previous</a>");
        match = re.exec(data);
        if (match !== null) {
            comic.previousIdentifier = match[1];
        }

        //getting the next identifier
        re = new RegExp("<a href=\"/comic/hd/([^\"]+)\">next .</a>");
        match = re.exec(data);
        if (match !== null) {
            comic.nextIdentifier = match[1];
        }
    }
}
```

## Testing the plugin

To test the plugin you need to install it first:

```bash
plasmapkg2 -t comic -i my_comic.comic
```

If your comic does not show up in the comic list you have to type `kbuildsycoca5`
and then it should be there.
That will install the plugin to `~/.local/share/apps/plasma/comics/my_comic`
Now best is you directly work on `~/.local/share/apps/plasma/comics/my_comic/contents/code/main.js`
as you do not have to have reinstall the plugin if you change something. If you
are finished and changed something on the main.es file simply store the main.es
in your original folder and use the zip-command mentioned above to update the
package.

To test your plugin type:

```bash
plasmoidviewer comic
```

and choose your plugin. That way you will see debug-output.
Alternatively you could use the plasmaengineexplorer

```bash
plasmaengineexplorer
```

there choose comic and type in your comic identifier e.g. _garfield:_ or _garfield:2000-01-01_

All the comic strips that have a next identifier will be cached at
`~/.local/share/apps/plasma_engine_comic/`` so if you change the applet it might be good to
clean the cache before further testing by:

```bash
cd ~/.local/share/apps/plasma_engine_comic/
rm my_comic*
```

## Debugging the plugin

Often it happens that your plugin won't work the first try and the following
debuggin can be painful as there is not that much output unless you use some
tricks.

Add print-statements in your main.es file to see what the values of different
variables are and where your plugin stops working. Here are some examples:

```js
function init() {
    ...
    var url = "XY" + comic.identifier;
    print("***url: " + url);
    ...
}

function pageRetrieved(id: string, data) {
    if (id === comic.page) {
        print("****in comic.page");
        ...
        print("****a");
        ...
        print("****b");
        ...
        print("****id: " + comic.identifier);
    }
}
```

I add "****" in the print to find the output more easily.
Sometimes when I do not find the error at first sight I add a lot print statements like in the example above to find the error (e.g. written something wrong, forgot something etc.).

In case all that does not work and pageRetrieved is still called you could use

```js
print(data);
```

so that you can check if the data is correct and if it is what you expected.


