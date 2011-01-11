package source.Objects 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import source.Colors;
	import source.Global;
	import net.flashpunk.FP;
	import source.PhotoController;
	import source.SoundController;
	import source.View;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Airplane extends Entity
	{
		public static const SPEED:Number = 5;
		
		[Embed(source = '../../assets/graphics/plane.png')] public static const S_PLANE:Class;
		public var image:Image = new Image(S_PLANE);	
		
		[Embed(source = '../../assets/sound/sounds.swf', symbol = 'plane_sound')] public static const SOUND_PLANE:Class;
		public var soundPlane:Sfx = new Sfx(SOUND_PLANE);
		
		public var playerDropped:Boolean = false;
		
		public function Airplane(x:Number, y:Number) 
		{
			super(x, y);
			image.flipped = true;
			graphic = image;
			layer = -100;
		}
		
		override public function added():void
		{
			soundPlane.loop(0.5);
		}
		
		override public function update():void
		{
			x += SPEED;
			if (x >= 3000 && !playerDropped)
			{
				playerDropped = true;
				Global.player.x = x;
				Global.player.y = y;
				Global.player.stunned = false;
				Global.view.setView(Global.player as Entity, new Rectangle(0, 0, FP.width, FP.height), 10);
				FP.world.add(Global.photoControler = new PhotoController);				
				FP.world.add(Global.soundControler = new SoundController);
				
				//= new View(Global.player as Entity, new Rectangle(0, 0, FP.width, FP.height), 10);
			}
			if (x > FP.width * 1.5)
			{
				FP.world.remove(this);
			}
			
			if (playerDropped)
			{
				y -= 1;
				// plane sound
				soundPlane.pan = FP.scale(x, 3000, FP.width * 1.5, 0, 1);
				soundPlane.volume = FP.scale(x, 3000, FP.width * 1.5, 0.5, 0);						
			}
			else 
			{
				y += 0.2;
			}
		}
		
	}

}