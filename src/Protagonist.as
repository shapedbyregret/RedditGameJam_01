package  
{
	import adobe.utils.CustomActions;
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.Point;
	
	public class Protagonist extends Sprite
	{
		private var pastPositions:Array;
		private var pastAngle:Array;
		private var ghostMode:Boolean;
		private var life:Number;
		private var maxLife:Number;
		
		private var xVel:Number;
		private var yVel:Number;
		private var moveLeft:Boolean;
		private var moveRight:Boolean;
		private var moveUp:Boolean;
		private var moveDown:Boolean;
		private var shoot:Boolean;
		private var shootCount:Number;
		private var shootDelay:Number;
		
		public function Protagonist() 
		{
			pastPositions = new Array();
			pastAngle = new Array();
			ghostMode = false;
			life = maxLife = 10;
			
			xVel = 4;
			yVel = 4;
			moveLeft = false;
			moveRight = false;
			moveUp = false;
			moveDown = false;
			shoot = false;
			shootCount = 0;
			shootDelay = 10;
			
			draw();
			
			// Event listeners
			Main._stage.focus = this;
			Main._stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			Main._stage.addEventListener(KeyboardEvent.KEY_UP, keyUp)
			Main._stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			Main._stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		public function update():void
		{
			if (ghostMode) {
				if(pastPositions.length>0) {
					var pastPoint:Point = pastPositions.shift();
					x = pastPoint.x;
					y = pastPoint.y;
				}
				if(pastAngle.length>0) {
					rotation = pastAngle.shift();
				}
			}
			else {
				// Move player
				if (moveLeft) {
					x -= xVel;
				}
				if (moveRight) {
					x += xVel;
				}
				if (moveUp) {
					y -= yVel;
				}
				if (moveDown) {
					y += yVel;
				}
				
				// Record position
				pastPositions.push(new Point(x, y));
				pastAngle.push(rotation);
				
				// Shoot
				if (shoot && shootCount > shootDelay) {
					// Shoot weapon
				}
				else {
					shootCount += 1;
				}
			}
		}
		
		private function draw():void
		{
			graphics.lineStyle(2, 0xFFFFFF, 0.8);
			graphics.drawRect( -5, -5, 10, 10);
			filters = [new GlowFilter(0xFFFFFF, 0.8)];
		}
		
		private function keyDown(ke:KeyboardEvent):void
		{
			if (ke.keyCode == 65) {
				moveLeft =  true;
			}
			else if (ke.keyCode == 68) {
				moveRight = true;
			}
			if (ke.keyCode == 83) {
				moveDown = true;
			}
			else if (ke.keyCode == 87) {
				moveUp = true;
			}
		}
		
		private function keyUp(ke:KeyboardEvent):void
		{
			if (ke.keyCode == 65) {
				moveLeft =  false;
			}
			else if (ke.keyCode == 68) {
				moveRight = false;
			}
			if (ke.keyCode == 83) {
				moveDown = false;
			}
			else if (ke.keyCode == 87) {
				moveUp = false;
			}
		}
		
		private function mouseDown(me:MouseEvent = null):void
		{
			shoot = true;
		}
		private function mouseUp(me:MouseEvent = null):void
		{
			shoot = false;
		}
		
	}

}