package com.elconline.externalinterface {		import com.hexagonstar.util.debug.Debug;		import flash.external.ExternalInterface;			/**	* *	 * @author nmouzannar	 */	public class FlashApi {				public function FlashApi() {			ExternalInterface.addCallback("javascriptToFlash", javascriptToFlash);		}						public static function loadData() : Array {					var result:Array = new Array();			if(ExternalInterface.available) {          		Debug.trace("calling productPage.getVideoData");				return result = ExternalInterface.call("productPage.getVideoData");			} else {				Debug.trace("### Engine: ExternalInterface is not available!");				return result = null;			}		}				/**		 * Quickshop clinique Redesign		 */		public static function quickShop(funcName:String, prodId:String,catId:String) : void {			if(ExternalInterface.available) {          		ExternalInterface.call(funcName, prodId,catId);				trace('ExternalInterface.call = '+funcName +  prodId+  '  '+catId);			} else {				trace("### Engine: ExternalInterface is not available!");			}		}						public static function addToBag(funcName:String, obj:Object):void{			if (ExternalInterface.available) {				ExternalInterface.call(funcName, obj);				trace('ExternalInterface.call = '+funcName + 'addToBagObj = '+ obj);				Debug.trace(obj);			}else {				trace("### Engine: ExternalInterface is not available!");			}		}		// -------------------------------------------		// Receive From Javascript 		// -------------------------------------------		private function javascriptToFlash(name:String, data:Array=null):void{			//TODO		}				// JS calls		public static function cmCreatePageviewTag(pageID:String, searchString:String, categoryID:String, searchResults:Number):void {			ExternalInterface.call('cmCreatePageviewTag',pageID,searchString,categoryID,searchResults);		}			public static function cmCreatePageElementTag(elementCategory:String,elementID:String):void {			ExternalInterface.call('cmCreatePageElementTag',elementCategory,elementID); //		}				public static function cmCreatePageElementTagVideo(type:String,elementCategory:String,elementID:String, videoStatus : Number, videoCurrentTime : Number, videoTotalLength : Number):void {			ExternalInterface.call( "console.log" , "type : "+ type+" " + elementCategory + " "+elementID+" videoStatus: "+videoStatus + " videoCurrentTime = "+videoCurrentTime+ " videoTotalLength = "+videoTotalLength);			ExternalInterface.call(type, elementID, elementCategory, "-_--_--_--_--_--_--_--_--_--_--_--_-"+Math.round(Number(videoStatus))+"-_-"+Math.round(Number(videoCurrentTime))+"-_-"+Math.round(Number(videoTotalLength)));		}	}}