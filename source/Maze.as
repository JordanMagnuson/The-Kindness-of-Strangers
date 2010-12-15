package source
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Maze extends Entity
	{
		// Graphic
		[Embed(source = '../assets/supertough_maze_top.png')] private const S_MAZE_TOP:Class;
		[Embed(source = '../assets/supertough_maze_bottom.png')] private const S_MAZE_BOTTOM:Class;
		public var imgTop:Image = new Image(S_MAZE_TOP);
		public var imgBottom:Image = new Image(S_MAZE_BOTTOM);
		
		public var mazeTop:Entity;
		public var mazeBottom:Entity;
		
		public function Maze(x:Number = 0, y:Number = 0) 
		{
			super(x, y);
			type = 'Solid';
			layer = 10;			
		}
		
		override public function added():void
		{
			// Maze top
			FP.world.add(mazeTop = new Entity(x, y, imgTop, new Pixelmask(S_MAZE_TOP)));
			mazeTop.type = type;
			mazeTop.layer = layer;
			
			// Maze bottom
			FP.world.add(mazeBottom = new Entity(x, y + imgTop.height, imgBottom, new Pixelmask(S_MAZE_BOTTOM)));
			mazeBottom.type = type;
			mazeBottom.layer = layer;			
		}
		
	}

}