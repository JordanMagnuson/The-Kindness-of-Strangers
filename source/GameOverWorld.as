package source 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.net.URLRequest
	import flash.net.navigateToURL;	
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class GameOverWorld extends World
	{
		
		[Embed(source = '../assets/end_screen_died.png')] private const S_DIED:Class;
		[Embed(source = '../assets/end_screen_lonely.png')] private const S_LONELY:Class;
		[Embed(source = '../assets/end_screen_strangers.png')] private const S_STRANGERS:Class;
		
		public var bgImage:Image;
		
		public var learnMoreURL:String = "http://www.gametrekking.com/category/tags/taiwan";
		
		public function GameOverWorld() 
		{
			FP.width = FP.screen.width;
			FP.height = FP.screen.height;
			FP.screen.color = Colors.BLACK;
			//add(new TextEntity("For My Friends in Taiwan.", FP.halfWidth, FP.halfHeight - 50, true));
			//add(new TextEntity("Press space to play again", FP.halfWidth, FP.halfHeight + 150, true));
			//add(new TextEntity("GameTrekking.com", FP.halfWidth, FP.halfHeight + 200, true, 8));
		}
	
		override public function begin():void
		{
			trace('game over');
			
			// Background
			if (Global.died)
				bgImage = new Image(S_DIED);
			else if (Global.kindness)
				bgImage = new Image(S_STRANGERS);
			else
				bgImage = new Image(S_LONELY);
				
			add(new Entity(0, 0, bgImage));
			
			// Stop airplane noise
			Global.airplane2.soundPlane.stop();
			Global.airplane2.playerTrigger03 = false;
			FP.world.remove(Global.airplane2);
			
			// Fade in
			add(new FadeIn(Colors.BLACK, 6));
		}		
		
		override public function update():void
		{
			if (Input.released(Key.SPACE))
			{
				// Determine whether strangers will help the player
				if (Global.died)
				{
					// Roll the dice again on kindness
					//if (FP.random < 0.25)
					if (false)
						Global.kindness = false;
					else
						Global.kindness = true;								
				}
				// If player didn't die, reverse kindness for "different experience"
				else if (Global.kindness)
					Global.kindness = false;
				else
					Global.kindness = true;				
				FP.world = new Game;
			}
			if (Input.pressed(Key.X))
			{
				var request:URLRequest = new URLRequest(learnMoreURL);
				try {
				  navigateToURL(request, '_blank'); // second argument is target
				} catch (e:Error) {
				  trace("Error occurred!");
				}
			}
			super.update();
		}		
		
	}

}