import hxd.Res;
import hxd.res.DefaultFont;
import h2d.Flow;
import h2d.Text;
import BoardState;
import BoardView;
import GameState;
import ScreenManager;
import MainMenuScreen;
import Camera;

class Game extends hxd.App {
	var sceneWidthStart:Float;
	var sceneHeightStart:Float;
	var sceneDiagonalStart:Float;
	public var sceneWidth(default, null):Float;
	public var sceneHeight(default, null):Float;
	public var sceneDiagonal(default, null):Float;
	public var viewCenterX(default, null):Int;
	public var viewCenterY(default, null):Int;
	var fps : Text;
	var fps_flow : Flow;
	var flow : Flow;
	var screenName : Text;
	public var camera : Camera;
	public var gridSize : Int = 13;

	override function new() {
		super();
	}

	override function init() {
		camera= new Camera(s2d);
		camera.viewX= s2d.width * 0.5;

		sceneWidthStart= s2d.width;
		sceneHeightStart= s2d.height;
		sceneDiagonalStart= Math.sqrt(sceneWidthStart*sceneWidthStart + sceneHeightStart*sceneHeightStart);

		calculateSceneBounds();
		calculateViewCenter();
		calculateCameraZoom();

		flow= new h2d.Flow(s2d);
		flow.padding= 20;

		fps_flow= new h2d.Flow(flow);
		fps_flow.layout= FlowLayout.Vertical;
		fps= new h2d.Text(DefaultFont.get(), fps_flow); 
		fps.text= "FPS: " + Std.string(0.0);
		fps.setScale(2.0);
		screenName = new h2d.Text(DefaultFont.get(), fps_flow);
		screenName.text = "No Screen Active";
		screenName.setScale(2);
	
		sceneWidthStart= s2d.width;
		sceneHeightStart= s2d.height;
		sceneDiagonalStart= 
			Math.sqrt(sceneWidthStart*sceneWidthStart + sceneHeightStart*sceneHeightStart);

		screenManager = new ScreenManager(camera);

		screenManager.onScreenChange = function() {
			screenName.text = screenManager.currentScreen.name;
		}

		screenManager.setScreen(new MainMenuScreen(camera));
	}

	public function log( s : String, ?pos : haxe.PosInfos ) {
		screenManager.currentScreen.log(s, pos);
	}

	override function update(dt:Float) {
		screenManager.update(dt);
	}

	override function render(e:h3d.Engine) {
		fps.text= "FPS: " + Std.string(e.fps);

		super.render(e);
	}

	public function calculateSceneBounds() {
		sceneWidth= s2d.width;
		sceneHeight= s2d.height;
		sceneDiagonal= Math.sqrt(sceneWidth*sceneWidth + sceneHeight*sceneHeight);
	}

	public function calculateViewCenter() {
		viewCenterX= Std.int(s2d.width / 2);
		viewCenterY= Std.int(s2d.height / 2);
	}

	public function calculateCameraZoom() {
		var zoom= sceneDiagonal / sceneDiagonalStart;
		camera.zoom= zoom * 0.8;
	}

	public override function onResize() {
		calculateSceneBounds();
		calculateViewCenter();
		calculateCameraZoom();
		view.setPosition(viewCenterX, viewCenterY);
	}

	public static var inst : Game;
	public static var screenManager : ScreenManager;
	
	static function main() {
		hxd.Res.initEmbed();
		inst= new Game();
	}
}