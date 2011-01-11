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
		// How long to wait before starting the "slide show"
		public static const START_TIME:Number = FP.assignedFrameRate * 5;
		
		// How long to display each photo
		public static const DISPLAY_TIME:Number = FP.assignedFrameRate * 10;
		
		public static var show:Boolean = true;
		
		/**
		 * Photo array 01
		 */
		[Embed(source='../assets/photos/005_P1110356.jpg')] private const PHOTO_005:Class;
		[Embed(source = '../assets/photos/010_IMG_1073.jpg')] private const PHOTO_01:Class;
		//[Embed(source = '../assets/photos/020_IMG_0133.jpg')] private const PHOTO_02:Class;
		[Embed(source = '../assets/photos/030_IMG_0987.jpg')] private const PHOTO_03:Class;
		[Embed(source = '../assets/photos/040_P1110802.jpg')] private const PHOTO_04:Class;
		[Embed(source = '../assets/photos/050_P1110722.jpg')] private const PHOTO_05:Class;
		public var photoArray01:Array = new Array(PHOTO_005, PHOTO_01, PHOTO_03, PHOTO_04, PHOTO_05);
		
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
		 * Photo array 03
		 */
		[Embed(source='../assets/photos/130_IMG_2957.jpg')] private const PHOTO_130:Class;
		[Embed(source = '../assets/photos/135_IMG_2046.jpg')] private const PHOTO_135:Class;
		[Embed(source = '../assets/photos/140_IMG_2056.jpg')] private const PHOTO_140:Class;
		//[Embed(source = '../assets/photos/150_IMG_2057.jpg')] private const PHOTO_150:Class;
		[Embed(source = '../assets/photos/155_IMG_2427.jpg')] private const PHOTO_155:Class;
		[Embed(source = '../assets/photos/160_IMG_2430.jpg')] private const PHOTO_160:Class;
		[Embed(source = '../assets/photos/170_IMG_2915.jpg')] private const PHOTO_170:Class;
		[Embed(source = '../assets/photos/180_IMG_2911.jpg')] private const PHOTO_180:Class;
		[Embed(source = '../assets/photos/190_IMG_3018.jpg')] private const PHOTO_190:Class;
		[Embed(source = '../assets/photos/200_IMG_3061.jpg')] private const PHOTO_200:Class;
		public var photoArray03:Array = new Array(PHOTO_130, PHOTO_135, PHOTO_140, PHOTO_155, PHOTO_160, PHOTO_170, PHOTO_180, PHOTO_190, PHOTO_200);
		
		/**
		 * Other vars
		 */
		public var currentPhotoArray:Array = photoArray01;
		public var currentIndex:int = 0;
		
		public var currentPhoto:PhotoBackdrop;
		public var lastPhoto:PhotoBackdrop;
		
		public var nextPhotoAlarm:Alarm = new Alarm(DISPLAY_TIME, nextPhoto);
		
		public var startAlarm:Alarm = new Alarm(START_TIME, start);
		
		public function PhotoController() 
		{
		}
		
		override public function added():void
		{
			addTween(startAlarm, true);
		}
		
		public function start():void
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
			// Triger 02
			else if (Global.player.collideWith(Global.trigger02, Global.player.x, Global.player.y) && currentPhotoArray != photoArray03)
			{
				currentPhotoArray = photoArray03;
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
			if (lastPhoto)
				lastPhoto.fadeOut();
			if (currentIndex < currentPhotoArray.length - 1)
				currentIndex++;
			else
				currentIndex = 0;
			nextPhotoAlarm.reset(DISPLAY_TIME);
		}
		
	}

}