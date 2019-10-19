package;

import CellState;
import Board;

class BoardIteratorObject {
  public var index(default, null):Int;
  public var row(default, null):Int;
  public var col(default, null):Int;
  public var state(default,null):CellState;

  public inline function new(index:Int, board:Board) {
    this.index = index;
    this.row = Std.int(index / board.height);
    this.col = index % board.width;
    this.state= board.get(row,col);
  }
}