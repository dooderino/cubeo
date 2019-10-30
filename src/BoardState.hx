
import CellStates;
import hxbit.NetworkSerializable;

class BoardState implements hxbit.NetworkSerializable {
    var game : Game;
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

    public function new(gridWith:Int, gridHeight:Int, uid= 0) {
        width= gridWith;
        height= gridHeight;
        this.uid= uid;
        index= 0;
        data= new Array<CellStates>();
        for (i in 0...width*height) {
            data.push(Empty);
        }
        init();
    }

    function init() {
        game= Game.inst;
        game.log("Init " + this);
        enableReplication= true;
    }

    public function alive() {
		init();

		if( uid != 0 && uid == game.uid && game.isClient ) {
			game.boardState = this;
			game.host.self.ownerObject = this;
		    var startx= Std.int(game.s2d.width / 2);
		    var starty= Std.int(game.s2d.height / 2);
			game.view= new BoardView(this, game.camera);
			game.view.setPosition(startx, starty);
		}
	}
}



