package;

import hxbit.NetworkSerializable;
import h2d.Anim;
import h2d.Bitmap;
import h2d.Object;

@:enum
abstract CellState(Int) from Int to Int
{
    var Empty= 0;
    var RedOne= 1;
    var RedTwo= 2;
    var RedThree= 3;
    var RedFour= 4;
    var RedFive=5 ;
    var RedSix= 6;
    var BlueOne= 7;
    var BlueTwo= 8;
    var BlueThree= 9;
    var BlueFour= 10;
    var BlueFive= 11;
    var BlueSix= 12;
    var Invalid= 13;
}

class Cell implements hxbit.NetworkSerializable {
    private var game : Game;
    private var anim : h2d.Anim;
    private var bmp : h2d.Bitmap;
    private var obj : h2d.Object;
    private var startx : Int;
    private var starty : Int;
    private var padding : Int;

    @:s public var Row(default, set) : Int;

    function set_Row(row : Int) {
        if (this.obj != null) {
            this.obj.y= starty + ((64 + padding) * row);
        }
        return this.Row= row;
    }

    @:s public var Col(default, set) : Int;

    function set_Col(col : Int) {
        if (this.obj != null) {
            this.obj.x= startx + ((64 + padding) * col);
        }
        return this.Col= col;
    }
    @:s public var State(default, set) : CellState;

    function set_State(s : CellState) {
        anim.currentFrame= cast(s, Float);
        bmp.tile= anim.getFrame();
        return this.State= s;
    }

    public function new(row: Int, col: Int, startx : Int, starty : Int, padding : Int) {
        game= Game.inst;
        anim= new h2d.Anim(
            [
                hxd.Res.empty.toTile(), 
                hxd.Res.red_one.toTile(),
                hxd.Res.red_two.toTile(),
                hxd.Res.red_three.toTile(),
                hxd.Res.red_four.toTile(),
                hxd.Res.red_five.toTile(),
                hxd.Res.red_six.toTile(),
                hxd.Res.blue_one.toTile(),
                hxd.Res.blue_two.toTile(),
                hxd.Res.blue_three.toTile(),
                hxd.Res.blue_four.toTile(),
                hxd.Res.blue_five.toTile(),
                hxd.Res.blue_six.toTile(),
            ], 
            0.0);

        obj= new h2d.Object(game.s2d);

        this.startx= startx;
        this.starty= starty;
        this.padding= padding;

        Row= row;
        Col= col;

        bmp= new Bitmap(anim.getFrame(), obj);    
    }
}