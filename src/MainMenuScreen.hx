package;

import Game;
import GameStates;
import h2d.Interactive;
import h2d.Font;
import h2d.Graphics;
import h2d.Object;
import h2d.Text;
import h2d.TextInput;

class MainMenuScreen extends Screen {
    var hostButton : Graphics;
    var hostText : Text;
    var joinButton : Graphics;
    var joinText : Graphics;
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

        hostButton = new h2d.Graphics(object);
        var RW = 100;
        var RH = 30;
        var size = RW - RH;
        var k = 10;

        hostButton.beginFill(0xFFFFFFFF);
        for( i in 0...k+1 ) {
            var a = Math.PI * i / k - Math.PI / 2;
            hostButton.lineTo(size + RH * Math.cos(a), RH * Math.sin(a));
        }
        for( i in 0...k+1 ) {
            var a = Math.PI * i / k + Math.PI / 2;
            hostButton.lineTo(-size + RH * Math.cos(a), RH * Math.sin(a));
        }
        hostButton.endFill();

        hostButton.x = Game.inst.sceneWidth/2 + 200;
        hostButton.y = Game.inst.sceneHeight/2 - 60;

        hostText = new Text(font, hostButton);
        hostText.text = "Host Game";
        hostText.textColor = 0x000000;
        hostText.textAlign = Align.Center;
        hostText.y -= 20;
        hostText.scale(2.5);

        joinButton = new h2d.Graphics(object);
        joinButton.beginFill(0xFFFFFFFF);
        for( i in 0...k+1 ) {
            var a = Math.PI * i / k - Math.PI / 2;
            joinButton.lineTo(size + RH * Math.cos(a), RH * Math.sin(a));
        }
        for( i in 0...k+1 ) {
            var a = Math.PI * i / k + Math.PI / 2;
            joinButton.lineTo(-size + RH * Math.cos(a), RH * Math.sin(a));
        }
        joinButton.endFill();

        joinButton.x = Game.inst.sceneWidth/2 + 200;
        joinButton.y = Game.inst.sceneHeight/2 + 60;

        
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
        parent.removeChild(joinButton);
        parent.removeChild(ipAddress);
        parent.removeChild(port);
    }
}