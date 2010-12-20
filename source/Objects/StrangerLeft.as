package source.Objects 
{
	import net.flashpunk.graphics.Image;
	import source.Global;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class StrangerLeft extends Stranger
	{
		[Embed(source = '../../assets/graphics/arrow_left.png')] public const ARROW_LEFT:Class;	
		
		public function StrangerLeft(x:Number, y:Number) 
		{
			super(x, y);
			imgArrow = new Image(ARROW_LEFT);
			imgArrow.color = Global.BG_COLOR;
		}
		
	}

}