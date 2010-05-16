package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.text.*;
	
	import de.polygonal.ds.*;
	
	public class Bullet extends Sprite
	{
		public var life:Number;
		
		private var xVel:Number;
		private var yVel:Number;
		private var angRad:Number;
		private var angDeg:Number;
		
		public function Bullet(newX:Number, newY:Number, newAng:Number, newAcc:Number) 
		{
			life = 1;
			xVel = newAcc * Math.sin(newAng);
			yVel = newAcc * Math.cos(newAng);
			angRad = 0;
			angDeg = 0;
			draw();
			x = newX;
			y = newY;
			
			Main.g.p1Bullets.append(this);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(e:Event):void
		{
			if(!Main.g.paused) {
				if (life > 0) {
					x += xVel;
					y += yVel;
					
					if (x < -5 || x > 645 || y < -5 || y > 485) {
						life = 0;
					}
				}
				else {
					destroy();
				}
			}
		}
		
		private function draw():void
		{
			graphics.lineStyle(1, 0xFFFFFF, 0.8);
			graphics.drawRect( -2, -2, 4, 4);
			filters = [new GlowFilter(0xFFFF00, 0.8)];
			Main.g.bulletLayer.addChild(this);
		}
		
		private function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, update);
			Main.g.bulletLayer.removeChild(this);
			Main.g.p1Bullets.nodeOf(this).remove();
			for (var i:int = 0; i < 1; i++) { new Particle(x, y); }
		}
	}

}