package scoutbar.view.productselection
{
	import com.adobe.serialization.json.JSON;
	
	import debug.Functions;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import scoutbar.data.Global;
	import scoutbar.data.Order;
	import scoutbar.data.User;
	import scoutbar.events.JSONLoaded;
	import scoutbar.events.ProductEvent;
	import scoutbar.loader.JsonLoadEvent;
	import scoutbar.loader.JsonSendEvent;
	import scoutbar.view.productselection.ProductBoard;
	
	public class ProductSelection extends Sprite
	{
		public static var board:ProductBoard = new ProductBoard(20,20,20,270);
		public static var border:ProductBar = new ProductBar(250);
		public static var user:User;
		public static var order:Order;
		
		public function ProductSelection()
		{
			this.addChild(board);
			this.addChild(border);
		}
		
		public static function sendOrder():void{
			var sender:JsonSendEvent = new JsonSendEvent();
			if(order.Rows.length > 0){
			sender.Send(order);
			}
			trace("Total "+order.Total());
			trace("Before "+Global.USERS[order.User].saldo);
			Global.USERS[order.User].saldo -= order.Total();
			trace("After "+Global.USERS[order.User].saldo);
			order = null;
			user = null;
			board.clearAll();
			Global.SCOUTBAR.switchToUserSelectionFromProduct(null);
		}
		
		public static function cancelOrder():void{
			var loader:JsonLoadEvent = new JsonLoadEvent();
			loader.LoadUsers(user.persoon_id);
			order = null;
			user = null;
			board.clearAll();
			Global.SCOUTBAR.switchToUserSelectionFromProduct(null);
		}

		public function setUser(usert:User):void{
			order = new Order(Global.USERS[usert.persoon_id]);
			border.setUser(Global.USERS[usert.persoon_id]);
			user = Global.USERS[usert.persoon_id];
			board.sortcards(Global.USERS[usert.persoon_id].leeftijd);
			//trace(user.level);
			if(usert.level == 1){
				border.hideSaldo(false);
			} else {
				border.hideSaldo(true);
			}
			dispatchEvent(new ProductEvent(ProductEvent.USER_LOADED));
		}
	}
}