package source.Objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Spikes extends Entity
	{
		[Embed(source = '../../assets/graphics/spikes.png')] public var imgSpike:Class;
		public var sprSpike:Image = new Image(imgSpike);
		
		public function Spikes(x:int, y:int) 
		{
			//set position
			super(x, y);
			
			//set graphic and mask
			graphic = sprSpike;
			mask = new Pixelmask(imgSpike);
			
			//set type
			type = "Spikes";
		}
		
	}

}