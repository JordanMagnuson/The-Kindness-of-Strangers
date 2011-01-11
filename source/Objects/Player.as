package source.Objects 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import source.FadeOut;
	import source.Global;
	import net.flashpunk.FP;
	import source.GameOverWorld
	import source.Colors;
	
	public class Player extends Physics
	{
		
		[Embed(source = '../../assets/graphics/player.png')] public var imgPlayer:Class;
		public var sprPlayer:Spritemap = new Spritemap(imgPlayer, 32, 32, animEnd);
		
		//how fast we accelerate
		public var movement:Number = 1;
		public var jump:Number = 8;
		
		//current player direction (true = right, false = left)
		public var direction:Boolean = true;
		
		//are we on the ground?
		public var onground:Boolean = false;
		
		//are we walljumping? (0 = no, 1 = left, 2 = right)
		public var walljumping:int = 0;
		//can we double jump? (false = no, true = yes)
		public var doublejump:Boolean = false;
		
		public var dead:Boolean = false;
		public var stunned:Boolean = false;
		public var start:Point;
		
		public function Player(x:int, y:int) 
		{
			//set position
			super(x, y);
			start = new Point(x, y);
			
			//set different speeds and such
			mGravity = 0.4;
			mMaxspeed = new Point(4, 8);
			mFriction = new Point(0.5, 0.5);
			
			//set up animations
			sprPlayer.add("standLeft", [0], 0, false);
			sprPlayer.add("standRight", [8], 0, false);
			sprPlayer.add("walkLeft", [0, 1, 2, 3, 4, 5, 6, 7], 0.2, true);
			sprPlayer.add("walkRight", [8, 9, 10, 11, 12, 13, 14, 15], 0.2, true);
			
			sprPlayer.add("jumpLeft", [2], 0, false);
			sprPlayer.add("jumpRight", [10], 0, false);
			
			sprPlayer.add("slideRight", [16], 0, false);
			sprPlayer.add("slideLeft", [17], 0, false);
			
			sprPlayer.play("standRight");
			
			//set hitbox & graphic
			layer = -2;
			setHitbox(12, 24, -10, -8);
			graphic = sprPlayer;
			type = "Player";
		}
		
		override public function update():void 
		{
			//did we... die?
			if (dead) { sprPlayer.alpha -= 0.1; return; } else if ( sprPlayer.alpha < 1 ) { sprPlayer.alpha += 0.1 }
			
			// Ran off the edge of the world?
			if (x < 0 || x > FP.width)
			{
				if (y > FP.height/3 && !Global.died  && !Global.airplane2.playerTrigger03)
				{
					Global.died = true;
					FP.world.add(new FadeOut(GameOverWorld, Colors.BLACK, 6));	
					Global.soundControler.fadeOut();
				}
			}
			
			//are we on the ground?
			onground = false;
			if (collide(solid, x, y + 1)) 
			{ 
				onground = true;
				walljumping = 0;
				doublejump = true;
			}
			
			//set acceleration to nothing
			acceleration.x = 0;
			
			//increase acceeration, if we're not going too fast
			if (!stunned)
			{
				if (Input.check(Global.keyLeft) && speed.x > -mMaxspeed.x) { acceleration.x = - movement; direction = false; }
				if (Input.check(Global.keyRight) && speed.x < mMaxspeed.x) { acceleration.x = movement; direction = true; }
			}
			
			//friction (apply if we're not moving, or if our speed.x is larger than maxspeed)
			if ( (! Input.check(Global.keyLeft) && ! Input.check(Global.keyRight)) || Math.abs(speed.x) > mMaxspeed.x ) { friction(true, false); }
			
			//jump
			if (!stunned && Input.pressed(Global.keyA) ) 
			{
				var jumped:Boolean = false;
				
				//normal jump
				if (onground) { 
					speed.y = -jump; 
					jumped = true; 
				}
				
				//wall jump
				if (collide(solid, x - 1, y) && !jumped && walljumping != 3) 
				{ 
					speed.y = -jump;			//jump up
					speed.x = mMaxspeed.x * 2;	//move right fast
					walljumping = 2;			//and set wall jump direction
					jumped = true;				//so we don't "use up" or double jump
				}
				//same as above
				if (collide(solid, x + 1, y) && !jumped && walljumping != 3) 
				{ 
					speed.y = -jump; 
					speed.x = - mMaxspeed.x * 2;
					walljumping = 1;
					jumped = true;
				}
				
				//set double jump to false
				if (!onground && !jumped && doublejump) { 
					speed.y = -jump;
					doublejump = false;
					//set walljumping to 0 so we can move back in any direction again
					//incase we were wall jumping prior to this double jump.
					//if you don't want to allow walljumping after a double jump, set this to 3.
					walljumping = 0;
				} 
			}
			
			
			//if we ARE walljumping, make sure we can't go back
			//if (walljumping > 0)
			//{
				//if (walljumping == 2 && speed.x < 0) { speed.x = 0; }
				//if (walljumping == 1 && speed.x > 0) { speed.x = 0; }
			//}
			
			//set the gravity
			gravity();
			
			//make sure we're not going too fast vertically
			//the reason we don't stop the player from moving too fast left/right is because
			//that would (partially) destroy the walljumping. Instead, we just make sure the player,
			//using the arrow keys, can't go faster than the max speed, and if we are going faster
			//than the max speed, descrease it with friction slowly.
			maxspeed(false, true);
			
			//variable jumping (tripple gravity)
			if (speed.y < 0 && !Input.check(Global.keyA)) { gravity(); gravity(); }
			
			
			//set the sprites according to if we're on the ground, and if we are moving or not
			if (onground)
			{
				if (speed.x < 0) { sprPlayer.play("walkLeft"); }
				if (speed.x > 0) { sprPlayer.play("walkRight"); }
				
				if (speed.x == 0) {
					if (direction) { sprPlayer.play("standRight"); } else { sprPlayer.play("standLeft"); }
				}
			} else {
				if (direction) { sprPlayer.play("jumpRight"); } else { sprPlayer.play("jumpLeft"); }
				
				//are we sliding on a wall?
				if (collide(solid, x - 1, y)) { sprPlayer.play("slideRight"); }
				if (collide(solid, x + 1, y)) { sprPlayer.play("slideLeft"); }
			}
			
			
			//set the motion. We set this later so it stops all movement if we should be stopped
			motion();
			
			//did we just get.. KILLED? D:
			if (collide("Spikes", x, y) && speed.y > 0)
			{
				//killme!
				killme();
			}
			
		}
		
		public function killme():void
		{
			dead = true;
			Global.restart = true;
		}
		
		public function animEnd():void { }
		
	}

}