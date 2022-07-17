---
title: Plasma Comic
weight: 9
description: >
  Learn how to create a Comic provider plugin
---

This tutorial will describe how to create your own plugin for the comic plasmoid. The comic plasmoid is part of kdeplasma-addons.

For this you can use JavaScript which is evaluated using QJSEngine.

## Type of comics

There are three different types of comics that are supported by the comic applet.

1. Date
2. Number
3. String

That is the way the comics are identified, like "garfield:2000-01-01" or "xkcd:100", string can be anything.

Sometimes the website your comic is published on neither have an easy way to get a date or a number to a comic strip or that would not help to access the strip, in that case you should use string.

The idea of this is that the type should be enough to get the comic e.g. "xkcd:100". The first part tells what plugin should be loaded and the last part tells your plugin what comic strip should be loaded. Your plugin won't get more information from the engine on the request than that.


## Package Structure

The comic plugins are provided as packages that can be uploaded to https://store.kde.org and easily downloaded from that place directly from the applet.

First create a folder you want to work in. You need a structure like the following:

```
├── contents
│   └── code
│       └── main.js
├── icon.png
└── metadata.json
```

Later you need to zip the files to a ".comic"-package, you can do that with e.g.

```bash
zip -r my_comic.comic contents/code/main.es metadata.json icon.png
```

where "my_comic" is the name of the comic you want to add.

## The metadata.json file

Every comic plugin needs a metadata.json file like the following:

```json
{
    "KPlugin": {
        "Authors": [
            {
                "Email": "Your email-adress",
                "Name": "Your Name"
            }
        ],
        "Description": "My Comic",
        "Icon": "icon.png",
        "Id": "my_comic",
        "License": "GPLv2",
        "Name": "My Comic",
        "Version": "0.1",
        "Website": "http://plasma.kde.org/"
    },
    "X-KDE-PlasmaComicProvider-SuffixType": "Date"
}
```

In the "Name" and "Description" section add the name of the comic you want to add. It will show up in the comic list (that is not the "Get New Comics..."-dialog) under that name. You could also translate the name of the comic to different languages e.g.

```json
"Name": "My Comic",
"Name[de]": "Mein Comic"
```

You only need "Icon" if you have an icon for your comic -- like a favicon. In this example, the file is called "icon.png".

**Id** is very important, as that is the internal name of your plugin. The comic engine will use this name to identify what comic plugin should be loaded. You also need this name if you test your plugin with the plasmoidviewer. There is no white space allowed in the id.

**X-KDE-PlasmaComicProvider-SuffixType** is the type of the comic as discussed the section above (Date, Number, or String).

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

