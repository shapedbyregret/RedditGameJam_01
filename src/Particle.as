package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.text.*;
	
	import de.polygonal.ds.*;
	
	public class Particle extends Sprite
	{
		public var life:Number;
		
		private var col:uint;
		private var degrade:Number;
		private var acc:Number;
		private var xVel:Number;
		private var yVel:Number;
		private var angRad:Number;
		private var angDeg:Number;
		private var count:Number;
		private var delay:Number;
		
		public function Particle(newX:Number, newY:Number, newCol:uint) 
		{
			life = 15;
			degrade = 1 / life;
			acc = 2;
			xVel = (-1 + Math.random() * 2) * 5;
			yVel = (-1 + Math.random() * 2) * 5;
			angRad = 0;
			angDeg = 0;
			count = 0;
			delay = 15;
			col = newCol;
			draw();
			x = newX;
			y = newY;
			
			Main.g.particles.append(this);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(e:Event):void
		{
			if(!Main.g.paused) {
				if (life > 0) {
					if (count > delay) { // Orbit center
						angRad = Math.atan2(240 - y, 320 - x);
						angDeg = angRad * 57.2957795;
						rotation += 1;
						xVel = acc * Math.cos(angRad + 1.2) * Main.g.bh.size / 20;
						yVel = acc * Math.sin(angRad + 1.2) * Main.g.bh.size / 20;
					}
					else { // Explosion trajectory
						count++;
						rotation += 30;
					}
					
					// Move
					x += xVel;
					y += yVel;
					
					alpha = life / 15;
				}
				else {
					destroy();
				}
			}
		}
		
		private function draw():void
		{
			graphics.lineStyle(1, 0xFFFFFF, 0.8);
			graphics.beginFill(0x333333, 0.8);
			//graphics.drawRect( -1.5, -1.5, 3, 3);
			graphics.moveTo(-2, -2);
			graphics.lineTo(2, 2);
			graphics.endFill();
			filters = [new GlowFilter(col, 0.8)];
			Main.g.bulletLayer.addChild(this);
		}
		
		public function destroy():void
		{
			Main.g.bh.size += 0.01;
			Main.g.bh.draw();
			removeEventListener(Event.ENTER_FRAME, update);
			Main.g.bulletLayer.removeChild(this);
			Main.g.particles.nodeOf(this).remove();
		}
	}

}