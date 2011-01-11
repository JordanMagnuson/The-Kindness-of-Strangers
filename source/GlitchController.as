package source 
{
	import net.flashpunk.Entity;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.FP;
	import source.Objects.Stranger;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class GlitchController extends Entity
	{
		public const GLITCH_01_TIME:Number = 6.2 * FP.assignedFrameRate;
		public const GLITCH_02_TIME:Number = 7.92 * FP.assignedFrameRate;
		public const GLITCH_03_TIME:Number = 10.45 * FP.assignedFrameRate;
		public const GLITCH_04_TIME:Number = 12.23 * FP.assignedFrameRate;
		public const GLITCH_05_TIME:Number = 13.14 * FP.assignedFrameRate;	//start spaz
		public const GLITCH_OVER_TIME:Number = 15.14 * FP.assignedFrameRate; 
		
		public const GLITCH_01_ALARM:Alarm = new Alarm(GLITCH_01_TIME, showHelp); 
		public const GLITCH_02_ALARM:Alarm = new Alarm(GLITCH_02_TIME, hideHelp); 
		public const GLITCH_03_ALARM:Alarm = new Alarm(GLITCH_03_TIME, showHelp); 
		public const GLITCH_04_ALARM:Alarm = new Alarm(GLITCH_04_TIME, hideHelp); 
		public const GLITCH_05_ALARM:Alarm = new Alarm(GLITCH_05_TIME, spazShow); 
		public const GLITCH_OVER_ALARM:Alarm = new Alarm(GLITCH_OVER_TIME, destroy); 
		
		public const SPAZ_TIME:Number = 0.1 * FP.assignedFrameRate;
		public var spazTime:Number = SPAZ_TIME;
		public const SPAZ_ON_ALARM:Alarm = new Alarm(SPAZ_TIME, spazShow);
		public const SPAZ_OFF_ALARM:Alarm = new Alarm(SPAZ_TIME, spazHide);
		
		public const STRANGER_LIST:Array = [];
			
		
		public function GlitchController() 
		{
			
		}
		
		override public function added():void
		{
			addTween(GLITCH_01_ALARM, true);
			addTween(GLITCH_02_ALARM, true);
			addTween(GLITCH_03_ALARM, true);
			addTween(GLITCH_04_ALARM, true);
			addTween(GLITCH_05_ALARM, true);
			addTween(GLITCH_OVER_ALARM, true);
			addTween(SPAZ_ON_ALARM);
			addTween(SPAZ_OFF_ALARM);
			FP.world.getClass(Stranger, STRANGER_LIST);
		}
		
		public function showHelp():void
		{
			trace('show help');
			PhotoController.show = false;
			for each (var s:Stranger in STRANGER_LIST)
				s.showTalkBubble = true;	
			Global.help = false;
		}
		
		public function hideHelp():void
		{
			trace('hide help');
			PhotoController.show = true;
			for each (var s:Stranger in STRANGER_LIST)
				s.showTalkBubble = false;	
			Global.help = true;			
		}
		
		public function spazShow():void
		{
			Global.help = false;
			PhotoController.show = false;
			//trace('spaz show');
			spazTime = SPAZ_TIME / 2 + FP.random * (SPAZ_TIME / 2);
			for each (var s:Stranger in STRANGER_LIST)
				s.showTalkBubble = true;	
			SPAZ_OFF_ALARM.reset(spazTime);
		}
		
		public function spazHide():void
		{
			Global.help = false;
			PhotoController.show = true;
			//trace('spaz hide');
			spazTime = SPAZ_TIME / 2 + FP.random * (SPAZ_TIME / 2);
			for each (var s:Stranger in STRANGER_LIST)
				s.showTalkBubble = false;	
			SPAZ_ON_ALARM.reset(spazTime);
		}
		
		public function destroy():void
		{
			PhotoController.show = false;
			FP.world.remove(Global.photoControler);
			Global.help = false;
			for each (var s:Stranger in STRANGER_LIST)
				s.showTalkBubble = false;				
			FP.world.remove(this);
		}
	}

}