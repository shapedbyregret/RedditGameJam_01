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
		
		private var degrade:Number;
		private var xVel:Number;
		private var yVel:Number;
		
		public function Particle(newX:Number, newY:Number) 
		{
			life = 10 + Math.random() * 5;;
			degrade = 1 / life;
			xVel = ( -1 + Math.random() * 2) * 2;
			yVel = ( -1 + Math.random() * 2) * 2;
			draw();
			x = newX;
			y = newY;
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(e:Event):void
		{
			if (life > 0) {
				x += xVel;
				y += yVel;
				life -= 1;
				alpha -= degrade;
			}
			else {
				destroy();
			}
		}
		
		private function draw():void
		{
			graphics.lineStyle(1, 0xFFFFFF, 0.8);
			graphics.beginFill(0x333333, 0.8);
			graphics.drawRect( -1.5, -1.5, 3, 3);
			graphics.endFill();
			filters = [new GlowFilter(0xFFFF00, 0.8)];
			Main.g.bulletLayer.addChild(this);
		}
		
		private function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, update);
			Main.g.bulletLayer.removeChild(this);
		}
	}

}