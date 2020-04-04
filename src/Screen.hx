package;

import h2d.Object;

class Screen {
    public var parent : Object;
    public var name : String;

    public function new(name:String) {
        this.name = name;
    }

    public function init(object:Object) {
        parent = object;
    }

    public function update(dt:Float) {
    }

    public function cleanup() {
    }
}