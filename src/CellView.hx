package;

import h2d.Bitmap;
import BoardView;
import CursorStates;

class CellView {
    var boardView: BoardView;
    private var cell_state_anim : h2d.Anim;
    private var cell_state_bmp : h2d.Bitmap;

    private var cell_hover_anim : h2d.Anim;
    private var cell_hover_bmp : h2d.Bitmap;

    public var obj : h2d.Object;
    public var hover : h2d.Object;
    public var interactive : h2d.Interactive;
    public static var size : Int= 64;
    public static var padding : Int= 4;
    public static var scale : Float = 1.0;

    public var Row(default, set) : Int;

    function set_Row(row : Int) {
        if (this.obj != null && this.hover != null) {            
            var pad= (padding * scale);
            this.obj.y= (row * (size * scale + pad * scale));
            this.hover.y= this.obj.y;
        }
        return this.Row= row;
    }

    public var Col(default, set) : Int;

    function set_Col(col : Int) {
        if (this.obj != null && this.hover != null) {
            this.obj.x= (col * (size * scale + padding * scale));            
            this.hover.x= this.obj.x;
        }
        return this.Col= col;
    }
    
    public var State(default, set) : CellStates;

    function set_State(s : CellStates) {
        cell_state_anim.currentFrame= cast(s, Float);
        cell_state_bmp.tile= cell_state_anim.getFrame();
        return this.State= s;
    }

    public var CursorState(default, set) : CursorStates;

    function set_CursorState(cs: CursorStates) {
        cell_hover_anim.currentFrame= cast(cs, Float);
        cell_hover_bmp.tile= cell_hover_anim.getFrame();
        return this.CursorState= cs;
    }

    public function new(view:BoardView, row: Int, col: Int, s:CellStates) {
        boardView= view;
        cell_state_anim= new h2d.Anim(
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

        cell_hover_anim= new h2d.Anim(
            [
                hxd.Res.border.toTile(),
                hxd.Res.highlight.toTile(),
                hxd.Res.red_one.toTile(),
                hxd.Res.blue_one.toTile()
            ],
            0.0);

        obj= new h2d.Object(Game.inst.s2d);
        obj.setScale(scale);
        hover= new h2d.Object(Game.inst.s2d);
        hover.setScale(scale);

        cell_state_bmp= new Bitmap(cell_state_anim.getFrame(), obj);
        cell_hover_bmp= new Bitmap(cell_hover_anim.getFrame(), hover);

        interactive= new h2d.Interactive(obj.getBounds().width, obj.getBounds().height, cell_state_bmp);

        interactive.onOver= function(e:hxd.Event) {
            CursorState= CursorStates.HoverDicePool;
        }

        interactive.onOut= function(e:hxd.Event) {
            CursorState= CursorStates.HoverNothing;
        }

        interactive.onClick= function(e:hxd.Event) {
            if (Game.inst.isClient)
                boardView.set(Row, Col, CellStates.BlueFive);
            else 
                boardView.set(Row, Col, CellStates.RedFive);
        }

        Row= row;
        Col= col;
        State= s;
    }
}