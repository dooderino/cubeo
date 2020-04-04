package;

import GameStates;
import hxbit.NetworkSerializable;

class GameState implements NetworkSerializable {
    var game : Game;
    @:s public var uid : Int;
    @:s public var state : GameStates;

    public function new(uid = 0) {
        this.uid = uid;
        state = Idle;
    }
    
    public function networkAllow( op : hxbit.NetworkSerializable.Operation, propId : Int, client : hxbit.NetworkSerializable ) : Bool {
		return client == this;
    }

    function init() {
        game= Game.inst;
        game.log("Init " + this);
        enableReplication= true;
    }
    
    public function alive() {
        init();

        if( uid != 0 && uid == game.uid && game.isClient ) {
			game.gameState = this;
		}
    }
}