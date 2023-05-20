package droplet.engine.scene;

import droplet.engine.assets.Assets;
import droplet.engine.system.Game;
import droplet.engine.utilities.Axes;
import droplet.engine.system.Vector2D;
import droplet.backend.graphics.DropletColor;

class Sprite extends Node2D {
	/**
	 * The rotation of the sprite in degrees.
	 */
	public var angle:Float = 0;

	/**
	 * The color tint applied when this sprite is rendered.
	 */
	public var color:DropletColor = DropletColor.White;

	/**
	 * The transparency of the sprite in a range from `0.0` to `1.0`.
	 */
	public var alpha:Float = 1.0;

	/**
	 * The texture used to render the sprite.
	 */
	public var texture:Rl.Texture2D;

    /**
     * How much parallax this sprite has on it's cameras.
     */
    public var scrollFactor:Vector2D = new Vector2D(1, 1);

	public function loadTexture(path:String):Sprite {
        texture = Assets.getImage(path);
		return this;
	}

    public function makeTexture(color:DropletColor, width:Int, height:Int) {
        texture = Rl.loadTextureFromImage(Rl.genImageColor(width, height, color.toRaylib()));
        return this;
    }

    public function screenCenter(axes:Axes = XY) {
        var textureSize:Vector2D = new Vector2D(Math.abs(texture.width * scale.x), Math.abs(texture.height * scale.y));
        if(axes.x) {
            position.x = (Game.width - textureSize.x) * 0.5;
            position.x += (textureSize.x * origin.x);
        }
        if(axes.y) {
            position.y = (Game.height - textureSize.y) * 0.5;
            position.y += (textureSize.y * origin.y);
        }
    }

	override function render() {
        if(!visible) return;

        var rawTextureSize:Vector2D = new Vector2D(Math.abs(texture.width), Math.abs(texture.height));
        var textureSize:Vector2D = new Vector2D(Math.abs(texture.width * scale.x), Math.abs(texture.height * scale.y));

        color.alphaFloat = alpha;

		Rl.drawTexturePro(texture,
            Rl.Rectangle.create(
                0, 0, 
                texture.width * (scale.x < 0 ? -1 : 1), texture.height * (scale.y < 0 ? -1 : 1)
            ),
			Rl.Rectangle.create(
                position.x, 
                position.y,
                textureSize.x, textureSize.y
            ), 
            Rl.Vector2.create(origin.x * textureSize.x, origin.y * textureSize.y),
            angle,
			color.toRaylib()
        );
	}

    override function destroy() {
        texture = null;
        color = 0;
    }
}
