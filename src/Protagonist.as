package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.Point;
	
	public class Protagonist extends Sprite
	{
		private var pastPositions:Array;
		private var pastAngle:Array;
		public var ghostMode:Boolean;
		public var life:Number;
		public var maxLife:Number;
		public var hitBox:Sprite;
		
		private var xVel:Number;
		private var yVel:Number;
		private var moveLeft:Boolean;
		private var moveRight:Boolean;
		private var moveUp:Boolean;
		private var moveDown:Boolean;
		private var shoot:Boolean;
		private var shootCount:Number;
		private var shootDelay:Number;
		private var angRad:Number;
		private var angDeg:Number;
		
		public function Protagonist() 
		{
			pastPositions = new Array();
			pastAngle = new Array();
			ghostMode = false;
			life = maxLife = 2;
			hitBox = new Sprite();
			
			xVel = 4;
			yVel = 4;
			moveLeft = false;
			moveRight = false;
			moveUp = false;
			moveDown = false;
			shoot = false;
			shootCount = 0;
			shootDelay = 5;
			angRad = 0;
			angDeg = 0;
			
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
				if (life==1) {
					if(pastPositions.length>0) {
						var pastPoint:Point = pastPositions.shift();
						x = pastPoint.x;
						y = pastPoint.y;
					}
					else {
						life = 0;
					}
					if(pastAngle.length>0) {
						rotation = pastAngle.shift();
					}
					
					// Shoot
					if (shootCount > shootDelay) {
						new Bullet(x, y, -rotation/57.2957795 + 1.57079633, 8);
						shootCount = 0;
					}
					else {
						shootCount += 1;
					}
				}
				else if (life == 0) {
					for (var i:int = 0; i < 4; i++) { new Particle(x, y); }
					life = -1;
				}
				else {
					visible = false;
				}
			}
			else {
				
				angRad = Math.atan2(Main._stage.mouseY - y, Main._stage.mouseX - x);
				angDeg = rotation = angRad * 57.2957795;
				pastAngle.push(rotation);
				
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
				
				// Shoot
				if (shootCount > shootDelay) {
					new Bullet(x, y, -angRad + 1.57079633, 8);
					shootCount = 0;
				}
				else {
					shootCount += 1;
				}
			}
			
			
		}
		
		private function draw():void
		{
			graphics.beginFill(0xCC3333, 0.8);
			graphics.drawRect(2, -5, 3, 10);
			graphics.endFill();
			graphics.lineStyle(2, 0xFFFFFF, 0.8);
			graphics.drawRect( -5, -5, 10, 10);
			filters = [new GlowFilter(0xFFFFFF, 0.8)];
			
			// Hitbox
			hitBox.graphics.clear();
			hitBox.graphics.drawRect( -3, 3, 6, 6);
			addChild(hitBox);
		}
		
		public function destroy():void
		{
			ghostMode = true;
			removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			removeEventListener(KeyboardEvent.KEY_UP, keyUp);
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
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