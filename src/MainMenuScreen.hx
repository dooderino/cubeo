package;

import h2d.Object;
import h2d.TextInput;
import h2d.Font;
import Game;
import GameStates;

class MainMenuScreen extends Screen {
    var ipAddress : TextInput;
    var port : TextInput;
    var font : Font;    

    public function new() {
        super();
    }

    public override function init(object:Object) {
        super.init(object);

        Game.inst.gameState = new GameState();

        font = hxd.res.DefaultFont.get();
        
        ipAddress = new TextInput(font, object);
        ipAddress.scale(2);
        ipAddress.x = Game.inst.viewCenterX;
        ipAddress.y = Game.inst.viewCenterY;
        ipAddress.text = "127.0.0.1";
        ipAddress.textColor = 0xAAAAAA;
        ipAddress.backgroundColor = 0x80808080;
        ipAddress.onFocus = function(_) {
            ipAddress.textColor = 0xFFFFFF;
        }

        ipAddress.onFocusLost = function(_) {
            ipAddress.textColor = 0xAAAAAA;
        }

        ipAddress.onChange = function() {
            while (ipAddress.text.length > 15)
                ipAddress.text = ipAddress.text.substr(0, -1);
        }

        port = new TextInput(font, object);
        port.scale(2);
        port.x = Game.inst.viewCenterX;
        port.y = Game.inst.viewCenterY + 50;
        port.text= "6676";
        port.textColor = 0xAAAAAA;
        port.backgroundColor = 0x80808080;
        port.onFocus = function(_) {
            port.textColor = 0xFFFFFF;
        }

        port.onFocusLost = function(_) {
            port.textColor = 0xAAAAAA;
        }

        port.onChange = function() {
            while (port.text.length > 5)
                port.text = port.text.substr(0, -1);
        }
    }

    public override function update(dt:Float) {
        super.update(dt);
    }

    public override function cleanup() {
        super.cleanup();
        font.dispose();
        parent.removeChild(ipAddress);
        parent.removeChild(port);
    }
}