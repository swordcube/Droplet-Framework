package droplet.engine.scene;

import droplet.engine.system.Vector2D;

class Node2D extends Node {
    /**
     * The X & Y position of this node.
     */
    public var position:Vector2D = new Vector2D(0, 0);

    /**
     * The X & Y pcale of this node.
     */
    public var scale:Vector2D = new Vector2D(1, 1);

    /**
     * The X & Y origin that this node should rotate at.
     * 
     * --------------------------------------------------
     * 
     * ### Examples
     * 
     * `0, 0` = Top Left
     * 
     * `0.5, 0.5` = Middle
     * 
     * `1, 1` = Bottom Right
     */
    public var origin:Vector2D = new Vector2D(0, 0);

    /**
     * Whether or not this node should be drawn to the screen.
     */
    public var visible:Bool = true;
}