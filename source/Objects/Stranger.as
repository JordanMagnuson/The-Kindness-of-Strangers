package source.Objects 
{
	import flash.geom.Point;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import source.Global;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	import source.Colors;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Stranger extends Physics
	{
		public static const X_DISTANCE_TO_HELP:Number = 100;
		public static const Y_DISTANCE_TO_HELP:Number = 10;
		
		public var showTalkBubble:Boolean = false;
		
		[Embed(source = '../../assets/graphics/stranger.png')] public var imgStranger:Class;
		public var sprStranger:Spritemap = new Spritemap(imgStranger, 32, 32, animEnd);		
		
		[Embed(source = '../../assets/graphics/talk_bubble.png')] public const SPRITE_BUBBLE:Class;
		public var imgBubble:Image = new Image(SPRITE_BUBBLE);		
		
		[Embed(source = '../../assets/graphics/arrow_right.png')] public const SPRITE_ARROW:Class;
		public var imgArrow:Image = new Image(SPRITE_ARROW);				
		
		//how fast we accelerate
		public var movement:Number = 1;
		public var jump:Number = 8;
		
		//current direction (true = right, false = left)
		public var direction:Boolean = true;
		
		//are we on the ground?
		public var onground:Boolean = false;
		
		public var start:Point;		
		
		public function Stranger(x:Number, y:Number) 
		{
			//set position
			super(x, y);
			start = new Point(x, y);
			
			//set different speeds and such
			mGravity = 0.4;
			mMaxspeed = new Point(4, 8);
			mFriction = new Point(0.5, 0.5);
			
			//set up animations
			sprStranger.add("standLeft", [0], 0, false);
			sprStranger.add("standRight", [8], 0, false);
			sprStranger.add("walkLeft", [0, 1, 2, 3, 4, 5, 6, 7], 0.2, true);
			sprStranger.add("walkRight", [8, 9, 10, 11, 12, 13, 14, 15], 0.2, true);
			
			sprStranger.add("jumpLeft", [2], 0, false);
			sprStranger.add("jumpRight", [10], 0, false);
			
			sprStranger.add("slideRight", [16], 0, false);
			sprStranger.add("slideLeft", [17], 0, false);
			
			sprStranger.play("standRight");
			
			//set hitbox & graphic
			setHitbox(12, 24, -10, -8);
			graphic = sprStranger;
			type = "Stranger";			
			
			//set different speeds and such
			mGravity = 0.4;
			mMaxspeed = new Point(4, 4);			
			
			//Face random direction
			direction = FP.choose(true, false);
			
			// Deal with talk bubble
			imgBubble.color = Global.BG_COLOR;
			imgArrow.color = Global.BG_COLOR;
			imgArrow.originX = imgArrow.width / 2;
			imgArrow.originY = imgArrow.height / 2;
			//imgArrow.x = -imgArrow.originX;
			//imgArrow.y = -imgArrow.originY;					
		}
		
		override public function added():void
		{
			//imgBubble.color = 0xFF0000;
		}
		
		override public function update():void
		{
			checkHelp();	
			faceDirection();
			updateTalkBubble();	
			
			super.update();
			
			//are we on the ground?
			//onground = false;
			//if (collide(solid, x, y + 1)) 
			//{ 
				//onground = true;
			//}
			//
			// Movement
			//if (!onground)
			//{
				//gravity();
				//maxspeed(false, true);
				//motion();
			//}
		}
		
		public function checkHelp():void
		{
			if (Global.player)
			{
				if (Math.abs(y - Global.player.y) <= Y_DISTANCE_TO_HELP)
				{
					if (Math.abs(x - Global.player.x) <= X_DISTANCE_TO_HELP)
					{
						showTalkBubble = true;
						if (x > Global.player.x)
						{
							direction = false;
						}
						else
						{
							direction = true;
						}
					}
					else
					{
						showTalkBubble = false;
					}
				}
				else
				{
					showTalkBubble = false;
				}
			}
		}
		
		public function updateTalkBubble():void
		{
			if (direction)
			{
				imgBubble.flipped = false;
				imgBubble.x = width + imgBubble.width;
			}
			else
			{
				imgBubble.flipped = true;
				imgBubble.x = -5;		
			}
			imgBubble.y = -5;	
			imgArrow.x = imgBubble.x + 1;
			imgArrow.y = imgBubble.y + 1;			
		}
		
		public function faceDirection():void
		{
			if (direction)
				sprStranger.play('standRight');
			else
				sprStranger.play('standLeft');
		}
		
		override public function render():void
		{
			if (showTalkBubble)
			{
				imgBubble.render(FP.buffer, new Point(x, y), FP.camera);
				imgArrow.render(FP.buffer, new Point(x, y), FP.camera);
			}
			super.render();
		}
		
		public function animEnd():void { }
		
	}

}