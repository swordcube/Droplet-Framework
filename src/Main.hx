package;

import droplet.engine.scene.TestScene;
import droplet.engine.system.Game;

class Main {
	static function main() {
		Game.init(1280, 720, "Hello World", 240, new TestScene());
	}
}
