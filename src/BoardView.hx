package;

import h2d.Object;
import GameplayScreen;
import CellView;
import BoardState;
import BoardIterator;

class BoardView {
	var width(default, null):Int= 0;
	var height(default, null):Int= 0;
	var index(default, null):Int =0;
	var totalWidth:Float= 0.0;
	var totalHeight:Float= 0.0;
	var root : h2d.Object;
	var data:Array<CellView>; 
	var boardState: BoardState;
	public var game : GameplayScreen;

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

	@:rpc public function set(row:Int, col:Int, s:CellStates) {
		boardState.set(row, col, s);
	}

	public function get(row:Int, col:Int) {
		return data[width * row + col].State;
	}

	public function setPosition(x:Int, y:Int) {
		root.setPosition(x, y);
	}

	public function update() {
		if (data.length == 0) return;

		for (board_cell in new BoardIterator(boardState)) {
			data[width * board_cell.row + board_cell.col].State= board_cell.state;
		}
	}

	public function new(board:BoardState, object:Object) {
		game = board.game;
		boardState= board;
		root= object;
		width= boardState.width;
		height= boardState.height;

		totalWidth= (width * (CellView.size * CellView.scale)) + (width * (CellView.padding * CellView.scale));
		totalHeight= (height * (CellView.size * CellView.scale)) + (height * (CellView.padding * CellView.scale));

		var offset_x= totalWidth * 0.5;
		var offset_y= totalHeight * 0.5;

		index= 0;
		data= new Array<CellView>();
		for (board_cell in new BoardIterator(boardState)) {
			var board_view_cell= new CellView(this, board_cell.row, board_cell.col, board_cell.state);
			board_view_cell.obj.x -= offset_x;
			board_view_cell.obj.y -= offset_y;
			board_view_cell.hover.x= board_view_cell.obj.x;
			board_view_cell.hover.y= board_view_cell.obj.y;
			board_view_cell.placement.x= board_view_cell.obj.x;
			board_view_cell.placement.y= board_view_cell.obj.y;
			root.addChild(board_view_cell.obj);
			root.addChild(board_view_cell.hover);
			root.addChild(board_view_cell.placement);
			data.push(board_view_cell);
		}
	}
}