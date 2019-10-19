import hxd.Res;
import hxd.res.DefaultFont;
import h2d.Flow;
import h2d.Text;
import Cell;
import Board;
import BoardView;
import Camera;
import CameraController;

class Game extends hxd.App {
	public var fps : Text;
	public var fps_flow : Flow;
	public var flow : Flow;
	public var board : Board;
	public var view : BoardView;
	public var camera : Camera;
	public var cameraController : CameraController;


	override function new() {
		super();
	}

	override function init() {
	    flow= new h2d.Flow(s2d);
	    flow.padding= 20;

		fps_flow= new h2d.Flow(flow);
		fps_flow.layout= FlowLayout.Vertical;
		fps= new h2d.Text(DefaultFont.get(), fps_flow); 
		fps.text= "FPS: " + Std.string(0.0);

		var startx= Std.int(s2d.width / 2) - Std.int((Cell.size+Cell.padding)*6);
		var starty= Std.int(s2d.height / 2) - Std.int((Cell.size+Cell.padding)*6);

		camera= new Camera(s2d);
		camera.viewX= s2d.width * 0.5;
		cameraController= new CameraController(camera, s3d);

		board= new Board(12, 12);
		view= new BoardView(board, camera);
		view.setPosition(startx, starty);
	}

	override function update(dt:Float) {
	}

	override function render(e:h3d.Engine) {
		//fps.text= "FPS: " + Std.string(e.fps);
		fps.text= "Zoom: " + camera.zoom;

		super.render(e);
	}

	public static var inst : Game;
	
	static function main() {
		hxd.Res.initEmbed();
		inst= new Game();
	}
}