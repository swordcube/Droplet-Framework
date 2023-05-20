package droplet.engine.scene;

class Node {
    /**
     * The children of this node.
     */
    public var children:Array<Node> = [];

    public function new() {}

    /**
     * A function that gets called every frame.
     * Override this to make custom behavior.
     * @param delta The time that has passed since last frame in seconds.
     */
    public function update(delta:Float) {}

    /**
     * A function that gets called every time this node
     * tries to render something to the window.
     * 
     * Override this to make custom behavior.
     */
    public function render() {}

    /**
     * Adds a child node into this node.
     * @param node The child to add.
     */
    public function add(node:Node) {
        children.push(node);
    }

    /**
     * Removes a child node from this node.
     * @param node The node to remove.
     */
    public function remove(node:Node) {
        children.remove(node);
    }

    /**
     * Destroys this node and all of it's children.
     */
    public function destroy() {
        for(child in children) {
            if(child == null) continue;
            child.destroy();
        }
        children = [];
    }

    @:noCompletion
    private function _update(_delta:Float) {
        update(_delta);
        for(child in children) {
            if(child == null) continue;
            child._update(_delta);
        }
    }

    @:noCompletion
    private function _render() {
        render();
        for(child in children) {
            if(child == null) continue;
            child._render();
        }
    }
}