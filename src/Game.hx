import hxd.res.DefaultFont;
import h2d.Graphics;
import h2d.Flow;
import h2d.Text;
import h3d.scene.*;

class Game extends hxd.App {
	public var fps : Text;
	public var fps_flow : Flow;
	public var flow : Flow;
	public var world : World;
	public var graphics : h2d.Graphics;

	override function new() {
		super();
	}

	override function init() {
		graphics = new h2d.Graphics(s2d);
		world = new h3d.scene.World(64, 128, s3d);

		s3d.camera.pos.set(0, 200, 0);
	
		s3d.lightSystem.ambientLight.set(0.9, 0.9, 0.9);

		var shadow = s3d.renderer.getPass(h3d.pass.DefaultShadowMap);
		shadow.power = 1;
		shadow.color.setColor(0x301030);

	    flow = new h2d.Flow(s2d);
	    flow.padding = 20;

		fps_flow = new h2d.Flow(flow);
		fps_flow.layout = FlowLayout.Vertical;
		fps = new h2d.Text(DefaultFont.get(), fps_flow); 
		fps.text = "FPS: " + Std.string(0.0);
	}

	override function update(dt:Float) {
	}

	override function render(e:h3d.Engine) {
		fps.text = "FPS: " + Std.string(e.fps);
		super.render(e);
	}
	
	static function main() {
		hxd.Res.initEmbed();
		new Game();
	}
}