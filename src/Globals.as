package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	import de.polygonal.ds.*;
	
	public class Globals
	{
		
		public var paused:Boolean;
		public var w:Number;
		public var h:Number;
		public var numPlayers:Number;
		public var maxNumPlayers:Number;
		
		
		public var p1:Protagonist;
		public var bh:BlackHole;
		
		// Containers
		public var ghosts:Array;
		public var p1Bullets:DLL;
		public var enemies:DLL;
		
		// Layers
		public var enemyLayer:Sprite;
		public var playerLayer:Sprite;
		public var bulletLayer:Sprite;
		public var hudLayer:Sprite;
		
		public function Globals() 
		{
			paused = false;
			w = 640;
			h = 480;
			numPlayers = 0;
			maxNumPlayers = 3;
			
			bh = new BlackHole();
			bh.x = w >> 1;
			bh.y = h >> 1;
			
			
			ghosts = [new Protagonist(), new Protagonist(), new Protagonist()];
			p1 = ghosts[0];
			p1Bullets = new DLL();
			enemies = new DLL();
			
			enemyLayer = new Sprite();
			playerLayer = new Sprite();
			playerLayer.addChild(bh);
			playerLayer.addChild(p1);
			bulletLayer = new Sprite();
			hudLayer = new Sprite();
		}
		
	}

}