package source 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class SoundController extends Entity
	{
		public const FADE_DURATION:Number = 3 * FP.assignedFrameRate;
		
		public var currentSound:Sfx;
		public var fader:SfxFader;
		
		// Transcript sounds
		[Embed(source = '../assets/sound/transcript_part01.mp3')] private const SND_TRANSCRIPT_01:Class;
		public var sndTranscript01:Sfx = new Sfx(SND_TRANSCRIPT_01);
		
		[Embed(source = '../assets/sound/transcript_part02.mp3')] private const SND_TRANSCRIPT_02:Class;
		public var sndTranscript02:Sfx = new Sfx(SND_TRANSCRIPT_02);		
		
		[Embed(source = '../assets/sound/transcript_part03.mp3')] private const SND_TRANSCRIPT_03:Class;
		public var sndTranscript03:Sfx = new Sfx(SND_TRANSCRIPT_03);				
		
		public function SoundController() 
		{
			currentSound = sndTranscript01;
		}
		
		override public function added():void
		{
			fader = new SfxFader(currentSound, fadeComplete);
			addTween(fader);
			currentSound.play();
		}
		
		override public function update():void
		{
			super.update();
			if (Global.player.collideWith(Global.trigger01, Global.player.x, Global.player.y) && currentSound != sndTranscript02)
			{
				trace('collide trigger 1');
				fader.fadeTo(0, FADE_DURATION);
				currentSound = sndTranscript02;
				currentSound.play();
			}
			else if (Global.player.collideWith(Global.trigger02, Global.player.x, Global.player.y) && currentSound != sndTranscript03)
			{
				trace('collide trigger 2');
				fader.fadeTo(0, FADE_DURATION);
				currentSound = sndTranscript03;
				currentSound.play();
			}			
		}
		
		public function fadeComplete():void
		{
			trace('sound fade complete');
			fader = new SfxFader(currentSound, fadeComplete);
			addTween(fader);
		}
		
	}

}