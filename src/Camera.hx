package;

import h2d.Scene;
import h2d.Object;

class Camera extends h2d.Object
{
	public var viewX(get, set):Float;
	public var viewY(get, set):Float;
	@:isVar public var zoom(get, set):Float;
	public var minZoom(default, null):Float= 0.3;

	var scene:Scene;

	public function new(scene:Scene)
	{
		super(scene);
		this.scene = scene;
		this.zoom= 1.0;
	}

	private function set_viewX(value:Float):Float
	{
		this.x = 0.5 * scene.width - value;
		return value;
	}

	private function get_viewX():Float
	{
		return 0.5 * scene.width - this.x;
	}

	private function set_viewY(value:Float):Float
	{
		this.y = 0.5 * scene.height - value;
		return value;
	}

	private function get_viewY():Float
	{
		return 0.5 * scene.height - this.y;
	}

	private function set_zoom(newZoom:Float):Float
	{
		if (newZoom < minZoom)
			this.zoom= minZoom;
		else
			this.zoom= newZoom;
		this.setScale(newZoom);
		return this.zoom;
	}

	private function get_zoom():Float 
	{
		return this.zoom;
	}
}