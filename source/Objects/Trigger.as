package source.Objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import source.Colors;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Trigger extends Entity
	{
		public var image:Image = Image.createRect(50, 50, Colors.GREEN);
		
		public function Trigger(x:Number, y:Number) 
		{
			super(x, y);
			type = 'trigger';
			graphic = image;
			layer = 0;
			
			width = image.width;
			height = image.height;
			
			visible = false;
		}
		
	}

}