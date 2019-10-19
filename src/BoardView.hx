package;

import h2d.Object;
import h2d.Scene;
import CellState;
import Cell;
import Board;
import BoardIterator;

class BoardView {
    var width(default, null):Int= 0;
    var height(default, null):Int= 0;
    var index(default, null):Int =0;
    var root : h2d.Object;
    var data:Array<Cell>; 

    public function hasNext() {
        return index < width * height;
    }

    public function next() {
        index++;
        var row= Std.int(index/width);
        var col= index % width;
        return data[width * row + col];
    }

    public function reset() {
        index= 0;
    }

    public function set(row:Int, col:Int, s:CellState) {
        data[width * row + col].State= s;
    }

    public function get(row:Int, col:Int) {
        return data[width * row + col].State;
    }

    public function setPosition(x:Int, y:Int) {
        root.setPosition(x, y);
        var offset_x= x * 0.5;
        var offset_y= y * 0.5;
    }

    public function new(board:Board, object:Object) {
        root= object;
        width= board.width;
        height= board.height;
        index= 0;
        data= new Array<Cell>();
        for (board_cell in new BoardIterator(board)) {
            var board_view_cell= new Cell(board_cell.row, board_cell.col, board_cell.state);
            root.addChild(board_view_cell.obj);
        }
    }
}