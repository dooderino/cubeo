package;

import BoardState;
import BoardView;
import Game;
import GameStates;
import h2d.Object;

class GameplayScreen extends Screen {
	var ip : String;
	var port : Int;
	public var host : hxd.net.SocketHost;
	public var event : hxd.WaitEvent;
	public var uid : Int;
	public var state : GameStates;

	public var boardState : BoardState;
	public var boardView : BoardView;
	public var gridSize : Int = 13;

	public function new(gameState:GameStates, ip:String, port:String, ?parent:Object) {
		super("GameplayScreen", parent); 

		this.ip = ip;
		this.port = Std.parseInt(port);
		this.state = gameState;

		event = new hxd.WaitEvent();
		host = new hxd.net.SocketHost();
		host.setLogger(function(msg) log(msg));
	}

	public override function log( s : String, ?pos : haxe.PosInfos ) {
		pos.fileName = (host.isAuth ? "[S]" : "[C]") + " " + pos.fileName;
		haxe.Log.trace(s, pos);
	}

	public override function init() {
		switch (state) {
			case GameStates.Server:
				initServer();
			case GameStates.Client:
				initClient();
			case GameStates.Idle:
				return;
		}
	}

	function initServer() {
		host.wait(ip, port, function(c) {
			log("Client Connected");
		});

		host.onMessage = function(b,uid:Int) {
			log("Client identified ("+uid+")");
			boardState= new BoardState(gridSize, gridSize, this, uid);
			b.ownerObject = boardState;
			b.sync();
			var startx= Std.int(Game.inst.s2d.width / 2);
			var starty= Std.int(Game.inst.s2d.height / 2);

			boardView= new BoardView(boardState, parent);
			boardView.setPosition(startx, starty);
		};
		log("Server Started");

		start();
	}

	function start() {
		boardState= new BoardState(gridSize, gridSize, this);

		var startx= Std.int(Game.inst.s2d.width / 2);
		var starty= Std.int(Game.inst.s2d.height / 2);

		boardView= new BoardView(boardState, parent);
		boardView.setPosition(startx, starty);

		log("Live");
		host.makeAlive();
	}


	function initClient() {
		log("Connecting");

		uid = 1 + Std.random(1000);
		host.connect(ip, port, function(b) {
			if( !b ) {
				log("Failed to connect to server");
				return;
			}
			log("Connected to server");
			host.sendMessage(uid);
		});
	}

	public override function update(dt:Float) {
		super.update(dt);

		event.update(dt);
		host.flush();
		if (boardView != null)
			boardView.update();
	}

	public override function cleanup() {
		super.cleanup();
	}
}