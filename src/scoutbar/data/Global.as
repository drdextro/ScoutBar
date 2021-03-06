package scoutbar.data
{
	public class Global
	{
		[Transient]
		private static var instance:Global = new Global();
		
		public static var APPNAME:String = "ScoutBar";
		public static var API_KEY:String = "85ce692db10a8350c25902c8d56dcbe2";
		
		public static var USERS:Array = new Array();
		public static var PRODUCTS:Array = new Array();
		public static var NEWS:Array = new Array();
		public static var GROUPS:Array = new Array();
		
		//public static var PRODUCT_URL:String = "http://10.0.0.6/Ext/scoutbar/data/php/product.php";
		//public static var HISTORY_URL:String = "http://10.0.0.6/Ext/scoutbar/data/php/history.php";
		//public static var USER_URL:String = "http://10.0.0.6/Ext/scoutbar/data/php/user.php";
		//public static var SEND_ORDER_URL:String = "http://10.0.0.6/Ext/scoutbar/data/connector/updateUsers.php";

		//public static var PRODUCT_URL:String = "http://192.168.178.20/scoutbar/server/product.php";
		//public static var HISTORY_URL:String = "http://192.168.178.20/scoutbar/server/history.php";
		//public static var USER_URL:String = "http://192.168.178.20/scoutbar/server/user.php";
		//public static var SEND_ORDER_URL:String = "http://192.168.178.20/scoutbar/server/updateUsers.php";
		//public static var NEWS_URL:String = "http://192.168.178.20/scoutbar/server/news.php";
		
		public static var PRODUCT_URL:String = "http://192.168.178.33/scoutbar/server/product.php";
		public static var HISTORY_URL:String = "http://192.168.178.33/scoutbar/server/history.php";
		public static var USER_URL:String = "http://192.168.178.33/scoutbar/server/user_group.php";
		public static var SEND_ORDER_URL:String = "http://192.168.178.33/scoutbar/server/updateUsers.php";
		public static var NEWS_URL:String = "http://192.168.178.33/scoutbar/server/news.php";
		public static var GROUPS_URL:String = "http://192.168.178.33/scoutbar/server/groups.php";
		
		public static var BASE_IMG_PATH:String = "../assets/";
		public static var SCOUTBAR = null;
		
		public static var CURRENT_HISTORY:Array = new Array();
		
		public static var MASSASTREEP:Boolean = false;

		/**
		 * 
			**/ 
		public function Global()
			{ 
					if(instance)
					{
						throw new Error ("We cannot create a new instance. Please use Global.getInstance()");
					}
				}
				
				public static function getInstance():Global
				{
					return instance;
				}
				
		public static function getUser(key:String):User{
			return User[key] as User;
		}
	}
}