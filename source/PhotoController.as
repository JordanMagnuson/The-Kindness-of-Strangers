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
		
		/**
		 * Photo array 01
		 */
		[Embed(source = '../assets/photos/010_IMG_1073.jpg')] private const PHOTO_01:Class;
		[Embed(source = '../assets/photos/020_IMG_0133.jpg')] private const PHOTO_02:Class;
		[Embed(source = '../assets/photos/030_IMG_0987.jpg')] private const PHOTO_03:Class;
		[Embed(source = '../assets/photos/040_P1110802.jpg')] private const PHOTO_04:Class;
		[Embed(source = '../assets/photos/050_P1110722.jpg')] private const PHOTO_05:Class;
		
		public var photoArray01:Array = new Array(PHOTO_01, PHOTO_02, PHOTO_03, PHOTO_04, PHOTO_05);
		
		/**
		 * Photo array 02
		 */
		[Embed(source = '../assets/photos/060_P1110356.jpg')] private const PHOTO_06:Class;
		[Embed(source = '../assets/photos/065_IMG_3166.jpg')] private const PHOTO_065:Class;
		[Embed(source = '../assets/photos/070_IMG_0423.jpg')] private const PHOTO_07:Class;
		[Embed(source = '../assets/photos/075_IMG_3114.jpg')] private const PHOTO_075:Class;
		[Embed(source = '../assets/photos/076_IMG_0415.jpg')] private const PHOTO_076:Class;
		[Embed(source = '../assets/photos/077_IMG_0348.jpg')] private const PHOTO_077:Class;
		[Embed(source = '../assets/photos/080_IMG_3090.jpg')] private const PHOTO_08:Class;
		[Embed(source = '../assets/photos/090_IMG_0336.jpg')] private const PHOTO_09:Class;
		[Embed(source = '../assets/photos/095_P1110657.jpg')] private const PHOTO_095:Class;
		[Embed(source = '../assets/photos/100_IMG_0561.jpg')] private const PHOTO_10:Class;
		[Embed(source = '../assets/photos/110_IMG_0833.jpg')] private const PHOTO_11:Class;
		[Embed(source = '../assets/photos/115_IMG_0923.jpg')] private const PHOTO_115:Class;
		[Embed(source = '../assets/photos/120_IMG_0920.jpg')] private const PHOTO_12:Class;
		
		
		public var photoArray02:Array = new Array(PHOTO_06, PHOTO_065, PHOTO_07, PHOTO_075, PHOTO_076, PHOTO_077, PHOTO_08, PHOTO_095, PHOTO_09, PHOTO_10, PHOTO_11, PHOTO_115, PHOTO_12);
		
		/**
		 * Other vars
		 */
		
		public var currentPhotoArray:Array = photoArray01;
		public var currentIndex:int = 0;
		
		public var currentPhoto:PhotoBackdrop;
		public var lastPhoto:PhotoBackdrop;
		
		public var nextPhotoAlarm:Alarm = new Alarm(DISPLAY_TIME, nextPhoto);
		
		public function PhotoController() 
		{
		}
		
		override public function added():void
		{
			currentPhoto = new PhotoBackdrop(currentPhotoArray[currentIndex]);
			FP.world.add(currentPhoto);
			currentIndex++;
			addTween(nextPhotoAlarm, true);
		}
		
		override public function update():void
		{
			// Trigger 01
			if (Global.player.collideWith(Global.trigger01, Global.player.x, Global.player.y) && currentPhotoArray != photoArray02)
			{
				currentPhotoArray = photoArray02;
				currentIndex = 0;
				nextPhoto();
			}	
			super.update();
		}
		
		public function nextPhoto():void
		{
			lastPhoto = currentPhoto;
			currentPhoto = new PhotoBackdrop(currentPhotoArray[currentIndex]);
			FP.world.add(currentPhoto);
			lastPhoto.fadeOut();
			if (currentIndex < currentPhotoArray.length - 1)
				currentIndex++;
			else
				currentIndex = 0;
			nextPhotoAlarm.reset(DISPLAY_TIME);
		}
		
	}

}