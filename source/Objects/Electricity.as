package source.Objects 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import source.Global;
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Electricity extends Entity
	{
		
		[Embed(source = '../../assets/graphics/electricity.png')] public var imgE:Class;
		public var sprE:Image = new Image(imgE);
		public var sprE2:Image = new Image(imgE);
		
		public var start:Point
		public var end:Point
		
		public function Electricity(x:int, y:int, x2:int, y2:int) 
		{
			super(x, y);
			
			sprE2.x = x2 - x;
			sprE2.y = y2 - y;
			
			graphic = new Graphiclist(sprE, sprE2);
			
			start = new Point(x, y);
			end = new Point(x2, y2);
			
		}
		
		override public function update():void
		{
			//if we hit the entity
			if (FP.world.collideLine("Player", start.x + 16, start.y + 16, end.x + 16, end.y + 16, 8))
			{
				Global.player.killme();
			}
		}
		
		override public function render():void
		{
			//how many and how crazy
			var amount:int = 16;
			var crazyness:int = 16;
			
			//the offset (so that it's not just a straight line)
			var poffset:Point = new Point(0, 0);
			var noffset:Point = new Point(0, 0);
			
			//previous and next point
			var previous:Point = new Point(start.x + 16,start.y + 16);
			var next:Point = new Point(start.x + 16, start.y + 16);
			
			//how much to increase each point by
			var incY:Number = (end.y - start.y) / amount;
			var incX:Number = (end.x - start.x) / amount;
			
			for (var i:int = 0; i < amount; i ++)
			{
				//set the new offset
				noffset = new Point((Math.random() * 16) - (16/2), (Math.random() * 16) - (16/2));
				
				//increase the next point
				next.x += incX;
				next.y += incY;
				
				//if the point is at the end, set the offset to nothing
				if (i == amount - 1) { noffset = new Point(0, 0); }
				
				//draw the line from the last point, with the last offset, to the new point, with the new offset
				Draw.line(previous.x + poffset.x, previous.y + poffset.y, next.x + noffset.x, next.y + noffset.y, 0xFFFFFF);
				
				//set the previous point and offset to the new point and offset
				previous = new Point(next.x, next.y);
				poffset = new Point(noffset.x, noffset.y);
			}
			
			//draw the blocks on the end
			super.render();
		}
		
	}

}