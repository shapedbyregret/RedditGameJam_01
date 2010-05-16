package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	import de.polygonal.ds.*;
	
	public class Main extends Sprite 
	{
		// Embed font
		[Embed(source="Distant-Galaxy/DISTGRG_.ttf", fontFamily="Distant")]
		private var Distant:String;
		
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
			addEventListener(Event.DEACTIVATE, deactivate);
			addEventListener(Event.ACTIVATE, activate);
		}
		
		private function update(e:Event):void
		{
			if (!g.paused) {
				
				// Spawn more enemies
				if (g.timer.currentCount % g.spawnDelay == 0) {
					new Enemy0();
				}
				if (g.timer.currentCount % 100 == 0) {
					g.spawnDelay -= 1;
				}
				
				// Update Players
				for (var i:int = 0; i <= g.numPlayer;i++) {
					g.ghosts[i].update();
				}
				
				// Collision
				collisions();
				
				// Spawn new player
				if (g.p1.life == 1) {
					g.numPlayer += 1;
					if (g.numPlayer >= g.maxNumPlayers) {
						// Game Over
						g.paused = true;
						g.titleScreen.toggleVisibility();
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
				for (var i:int = 0; i <= g.numPlayer; i++) {
					if (aNode.val.hitTestObject(g.ghosts[i].hitBox)) {
						g.ghosts[i].life -= 1;
						aNode.val.life -= 10;
						break;
					}
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
			
			// Particle to black hole collision
			aNode = g.particles.head();
			while (aNode != null) {
				if (aNode.val.hitTestObject(g.bh.hitBox)) {
					aNode.val.life -= 1;
				}
				aNode = aNode.next;
			}
		}
		
		private function deactivate(e:Event):void
		{
			if(!Main.g.titleScreen.visible) {
				Main.g.paused = true;
			}
		}
		
		private function activate(e:Event):void
		{
			if(!Main.g.titleScreen.visible) {
				Main.g.paused = false;
			}
		}
		
	}
	
}