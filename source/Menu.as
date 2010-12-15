package source 
{
	import flash.geom.Rectangle;
	import flash.net.NetStreamPlayTransitions;
	import net.flashpunk.debug.Console;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	/*
	 * The main menu of the game. We use this to load a new game, continue an old one,
	 * or to check out the options
	 */
	public class Menu extends World
	{
		//add the banner as an image
		[Embed(source = '../assets/graphics/banner.png')] public var imgBanner:Class;
		public var sprBanner:Image = new Image(imgBanner);
		
		//add each menu option from the menu.png
		[Embed(source = '../assets/graphics/menu.png')] public var imgMenu:Class;
		public var sprNewGame:Image = new Image(imgMenu, new Rectangle(0, 0, 640, 64));
		public var sprNewGameHover:Image = new Image(imgMenu, new Rectangle(0, 64, 640, 64));
		public var sprLoadGame:Image = new Image(imgMenu, new Rectangle(0, 128, 640, 64));
		public var sprLoadGameHover:Image = new Image(imgMenu,new Rectangle(0,192,640,64));
		
		//create a new graphic list of our images
		public var sprites:Graphiclist = new Graphiclist(sprBanner, sprNewGame, sprNewGameHover, sprLoadGame, sprLoadGameHover);
		//variable that contains the entity that holds all the graphics
		public var display:Entity;
		
		//current menu selected
		public var selected:int = 0;
		//if a menu selection has been changed (so we're not executing this every frame)
		public var changed:Boolean = true;
		
		public function Menu() 
		{
			//add the display entity to the world
			add(display = new Entity(0, 0, sprites));
		
			//image positions
			sprBanner.y = -128;
			sprNewGame.y = sprNewGameHover.y = 200;
			sprLoadGame.y = sprLoadGameHover.y = 264;
		}
		
		override public function update():void
		{
			//make the banner slide in
			sprBanner.y += - Math.floor(sprBanner.y / 10);
			
			//if the menu selection changed
			if ( changed ) {
				//if the selection is out of the range, reset it
				if ( selected < 0 ) { selected = 0; }
				if ( selected > 1 ) { selected = 1; }
				
				//set the incorrect images to visible/invisible
				sprNewGame.visible = selected == 0 ? false : true;
				sprNewGameHover.visible = !sprNewGame.visible;
				sprLoadGame.visible = selected == 1 ? false : true;
				sprLoadGameHover.visible = !sprLoadGame.visible;
				
				//we're done changing
				changed = false;
			}
			
			//change selection
			if ( Input.pressed( Global.keyDown ) ) { selected += 1; }
			if ( Input.pressed( Global.keyUp ) ) { selected -= 1; }
			
			if ( Input.pressed( Global.keyA ) ) { 
				//fade out, go to the game
				FP.world = new Transition(Game); 
			}
			
			if ( Input.pressed( Key.ANY ) ) { changed = true; }
		}
		
	}

}