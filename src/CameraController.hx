package;

import h3d.scene.Object;
import Camera;

class CameraController extends h3d.scene.Object {
	var camera:Camera;
	var scene : h3d.scene.Scene;

	public function new(camera:Camera, ?parent) {
		super(parent);
		this.camera= camera;
	}

	override function onAdd() {
		super.onAdd();
		scene = getScene();
		scene.addEventListener(onEvent);
	}

	override function onRemove() {
		super.onRemove();
		scene.removeEventListener(onEvent);
		scene = null;
	}

	function onEvent(e:hxd.Event) {
		var p : h3d.scene.Object = this;
		while( p != null ) {
			if( !p.visible ) {
				e.propagate = true;
				return;
			}
			p = p.parent;
		}

		switch(e.kind) {
		case EWheel:
			var currentZoom= camera.zoom;
			currentZoom += e.wheelDelta * 0.001;
			if (currentZoom < camera.minZoom)
				currentZoom= camera.minZoom;

			camera.zoom= currentZoom;

			if (camera.zoom < 0) {
				camera.zoom= 0.0;
			}
		default:
		}
	}
}