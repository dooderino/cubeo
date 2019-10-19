
import CellState;
import hxbit.NetworkSerializable;

class Board implements hxbit.NetworkSerializable {
    public var width(default, null):Int= 0;
    public var height(default, null):Int= 0;
    var index(default, null):Int =0;
    @:s var data:Array<CellState>; 

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

    public function set(row:Int, col:Int, s:CellState) {
        data[width * row + col]= s;
    }

    public function get(row:Int, col:Int) {
        return data[width * row + col];
    }

    public function new(gridWith:Int, gridHeight:Int) {
        width= gridWith;
        height= gridHeight;
        index= 0;
        data= new Array<CellState>();
        for (i in 0...width*height) {
            data.push(Empty);
        }
    }
}



