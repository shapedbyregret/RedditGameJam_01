package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	public class Main extends Sprite 
	{
		
		public static var g:Globals;
		public static var _stage:Stage;
		
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
			
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{
			if (!g.paused) {
				
			}
		}
		
	}
	
}