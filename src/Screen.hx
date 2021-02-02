package;

import h2d.Object;

class Screen {
	public var parent : Object;
	public var name : String;

	public function new(name:String, ?parent:Object) {
		this.name = name;
		this.parent = parent;
	}

	public function log( s : String, ?pos : haxe.PosInfos, ?updateUI : Bool = false ) {
		haxe.Log.trace(s, pos);
	}

	public function init() {
	}

	public function update(dt:Float) {
	}

	public function cleanup() {
	}
}