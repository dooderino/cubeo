import h3d.shader.SkinBase;
import h3d.Vector;
import haxe.Timer;
import h2d.Bitmap;
import h2d.Object;
import h2d.Tile;
import hxd.Res;
import hxd.res.DefaultFont;
import h2d.Flow;
import h2d.Text;
import h2d.Anim;
import Cell;

class Game extends hxd.App {
	public var fps : Text;
	public var fps_flow : Flow;
	public var flow : Flow;
	public var board : Array<Cell>;

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

		//cell= new Cell(Std.int(s2d.width / 2), Std.int(s2d.height / 2));
		var startx= Std.int(s2d.width / 2) - Std.int((64+2)*6);
		var starty= Std.int(s2d.height / 2) - Std.int((64+2)*6);

		board= new Array<Cell>();
		for (row in 0...12) {
			for (col in 0...12) {
				board.push(new Cell(row, col, startx, starty, 2));
			}
		}
	}

	override function update(dt:Float) {
	}

	override function render(e:h3d.Engine) {
		fps.text = "FPS: " + Std.string(e.fps);

		super.render(e);
	}

	public static var inst : Game;
	
	static function main() {
		hxd.Res.initEmbed();
		inst= new Game();
	}
}