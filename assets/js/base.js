/*
 * Copyright 2018 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

(function($) {

    'use strict';

    $(function() {
        $('[data-toggle="tooltip"]').tooltip();
        $('[data-toggle="popover"]').popover();

        $('.popover-dismiss').popover({
            trigger: 'focus'
        })
    });


    function bottomPos(element) {
        return element.offset().top + element.outerHeight();
    }

    // Bootstrap Fixed Header
    $(function() {
        var promo = $(".js-td-cover");
        if (!promo.length) {
            return
        }

        var promoOffset = bottomPos(promo);
        var navbarOffset = $('.js-navbar-scroll').offset().top;

        var threshold = Math.ceil($('.js-navbar-scroll').outerHeight());
        if ((promoOffset - navbarOffset) < threshold) {
            $('.js-navbar-scroll').addClass('navbar-bg-onscroll');
        }


        $(window).on('scroll', function() {
            var navtop = $('.js-navbar-scroll').offset().top - $(window).scrollTop();
            var promoOffset = bottomPos($('.js-td-cover'));
            var navbarOffset = $('.js-navbar-scroll').offset().top;
            if ((promoOffset - navbarOffset) < threshold) {
                $('.js-navbar-scroll').addClass('navbar-bg-onscroll');
            } else {
                $('.js-navbar-scroll').removeClass('navbar-bg-onscroll');
                $('.js-navbar-scroll').addClass('navbar-bg-onscroll--fade');
            }
        });
    });


}(jQuery));

function getOffsetSum(elem) {
    var top=0, left=0
    while (elem) {
        top = top + parseInt(elem.offsetTop)
        left = left + parseInt(elem.offsetLeft)
        elem = elem.offsetParent
    }
    return { top: top, left: left }
}

function setActiveMenuItem(li) {
    var isMenuItem = li.matches('#TableOfContents > ul > li')
    var isSubMenuItem = li.matches('#TableOfContents > ul > li > ul > li')
    var wasActive = li.classList.contains('active')

    if (isMenuItem || !wasActive) {
        // Unset current active item
        var menuItem = document.querySelector('#TableOfContents > ul > li.active')
        if (menuItem) {
            menuItem.classList.remove('active')
        }
        var menuItem = document.querySelector('#TableOfContents > ul > li > ul > li.active')
        if (menuItem) {
            menuItem.classList.remove('active')
        }
    }
    li.classList.add('active')

    if (isMenuItem) {
        var firstSubMenuItem = li.querySelector('ul > li')
        if (firstSubMenuItem) {
            firstSubMenuItem.classList.add('active')
        }
    } else if (isSubMenuItem) {
        var menuItem = li.parentNode.parentNode // TODO: parentUntil('li')
        menuItem.classList.add('active')
    }

    // Scroll to item
    // li.scrollIntoView()
}
function getMenuItemElement(li) {
    var id = li.querySelector('a').href.split('#', 2)[1]
    return document.getElementById(id)
}
function updateTOC() {
    var viewTop = window.scrollY
    var viewHeight = window.innerHeight
    var tocList = document.querySelectorAll('#TableOfContents li')
    // Binary Search maybe (since elements are in order)?
    for (var i = 0; i < tocList.length; i++) {
        var curMenuItem = tocList[i]
        var curElement = getMenuItemElement(curMenuItem)
        var offset = getOffsetSum(curElement)
        var offsetDiff = viewTop - offset.top
        if (offsetDiff < 0) {
            if (i <= 0) {
                // At top, select the first item
                setActiveMenuItem(curMenuItem)
            } else {
                var prevMenuItem = tocList[i - 1]
                var prevElement = getMenuItemElement(prevMenuItem)
                var prevOffset = getOffsetSum(prevElement)
                var prevOffsetDiff = viewTop - prevOffset.top
                var sectionHeight = offset.top - prevOffset.top
                var sectionUnread = sectionHeight - prevOffsetDiff
                var screenRatioLeft = sectionUnread / viewHeight
                if (screenRatioLeft <= 0.3) {
                    // Current item is being read
                    setActiveMenuItem(curMenuItem)
                } else {
                    // Previous item is still being read
                    setActiveMenuItem(prevMenuItem)
                }
            }
            break
        } else if (i >= tocList.length - 1) {
            // At bottom, select last item
            setActiveMenuItem(curMenuItem)
        }
    }
}

var updating = false
function queueUpdateTOC() {
    if (!updating) {
        updating = true
        requestAnimationFrame(function() {
            updateTOC()
            updating = false
        })
    }
}

queueUpdateTOC()
window.addEventListener('scroll', queueUpdateTOC)
