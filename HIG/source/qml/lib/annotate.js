var ruler = Qt.createComponent("Ruler.qml");
var brace = Qt.createComponent("Brace.qml");
var outline = Qt.createComponent("Outline.qml");
var messure = Qt.createComponent("Messure.qml");
var padding = Qt.createComponent("Padding.qml");
var mouse = Qt.createComponent("Mouse.qml");
var touch = Qt.createComponent("Touch.qml");

// get classname and strip _QML of the name
function getClassName(obj) {
    var str = obj.toString();
    str = str.substring(0, str.indexOf("("));
    if (str.search(/_QML/) !== -1) {
        str = str.substring(0, str.indexOf("_QML"));
    }
    return str.toLowerCase();
}

// Merge 2 objects of options
function getOpts(opts, choices) {
    for (var choice in choices) {
        opts[choice] = choices[choice];
    }
    return opts;
}

// An extended array of QML elements
function An(node) {
    this.nodes = [];
    if (typeof node === "undefined") {
        this.nodes = []
    }
    else if (typeof node === "Array") {
        this.nodes = node;
    }
    else {
        this.nodes = [node];
    }
}

// Find an An of QML elements from this point down the subtrees
An.prototype.find = function(selector) {
    var result = new An();

    if (typeof selector === "string") {
        selector = new Select(selector);
    }

    /* for debugging
    for (var member in this) {
        if (typeof this[member] !== "function") {
            console.log(member + ": " + this[member]);
        }
    }*/

    // iterate threw the children
    // apply the selector and traverse down the tree
    for (var n = 0; n < this.nodes.length; n++) {
        var node = this.nodes[n];
        for (var i = 0; i < node.children.length; i++) {
            if (selector.match(node.children[i])) {
                // Add matching element to result
                result.nodes.push(node.children[i]);
            }
            if (node.children[i].children.length) {
                // Merge matching results of subrtree
                var child = new An(node.children[i]);
                result.concat(child.find(selector));
            }
        }
    }
    return result;
}

An.prototype.inspect = function() {
    for (var member in this.nodes[0]) {
        if (typeof this[member] !== "function") {
            console.log(member + ": " + this[member]);
        }
    }
    return this;
}

// Search only direct children
An.prototype.children = function(selector) {
    var result = new An();

    if (typeof selector === "string") {
        selector = new Select(selector);
    }

    for (var n = 0; n < this.nodes.length; n++) {
        var node = this.nodes[n];
        for (var i = 0; i < node.children.length; i++) {
            if (selector.match(node.children[i])) {
                 // Add matching element to result
                result.nodes.push(node.children[i]);
            }
        }
    }
    return result;
}

An.prototype.concat = function(n) {
    this.nodes = this.nodes.concat(n.nodes);
}

An.prototype.first = function() {
    if (this.nodes.length > 0) {
        return new An(this.nodes[0]);
    }
    return new An();
}

An.prototype.last = function() {
    if (this.nodes.length > 0) {
        return new An(this.nodes[this.nodes.length - 1]);
    }
    return new An();
}

An.prototype.eq = function(n) {
    if (this.nodes.length > n) {
        return new An(this.nodes[n]);
    }
    return new An();
}

/**
 * Simulate a mouse click on the nodes
 */
An.prototype.click = function(opt) {
    var options = getOpts({
        x: 0,
        y: 0
    }, opt);

    for (var n = 0; n < this.nodes.length; n++) {
        var node = this.nodes[n];
        var x = node.mapToItem(null, 0, 0).x + Math.floor(node.width / 2) + options.x;
        var y = node.mapToItem(null, 0, 0).y + Math.floor(node.height / 2) + options.y;
        var m = mouse.createObject(root, {px: x, py: y});
        m.click();
    }
    return this;
}

/**
 * Simulate a touch the nodes
 */
An.prototype.touch = function(opt) {
    var options = getOpts({
        x: 0,
        y: 0
    }, opt);

    for (var n = 0; n < this.nodes.length; n++) {
        var node = this.nodes[n];
        var x = node.mapToItem(null, 0, 0).x + Math.floor(node.width / 2) + options.x;
        var y = node.mapToItem(null, 0, 0).y + Math.floor(node.height / 2) + options.y;
        var m = touch.createObject(root, {toX: x, toY: y});
        m.touch();
    }
    return this;
}

/**
 * Simulate a mouse hover on the nodes
 */
