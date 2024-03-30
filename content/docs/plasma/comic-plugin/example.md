---
title: Examples
weight: 2
---

In this section there are some working examples -- for every type of comic one -- that should give you more insight of what comic plugins look like. You can look at other examples by downloading comic plugins either directly from store.kde.org or by installing further comics by using the "Get New Comics..."-dialog, then you find the installed comics and their code at `~/.local/share/plasma/comics/`.

## date

This example shows the implementation of the comic plugin for [Jesus and Mo.](https://store.kde.org/p/1080386).

It also shows how to deal with a special case where [jesusandmo.net/2009/01/28/](http://www.jesusandmo.net/2009/01/28/)
does not lead to the image itself, but rather a smaller version. One need to follow the provided link there to get to that information as well as the next and previous identifiers.

There are some other comic websites that use the same structure.

```js
// SPDX-FileCopyrightText: 2009 Matthias Fuchs <mat69 AT YOU KNOW DELETE THAT gmx.net>
// SPDX-License-Identifier: LGPL-2.0-or-later

let findNewDate = new Boolean();
const mainPage = "https://www.jesusandmo.net";

function init() {
    comic.comicAuthor = "\"Mohammed Jones\"";
    comic.firstIdentifier = "2005-11-24";
    comic.shopUrl = "https://www.jesusandmo.net/the-shop/";

    var today = date.currentDate();
    findNewDate = (comic.identifier.date >= today.date);
    var url = mainPage;

    if (!findNewDate) {
        url += comic.identifier.toString("yyyy/MM/dd/");
    }

    comic.requestPage(url, comic.User);
}

function pageRetrieved(id, data) {
    // find the url to the comic website
    if (id === comic.User) {
        // find the most recent date
        if (findNewDate) {
            const re = new RegExp("(http://www.jesusandmo.net/(\\d{4}/\\d{2}/\\d{2}/)[^/]+/)#comments\"");
            const match = re.exec(data);
            if (match !== null) {
                comic.identifier = date.fromString(match[2], "yyyy/MM/dd");
                comic.websiteUrl = match[1];
            } else {
                comic.error();
                return;
            }
        } else {
            const re = new RegExp("<a href=\"(" + mainPage + comic.identifier.toString("yyyy/MM/dd/") + "[^\"]+)\"><img");
            const match = re.exec(data);
            if (match !== null) {
                comic.websiteUrl = match[1];
            } else {
                comic.error();
                return;
            }
        }

        comic.requestPage(comic.websiteUrl, comic.Page);
    }
    if (id === comic.Page) {
        const url = `${mainPage}strips/`;
        let re = new RegExp(`<img src="(${url + comic.identifier.toString(date.ISODate)}[^"]+)" alt="([^"]+)"`);
        let match = re.exec(data);
        if (match !== null) {
            url = match[1];
            comic.title = match[2];
            comic.requestPage(url, comic.Image);
        } else {
            comic.error();
        }

        re = new RegExp("<a href=\"" + mainPage + "(\\d{4}/\\d{2}/\\d{2}/)[^\"]+\"><span class=\"prev\">");
        match = re.exec(data);
        if (match !== null) {
            comic.previousIdentifier = date.fromString(match[1], "yyyy/MM/dd/");
        }

        re = new RegExp("<a href=\"" + mainPage + "(\\d{4}/\\d{2}/\\d{2}/)[^\"]+\"><span class=\"next\">");
        match = re.exec(data);
        if (match !== null) {
            comic.nextIdentifier = date.fromString(match[1], "yyyy/MM/dd/");
        }
    }
}
```

## number

This example shows the implementation of the comic plugin for [xkcd](https://store.kde.org/p/1080452)

```js
// SPDX-FileCopyrightText: 2007 Tobias Koenig <tokoe AT YOU KNOW DELETE THAT kde.org>
// SPDX-FileCopyrightText: 2009 Matthias Fuchs <mat69 AT YOU KNOW DELETE THAT gmx.net>
// SPDX-License-Identifier: LGPL-2.0-or-later

function init() {
    comic.comicAuthor = "Randall Munroe";
    comic.websiteUrl = "https://xkcd.com/";
    comic.shopUrl = "https://store.xkcd.com/";

    comic.requestPage(comic.websiteUrl, comic.User);
}

function pageRetrieved(id, data) {
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
    if (id === comic.Page) {
        var re = new RegExp(`<img src="(http://imgs.xkcd.com/comics/[^"]+)"`);
        var match = re.exec(data);
        if (match != null) {
            comic.requestPage(match[1], comic.Image);
        } else {
            comic.error();
            return;
        }

        //find the tooltip and the strip title of the comic
        re = new RegExp(`src="http://imgs.xkcd.com/comics/.+" title="([^"]+)" alt="([^"]+)"`);
        match = re.exec(data);
        if (match !== null) {
            comic.additionalText = match[1];
            comic.title = match[2];
        }
    }
}
```

## string

This example shows the implementation of the [https://store.kde.org/p/1080275](Help Desk) comic plugin.

```js
// SPDX-FileCopyrightText: 2008 Matthias Fuchs <mat69 AT YOU KNOW DELETE THAT gmx.net>
// SPDX-License-Identifier: GPL-2.0-or-later

function init() {
    comic.comicAuthor = "Christopher Wright";
    comic.firstIdentifier = "1996/03/alex-loss-words";
    comic.websiteUrl = "http://www.ubersoft.net/comic/hd/";
    comic.shopUrl = "http://www.cafepress.com/evisceratistore";

    //cehck if the comic.identifier is empty, there are other ways as well like checking its length
    if (comic.identifier !== new String()) {
        comic.websiteUrl += comic.identifier;
        comic.requestPage(comic.websiteUrl, comic.Page);
    } else {
        comic.requestPage(comic.websiteUrl + comic.firstIdentifier, comic.User);
    }
}

function pageRetrieved(id: string, data: string) {
    //find the most recent comic
    if (id === comic.User) {
        const re = new RegExp(`<a href="/comic/hd/([^"]+)">last`);
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
