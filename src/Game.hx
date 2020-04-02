import hxd.Res;
import hxd.res.DefaultFont;
import h2d.Flow;
import h2d.Text;
import BoardState;
import BoardView;
import Camera;

class Game extends hxd.App {
	static var HOST = "127.0.0.1";
	static var PORT = 6676;
	public var isServer : Bool;
	public var isClient : Bool;

	var sceneWidthStart:Float;
	var sceneHeightStart:Float;
	var sceneDiagonalStart:Float;
	var fps : Text;
	var fps_flow : Flow;
	var flow : Flow;
	public var boardState : BoardState;
	public var view : BoardView;
	public var camera : Camera;
	public var host : hxd.net.SocketHost;
	public var event : hxd.WaitEvent;
	public var uid : Int;

	override function new() {
		super();
	}

	override function init() {

		event = new hxd.WaitEvent();
		host = new hxd.net.SocketHost();
		host.setLogger(function(msg) log(msg));

	    flow= new h2d.Flow(s2d);
	    flow.padding= 20;

		fps_flow= new h2d.Flow(flow);
		fps_flow.layout= FlowLayout.Vertical;
		fps= new h2d.Text(DefaultFont.get(), fps_flow); 
		fps.text= "FPS: " + Std.string(0.0);
		fps.setScale(2.0);

		sceneWidthStart= s2d.width;
		sceneHeightStart= s2d.height;
		sceneDiagonalStart= Math.sqrt(sceneWidthStart*sceneWidthStart + sceneHeightStart*sceneHeightStart);

		camera= new Camera(s2d);
		camera.viewX= s2d.width * 0.5;
		camera.zoom= 0.8;

		try {
			host.wait(HOST, PORT, function(c) {
				log("Client Connected");
			});
			host.onMessage = function(b,uid:Int) {
				log("Client identified ("+uid+")");
				boardState= new BoardState(12, 12, uid);
				b.ownerObject = boardState;
				b.sync();
				var startx= Std.int(s2d.width / 2);
				var starty= Std.int(s2d.height / 2);

				view= new BoardView(boardState, camera);
				view.setPosition(startx, starty);
			};
			log("Server Started");

			isServer= true;

			start();

		} catch( e : Dynamic ) {

			// we could not start the server
			log("Connecting");

			uid = 1 + Std.random(1000);
			host.connect(HOST, PORT, function(b) {
				if( !b ) {
					log("Failed to connect to server");
					return;
				}
				log("Connected to server");
				host.sendMessage(uid);
			});

			isClient= true;

		}
	}

	function start() {
		boardState= new BoardState(13, 13);

		var startx= Std.int(s2d.width / 2);
		var starty= Std.int(s2d.height / 2);

		view= new BoardView(boardState, camera);
		view.setPosition(startx, starty);

		log("Live");
		host.makeAlive();
	}

	override function update(dt:Float) {
		event.update(dt);
		host.flush();
		if (view != null)
			view.updateView();
	}

	override function render(e:h3d.Engine) {
		fps.text= "FPS: " + Std.string(e.fps);

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

	public function log( s : String, ?pos : haxe.PosInfos ) {
		pos.fileName = (host.isAuth ? "[S]" : "[C]") + " " + pos.fileName;
		haxe.Log.trace(s, pos);
	}
}