package source.Objects 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import source.Colors;
	import source.FadeOut;
	import source.Global;
	import net.flashpunk.FP;
	import source.GameOverWorld;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Airplane2 extends Entity
	{
		public static const SPEED:Number = 5;
		public var image:Image = new Image(Airplane.S_PLANE);
		public var playerTrigger03:Boolean = false;
	
		public var soundPlane:Sfx = new Sfx(Airplane.SOUND_PLANE);
		
		public var fadeOutStarted:Boolean = false;
		
		public function Airplane2(x:Number, y:Number)  
		{
			super(x, y);
			graphic = image;
			width = image.width;
			height = image.height;
			layer = -100;
		}
		
		override public function update():void
		{
			if (Global.player.collideWith(Global.trigger03, Global.player.x, Global.player.y) && !playerTrigger03)
			{
				playerTrigger03 = true;
				Global.player.stunned = true;
				Global.player.speed.x = 0;
				Global.player.acceleration.x = 0;
				soundPlane.loop(0.5);
			}
			if (playerTrigger03)
			{
				x -= SPEED;
				y -= 0.7;
				// Move the player away (removing from world causes problems, so just stick player in a corner)
				if (this.collideWith(Global.player, this.x, this.y))
				{
					Global.player.x = FP.width;
					Global.player.y = 10;
					// make view follow plane
					Global.view.setView(Global.airplane2 as Entity, new Rectangle(0, 0, FP.width, FP.height), 10);
					Global.soundControler.hitPlane2();
				}
				
				// plane sound
				soundPlane.pan = FP.scale(x, -1000, FP.width, -1, 0);
				soundPlane.volume = FP.scale(x, -1000, FP.width, 0, 0.5);
			}
			
			if (!Global.kindness)
			{
				if (x < FP.width/2 && !fadeOutStarted)
				{
					fadeOutStarted = true;
					FP.world.add(new FadeOut(GameOverWorld, Colors.BLACK, 6));					
				}
			}			
		}
		
	}

}