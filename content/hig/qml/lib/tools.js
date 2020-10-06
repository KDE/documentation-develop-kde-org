// get scale because e.g. annotation should not be scaled
function getScale(node) {
    var scale = 1
    while (node !== null) {
        scale = scale * node.scale
        node = node.parent
    }
    return scale;
}

 function Timer() {
    return Qt.createQmlObject("import QtQuick 2.2; Timer {}", root);
}

function sleep(delayTime, cb) {
    var timer = new Timer();
    timer.interval = delayTime;
    timer.repeat = false;
    timer.triggered.connect(cb);
    timer.start();
}

function JoinSignals(signals, cb) {
    this.signals = [];
    this.cb = cb;
    for (var i = 0; i < signals.length; i++) {
        this.signals.push(new Signal(signals[i], this));
    }
}

JoinSignals.prototype.check = function() {
    for (var i = 0; i < this.signals.length; i++) {
        if (!this.signals[i].fired) {
            return;
        }
    }
    this.cb();
}

function Signal(signal, join) {
    this.fired = false;
    var that = this;
    
    signal.connect(function() {
        that.fired = true;
        join.check();
    });
}

function join(signals, cb) {
    var join = new JoinSignals(signals, cb);
}
