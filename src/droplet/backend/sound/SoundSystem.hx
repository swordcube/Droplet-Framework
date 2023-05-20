package droplet.backend.sound;

class SoundSystem {
    public static function init() {
        Rl.initAudioDevice();
    }
}