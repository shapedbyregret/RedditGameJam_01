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
				g.p1.update();
			}
		}
		
	}
	
}