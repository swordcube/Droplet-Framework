package droplet.backend.graphics;

import droplet.engine.system.Game;

class Renderer {
	public static inline function begin() {
		Rl.beginDrawing();
	}

	public static inline function end() {
		Rl.endDrawing();
	}

	public static inline function clear(color:DropletColor) {
		Rl.clearBackground(color.toRaylib());
	}

	@:noCompletion
	private static inline function _drawBlackBars(renderTexture:Rl.Texture2D, destRect:Rl.Rectangle) {
		switch (Game.scaleMode) {
			case FIXED:
				// left and right
				if (destRect.x > 0) {
					Rl.drawRectangle(0, 0, Std.int(destRect.x) + 1, Rl.getScreenHeight() + 1, Rl.Colors.BLACK);

					Rl.drawRectangle(Std.int(destRect.x + destRect.width), 0, Std.int(destRect.x) + 1, Rl.getScreenHeight() + 1, Rl.Colors.BLACK);
				}

				// top and bottom
				if (destRect.y > 0) {
					Rl.drawRectangle(0, 0, Rl.getScreenWidth(), Std.int(destRect.y) + 1, Rl.Colors.BLACK);

					Rl.drawRectangle(0, Std.int(destRect.y + destRect.height), Rl.getScreenWidth(), Std.int(destRect.y) + 1, Rl.Colors.BLACK);
				}

			default: // nah
		}
	}

	@:noCompletion
	private static inline function _renderGame(renderTexture:Rl.Texture2D, destRect:Rl.Rectangle) {
		Rl.drawTexturePro(renderTexture, Rl.Rectangle.create(0.0, renderTexture.height, renderTexture.width, -renderTexture.height), destRect,
			Rl.Vector2.zero(), 0.0, Rl.Colors.WHITE);
	}
}
