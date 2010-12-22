package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import source.Game;
	import source.Menu;
	import source.Colors;
	
	public class Main extends Engine
	{
		
		public function Main():void 
		{
			//init the game
			super(640, 480, 60, true);
			
			//FP.screen.color = Colors.RED;
			
			//FP.console.enable();
		}
		
		override public function init():void
		{
			//load up the new world
			FP.world = new Game;
		}
		
	}
	
}