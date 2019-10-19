package;

import Board;
import BoardIteratorObject;

class BoardIterator {
  var width:Int = 0;
  var height:Int = 0;
  var index:Int = 0;
  var board:Board;

  public inline function new(board:Board) {
    this.width = board.width;
    this.height = board.height;
    this.board= board;
  }

  public inline function hasNext() {
    return index < width * height;
  }

  public inline function next() {
    return new BoardIteratorObject(index++, board);
  }
}

