package scoutbar.view.productselection
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.filters.GlowFilter;
	
	import scoutbar.data.Global;

	public class codePad extends Sprite
	{
		public var _1:padButton = new padButton("1");
		public var _2:padButton = new padButton("2");
		public var _3:padButton = new padButton("3");
		public var _4:padButton = new padButton("4");
		public var _5:padButton = new padButton("5");
		public var _6:padButton = new padButton("6");
		public var _7:padButton = new padButton("7");
		public var _8:padButton = new padButton("8");
		public var _9:padButton = new padButton("9");
		public var _0:padButton = new padButton("0");
		public var ok:padButton = new padButton("ok",0x00ff00);
		public var _x:padButton = new padButton("x",0xff0000);
		private var background:Shape = new Shape();
		private var text:TextField = new TextField();
		
		
		public function codePad()
		{
			_1.x = 0;
			_1.y = 40;
			_2.x = 70;
			_2.y = 40;
			_3.x = 140;
			_3.y = 40;
			_4.x = 0;
			_4.y = 80;
			_5.x = 70;
			_5.y = 80;
			_6.x = 140;
			_6.y = 80;
			_7.x = 0;
			_7.y = 120;
			_8.x = 70;
			_8.y = 120;
			_9.x = 140;
			_9.y = 120;
			_0.x = 70;
			_0.y = 160;
			ok.x = 0;
			ok.y = 160;
			_x.x = 140;
			_x.y = 160;
			this.addChild(_1);
			this.addChild(_2);
			this.addChild(_3);
			this.addChild(_4);
			this.addChild(_5);
			this.addChild(_6);
			this.addChild(_7);
			this.addChild(_8);
			this.addChild(_9);
			this.addChild(_0);
			this.addChild(ok);
			this.addChild(_x);
			
			_1.addEventListener(MouseEvent.CLICK,clickHandeler);
			_2.addEventListener(MouseEvent.CLICK,clickHandeler);
			_3.addEventListener(MouseEvent.CLICK,clickHandeler);
			_4.addEventListener(MouseEvent.CLICK,clickHandeler);
			_5.addEventListener(MouseEvent.CLICK,clickHandeler);
			_6.addEventListener(MouseEvent.CLICK,clickHandeler);
			_7.addEventListener(MouseEvent.CLICK,clickHandeler);
			_8.addEventListener(MouseEvent.CLICK,clickHandeler);
			_9.addEventListener(MouseEvent.CLICK,clickHandeler);
			_0.addEventListener(MouseEvent.CLICK,clickHandeler);
			ok.addEventListener(MouseEvent.CLICK,clickHandeler);
			_x.addEventListener(MouseEvent.CLICK,clickHandeler);
			
			var myGlow:GlowFilter = new GlowFilter();
			myGlow.color = 0x0000ff;
			myGlow.strength = 255;
			this.background.filters = [myGlow];
			this.background.graphics.lineStyle();
			this.background.graphics.beginFill(0xffffff,1);
			this.background.graphics.drawRoundRect(0,0,this.width,30,20,20);
			this.background.graphics.endFill();
			this.addChild(this.background);
			
			var textformat:TextFormat = new TextFormat();
			textformat.size = 20;
			textformat.align = TextFormatAlign.CENTER;
			this.text.defaultTextFormat = textformat;
			this.text.text = "";
			this.text.y = 5;
			this.text.width = this.width;
			this.text.height = 30;
			this.text.selectable = false;
			this.text.displayAsPassword = true;
			this.addChild(text);
		}
		public function clickHandeler(e:MouseEvent):void
		{
			if(e.currentTarget.text.text == "ok"){
				testCode();
				this.text.text = "";
			}else if(e.currentTarget.text.text == "x"){
				this.text.text = "";
			}else{
				if(this.text.length < 4){
					this.text.appendText(e.currentTarget.text.text);
				}
			}
		}
		private function testCode():void
		{
			if(this.text.text.length < 4) return;
			var succes:Boolean = false;
			var u:int;
			for(var index:String in Global.USERS){
				//trace(Global.USERS[index].password + " -- "+ this.text.text);
				if(Global.USERS[index].password == this.text.text){
					succes = true;
					u = Global.USERS[index].persoon_id;
				break;	
				}
			}
			if(succes){
				ProductSelection.order.BarUser = u;
				ProductSelection.board.showMoney();
			}
		}
	}
}