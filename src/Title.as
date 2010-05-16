package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.text.*;
	
	public class Title extends Sprite
	{
		
		private var styles:StyleSheet;
		
		public function Title() 
		{
			graphics.beginFill(0x333333, 0.8);
			graphics.drawRect(0, 0, 640, 480);
			graphics.endFill();
			
			styles = new StyleSheet();
			styles.parseCSS("h1{color:#FFFFFF;font-size:48px;}" +
							"h2{color:#FFFFFF;font-size:24px;}" +
							"h3{color:#CC3333;font-size:24px;}");
			
			var tfTitle:TextField = tfHelper(320, 30);
			tfTitle.htmlText = "<font face='Distant'><h1>Collapse</h1></font>";
			addChild(tfTitle);
			
			var tfScore:TextField = tfHelper(320, 60);
			tfScore.htmlText = "<font face='Distant'><h2>Hiscore:0</h2></font>";
			addChild(tfScore);
			
			var tfPlay:TextField = tfHelper(-50, -50);
			tfPlay.htmlText = "<font face='Distant'><h2>Play</h2></font>";
			addChild(tfPlay);
			var tfPlayHover:TextField = tfHelper(-50, -50);
			tfPlayHover.htmlText = "<font face='Distant'><h3>Play</h3></font>";
			addChild(tfPlayHover);
			var butPlay:SimpleButton = new SimpleButton(tfPlay, tfPlayHover, tfPlayHover, tfPlayHover);
			butPlay.x = 320;
			butPlay.y = 200;
			butPlay.addEventListener(MouseEvent.CLICK, play);
			addChild(butPlay);
		}
		
		private function play(me:MouseEvent):void {
			Main.g.paused = false;
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