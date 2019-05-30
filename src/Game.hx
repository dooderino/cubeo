import hxd.Res;
import hxd.res.DefaultFont;
import h2d.Flow;
import h2d.Text;

class Game extends hxd.App {
	public var fps : Text;
	public var fps_flow : Flow;
	public var flow : Flow;

	override function new() {
		super();
	}

	override function init() {
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