package source 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.FP;
	import source.Objects.Airplane;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class SoundController extends Entity
	{
		public const FADE_DURATION:Number = 4 * FP.assignedFrameRate;
		
		public var currentSound:Sfx;
		public var fader:SfxFader;
		
		public var trigger04:Boolean = false;
		public var fadeOutStarted:Boolean = false;
		
		// Transcript sounds
		[Embed(source='../assets/sound/sounds.swf', symbol='transcript_part01.wav')] private const SND_TRANSCRIPT_01:Class;
		public var sndTranscript01:Sfx = new Sfx(SND_TRANSCRIPT_01);
		
		[Embed(source='../assets/sound/sounds.swf', symbol='transcript_part02.wav')] private const SND_TRANSCRIPT_02:Class;
		public var sndTranscript02:Sfx = new Sfx(SND_TRANSCRIPT_02);		
		
		[Embed(source='../assets/sound/sounds.swf', symbol='transcript_part02_breakdown.wav')] private const SND_TRANSCRIPT_02_BREAK:Class;
		public var sndTranscript02Break:Sfx = new Sfx(SND_TRANSCRIPT_02_BREAK);				
		
		[Embed(source='../assets/sound/sounds.swf', symbol='transcript_part03.wav')] private const SND_TRANSCRIPT_03:Class;
		public var sndTranscript03:Sfx = new Sfx(SND_TRANSCRIPT_03);	
		
		[Embed(source='../assets/sound/sounds.swf', symbol='transcript_part04.wav')] private const SND_TRANSCRIPT_04:Class;
		public var sndTranscript04:Sfx = new Sfx(SND_TRANSCRIPT_04);	
		
		// Other sounds
		public var soundPlane:Sfx = new Sfx(Airplane.SOUND_PLANE);
		
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
			if (Global.player.collideWith(Global.trigger01, Global.player.x, Global.player.y))
			{
				if (currentSound != sndTranscript02 && currentSound != sndTranscript02Break)
				{
					trace('collide trigger 1');
					fader.fadeTo(0, FADE_DURATION);
					if (Global.kindness)
						currentSound = sndTranscript02;
					else
					{
						currentSound = sndTranscript02Break;
						FP.world.add(new GlitchController);
					}
					currentSound.play();
				}
			}
			else if (Global.player.collideWith(Global.trigger02, Global.player.x, Global.player.y) && currentSound != sndTranscript03)
			{
				trace('collide trigger 2');
				if (Global.kindness)
				{
					fader.fadeTo(0, FADE_DURATION);
					currentSound = sndTranscript03;
					currentSound.play();
				}
			}	
			else if (Global.player.collideWith(Global.trigger04, Global.player.x, Global.player.y) && !trigger04)
			{
				trace('trigger04');
				trigger04 = true;
				soundPlane.loop();
			}	
			else if (trigger04)
			{
				soundPlane.pan = FP.scale(Global.player.x, Global.trigger04.x, FP.width, 1, 0);
				soundPlane.volume = FP.scale(Global.player.x, Global.trigger04.x, FP.width, 0, 0.5);
			}
			
			//if (currentSound == sndTranscript04 && !fadeOutStarted)
			if (currentSound == sndTranscript04 && !sndTranscript04.playing && !fadeOutStarted)
			{
				fadeOutStarted = true;
				FP.world.add(new FadeOut(GameOverWorld, Colors.BLACK, 6));
			}
		}
		
		// Called by plane 2, when it picks up player
		public function hitPlane2():void
		{
			soundPlane.stop();
			trigger04 = false;
			fader.fadeTo(0, FADE_DURATION);
			if (Global.kindness)
			{
				currentSound = sndTranscript04;
				currentSound.play();	
			}
		}
		
		public function fadeComplete():void
		{
			fader = new SfxFader(currentSound, fadeComplete);
			addTween(fader);
		}
		
		public function fadeOut():void
		{
			fader = new SfxFader(currentSound);
			addTween(fader);
			fader.fadeTo(0, 6  * FP.assignedFrameRate);
		}
		
	}

}