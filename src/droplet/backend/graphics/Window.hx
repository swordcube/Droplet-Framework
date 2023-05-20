package droplet.backend.graphics;

import droplet.engine.system.Vector2D;

class Window {
    public var position(get, set):Vector2D;
    public var title(get, set):String;
    public var icon(default, set):Rl.Image;
    public var shouldClose(get, never):Bool;

    private var _title:String;
    
    public function new(width:Int, height:Int, title:String) {
        Rl.initWindow(width, height, _title = title);

        // turns out you can set multiple states
        // neat
        Rl.setWindowState(Rl.ConfigFlags.WINDOW_RESIZABLE);
    }

    public function close() {
        Rl.closeWindow();
    }

    @:noCompletion
    private inline function set_icon(v:Rl.Image) {
        Rl.setWindowIcon(v);
        return icon = v;
    }

    @:noCompletion
    private inline function get_shouldClose():Bool {
        return Rl.windowShouldClose();
    }

    @:noCompletion
    private inline function get_title():String {
        return _title;
    }

    @:noCompletion
    private inline function set_title(v:String) {
        Rl.setWindowTitle(v);
        return _title = v;
    }

    @:noCompletion
    private inline function get_position():Vector2D {
        return Vector2D.fromRaylib(Rl.getWindowPosition());
    }

    @:noCompletion
    private inline function set_position(v:Vector2D) {
        Rl.setWindowPosition(Std.int(v.x), Std.int(v.y));
        return v;
    }
}