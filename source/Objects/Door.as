package source.Objects 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import source.Game;
	import source.Global;
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Door extends Entity
	{
		
		[Embed(source = '../../assets/graphics/door.png')] public var imgDoor:Class;
		public var sprDoor:Image = new Image(imgDoor, new Rectangle(0, 0, 32, 64));
		public var sprDoorHover:Image = new Image(imgDoor, new Rectangle(32, 0, 32, 64));
		
		public function Door(x:int, y:int) 
		{
			super(x, y-32);
			
			graphic = sprDoor;
			setHitbox(32, 32, 0, -32);
		}
		
		override public function update():void
		{
			graphic = sprDoor;
			if (collide("Player", x, y)) {
				graphic = sprDoorHover;
				
				if (Input.pressed(Global.keyDown))
				{
					Global.finished = true;
				}
			}
		}
		
	}

}