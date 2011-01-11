package source 
{
	import net.flashpunk.utils.Key;
	import source.Objects.Airplane;
	import source.Objects.Airplane2;
	import source.Objects.BigHeart;
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
			bigHeart:BigHeart,
			kindness:Boolean, 	//controlls whether people will help or not
			help:Boolean = true,		//controlls whether help bubbles show, turned off automatically if kindness is false
			intro:Boolean = true, 		//controlls whether the plane flies in with an intro, or not (for testing)
			showSolution:Boolean = true, //show maze solution (for testing, cheating);
			died:Boolean = false,
			
			paused:Boolean = false,
			restart:Boolean = false,
			finished:Boolean = false;
			
		public static const
			BG_COLOR:uint = Colors.WHITE,
			grid:int = 32;
		
	}

}