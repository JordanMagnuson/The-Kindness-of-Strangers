package source.Objects 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import source.Global;
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Physics extends Entity
	{
		
		public var speed:Point = new Point(0, 0);			//speed
		public var acceleration:Point = new Point(0, 0);	//acceleration
		public var mGravity:Number = 0.2;
		public var solid:String = "Solid";
		public var mFriction:Point = new Point(0.5, 0.5);
		public var slopeHeight:int = 1;
		public var mMaxspeed:Point = new Point(3, 8);
		
		public function Physics(x:int = 0, y:int = 0) 
		{
			super(x, y);
			type = solid;
		}
		
		override public function update():void {
			motion();
			gravity();
		}
		
		/**
		 * Moves this entity at it's current speed (speed.x, speed.y) and increases speed based on acceleration (acceleration.x, acceleration.y)
		 * @param	mx		Include horizontal movement
		 * @param	my		Include vertical movement
		 * @return	void
		 */
		public function motion(mx:Boolean = true, my:Boolean = true):void {
			
			//if we should move horizontally
			if ( mx )
			{
				//make us move, and stop us on collision
				if (!motionx(this, speed.x)) { speed.x = 0; }
				
				//increase velocity/speed
				speed.x += acceleration.x;
			}
			
			//if we should move vertically
			if ( my )
			{
				//make us move, and stop us on collision
				if (!motiony(this, speed.y)) { speed.y = 0; }
				
				//increase velocity/speed
				speed.y += acceleration.y;
			}
			
		}
		
		/**
		 * Increases this entities speed, based on its gravity (mGravity)
		 * @return	Void
		 */
		public function gravity():void 
		{
			//increase velocity/speed based on gravity
			speed.y += mGravity;
			
		}
		
		/**
		 * Slows this entity down, according to its friction (mFriction.x, mFriction.y)
		 * @param	mx		Include horizontal movement
		 * @param	my		Include vertical movement
		 * @return	void
		 */
		public function friction(x:Boolean = true, y:Boolean = true):void 
		{
			//if we should use friction, horizontally
			if ( x )
			{
				//speed > 0, then slow down
				if ( speed.x > 0 ) {
					speed.x -= mFriction.x;
					//if we go below 0, stop.
					if ( speed.x < 0 ) { speed.x = 0; }
				}
				//speed < 0, then "speed up" (in a sense)
				if ( speed.x < 0 ) {
					speed.x += mFriction.x;
					//if we go above 0, stop.
					if ( speed.x > 0 ) { speed.x = 0; }
				}
			}
			
		}
		
		/**
		 * Stops entity from moving to fast, according to maxspeed (mMaxspeed.x, mMaxspeed.y)
		 * @param	mx		Include horizontal movement
		 * @param	my		Include vertical movement
		 * @return	void
		 */
		public function maxspeed(x:Boolean = true, y:Boolean = true):void
		{
			if ( x ) {
				if ( Math.abs(speed.x) > mMaxspeed.x )
				{
					speed.x = mMaxspeed.x * FP.sign(speed.x);
				}
			}
			
			if ( y ) {
				if ( Math.abs(speed.y) > mMaxspeed.y )
				{
					speed.y = mMaxspeed.y * FP.sign(speed.y);
				}
			}
		}
		
		/**
		 * Moves the set entity horizontal at a given speed, checking for collisions and slopes
		 * @param	e		The entity you want to move
		 * @param	spdx	The speed at which the entity should move
		 * @return	True (didn't hit a solid) or false (hit a solid)
		 */
		public function motionx(e:Entity, spdx:Number):Boolean
		{
			//check each pixel before moving it
			for (var i:int = 0; i < Math.abs(spdx); i ++) 
			{
				//if we've moved
				var moved:Boolean = false;
				var below:Boolean = true;
				
				if (!e.collide(solid, e.x, e.y + 1)) { below = false; }
				
				//run through how high a slope we can move up
				for (var s:int = 0; s <= slopeHeight; s ++)
				{
					//if we don't hit a solid in the direction we're moving, move....
					if (!e.collide(solid, e.x + FP.sign(spdx), e.y - s)) 
					{
						//increase/decrease positions
						//if the player is in the way, simply don't move (but don't count it as stopping)
						if (!e.collide(Global.player.type, e.x + FP.sign(spdx), e.y - s)) { e.x += FP.sign(spdx); }
						
						//move up the slope
						e.y -= s;
						
						//we've moved
						moved = true;
						
						//stop checking for slope (so we don't fly up into the air....)
						break;
					}
					
				}
				
				//if we are now in the air, but just above a platform, move us down.
				if (below && !e.collide(solid,e.x, e.y + 1)) { e.y += 1; }
				
				//if we haven't moved, set our speed to 0
				if ( !moved ) { return false; }
				
			}
			
			//hit nothing!
			return true;
		}
		
		/**
		 * Moves the set entity vertical at a given speed, checking for collisions
		 * @param	e		The entity you want to move
		 * @param	spdy	The speed at which the entity should move
		 * @return	True (didn't hit a solid) or false (hit a solid)
		 */
		public function motiony(e:Entity, spdy:Number):Boolean
		{
			//for each pixel that we will move...
			for ( var i:int = 0; i < Math.abs(spdy); i ++ )
			{
				//if we DON'T collide with solid
				if (!e.collide(solid, e.x, e.y + FP.sign(spdy))) { 
					//if we don't run into a player, them move us
					if (!e.collide(Global.player.type, e.x, e.y + FP.sign(spdy))) { e.y += FP.sign(spdy); }
					//but note that we wont stop our movement if we hit a player.
				} else { 
					//stop movement if we hit a solid
					return false; 
				}
			}
			
			//hit nothing!
			return true;
		}
		
		/**
		 * Moves an entity of the given type that is on top of this entity (if any). Also moves player if it's on top of the entity on top of this one. (confusing.. eh?).
		 * Mostly used for moving platforms
		 * @param	type	Entity type to check for
		 * @param	speed	The speep at which to move the thing above you
		 * @return	void
		 */
		public function moveontop(type:String,speed:Number):void
		{
			var e:Entity = collide(type, x, y - 1) as Entity;
			if (e) {
				motionx(e, speed);
				
				//if the player is on tope of the thing that's being moved, move him/her too.
				var p:Physics = e as Physics;
				if(p != null) { p.moveontop("Player", speed); }
			}
		}
		
	}

}