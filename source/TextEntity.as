package source
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class TextEntity extends Entity
	{
		public var text:Text;
		public var bg:Image;
		
		//[Embed(source = '../assets/fonts/CasualEncounter.ttf', embedAsCFF = "false", fontFamily = 'CasualEncounter')] private var FONT_CE:Class;
		[Embed(source = '../assets/fonts/verdana.ttf', embedAsCFF="false", fontFamily = 'verdana')] private var FONT_VERDANA:Class;
		
		public function TextEntity(textString:String, x:Number = 0, y:Number = 0, centered:Boolean = true, size:int = 8, fontFamily:String = 'CasualEncounter', color:uint = Colors.WHITE, fillBG:Boolean = false, bgColor:uint = Colors.BLACK) 
		{
			super(x, y);
			layer = -100;
			this.x = x;
			this.y = y;		
			text = new Text(textString, x, y);
			text.font = fontFamily;
			text.size = size;
			
			// Initialize text rendering
			if (centered)
			{
				text.originX = text.width / 2;
				text.originY = text.height / 2;
				text.x = -text.originX;
				text.y = -text.originY;		
			}
			else
			{
				text.originX = 0;
				text.originY = 0;				
				text.x = 0;
				text.y = 0;
			}
			text.color = color;
			
			// Initialize background rendering
			if (fillBG)
			{
				bg = Image.createRect(text.width, text.height, bgColor);
				bg.originX = bg.width / 2;
				bg.originY = bg.height / 2;
				bg.x = -bg.originX;
				bg.y = -bg.originY;				
			}
			
			//setHitbox(text.width, text.height, text.originX, text.originY);		
			graphic = text;						
		}
		
		override public function render():void
		{
			if (bg)
				Draw.graphic(bg, x, y);
			super.render();
		}
		
		public function fadeIn():void
		{
			
		}
		
		public function fadeOut():void
		{
			
		}
		
	}

}