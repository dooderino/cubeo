package;

import h2d.Anim;
import h2d.Bitmap;
import h2d.Object;
import h3d.Vector;
import CellState;


class Cell {
    private var anim : h2d.Anim;
    private var bmp : h2d.Bitmap;
    public var obj : h2d.Object;
    public var interactive : h2d.Interactive;
    public static var size : Int= 64;
    public static var padding : Int= 4;
    public static var scale : Float = 1.0;

    public var Row(default, set) : Int;

    function set_Row(row : Int) {
        if (this.obj != null) {            
            var pad= (padding * scale);
            this.obj.y= (row * (size * scale + pad * scale));
        }
        return this.Row= row;
    }

    public var Col(default, set) : Int;

    function set_Col(col : Int) {
        if (this.obj != null) {
            this.obj.x= (col * (size * scale + padding * scale));            
        }
        return this.Col= col;
    }
    
    public var State(default, set) : CellState;

    function set_State(s : CellState) {
        anim.currentFrame= cast(s, Float);
        bmp.tile= anim.getFrame();
        return this.State= s;
    }

    public function new(row: Int, col: Int, s:CellState) {
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
                hxd.Res.border.toTile()
            ], 
            0.0);

        obj= new h2d.Object(Game.inst.s2d);
        obj.setScale(scale);

        bmp= new Bitmap(anim.getFrame(), obj);
        interactive= new h2d.Interactive(obj.getBounds().width, obj.getBounds().height, bmp);
        interactive.onOver= function(e:hxd.Event) {
            bmp.colorAdd= new Vector(0.5,0,1,1);
            var state:Int = cast(State, Int);
            state++;
            State = cast(state, CellState);
        }

        Row= row;
        Col= col;
        State= s;
    }
}