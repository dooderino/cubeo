package;

import CellStates;
import BoardState;

class BoardIteratorObject {
  public var index(default, null):Int;
  public var row(default, null):Int;
  public var col(default, null):Int;
  public var state(default,null):CellStates;

  public inline function new(index:Int, board:BoardState) {
	this.index = index;
	this.row = Std.int(index / board.height);
	this.col = index % board.width;
	this.state= board.get(row,col);
  }
}