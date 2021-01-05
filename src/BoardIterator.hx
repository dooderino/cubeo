package;

import BoardState;
import BoardIteratorObject;

class BoardIterator {
  var width:Int = 0;
  var height:Int = 0;
  var index:Int = 0;
  var boardState:BoardState;

  public inline function new(board:BoardState) {
	this.width = board.width;
	this.height = board.height;
	this.boardState= board;
  }

  public inline function hasNext() {
	return index < width * height;
  }

  public inline function next() {
	return new BoardIteratorObject(index++, boardState);
  }
}

