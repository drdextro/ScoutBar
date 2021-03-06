package scoutbar.view.productselection
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import scoutbar.data.Global;
	import scoutbar.data.Product;
	import scoutbar.view.card.Card;
	import scoutbar.view.userselection.UserSelection;
	
	public class ProductBoard extends Sprite
	{
		
		private var cardarr:Array = new Array();
		private var scrollfield:Sprite = new Sprite();
		private var maskingShape:Shape=new Shape();
		private var main:Boolean;
		
		private var top:int = 0;
		private var bottom:int = 0;
		private var left:int = 0;
		private var right:int = 0;
		
		private var age:int;
		
		public function ProductBoard(t:int,b:int,l:int,r:int,f:Boolean = false)
		{
			main = f;
			top = t;
			bottom = b;
			left = l;
			right = r;
			addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		public function addedHandler(e : Event):void
		{
			this.x = left;
			this.y = top;
			createMask();
			createCards();
		}
		public function createMask():void
		{
			maskingShape.graphics.lineStyle();
			maskingShape.graphics.beginFill(0x000000,1);
			maskingShape.graphics.drawRoundRect(0,0,stage.stageWidth - (left+right),stage.stageHeight - (top+bottom),50,50);
			maskingShape.graphics.endFill();
			addChild(maskingShape);
			addChild(scrollfield);			
			this.mask = maskingShape;
		}
		public function createCards():void
		{
			for(var index:String in Global.PRODUCTS){
				var card:Card;
				switch(Global.PRODUCTS[index].categorie){
					case 1:
						 card = new Card(Global.PRODUCTS[index],90,90,0xff0000);
						 card.isMin16();
					break;
					case 2:
						 card = new Card(Global.PRODUCTS[index],90,90,0x00ff00);
					break;
					case 3:
						 card = new Card(Global.PRODUCTS[index],90,90,0x0000ff);
					break;
					case 4:
						 card = new Card(Global.PRODUCTS[index],90,90,0xffff00);
					break;
					default:
						 card = new Card(Global.PRODUCTS[index],90,90);
					break;
				}
				scrollfield.addChild(card);
				card.addEventListener(MouseEvent.CLICK, orderItem);
				cardarr.push(card);
			}
			cardarr.sort(card.compareCategorie);
			sortcards(18);
		}
		public function sortcards(a:int = 1):void
		{
			age = a;
			for(var index2:String in cardarr){
				cardarr[index2].visible = false;
			}
			var temparr2:Array = cardarr.filter(searchAge);
			for(var index3:String in temparr2){
				temparr2[index3].visible = true;
			}
			var temparr:Array = cardarr.filter(searchClass);
			for(var index:String in temparr){
				temparr[index].visible = false;
			}
			//trace("filter geeft "+ temparr);
			var xcount:int = maskingShape.width / temparr2[0].width;
			var countx:int = 0;
			var county:Number = 0;
			var xoffset:int = (maskingShape.width - (xcount * temparr2[0].width))/2;
			var precat:int = 1;
			if (xoffset <= temparr2[0].width * 0.2){
				
				xcount--;
				xoffset = (maskingShape.width - (xcount * temparr2[0].width))/2;
			}
			var skip:Boolean = false;
			for(var i:Number=0; i<temparr2.length;i++){
				if(i == 0){
					precat = temparr2[i].data.categorie;
				}
				if(precat != temparr2[i].data.categorie && skip == false){
					//trace("skip categorie");
					countx = 0;
					county += 1.05;
				}
				
				temparr2[i].x = (temparr2[i].width * countx)+xoffset;
				temparr2[i].y = (temparr2[i].height * county)+20;
				precat = temparr2[i].data.categorie;
				countx++
				if(countx >= xcount){
					//trace("skip width");
					countx = 0;
					county++;
					skip = true;
				}else{
					skip = false;
				}
			}
		}
		public function showMoney():void{
			var temparr:Array = cardarr.filter(searchClass);
			for(var index:String in temparr){
				temparr[index].visible = true;
			}
		}
		public function clearAll():void{
			for(var i:String in cardarr){
				cardarr[i].setCount(0);
			}
		}
		
		public function orderItem(e:Event):void{
			var card:Card = e.currentTarget as Card;
			if(main){
				UserSelection.bar.card.updateCard(card.data,90,90,0xff0000);
				UserSelection.board.visible = true;
				UserSelection.product.visible = false;
			}else{
				
				ProductSelection.order.AddRow(card.incCount(), card.data as Product);
				ProductSelection.border.updateProductField();
			}
		}
		private function searchClass(item:*,index:int,array:Array):Boolean
		{
			if(item.data.categorie == 4){
				return true;
			}else{
				return false;
			}
		}
		private function searchAge(item:*,index:int,array:Array):Boolean
		{
			if(item.data.min_leeftijd < age){
				return true;
			}else{
				return false;
			}
		}
	}
}