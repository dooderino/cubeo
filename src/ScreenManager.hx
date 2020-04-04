package;

import h2d.Object;

class ScreenManager {
    public var root : Object;

    var currentScreen : Screen;

    public function new(object:Object) {
        root = object;
    }

    public function setScreen(screen:Screen) {
        if (currentScreen != null)
            currentScreen.cleanup();
        currentScreen = screen;
        currentScreen.init(root);
    }

    public function update(dt:Float) {
        currentScreen.update(dt);
    }
}