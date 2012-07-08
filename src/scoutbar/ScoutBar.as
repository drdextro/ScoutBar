package scoutbar
{
	//de json lib die ik nog ni
	import com.adobe.serialization.json.JSON;
	import com.greensock.TweenLite;
	
	import debug.Functions;
	import debug.it.flashfuck.debugger.FPSMonitor;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import scoutbar.data.Global;
	import scoutbar.data.User;
	import scoutbar.events.JSONLoaded;
	import scoutbar.loader.JsonLoadEvent;
	import scoutbar.loader.JsonSendEvent;
	import scoutbar.resource.Image;
	import scoutbar.view.productselection.ProductSelection;
	import scoutbar.view.splash.Splash;
	import scoutbar.view.userselection.UserSelection;
	
	public class ScoutBar extends Sprite
	{
		
		public static var STAGE:Stage;
		public static var splash:Splash = new Splash();
		public static var us:UserSelection;
		public static var ps:ProductSelection;

		
		//URL request loader voor het php script met de JSON data

		
		public function ScoutBar()
		{
			Global.SCOUTBAR = this;
			this.init();
			this.createSplash();
			var load:JsonLoadEvent = new JsonLoadEvent();
			load.addEventListener(JSONLoaded.JSON_LOADED, tracetest);
			load.Load();

		}
		
		protected function tracetest(e:Event):void{
			trace("JSON completely loaded");
			for(var index:String in Global.USERS){
				trace(Global.USERS[index].voornaam);
			}
			createUserSelection();
			createProductSelection();
		}
		
		protected function init():void
		{
			trace("Init dataobjects ..");
			stage.displayState = StageDisplayState.FULL_SCREEN;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			
			var backGroundSprite:Sprite = new Sprite();
			backGroundSprite.graphics.beginBitmapFill(Image.Splashbg.bitmapData);
			backGroundSprite.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			backGroundSprite.graphics.endFill();
			this.addChild(backGroundSprite);
			trace("Init successfull");
		}
		
		protected function createSplash():void
		{
			trace("Create splash");
			splash.addEventListener(MouseEvent.CLICK, switchToUserSelection);
			stage.addChild(splash);
			
		}
		
		protected function createUserSelection():void
		{
			trace("Create userselectioin");
			us =  new UserSelection();
			us.x = stage.stageWidth;
			stage.addChild(us);

		}
		
		protected function createProductSelection():void {
			trace("Create productselection");
			ps =  new ProductSelection();
			ps.x = stage.stageWidth*2;
			stage.addChild(ps);
			this.addChildAt(new FPSMonitor(), this.numChildren);
		}
		
		protected function switchToUserSelection(e:Event):void{
			trace("Switch to userselection");
			//us.addEventListener(MouseEvent.CLICK, switchToProductSelection);
			TweenLite.to(splash, 1, {x:0-stage.stageWidth});
			TweenLite.to(us, 1, {x:0});
			TweenLite.to(ps, 1, {x:stage.stageWidth});
		}
		
		public function switchToProductSelection(e:Event):void{
			trace("Switch to productselection");
			TweenLite.to(us, 1, {x:0-stage.stageWidth});
			TweenLite.to(ps, 1, {x:0});
		}
		
	}
}