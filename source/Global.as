package source 
{
	import net.flashpunk.utils.Key;
	import source.Objects.Airplane;
	import source.Objects.Airplane2;
	import source.Objects.Player;
	import source.Objects.Trigger;
	/*
	 * This class contains a number of global variables to be used throughout the game
	 */
	public class Global
	{
		public static var
			time:int = 0,
			deaths:int = 0,
			gems:int = 0,
			level:int = 0,
			
			newgame:Boolean = false,
			loadgame:Boolean = false,
			
			musicon:Boolean = true,
			soundon:Boolean = true,
			
			keyUp:int = Key.UP,
			keyDown:int = Key.DOWN,
			keyLeft:int = Key.LEFT,
			keyRight:int = Key.RIGHT,
			keyA:int = Key.X,
			
			airplane:Airplane,
			airplane2:Airplane2,
			player:Player,
			maze:Maze,
			view:View,
			soundControler:SoundController,
			photoControler:PhotoController,
			trigger01:Trigger,
			trigger02:Trigger,
			trigger03:Trigger,
			trigger04:Trigger,
			
			paused:Boolean = false,
			restart:Boolean = false,
			finished:Boolean = false;
			
		public static const
			BG_COLOR:uint = Colors.WHITE,
			grid:int = 32;
		
	}

}