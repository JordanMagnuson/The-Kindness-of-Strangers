package source.Objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import source.Global;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class BigHeart extends Entity
	{
		[Embed(source = '../../assets/graphics/pixel_heart.png')] public static const SPRITE:Class;
		public var image:Image = new Image(SPRITE);			
		
		[Embed(source = '../../assets/sound/sounds.swf', symbol = 'powerup03.wav')] public static const SND_P3:Class;
		public var sndP3:Sfx = new Sfx(SND_P3);				
		
		public function BigHeart(x:Number, y:Number) 
		{
			super(x, y);
			graphic = image;
			width = image.width;
			height = image.height;
		}
		
		override public function update():void
		{
			if (collideWith(Global.player, x, y))
			{
				sndP3.play();
				FP.world.remove(this);
			}
			super.update();
		}
		
	}

}