An.prototype.hover = function(opt) {
    var options = getOpts({
        x: 0,
        y: 0
    }, opt);

    for (var n = 0; n < this.nodes.length; n++) {
        var node = this.nodes[n];
        var x = node.mapToItem(null, 0, 0).x + Math.floor(node.width / 2) + options.x;
        var y = node.mapToItem(null, 0, 0).y + Math.floor(node.height / 2) + options.y;
        var m = mouse.createObject(root, {px: x, py: y});
        m.hover();
    }
    return this;
}

/**
 * Simulate a touch
 */
An.prototype.swipe = function(opt) {
    var options = getOpts({
        fromX: 0,
        fromY: 0,
        toX: 0,
        toY: 0
    }, opt);

    for (var n = 0; n < this.nodes.length; n++) {
        var node = this.nodes[n];
        var x = node.mapToItem(null, 0, 0).x + Math.floor(node.width / 2) + options.fromX;
        var y = node.mapToItem(null, 0, 0).y + Math.floor(node.height / 2) - Kirigami.Units.iconSizes.smallMedium / 2 + options.fromY;
        var t = touch.createObject(root, {fromX: x, fromY: y, toX: x + options.toX, toY: y + options.toY});
        t.swipe();
    }
    return this;
}

/**
 * Draw a tree of all the elements
 */
An.prototype.tree = function(lvl) {
    if (typeof lvl === "undefined") {
        lvl = ""
    }

    /* for debug
    for (var member in this.nodes) {
        if (typeof this[member] !== "function") {
            console.log("|" + lvl + "  " + member + ": " + (typeof this[member]));
        }
    }*/

    for (var n = 0; n < this.nodes.length; n++) {
        var node = this.nodes[n];
        console.log("|" + lvl + "  " + getClassName(node) + "  " + node.toString());
        for (var i = 0; i < node.children.length; i++) {
            var child = new An(node.children[i]);
            child.tree(lvl + "--");
        }
    }
}

/**
 * Drawing annotation on the nodes
 */
An.prototype.draw = function(obj) {
    console.log(this.nodes)
    for (var n = 0; n < this.nodes.length; n++) {
        var node = this.nodes[n];
        var opt;
        for (var type in obj) {
            if (Array.isArray(obj[type])) {
                for (var i = 0; i < obj[type].length; i++) {
                    this._draw(node, type, obj[type][i]);
                }
            }
            else {
                this._draw(node, type, obj[type]);
            }
        }
    }
    return this;
}

/**
 * Internal method to draw
 */
An.prototype._draw = function(node, type, opt) {
    //console.log("drawing " + type)
    switch (type) {
        case "outline":
            outline.createObject(root, {item: node, label: opt.label, aspectratio: opt.aspectratio});
        break
        case "ruler":
            var options = getOpts({
                offset: opt.horizontal ? node.mapToItem(null, 0, 0).y : node.mapToItem(null, 0, 0).x,
                horizontal: false
            }, opt);
            ruler.createObject(root, options);
        break
        case "padding":
            var options = getOpts({
                padding: opt.padding
            }, opt);
            padding.createObject(root, {item: node, padding: options.padding});
        break
        case "brace":
            brace.createObject(root, {"from": node, "to": opt.to.nodes[0], "text": opt.text, "center": opt.center, "horizontal": opt.horizontal});
        break
        case "messure":
            messure.createObject(root, {"from": node, "to": opt.to.nodes[0], "type": opt.type});
        break
    }
}

/**
 * Selector for qml elements
 */
function Select(str) {
    // TODO support more complex syntax
    // - multiple nodenames, hirachy, ...
    if (str.search(/\{/) !== -1) {
        this.nodeName = str.substring(0, str.indexOf("{"));
        var members = str.match(/\{.+\}/);
        try {
            this.attrs = JSON.parse(members[0]);
        }
        catch(e) {
            console.log("Could not parse attributes");
            console.log(e);
        }
    }
    else {
        this.nodeName = str;
    }
}

/**
 * Check if the node matches the selector
 */
Select.prototype.match = function(node) {
    if (this.nodeName === "*" || getClassName(node) === this.nodeName) {
        if (typeof this.attrs !== "undefined") {
            // TODO only return true if all attributes match
            for (var attr in this.attrs) {
                if (typeof node[attr] !== "undefined" && node[attr].toString() === this.attrs[attr]) {
                    return true;
                }
            }
        }
        else {
            return true;
        }
    }
    return false;
}
