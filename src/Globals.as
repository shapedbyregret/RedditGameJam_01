package  
{

	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	public class Globals
	{
		
		public var paused:Boolean;
		public var w:Number;
		public var h:Number;
		public var numPlayers:Number;
		public var maxNumPlayers:Number;
		
		public var p1:Protagonist;
		
		public function Globals() 
		{
			paused = false;
			w = 640;
			h = 480;
			numPlayers = 0;
			maxNumPlayers = 3;
			
			p1 = new Protagonist();
		}
		
	}

}