package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	
	public class Protagonist extends Sprite
	{
		
		private var xVel:Number;
		private var yVel:Number;
		private var ghostMode:Boolean;
		private var life:Number;
		private var maxLife:Number;
		
		public function Protagonist() 
		{
			xVel = 0;
			yVel = 0;
			ghostMode = false;
			life = maxLife = 10;
		}
		
		public function update():void
		{
			
		}
		
		private function draw():void
		{
			graphics.lineStyle(2, 0xFFFFFF, 0.8);
			graphics.drawRect( -10, -10, 20, 20);
			filters = [new GlowFilter(0xFFFFFF, 0.8)];
		}
		
	}

}