﻿package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.text.*;
	
	public class Title extends Sprite
	{
		
		private var styles:StyleSheet;
		private var tfHiScore:TextField;
		private var tfScore:TextField;
		
		public function Title() 
		{
			graphics.beginFill(0x333333, 0.8);
			graphics.drawRect(0, 0, 640, 480);
			graphics.endFill();
			
			styles = new StyleSheet();
			styles.parseCSS("h1{color:#FFFFFF;font-size:48px;}" +
							"h2{color:#FFFFFF;font-size:36px;}" +
							"h3{color:#CC3333;font-size:36px;}");
			
			var tfTitle:TextField = tfHelper(320, 30);
			tfTitle.htmlText = "<font face='Distant'><h1>Collapse</h1></font>";
			addChild(tfTitle);
			
			tfHiScore = tfHelper(320, 120);
			tfHiScore.htmlText = "<font face='Distant'><h2>Hi Score:0</h2></font>";
			addChild(tfHiScore);
			
			tfScore = tfHelper(320, 160);
			tfScore.htmlText = "<font face='Distant'><h2>Score:0</h2></font>";
			addChild(tfScore);
			
			var tfPlay:TextField = tfHelper(0,0);
			tfPlay.htmlText = "<font face='Distant'><h2>Play</h2></font>";
			var tfPlayHover:TextField = tfHelper(0,0);
			tfPlayHover.htmlText = "<font face='Distant'><h3>Play</h3></font>";
			var butPlay:SimpleButton = new SimpleButton(tfPlay, tfPlayHover, tfPlayHover, tfPlayHover);
			butPlay.x = 320;
			butPlay.y = 300;
			butPlay.addEventListener(MouseEvent.CLICK, play);
			addChild(butPlay);
		}
		
		public function toggleVisibility():void
		{
			visible = !visible;
			if (Main.g.curScore > Main.g.hiScore) {
				Main.g.hiScore = Main.g.curScore;
				tfHiScore.htmlText = "<font face='Distant'><h2>Hi Score:" + Main.g.hiScore + "</h2></font>";
			}
			tfScore.htmlText = "<font face='Distant'><h2>Score:" + Main.g.curScore + "</h2></font>";
		}
		
		private function play(me:MouseEvent):void
		{
			Main.g.resetVariables();
			
			Main.g.paused = false;
			Main.g.timer.reset();
			Main.g.timer.start();
			Main._stage.focus = this;
			visible = false;
		}
		
		private function tfHelper(newX:Number, newY:Number):TextField
		{
			var tf:TextField = new TextField();
			tf.styleSheet = styles;
			tf.embedFonts = true;
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.x = newX;
			tf.y = newY;
			
			return tf;
		}
		
	}

}