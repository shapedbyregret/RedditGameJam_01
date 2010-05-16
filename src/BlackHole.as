package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.text.*;
	
	import de.polygonal.ds.*;
	
	public class BlackHole extends Sprite
	{
		
		public var life:Number;
		public var maxLife:Number;
		
		public function BlackHole() 
		{
			life = maxLife = 50;
			draw();
		}
		
		public function update():void
		{
			
		}
		
		private function draw():void
		{
			graphics.lineStyle(2, 0x444444, 0.8);
			graphics.beginFill(0x111111, 0.8);
			graphics.drawCircle(0, 0, 15);
			graphics.endFill();
			filters = [new GlowFilter(0xCC00CC, 0.8)];
		}
		
	}

}