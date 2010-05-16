package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.text.*;
	
	import de.polygonal.ds.*;
	
	public class Bullet extends Sprite
	{
		private var xVel:Number;
		private var yVel:Number;
		private var angRad:Number;
		private var angDeg:Number;
		private var life:Number;
		
		public function Bullet() 
		{
			xVel = 2;
			yVel = 2;
			angRad = 0;
			angDeg = 0;
			life = 1;
			draw();
		}
		
		public function update():void
		{
			if (life > 0) {
				
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
			
		}
	}

}