// get scale because e.g. annotation should not be scaled
function getScale(node) {
    var scale = 1
    while (node !== null) {
        scale = scale * node.scale
        node = node.parent
    }
    return scale;
}