Additionally to that there are some date-handling functions similar to [QDate](https://doc.qt.io/qt-5/qdate.html).

Of course, you can add other functions if you need them.

#### init()

`init()` is called by the engine, so you need to include it. The engine will only load your plugin and thus call init() if the asked for comic strip has not been cached.

#### comic.requestPage(url, id, metadata) {#requestpage}

Ask the engine to download `url` for you. `id` specifies of what type the download is. There are three predefined different ids:
* comic.Page
* comic.User
* comic.Image
Both `comic.Page` and `comic.User` (and any integer that is not `comic.Image`) are intended to be used for downloading web-pages (so only text), while `comic.Image` is used for the actual comic image. In

You can also specify `metadata` like the referrer. See [http://websvn.kde.org:80/trunk/KDE/kdelibs/kio/DESIGN.metadata?view=markup DESIGN.metadata] for what types are in general supported.

```js
const infos = {
    accept: "text/html, image/jpeg, image/png, text/*, image/*, */*",
    referrer: "www.example.com/index.html",
}
comic.requestPage("www.example.com/image.jpg", comic.image, infos);
comic.requestPage("www.example.com/image.jpg", comic.image); // would also work, but send no metadata
```

If the download was successful the engine will call pageRetrieved.

#### pageRetrieved(id, data)

`pageRetrieved` is only called if you asked the engine to download something for you.

What data is depends on the id.
If the id is `comic.Image` then `data` is the image, making any changes to data will change the image being displayed by the comic plugin. In all other cases `data` is the downloaded data in a byte stream converted to unicode -- in some cases not see comic.textCodec at [Available Objects] -- while `id` defines what kind of download it was. You can convert the byte stream to a String if needed:

```js
const dataString = data.toString();
const begin = dataString.indexOf("test"); // would not work without the conversion
```

Here you could search in the data for the URL to the comic strip, the title of the comic, the comic's author, the identifier for the next comic, etc.
So you only need to implement that function if you want to find something in a webpage or if you want to modify the image.

#### comic.combine(image, position)

As the comic engine can not handle multiple pictures itself you have to combine several pictures to one occasionally.

For this you can use `comic.combine(image, position)`. `image` needs to be an image, while `position` can be one of the following:

* comic.Left
* comic.Top # that is the default
* comic.Right
* comic.Bottom

`image` will be combined with the last downloaded image -- `comic.pageRequest(url, comic.Image)`. The position defines, where `image` will be placed. That way you can combine multiple images.

The following code is taken from the [Deo Ignito](http://www.kde-files.org/content/show.php/Deo+Ignito+(fr)?content=92428) comic plugin. I removed parts that are not nescessary for explaining this function, added some comments and pseudo code.

```js
const firstImage = 0;
// the variable we will temporaly store the combined images in,
// so this is the image that all other pictures will be combined with
// e.g. 4 different pictures 1,2,3,4
// 1. 4
// 2. 3 and 4 --> 34
// 3. 2 and 34 --> 234
// 4. 1 and 234 --> 1234
// as you might have guessed, we are using comic.Bottom here, as that
// works good with Array::pop()

const urlArray = [];
// the array that will store the urls to the pictures

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
    if (id === comic.Image) {
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

Another comic plugin that currently uses this feature is [Shit Happens \[ger\]](https://store.kde.org/p/1080445), though in this case an image provided by the comic-package is combined with the comics.

#### date-functions

Here I'm showing only two examples of the date-object and its member functions. If you want more information look at the [sourcecode](https://invent.kde.org/plasma/kdeplasma-addons/-/tree/master/applets/comic/engine) and look at the [Qt-documentation](https://doc.qt.io/qt-5/qdate.html) as this object was designed to work similar to QDate. In some cases there might be differences though!

```js
comic.identifier = date.fromString("2008,03,07", "yyyy,MM,dd");
comic.website += comic.identifier.toString("dd-MM-yyyy");
```

#### comic.requestRedirectedUrl(url, id, metadata)

Sometimes you only have a relative url, e.g. next would be current url + "/?relid=X&go=+1". This function helps you to get the real url this relative url points to. This is useful for cases where you don't know the next or previous identifier, while this information is embded in the "real" url.

Ask the engine to retrieve the real (redirected) url for `url`. `id` specifies of what type the download is. There are some predefined ids:
* comic.PreviousUrl
* comic.NextUrl
* comic.CurrentUrl
* comic.FirstUrl
* comic.LastUrl
* comic.UserUrl
Those are for convenience only, you could use any integer you want.

You can also add `metdata` though that is optional. For more information on metadata see [requestpage]({{< relref "#requestpage" >}}).

This method will always call `redirected(id, url)`. If there was no redirection, then it will be called with the original url.

Example:

```js
function init() {
  //... do something
  comic.requestRedirectedUrl("www.example.com/aComicId?go=-1", comic.PreviousUrl);
  //... do something
}

function redirected(id, url) {
  if (id === comic.PreviousUrl) {
    comic.previousIdentifier = //... transform the url to an identifier
  }
}
```

#### redirected(id, url)


Only called when you called `comic.requestRedirectedUrl`.
Will either contain a redirected url or the original url.

### Available objects

In this section the available objects that you can assign something are listed and described.
Only comic.identifier and some other identifiers in special
cases -- as discussed below -- have something assigned to them initially.

```js
comic.comicAuthor = "Randall Munroe";      // the author or authors of the comic strip
comic.websiteUrl = "http://xkcd.com/42/";  // the address to the page where the strip is
comic.shopUrl = "http://store.xkcd.com/";  // if there is a shop for the comic
comic.title = "Geico";                     // the title of the comic strip, can be also the chapter etc.
comic.additionalText = "David did this";   // additional text, that will be shown as tooltip in the comic applet.
comic.textCodec = "Windows-1251";          // Only set the codec of the web content if it is not automatically recognized! So test first if it works without setting it.
comic.isLeftToRight = false;               // true is the default, only set if the comic is not LTR
comic.isTopToBottom = false;               // true is the default, only set if the comic is not from TopToBottom
```

Refer the Qt documentation for a [list of codecs you can use in comic.textCodec](https://doc.qt.io/qt-5/qtextcodec.html).

#### Identifier

There are six "identifier" objects, that react differently depending on the type of the comic.

```js
comic.identifier          // the identifier of the recent comic strip
comic.firstIdentifier     // the first comic strip e.g. number 1
comic.lastIdentifier      // the last (most recent) comic strip e.g. number 42
comic.previousIdentifier  // the previous identifier of the current strip e.g. number 40
comic.nextIdentifier      // the next identifier of the current strip e.g. 41
comic.identifierSpecified // if the engine specified an (bool) identifier. 
```

`comic.identifier` is the identifier the engine is being asked for, so it is already set, though you can assign something different to it if needed.

If `comic.identifierSpecified` is false you should download the most recent comic strip.

For some types what *you* assigned to `comic.identifier`, `comic.lastIdentifier`, or `comic.firstIdentifier` will be checked and comic.identifier will be modified accordingly.

If there is a nextIdentifier then the engine will cache the comic strip, it does not need to be downloaded again in the future.

#### date

comic.identifier will always be an actual date that exists, if no exact date has been specified by the engine it will be today.

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

comic.previousIdentifier and comic.nextIdentifier will also be checked:
* if comic.identifier is comic.firstIdentifier there won't be a comic.previousIdentifier
* if comic.identifier is comic.lastIdentifier there won't be a comic.nextIdentifier


If you do not set both (!) comic.previousIdentifier and comic.nextIdentifier
then they will be set automatically according to this rules:
* `comic.previousIdentifier = comic.identifier - 1 day;`
* `comic.previousIdentifier` never will be a day before `comic.firstIdentifier`
* `comic.nextIdentifier = comic.identifier + 1 day;`
* `comic.nextIdentifier` never will be a day after `comic.lastIdentifier`

You should set the identifiers yourself if the comic is _not_ end-to-end e.g.
2009-01-12, 2009-01-14, 2009-02-01, ... If you are not sure also set the identifiers yourself.

#### number

comic.identifier will either be a specific number, or if no number has been
specified by the engine it will be "0".

Using comic.identifierSpecified (recommended!) you can have a comic that is identified by the number "0", if you don't use comic.identifierSpecified you have to shift everything see [Digital Purgatory (en)](https://store.kde.org/p/1080349) as an example.

```js
comic.firstIdentifier   // is 1 by default
comic.lastIdentifier    // has to be manually specified
```

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

comic.previousIdentifier and comic.nextIdentifier will also be checked:
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
specified by the engine it will be an empty string (length = 0).


```js
print(comic.identifierSpecified);   //suppose that it is false
comic.lastIdentifier = "muahaha";
print(comic.identifier);            //would be "muahaha" now
```

#### comic.image()

Accesses the image object.

Following is an example that works with apiVersion 4600. It sets the last frame of an animation as used image. In fact before this can work data has to be set e.g. via `comic.requestPage(url, comic.Image)`.

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

