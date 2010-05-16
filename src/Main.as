package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	import de.polygonal.ds.*;
	
	public class Main extends Sprite 
	{
		
		public static var g:Globals;
		public static var _stage:Stage;
		public static var mainLayer:Sprite;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_stage = stage;
			g = new Globals();
			mainLayer = new Sprite();
			
			mainLayer.addChild(g.enemyLayer);
			mainLayer.addChild(g.playerLayer);
			mainLayer.addChild(g.bulletLayer);
			mainLayer.addChild(g.hudLayer);
			addChild(mainLayer);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{
			if (!g.paused) {
				trace(g.timer.currentCount);
				if (g.timer.currentCount % g.spawnDelay == 0) {
					new Enemy0();
				}
				
				for (var i:int = 0; i <= g.numPlayer;i++) {
					g.ghosts[i].update();
				}
				collisions();
				
				if (g.p1.life <= 0) {
					g.numPlayer += 1;
					if (g.numPlayer > g.maxNumPlayers) {
						// Game Over
					}
					else {
						// Old player
						g.p1.destroy();
						g.p1.x = 300;
						g.p1.y = 200;
						// New player
						g.p1 = g.ghosts[g.numPlayer];
						g.playerLayer.addChild(g.p1);
						g.p1.x = 300;
						g.p1.y = 200;
					}
				}
			}
		}
		
		private function collisions():void
		{
			var aNode:DLLNode;
			var bNode:DLLNode;
			
			// Player to enemy collisions
			aNode = g.enemies.head();
			while (aNode != null) {
				if (aNode.val.hitTestObject(g.p1.hitBox)) {
					g.p1.life -= 1;
					aNode.val.life -= 10;
				}
				aNode = aNode.next;
			}
			
			// Enemy to bullet collision
			aNode = g.enemies.head();
			while (aNode != null) {
				bNode = g.p1Bullets.head();
				while (bNode != null) {
					if (aNode.val.hitTestObject(bNode.val)) {
						aNode.val.life -= 2;
						bNode.val.life -= 2;
						break;
					}
					bNode = bNode.next;
				}
				aNode = aNode.next;
			}
			
			// Enemy to black hole collision
			aNode = g.enemies.head();
			while (aNode != null) {
				if (aNode.val.hitTestObject(g.bh.hitBox)) {
					g.bh.life -= 1;
					g.bh.size += 0.5;
					g.bh.draw();
					aNode.val.life -= 10;
				}
				aNode = aNode.next;
			}
		}
		
	}
	
}