package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import source.Game;
	import source.Menu;
	import source.Colors;
	import source.Global;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.ui.Mouse;
	
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
			Global.intro = true;
			
			// Determine whether strangers will help the player
			//if (FP.random < 0.25)
			if (false)
				Global.kindness = false;
			else
				Global.kindness = true;		
				
			Mouse.hide();
			FP.world = new Game;
		}
		
		override public function update():void
		{
			if (Input.pressed(Key.F1))
			{
				Global.kindness = true;
				Global.soundControler.currentSound.stop();
				FP.world = new Game;
			}			
			if (Input.pressed(Key.F2))
			{
				Global.kindness = false;
				Global.soundControler.currentSound.stop();
				FP.world = new Game;
			}			
			
			super.update();
		}
		
	}
	
}