package source.Objects 
{
	import net.flashpunk.graphics.Image;
	import source.Global;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class StrangerDown extends Stranger
	{
		
		[Embed(source = '../../assets/graphics/arrow_down.png')] public const ARROW_DOWN:Class;	
		
		public function StrangerDown(x:Number, y:Number) 
		{
			super(x, y);
		
			imgArrow = new Image(ARROW_DOWN);
			imgArrow.color = Global.BG_COLOR;
		}
		
	}

}