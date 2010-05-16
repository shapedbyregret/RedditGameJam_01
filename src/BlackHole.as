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
		public var size:Number;
		public var hitBox:Sprite;
		
		public function BlackHole() 
		{
			life = maxLife = 50;
			size = 15;
			hitBox = new Sprite();
			draw();
			filters = [new GlowFilter(0xCC00CC, 0.8)];
		}
		
		public function update():void
		{
			
		}
		
		public function draw():void
		{
			graphics.clear();
			graphics.lineStyle(2, 0x444444, 0.8);
			graphics.beginFill(0x111111, 0.8);
			graphics.drawCircle(0, 0, size);
			graphics.endFill();
			
			// Hitbox
			hitBox.graphics.clear();
			hitBox.graphics.drawCircle(0, 0, size-(size/5));
			addChild(hitBox);
		}
		
		public function destroy():void {
			Main.g.playerLayer.removeChild(this);
			for (var i:int = 0; i < 20; i++) { new Particle(x, y); }
		}
	}

}