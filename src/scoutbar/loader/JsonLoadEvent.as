package scoutbar.loader
{
	import com.adobe.serialization.json.JSON;
	
	import debug.Functions;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import scoutbar.data.Global;
	import scoutbar.data.Order;
	import scoutbar.data.Product;
	import scoutbar.data.User;
	import scoutbar.events.JSONLoaded;
	import scoutbar.events.ProductEvent;
	import scoutbar.events.UserEvent;
	import flash.events.IOErrorEvent;
	
	import scoutbar.view.Messagebox;
	
	public class JsonLoadEvent extends EventDispatcher
	{
		private var Loaders:Array = new Array();
		
		private var UserLoaded:Boolean = false;
		private var ProductsLoaded:Boolean = false;
		
		public function JsonLoadEvent(){
			
		}
		
		public function Load():void {
			LoadNews();
			LoadGroups();
			LoadUsers();
			LoadProducts();
		}
		
		public function LoadUsers(id:int = -1):void {
			var path:String = Global.USER_URL;
			if(id != -1){
				path += "?id=" + id.toString();
			}
			var Request:URLRequest = new URLRequest(path);
			this.Loaders['users'] = (new URLLoader());
			this.Loaders['users'].addEventListener(Event.COMPLETE, saveUsers);
			this.Loaders['users'].addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			this.Loaders['users'].addEventListener(IOErrorEvent.NETWORK_ERROR, onIOError);
			try {
				this.Loaders['users'].load(Request);
			} catch (e:Error) {
				trace(e);
			}
			
		}
		
		private function saveUsers(e : Event):void {
			trace('LoadUsers');
			var myData:Object = com.adobe.serialization.json.JSON.decode(this.Loaders['users'].data);
			var count:int = 0;
			var total:int = 0;
			for(var i:String in myData.data){
				total++;
			}
			for(var index:String in myData.data){
				if(myData.data[index].persoon_id == 1) trace("Saldo:"+myData.data[index].saldo);
				var myUser:User = new User(myData.data[index]);
				Global.USERS[myUser.persoon_id]=(myUser);
				myUser.addEventListener(UserEvent.USER_READY, function():void {
					count++;
					if(count == total){
						UserLoaded = true;
						dispatchEvent(new JSONLoaded(JSONLoaded.JSON_USERS_LOADED));
						if(total != 1){
							Test();
						}
					}
				});
			}
		}
		
		public function LoadGroups():void {
			var path:String = Global.GROUPS_URL;
			var Request:URLRequest = new URLRequest(path);
			this.Loaders['groups'] = (new URLLoader());
			this.Loaders['groups'].addEventListener(Event.COMPLETE, saveGroups);
			this.Loaders['groups'].addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			this.Loaders['groups'].addEventListener(IOErrorEvent.NETWORK_ERROR, onIOError);
			try {
				this.Loaders['groups'].load(Request);
			} catch (e:Error) {
				trace(e);
			}
			
		}
		
		private function saveGroups(e : Event):void {
			trace('LoadGroups');
			var myData:Object = com.adobe.serialization.json.JSON.decode(this.Loaders['groups'].data);
			for(var index:String in myData.data){
				Global.GROUPS[myData.data[index].groep_id]=myData.data[index].Groepsnaam;
			}
		}
		
		
		public function LoadProducts():void {
			this.Loaders['products'] = new URLLoader();
			var Request:URLRequest = new URLRequest(Global.PRODUCT_URL);
			this.Loaders['products'].addEventListener(Event.COMPLETE, saveProducts);
			this.Loaders['products'].addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			this.Loaders['products'].addEventListener(IOErrorEvent.NETWORK_ERROR, onIOError);
			try {
				this.Loaders['products'].load(Request);
			} catch (e:Error) {
				trace(e);
			}
		}
		
		private function saveProducts(e : Event):void {
			var myData:Object = com.adobe.serialization.json.JSON.decode(this.Loaders['products'].data);
			var count:int = 0;
			var total:int = 0;
			for(var i:String in myData.data){
				total++;
			}
			for(var index:String in myData.data){
				var myProduct:Product = new Product(myData.data[index]);
				Global.PRODUCTS.push(myProduct);
				myProduct.addEventListener(ProductEvent.PRODUCT_READY, function():void {
					count++;
					if(count == total){
						ProductsLoaded = true;
						Test();
					}			
				});
			}
		}
		
		public function LoadHistory(id:int):void {
			this.Loaders['history'] = new URLLoader();
			var path:String = Global.HISTORY_URL+id;
			var Request:URLRequest = new URLRequest(path);
			this.Loaders['history'].addEventListener(Event.COMPLETE, saveHistory);
			try {
				this.Loaders['history'].load(Request);
			} catch (e:Error) {
				trace(e);
			}
		}
		
		private function saveHistory(e : Event):void {
			var myData:Object = com.adobe.serialization.json.JSON.decode(this.Loaders['history'].data);
			var count:int = 0;
			var total:int = 0;
			for(var i:String in myData.data){
				total++;
			}
			for(var index:String in myData.data){
				var myHistory:Order = new Order(myData.data[index]);
				Global.CURRENT_HISTORY.push(myHistory);
				myHistory.addEventListener(ProductEvent.PRODUCT_READY, function():void {
					count++;
					if(count == total){
						dispatchEvent(new JSONLoaded(JSONLoaded.JSON_HISTORY_LOADED));
					}			
				});
			}
		}
		
		
		public function LoadNews():void {
			this.Loaders['news'] = new URLLoader();
			var path:String = Global.NEWS_URL;
			var Request:URLRequest = new URLRequest(path);
			this.Loaders['news'].addEventListener(Event.COMPLETE, saveNews);
			this.Loaders['news'].addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			this.Loaders['news'].addEventListener(IOErrorEvent.NETWORK_ERROR, onIOError);
			try {
				this.Loaders['news'].load(Request);
			} catch (e:Error) {
				trace(e);
			}
		}
		
		private function saveNews(e : Event):void {
			var myData:Object = com.adobe.serialization.json.JSON.decode(this.Loaders['news'].data);
			var count:int = 0;
			var total:int = 0;
			for(var i:String in myData.data){
				total++;
			}
			for(var index:String in myData.data){
				Global.NEWS.push(myData.data[index].bericht);
			}
		}
		
		private function Test():void{
			//trace(this.ProductsLoaded +" "+ this.UserLoaded);
			if(this.ProductsLoaded && this.UserLoaded){	
				var jlevent:Event = new JSONLoaded("allJsonLoaded");
				dispatchEvent(jlevent);
			}
		}
		
		public function onIOError(e:IOErrorEvent):void
		{
			Global.SCOUTBAR.stage.addChild(new Messagebox("Start het programma opnieuw op, er is iets fout gegaan"));
		}
	}
}