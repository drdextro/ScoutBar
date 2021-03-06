package scoutbar.view.productselection
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class ToggleButton extends Sprite
	{
		private var bg:Shape = new Shape();
		public var bg2:Shape = new Shape();
		private var namefield:TextField = new TextField();
		
		public var on:Boolean = true;
		public var index:String;
		public var group:String;
		
		public function ToggleButton(s:String,i:String)
		{
			index = i;
			group = s;
			
			bg.graphics.lineStyle();
			bg.graphics.beginFill(0xffffff,1);
			bg.graphics.drawRoundRect(0,0,30,30,10,10);
			bg.graphics.endFill();
			addChild(bg);
			
			bg2.graphics.lineStyle();
			bg2.graphics.beginFill(0x000000,1);
			bg2.graphics.drawRoundRect(5,5,20,20,10,10);
			bg2.graphics.endFill();
			addChild(bg2);
			
			var textformat:TextFormat = new TextFormat();
			textformat.size = 20;
			textformat.align = TextFormatAlign.LEFT;
			this.namefield.defaultTextFormat = textformat;
			this.namefield.text = s;
			this.namefield.x = 40;
			this.namefield.width = namefield.textWidth + 5;
			this.namefield.textColor = 0xFFFFFF;
			this.namefield.selectable = false;
			this.namefield.wordWrap = true;
			this.addChild(namefield);
		}
	}
}