package source 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class PhotoController extends Entity
	{
		public static const DISPLAY_TIME:Number = FP.assignedFrameRate * 10;
		
		[Embed(source = '../assets/photos/01_IMG_1073.jpg')] private const PHOTO_01:Class;
		[Embed(source = '../assets/photos/02_IMG_0133.jpg')] private const PHOTO_02:Class;
		public var photoArray01:Array = new Array(PHOTO_01, PHOTO_02);
		
		public var currentPhotoArray:Array = photoArray01;
		public var currentIndex:int = 0;
		
		public var nextPhotoAlarm:Alarm = new Alarm(DISPLAY_TIME, nextPhoto);
		
		public function PhotoController() 
		{
		}
		
		override public function added():void
		{
			nextPhoto();
			addTween(nextPhotoAlarm, true);
		}
		
		public function nextPhoto():void
		{
			trace(FP.assignedFrameRate);
			FP.world.add(new PhotoBackdrop(currentPhotoArray[currentIndex]));
			if (currentIndex < photoArray01.length - 1)
				currentIndex++;
			else
				currentIndex = 0;
			nextPhotoAlarm.reset(DISPLAY_TIME);
		}
		
	}

}