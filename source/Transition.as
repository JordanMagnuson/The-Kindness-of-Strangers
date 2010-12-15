package source 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.World;
	
	public class Transition extends World
	{
		//the screen (to display)
		public var screen:Image;
		//the entity that actually holds the screen
		public var display:Entity;
		//what world to goto
		public var _goto:Class;
		//the alpha to put over
		public var alpha:Number = 0;
		
		public function Transition(goto:Class) 
		{
			//set the screen to what was last being displayed
			screen = new Image(FP.buffer);
			//add the display entity with the new graphic
			add(display = new Entity(0, 0, screen));
			
			//set goto
			_goto = goto;
		}
		
		override public function render():void {
			//fade out
			Draw.rect(0, 0, FP.width, FP.height, 0x000000, alpha);
			alpha += 0.1;
			
			//if we're done, go to the next world
			if (Math.floor(alpha) == 1) { FP.world = new _goto; }
		}
	}

}