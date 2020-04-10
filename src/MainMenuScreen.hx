package;

import Game;
import GameplayScreen;
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
	var hostInteractive : Interactive;
	var joinButton : Graphics;
	var joinText : Text;
	var joinInteractive : Interactive;
	var ipAddress : TextInput;
	var ipText : Text;
	var port : TextInput;
	var portText : Text;
	var font : Font;	

	public function new(?parent:Object) {
		super("MainMenuScreen", parent);
	}

	public override function init() {
		super.init();

		font = hxd.res.DefaultFont.get();

		hostButton = new h2d.Graphics(parent);
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
		hostButton.color.set(0.8,0.8,0.8);

		hostButton.x = Game.inst.sceneWidth/2 + 200;
		hostButton.y = Game.inst.sceneHeight/2 - 60;

		hostText = new Text(font, hostButton);
		hostText.text = "Host Game";
		hostText.textColor = 0x000000;
		hostText.textAlign = Align.Center;
		hostText.y -= 20;
		hostText.scale(2.5);

		hostButton.scale(2);

		hostInteractive = 
			new Interactive(
					hostButton.getBounds().width,
					hostButton.getBounds().height, 
					hostButton,
					new h2d.col.RoundRect(0, 0, 2*RW, 2*RH, 0));

		hostInteractive.onOver = function(e:hxd.Event) {
			hostButton.color.set(1, 1, 1);
		}

		hostInteractive.onOut = function(e:hxd.Event) {
			hostButton.color.set(0.7,0.7,0.8);
		}

		hostInteractive.onClick = function(e:hxd.Event) {
			joinButton.visible = false;
			port.visible = true;
			port.backgroundColor = 0x80808080;
			port.x = hostButton.x;
			hostText.text = "Start";
			hostInteractive.onClick = function(_) {
				Game.screenManager.setScreen(
					new GameplayScreen(GameStates.Server, ipAddress.text, port.text, parent));
			}
		}

		hostInteractive.onPush = function(e:hxd.Event) {
			hostButton.color.set(0.9,1,0.6);
		}

		hostInteractive.onRelease = function(e:hxd.Event) {
			hostButton.color.set(1,1,1);
		}
	
		joinButton = new h2d.Graphics(this.parent);
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
		joinButton.y = Game.inst.sceneHeight/2 + 120;

		joinText = new Text(font, joinButton);
		joinText.text = "Join Game";
		joinText.textColor = 0x000000;
		joinText.textAlign = Align.Center;
		joinText.y -= 20;
		joinText.scale(2.5);

		joinButton.scale(2);

		joinInteractive = 
			new Interactive(
					joinButton.getBounds().width,
					joinButton.getBounds().height, 
					joinButton,
					new h2d.col.RoundRect(0, 0, 2*RW, 2*RH, 0));

		joinInteractive.onOver = function(e:hxd.Event) {
			joinButton.color.set(1, 1, 1);
		}

		joinInteractive.onOut = function(e:hxd.Event) {
			joinButton.color.set(0.7,0.7,0.8);
		}

		joinInteractive.onClick = function(e:hxd.Event) {
			hostButton.visible = false;
			ipAddress.visible = true;
			ipAddress.backgroundColor = 0x80808080;
			ipAddress.x = joinButton.x - 80;
			ipAddress.y -= 70;

			port.visible = true;
			port.backgroundColor = 0x80808080;
			port.x = joinButton.x - 15;
			port.y -= 60;
			joinText.text = "Start";
			joinInteractive.onClick = function(_) {
				Game.screenManager.setScreen(
					new GameplayScreen(GameStates.Client, ipAddress.text, port.text, parent));
			}
		}

		joinInteractive.onPush = function(e:hxd.Event) {
			joinButton.color.set(0.9,1,0.6);
		}

		joinInteractive.onRelease = function(e:hxd.Event) {
			joinButton.color.set(1,1,1);
		}
		
		ipAddress = new TextInput(font, parent);
		ipAddress.scale(4);
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

		ipText = new Text(font, ipAddress);
		ipText.text= "IP: ";
		ipText.textColor= 0xFFFFFF;
		ipText.x = -15;

		port = new TextInput(font, parent);
		port.scale(4);
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

		portText = new Text(font, port);
		portText.text = "Port:";
		portText.textColor = 0xFFFFFF;
		portText.x = -32;

		ipAddress.visible = false;
		ipAddress.backgroundColor = 0x0;
		port.visible = false;
		port.backgroundColor = 0x0;
	}

	public override function update(dt:Float) {
		super.update(dt);
	}

	public override function cleanup() {
		super.cleanup();

		parent.removeChild(hostButton);
		parent.removeChild(joinButton);
		parent.removeChild(ipAddress);
		parent.removeChild(port);
	}
}