﻿package com.coresite.externalinterface {	import flash.external.ExternalInterface;	public class ExternalInterfaceLinkage {		public function ExternalInterfaceLinkage() {			//if(ExternalInterface.available)			//{			//ExternalInterface.call("myJavaScriptFunction", "Hello World");			//}		}		//private function receivedFromJavaScript(value:String):void {			//output.appendText("JavaScript says: " + value + "\n");		//}		private function checkJavaScriptReady():Boolean {			var isReady:Boolean = ExternalInterface.call("isReady");			return isReady;		}		//private function timerHandler(event:TimerEvent):void {			//output.appendText("Checking JavaScript status...\n");			//var isReady:Boolean = checkJavaScriptReady();			//if (isReady) {				//output.appendText("JavaScript is ready.\n");				//Timer(event.target).stop();			//}		//}		public function closeWindow():void{			if (ExternalInterface.available) {				ExternalInterface.call("closeFlashPopUp");			}		}		public function addToBag(arg:String):void{			if (ExternalInterface.available) {				ExternalInterface.call("recieveProductID", arg);			}		}		public function callJavaScript(arg:String):void {			//trace(arg);			if (ExternalInterface.available) {				ExternalInterface.call("sendToJavaScript", arg);			}		}	}}