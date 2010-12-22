package source 
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class GameOverWorld extends World
	{
		
		public function GameOverWorld() 
		{
			FP.width = FP.screen.width;
			FP.height = FP.screen.height;
			FP.screen.color = Colors.BLACK;
			add(new TextEntity("For My Friends in Taiwan.", FP.halfWidth, FP.halfHeight - 50, true));
			add(new TextEntity("Press space to play again", FP.halfWidth, FP.halfHeight + 150, true));
			//add(new TextEntity("GameTrekking.com", FP.halfWidth, FP.halfHeight + 200, true, 8));
		}
	
		override public function begin():void
		{
			trace('game over');
			add(new FadeIn(Colors.BLACK, 6));
		}		
		
		override public function update():void
		{
			if (Input.released(Key.SPACE))
			{
				FP.world = new Game;
			}
			super.update();
		}		
		
	}

}