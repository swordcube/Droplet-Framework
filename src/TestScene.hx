package;

import droplet.backend.graphics.DropletColor;
import droplet.engine.system.Game;
import droplet.engine.scene.Scene;
import droplet.engine.scene.Sprite;

class TestScene extends Scene {
	var t:Float = 0;
	var s:Sprite;

	override function ready() {
		super.ready();
		Game.clearColor = DropletColor.Gray;

		add(s = new Sprite().loadTexture("assets/images/droplet.png"));
		s.origin.set(0.5, 0.5);
		s.screenCenter();
		s.scale.set(1.5, 1.5);
		s.position.subtract(300, 100);

		var b = new Sprite().loadTexture("assets/images/droplet.png");
		b.origin.set(0.5, 0.5);
		b.screenCenter();
		b.position.subtract(40, 20);
		add(b);
	}

	override function update(delta:Float) {
		super.update(delta);
		t += delta;
	}
}
