/**
 * File: com.doubleprime.generic.DojoExternalInterface  v0.0.2
 * Auth: Anthony Decena
 * Desc: This is an ActionScript 3 port of the DojoExternalInterface.
 * 		 This wraps up the newer ExternalInterface available in Flash 9.
 * 		 The original AS2 class was written by Brad Neuberg and was packaged
 * 		 with the dojo 1.1.0 release.
 */
package com.doubleprime.generic {
	//import mx.core.Application;
	import flash.display.MovieClip;
	import flash.external.ExternalInterface;
	import com.doubleprime.generic.ExpressInstall;
	
	public class DojoExternalInterface extends MovieClip {
		public static var available:Boolean;
		public static var dojoPath:String = "";
		public static var lInfo:Object;

		public static function initialize(loadinfo:Object):void {
			DojoExternalInterface.lInfo = loadinfo;
			DojoExternalInterface.dojoPath = DojoExternalInterface.getDojoPath();
			
			// Allows for express install of flash player plugin.
			var install:ExpressInstall = new ExpressInstall(lInfo);
			if (install.needsUpdate) {
				install.init();
			}
			
			// Sanity check
			DojoExternalInterface.available = ExternalInterface.available;
			ExternalInterface.marshallExceptions = true;
		}
		
		// Called when we are finished adding methods through addCallback()
		public static function done():void {
			DojoExternalInterface.call("dojox.flash.loaded");
		}
		
		/**
		 * This is how we expose as methods to javascript.  The FlashApi class
		 * takes over this work because we only add the single flashCall() method.
		 */
		public static function addCallback(methodName:String, method:Function):Boolean {
			ExternalInterface.addCallback(methodName, function(... args):Object {
				var params:Array = [];
				if (args && args.length) {
					for (var i:uint = 0; i < args.length; i++) {
						params[i] = DojoExternalInterface.decodeData(args[i]);
					}
				}
			
				var results:Object = method.apply(FlashApi, params);
				return results;
			});
		
			// tell JavaScript about DojoExternalInterface new method so we can create a proxy
			ExternalInterface.call("dojox.flash.comm._addExternalInterfaceCallback", methodName);
													 
			return true;
		}
		
		public static function call(... args):Object {
			// we might have any number of optional arguments, so we have to 
			// pass them in dynamically; strip out the results callback			
			var params:Array = [];
			for (var i:uint = 0; i < args.length; i++) {
				params.push(args[i]);
			}
			
			// FIXME: Should we be encoding or decoding the data to get
			// around Flash's serialization bugs?

			var results:Object;
			if (DojoExternalInterface.available) {
				results = ExternalInterface.call.apply(ExternalInterface, params);
			}
			
			return results;
		}
		
		/** 
			Called by Flash to indicate to JavaScript that we are ready to have
			our Flash functions called. Calling loaded()
			will fire the dojox.flash.loaded() event, so that JavaScript can know that
			Flash has finished loading and adding its callbacks, and can begin to
			interact with the Flash file.
		*/
		public static function loaded():void {
			DojoExternalInterface.call("dojox.flash.loaded");
		}
	
		/**
			Utility trace implementation that prints out to console.debug.
		*/
		public static function trace(msg:String):void {
			DojoExternalInterface.call("console.debug", "FLASH: " + msg);
		}
		
		private static function decodeData(data:String):String {
			if (!data || typeof data != "string") {
				return data;
			}
		
			// we have to use custom encodings for certain characters when passing
			// them over; for example, passing a backslash over as //// from JavaScript
			// to Flash doesn't work
			data = replaceStr(data, "&custom_backslash;", "\\");
			
			data = replaceStr(data, "\\\'", "\'");
			data = replaceStr(data, "\\\"", "\"");
			
			return data;
		}
	
		private static function encodeData(data:String):String {	
			if (!data || typeof data != "string"){
				return data;
			}
			
			// certain XMLish characters break Flash's wire serialization for
			// ExternalInterface; encode these into a custom encoding, rather than
			// the standard entity encoding, because otherwise we won't be able to
			// differentiate between our own encoding and any entity characters
			// that are being used in the string itself
			data = replaceStr(data, '<', '&custom_lt;');
			data = replaceStr(data, '>', '&custom_gt;');
			
			// needed for IE
			data = replaceStr(data, '\\', '&custom_backslash;');
			
			// encode control characters and JavaScript delimiters
			data = replaceStr(data, "\n", "\\n");
			data = replaceStr(data, "\r", "\\r");
			data = replaceStr(data, "\f", "\\f");
			data = replaceStr(data, "'", "\\'");
			data = replaceStr(data, '"', '\"');
			
			return data;
		}
		
		/** 
				Flash ActionScript has no String.replace method or support for
				Regular Expressions! We roll our own very simple one.
		*/
		public static function replaceStr(inputStr:String, replaceThis:String, withThis:String):String {
			var splitStr:Array = inputStr.split(replaceThis);
			if (!splitStr) {
				return inputStr;
			}
			
			inputStr = splitStr.join(withThis);
			return inputStr;
		}
		
		public static function getDojoPath():String {
			var url:String = lInfo.url;
			var start:Number = url.indexOf("baseUrl=") + "baseUrl=".length;
			var path:String = url.substring(start);
			var end:Number = path.indexOf("&");
			if (end != -1) {
				path = path.substring(0, end);
			}
			
			// some browsers append a junk string at the end: '%20'%20quality=
			if (path.indexOf("'%20'%20quality=") != -1) {
				path = path.substring(0, path.indexOf("'%20'%20quality="));
			}
			return path;
		}
		
		
		
	}
	
}