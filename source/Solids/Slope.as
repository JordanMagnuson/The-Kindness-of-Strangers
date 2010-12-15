package source.Solids 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Slope extends Solid
	{
		
		[Embed(source = '../../assets/graphics/slope1.png')] public var imgSlope1:Class;
		[Embed(source = '../../assets/graphics/slope2.png')] public var imgSlope2:Class;
		[Embed(source = '../../assets/graphics/slope3.png')] public var imgSlope3:Class;
		[Embed(source = '../../assets/graphics/slope4.png')] public var imgSlope4:Class;
		
		public var slopeMask:Pixelmask
		
		public function Slope(x:int, y:int, type:int) 
		{
			super(x, y, 0, 0);
			
			var slope:Class;
			switch(type) {
				case 0: slope = imgSlope1; break;
				case 1: slope = imgSlope2; break;
				case 2: slope = imgSlope3; break;
				case 3: slope = imgSlope4; break;
			}
			
			slopeMask = new Pixelmask(slope, 0, 0);
			mask = slopeMask;
		}
		
	}

}