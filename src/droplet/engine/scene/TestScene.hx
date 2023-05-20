package droplet.engine.scene;

class TestScene extends Scene {
    var s:Sprite;

    override function create() {
        super.create();
        add(s = new Sprite().loadGraphic("assets/images/droplet.png"));
    }
}