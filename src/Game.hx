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
	var sceneWidthStart:Float;
	var sceneHeightStart:Float;
	var sceneDiagonalStart:Float;
	var fps : Text;
	var fps_flow : Flow;
	var flow : Flow;
	var board : Board;
	var view : BoardView;
	var camera : Camera;

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

		sceneWidthStart= s2d.width;
		sceneHeightStart= s2d.height;
		sceneDiagonalStart= Math.sqrt(sceneWidthStart*sceneWidthStart + sceneHeightStart*sceneHeightStart);

		var startx= Std.int(s2d.width / 2);
		var starty= Std.int(s2d.height / 2);

		camera= new Camera(s2d);
		camera.viewX= s2d.width * 0.5;
		camera.zoom= 0.8;

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

	public override function onResize() {
		var sceneWidth= s2d.width;
		var sceneHeight= s2d.height;
		var sceneDiagonal= Math.sqrt(sceneWidth*sceneWidth + sceneHeight*sceneHeight);
		var zoom= sceneDiagonal / sceneDiagonalStart;

		camera.zoom= zoom * 0.8;

		var viewCenterX= Std.int(s2d.width / 2);
		var viewCenterY= Std.int(s2d.height / 2);
		view.setPosition(viewCenterX, viewCenterY);
	}

	public static var inst : Game;
	
	static function main() {
		hxd.Res.initEmbed();
		inst= new Game();
	}
}