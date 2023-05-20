package droplet.engine.system;

import droplet.engine.utilities.MathUtil;
import droplet.backend.graphics.*;
import droplet.backend.sound.*;
import droplet.engine.scene.*;

enum abstract ScaleMode(Int) to Int from Int {
	/**
	 * Maintains the game's scene at a fixed size. 
	 * This will clip off the edges of the scene for dimensions which are too small, 
	 * and leave black margins on the sides for dimensions which are too large.
	 */
	var FIXED = 0;

	/**
	 * Stretches and squashes the game to exactly fit the provided window. 
	 * This may result in the graphics of your game being distorted if the user resizes their game window.
	 */
	var FILL = 1;
}

@:access(droplet.backend.graphics.Renderer)
@:access(droplet.engine.scene.Node)
class Game {
    /**
     * Whether or not the game is already initialized.
     */
    public static var initialized:Bool = false;

    /**
     * The kind of scaling that should be applied to the game
     * when rendering onto the window.
     */
    public static var scaleMode:ScaleMode = FIXED;

    /**
     * The maximum framerate the game can run at.
     */
    public static var framerate(default, set):Int = 60;

    /**
     * The window used to display the game.
     */
    public static var window:Window;

    /**
     * The width of the game.
     */
    public static var width(default, null):Int;

    /**
     * The height of the game.
     */
    public static var height(default, null):Int;

    /**
     * The current scene that is updating & rendering.
     */
    public static var scene:Scene;
    
    /**
     * The amount of time in seconds that has passed since last frame.
     */
    public static var elapsed:Float = 0;

    /**
	 * The maximum amount that `elapsed` can be during update functions.
     * 
     * It is recommended not to change this unless absolutely needed!
	 */
    public static var maxElapsed:Float = 0.1;

    /**
     * The background color the window displayed when it isn't
     * fully covered by another sprite/object.
     */
    public static var clearColor:DropletColor = DropletColor.BLACK;

    private static var _renderTexture:Rl.RenderTexture2D;

    /**
     * Makes a new game object.
     * 
     * @param width The width of the game.
     * @param height The height of the game.
     * @param title The title of the game window.
     * @param framerate The maximum framerate the game is capped to.
     * @param initialScene The scene to load when the game starts.
     */
    public static function init(width:Int, height:Int, title:String, framerate:Int, initialScene:Scene) {
        if(initialized) return;
        initialized = true;

        Rl.setTraceLogLevel(Rl.TraceLogLevel.WARNING);

        window = new Window(Game.width = width, Game.height = height, title);
        scene = initialScene;
        scene.create();

        _renderTexture = Rl.loadRenderTexture(width, height);

        Game.framerate = framerate;
        SoundSystem.init();

        var fpsFont:Rl.Font = Rl.loadFont("assets/fonts/vcr.ttf");

        while(!window.shouldClose) {
            // NOTE TO ANYONE PASSING BY: i'm doing this cast here
            // because hxcpp will fucking murder me otherwise
			var renderTexture:Rl.Texture2D = cast(_renderTexture.texture, Rl.Texture2D);

            switch(Game.scaleMode) {
				case FILL:
					renderTexture.width = Rl.getScreenWidth();
					renderTexture.height = Rl.getScreenHeight();

				default:
					renderTexture.width = Game.width;
					renderTexture.height = Game.height;
			}

            // Start rendering
            Renderer.begin();

            // Start rendering the game to the render texture
            Rl.beginTextureMode(_renderTexture);
            Renderer.clear(clearColor);

            elapsed = MathUtil.bound(Rl.getFrameTime(), 0, maxElapsed);
            scene._update(elapsed);
            scene._render();

            // Stop rendering to the render texture
            Rl.endTextureMode();

            // Draw black bars on the window based on scale mode
            // and draw the game to the window
            var destRect = MathUtil.letterBoxRectangle( 
                new Vector2D(renderTexture.width, renderTexture.height),
                new Rect2D(0.0, 0.0, Rl.getScreenWidth(), Rl.getScreenHeight())
            );
            Renderer._drawBlackBars(renderTexture, destRect);
			Renderer._renderGame(renderTexture, destRect);

            Rl.drawTextPro(fpsFont, "FPS: "+Rl.getFPS(), Rl.Vector2.create(10, 3), Rl.Vector2.zero(), 0, 18, 0, Rl.Colors.WHITE);

            // Stop rendering
            Renderer.end();
        }
        window.close();
    }

    @:noCompletion
    private static inline function set_framerate(v:Int):Int {
        Rl.setTargetFPS(v);
        return framerate = v;
    }
}