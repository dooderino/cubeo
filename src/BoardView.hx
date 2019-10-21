package;

import h2d.Object;
import h2d.Scene;
import CellStates;
import CellView;
import Board;
import BoardIterator;

class BoardView {
    var width(default, null):Int= 0;
    var height(default, null):Int= 0;
    var index(default, null):Int =0;
    var totalWidth:Float= 0.0;
    var totalHeight:Float= 0.0;
    var root : h2d.Object;
    var data:Array<CellView>; 

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

    public function set(row:Int, col:Int, s:CellStates) {
        data[width * row + col].State= s;
    }

    public function get(row:Int, col:Int) {
        return data[width * row + col].State;
    }

    public function setPosition(x:Int, y:Int) {
        root.setPosition(x, y);
    }

    public function new(board:Board, object:Object) {
        root= object;
        width= board.width;
        height= board.height;

        totalWidth= (width * (CellView.size * CellView.scale)) + (width * (CellView.padding * CellView.scale));
        totalHeight= (height * (CellView.size * CellView.scale)) + (height * (CellView.padding * CellView.scale));

        var offset_x= totalWidth * 0.5;
        var offset_y= totalHeight * 0.5;

        index= 0;
        data= new Array<CellView>();
        for (board_cell in new BoardIterator(board)) {
            var board_view_cell= new CellView(board_cell.row, board_cell.col, board_cell.state);
            board_view_cell.obj.x -= offset_x;
            board_view_cell.obj.y -= offset_y;
            root.addChild(board_view_cell.obj);
        }
    }
}