package droplet.engine.scene;

import droplet.backend.graphics.DropletColor;

class Sprite extends Node2D {
	public var angle:Float = 0;
	public var color:DropletColor = DropletColor.White;
	public var texture:Rl.Texture2D;

	public function loadGraphic(path:String):Sprite {
		texture = Rl.loadTexture(path);
		return this;
	}

	override function render() {
		Rl.drawTexturePro(texture, 
            Rl.Rectangle.create(
                0, 0, 
                texture.width, texture.height
            ),
			Rl.Rectangle.create(
                position.x, position.y,
                Math.abs(texture.width * scale.x), Math.abs(texture.height * scale.y)
            ), 
            origin.toRaylib(),
            angle,
			color.convertToRaylib()
        );
	}
}
