package source.Objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Moving extends Physics
	{
		[Embed(source = '../../assets/graphics/moving.png')] public var imgMoving:Class;
		public var sprMoving:Image = new Image(imgMoving);
		
		public var direction:Boolean = FP.choose(true, false);
		public var movement:Number = 2;
		public var carry:Array = new Array("Solid", "Player");
		
		public function Moving(x:int, y:int) 
		{
			//our x/y position
			super(x, y);
			
			//graphic & hitbox
			graphic = sprMoving;
			setHitbox(64, 32);
		}
		
		override public function update():void {
			
			//move in the correct direction
			speed.x = direction ? movement : - movement;
			
			//move stuff that's on top of us, for each type of entity we can carry
			for each(var i:String in carry) {
				moveontop(i,speed.x);
			}
			
			//move ourselves
			motion();
			
			//if we've stopped moving, switch directions!
			if ( speed.x == 0 ) { direction = !direction; }
		}
		
	}

}