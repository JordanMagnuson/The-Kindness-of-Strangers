package source.Objects 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import source.Global;
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Crate extends Physics
	{
		
		[Embed(source = '../../assets/graphics/crate.png')] public var imgCrate:Class;
		public var sprCrate:Image = new Image(imgCrate);
		
		//this is here to check how long the player has been pushing
		//BEFORE we start to move.
		public var timer:int = 10;
		//what direction we're pushing (0 = none, -1 = left, 1 = right)
		public var pushing:int;
		//if we're moving (being pushed)
		public var moving:Boolean = false;
		//our speed when being pushed (shouldn't be larger than player speed)
		public var movement:int = 2;
		
		public function Crate(x:int, y:int) 
		{
			super(x, y);
			
			graphic = sprCrate;
			type = "Solid";
			
			setHitbox(32, 32);
		}
		
		override public function update():void 
		{
			//only move vertically here
			motion(false,true);
			gravity();
			
			//check if we're being pushed
			pushing = 0;
			if (collide("Player", x + 1, y) && Input.check(Global.keyLeft)) { pushing = -1; }
			if (collide("Player", x - 1, y) && Input.check(Global.keyRight)) { pushing = 1; }
			
			//if we're being pushed, count the timer down
			if (pushing == -1)
			{
				if (timer > 0) { timer --; }
				//start moving if timer has hit bottom
				if (timer < 1) { moving = true; }
			}
			
			if (pushing == 1)
			{
				if (timer > 0) { timer --; }
				if (timer < 1) { moving = true; }
			}
			
			//if we're moving
			if (moving) 
			{
				//if we're still being pushed, set our speed
				if (pushing != 0) { speed.x = movement * pushing; }
				//update our position
				motion(true, false);
				//update the player position
				Global.player.motion(true,false);
				
				//no longer being pushed
				if (pushing == 0)
				{
					timer = 10;
					moving = false;
				}
			}
			
			//slide to a stop if we're not moving
			if (!moving) { 
				friction(true, false); 
				motion(true, false); 
			}
		}
	}

}