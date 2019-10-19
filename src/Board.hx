
import CellState;
import hxbit.NetworkSerializable;

class Board implements hxbit.NetworkSerializable {
    var width(default, null):Int= 0;
    var height(default, null):Int= 0;
    var index(default, null):Int =0;
    @:s var data:Array<CellState>; 

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

    public function set(x:Int, y:Int, s:CellState) {
        data[width * y + x]= s;
    }

    public function get(x:Int, y:Int) {
        return data[width * y + x];
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

