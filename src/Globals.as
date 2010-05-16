package  
{
	import adobe.utils.ProductManager;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;
	
	import de.polygonal.ds.*;
	
	public class Globals
	{
		
		public var paused:Boolean;
		public var w:Number;
		public var h:Number;
		public var numPlayer:Number;
		public var maxNumPlayers:Number;
		public var timer:Timer;
		public var spawnDelay:Number;
		public var hiScore:Number;
		public var curScore:Number;
		
		public var p1:Protagonist;
		public var bh:BlackHole;
		
		// Containers
		public var ghosts:Array;
		public var p1Bullets:DLL;
		public var enemies:DLL;
		public var particles:DLL;
		
		// Layers
		public var enemyLayer:Sprite;
		public var playerLayer:Sprite;
		public var bulletLayer:Sprite;
		public var hudLayer:Sprite;
		
		public var titleScreen:Title;
		public var tfHiScore:TextField;
		
		public function Globals() 
		{
			paused = true;
			w = 640;
			h = 480;
			numPlayer = 0;
			maxNumPlayers = 3;
			timer = new Timer(50);
			timer.start();
			spawnDelay = 30;
			curScore = hiScore = 0;
			
			p1Bullets = new DLL();
			enemies = new DLL();
			particles = new DLL();
			
			enemyLayer = new Sprite();
			playerLayer = new Sprite();
			bulletLayer = new Sprite();
			hudLayer = new Sprite();
			
			tfHiScore = tfHelper(0, 0);
			tfHiScore.x = 320;
			tfHiScore.y = 0;
			tfHiScore.htmlText = "<font face='Distant'><h1>0</h1></font>";
			hudLayer.addChild(tfHiScore);
			titleScreen = new Title();
			hudLayer.addChild(titleScreen);
		}
		
		public function resetVariables():void
		{	
			var aNode:DLLNode = particles.head();
			while (aNode != null) {
				aNode.val.destroy();
				aNode = particles.head();
			}
			curScore = 0;
			updateScore(0);
			numPlayer = 0;
			spawnDelay = 30;
			bh = new BlackHole();
			bh.x = w >> 1;
			bh.y = h >> 1;
			playerLayer.addChild(bh);
			ghosts = [new Protagonist(), new Protagonist(), new Protagonist()];
			p1 = ghosts[0];
			p1.x = 300;
			p1.y = 200;
			playerLayer.addChild(p1);
		}
		
		public function updateScore(amount:Number):void {
			curScore += amount;
			tfHiScore.htmlText = "<font face='Distant'><h1>" + curScore + "</h1></font>";
		}
		
		private function tfHelper(newX:Number, newY:Number):TextField
		{
			var styles:StyleSheet = new StyleSheet();
			styles.parseCSS("h1{color:#FFFFFF;font-size:24px;}");
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