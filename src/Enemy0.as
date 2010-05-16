package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.text.*;
	
	import de.polygonal.ds.*;
	
	public class Enemy0 extends Sprite
	{
		public var life:Number;
		public var col:uint;
		private var colArr:Array;
		
		private var acc:Number;
		private var xVel:Number;
		private var yVel:Number;
		private var angRad:Number;
		private var angDeg:Number;
		
		public function Enemy0() 
		{
			life = 2;
			//colArr = [0x0B0814, 0x002247, 0xA35E85, 0xB50200, 0xE34A14];
			colArr = [0xFF00A9, 0xA4EE00, 0x00B0FF, 0xBF00FF, 0xFF851B];
			var randCol:int = Math.round(Math.random() * 5);
			col = colArr[randCol];
			
			acc = 2 + Math.random() * 2;
			xVel = 1 + (Main.g.bh.size / 5);
			yVel = 1 + (Main.g.bh.size / 5);
			angRad = 0;
			angDeg = 0;
			draw();
			
			Main.g.enemies.append(this);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(e:Event):void
		{
			if(!Main.g.paused) {
				if (life > 0) {
					angRad = Math.atan2(240 - y, 320 - x);
					angDeg = angRad * 57.2957795;
					rotation = angDeg;
					xVel = 2 * Math.cos(angRad + 1.2) * Main.g.bh.size / 20;
					yVel = 2 * Math.sin(angRad + 1.2) * Main.g.bh.size / 20;
					x += xVel;
					y += yVel;
				}
				else {
					destroy();
				}
			}
		}
		
		private function draw():void
		{
			graphics.lineStyle(1, 0xFFFFFF, 0.8);
			graphics.drawRect( -5, -5, 10, 10);
			filters = [new GlowFilter(col, 0.8, 6, 6, 4)];
			
			var pos:Number = Math.round(Math.random() * 5);
			if (pos==1) {
				x = -20;
				y = Math.random() * 480;
			}
			else if (pos == 2) {
				x = 660;
				y = Math.random() * 480;
			}
			else if (pos == 3) {
				x = Math.random() * 640;
				y = -20;
			}
			else {
				x = Math.random() * 640;
				y = 500;
			}
			
			Main.g.enemyLayer.addChild(this);
		}
		
		private function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, update);
			Main.g.enemyLayer.removeChild(this);
			Main.g.enemies.nodeOf(this).remove();	
		}
	}

}