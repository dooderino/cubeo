package;

import hxbit.NetworkSerializable;
import h2d.Anim;
import h2d.Bitmap;
import h2d.Object;

@:enum
abstract CellState(Float) {
    var Empty=      0.0f;
    var RedOne=     1.0f;
    var RedTwo=     2.0f;
    var RedThree=   3.0f;
    var RedFour=    4.0f;
    var RedFive=    5.0f;
    var RedSix=     6.0f;
    var BlueOne=    7.0f;
    var BlueTwo=    8.0f;
    var BlueThree=  9.0f;
    var BlueFour=   10.0f;
    var BlueFive=   11.0f;
    var BlueSix=    12.0f;
}

class Cell implements hxbit.NetworkSerializable {
    private var anim : h2d.Anim;
    private var bmp : h2d.Bitmap;
    private var obj : h2d.Object;

    @:s public var State(default, set) : CellState;

    function set_State(s : CellState) {
        anim.currentFrame= cast(s, Float);
        bmp.tile= anim.getFrame();
        return this.State= s;
    }

    public function new(x : Float, y : Float) {
        anim= new h2d.Anim(
            [
                hxd.Res.empty.toTile(),
                hxd.Res.red_one.toTile(),
                hxd.Res.red_two.toTile(),
                hxd.Res.red_three.toTile(),
                hxd.Res.red_four.toTile(),
                hxd.Res.red_five.toTile(),
                hxd.Res.red_six,toTile(),
                hxd.Res.blue_one.toTile(),
                hxd.Res.blue_two.toTile(),
                hxd.Res.blue_three.toTile(),
                hxd.Res.blue_four.toTile(),
                hxd.Res.blue_five.toTile(),
                hxd.Res.blue_six.toTile()
            ], 0.0);

        obj= new h2d.Object(s2d);
        obx.x= x;
        obj.y= y;

        bmp= new Bitmap(anim.getFrame(), obj);    
    }
}