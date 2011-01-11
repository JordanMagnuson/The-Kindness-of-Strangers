package source 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.ColorTween;
	import source.Colors;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class PhotoBackdrop extends Entity
	{
		public static const FADE_IN_DURATION:Number = 3 * FP.assignedFrameRate;		
		public static const FADE_OUT_DURATION:Number = 3 * FP.assignedFrameRate;
		public static const MAX_ALPHA:Number = 0.5;
		
		public static const DISPLAY_DURATION:Number = PhotoController.DISPLAY_TIME;
		
		public var fadeTween:ColorTween;
		public var displayAlarm:Alarm = new Alarm(DISPLAY_DURATION, fadeOut);
		
		public function PhotoBackdrop(source:*) 
		{
			graphic = new Backdrop(source);
			layer = 100;
			graphic.scrollX = 0;
			graphic.scrollY = 0;
			(graphic as Backdrop).alpha = 0;
		}
		
		override public function added():void
		{
			//addTween(displayAlarm, true);
			fadeIn();
		}
		
		override public function update():void
		{
			(graphic as Backdrop).alpha = fadeTween.alpha;
			super.update();
		}
		
		public function fadeIn():void
		{
			fadeTween = new ColorTween();
			addTween(fadeTween);		
			fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 0, MAX_ALPHA);			
		}
		
		public function fadeOut():void
		{
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween);		
			fadeTween.tween(FADE_OUT_DURATION, Colors.WHITE, Colors.WHITE, (graphic as Backdrop).alpha, 0);				
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
		override public function render():void
		{
			if (PhotoController.show)
				super.render();
		}		
		
	}

}