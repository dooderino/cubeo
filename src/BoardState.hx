import GameplayScreen;
import CellStates;
import hxbit.NetworkSerializable;

class BoardState implements hxbit.NetworkSerializable {
	public var game : GameplayScreen;
	@:s public var width:Int;
	@:s public var height:Int;
	var index(default, null):Int =0;
	@:s public var uid : Int;
	@:s var data:Array<CellStates>; 

	public function hasNext() {
		return index < width * height;
	}

	public function next() {
		index++;
		var row= Std.int(index/height);
		var col= index % width;
		return data[width * row + col];
	}

	public function reset() {
		index= 0;
	}

	public function set(row:Int, col:Int, s:CellStates) {
		data[width * row + col]= s;
	}

	public function get(row:Int, col:Int) {
		return data[width * row + col];
	}

	public function networkAllow( op : hxbit.NetworkSerializable.Operation, propId : Int, client : hxbit.NetworkSerializable ) : Bool {
		return client == this;
	}

	public function new(gridWith:Int, gridHeight:Int, owner:GameplayScreen, uid= 0) {
		width= gridWith;
		height= gridHeight;
		game= owner;
		this.uid= uid;
		index= 0;

		// Fill the board with empty squares
		data= new Array<CellStates>();
		for (i in 0...width*height) {
			data.push(Empty);
		}

		// Add the default starting state, one blue and one red die
		// in the center.
		set(6,5,RedOne);
		set(6,6,BlueOne);

		// Cross out extra squares to create the dice pools for each
		// player
		for (i in 0...width) {
			// Cross out the last column
			set(i,12, Invalid);

			// Cross out the left side of the dice pools
			if (i <= 2) {
				set(0, i, Invalid);
				set(12, i, Invalid);
			}

			// Cross out the right side of the dice pools
			if (i >= 9) {
				set(0, i, Invalid);
				set(12, i, Invalid);
			}

			// Fill in the dice pools with dice set to one
			// for each player
			if (i >= 3 && i <= 7) {
				set(0, i, BlueOne);
				set(12, i, RedOne);
			}
		}
		
		init();
	}

	function init() {
		game = cast Game.screenManager.currentScreen;
		game.log("Init " + this);
		enableReplication= true;
	}

	public function alive() {
		init();

		if (uid != 0 && uid == game.uid && game.state == GameStates.Client) {
			game.boardState = this;
			game.host.self.ownerObject = this;
			var startx= Std.int(Game.inst.s2d.width / 2);
			var starty= Std.int(Game.inst.s2d.height / 2);
			game.boardView= new BoardView(this, Game.inst.camera);
			game.boardView.setPosition(startx, starty);
		}
	}
}



