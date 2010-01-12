/**
 * File: com.doubleprime.generic.FlashApi  v0.0.3
 * Auth: Anthony Decena
 * Desc: This is an ActionScript 3 port of the FlashApi.  While there were numerous
 * 		 changes that had to occur in order to port this correctly, the idea is still
 * 		 the same, we use a single js method and a single as method to dispatch calls
 * 		 to any number of exposed methods.
 */

package com.doubleprime.generic {
	
	/**
	 * Depending on how your swf is compiled, you may need to pass the
	 * application data to the api in order for all parameters to be
	 * set correctly.
	 * 
	 * Usage:
	 * 			import flash.display.LoaderInfo;
	 * 			import com.doubleprime.generic.FlashApi;
	 * 
	 * 			FlashApi.initialize(this.loaderInfo);
	 * 			var resp:Object = FlashApi.jsCall("pageData", { query: "catalog.spp.product" });
	 * 			if (resp.success) {
	 * 				var data:* = resp.results;
	 * 				FlashApi.console("log", data.image_large);  //("/product/images/152x358/B01J_152x358.jpg")
	 * 			}
	 * 
	 */
	import com.doubleprime.generic.DojoExternalInterface;
	import com.doubleprime.generic.ExpressInstall;
	//import mx.core.Application;

	import flash.net.LocalConnection;
	import flash.display.MovieClip;

	public class FlashApi extends MovieClip {
		public static var __defaults : Object = {
			elcDom: "/", siteDom: "/", moviePath: "/flash", section: "", cartBase: "", jsonrpcBase: "/jsonrpc.logic", jsonrpcTimeout: 30
		};

		public static var conf : Object;
		public static var lInfo : Object;
		public static var callbackObjects : Array;

		public static function initialize(loadinfo : Object) : void {
			FlashApi.callbackObjects = new Array();
			FlashApi.lInfo = loadinfo;
			var conf : Object = new Object();
			var params : Object = FlashApi.lInfo.parameters;
			for (var i:String in FlashApi.__defaults) {
				if (params.hasOwnProperty(i)) {
					conf[i] = params.valueOf(i);
				} else {
					conf[i] = __defaults[i];
				}
			}
			FlashApi.conf = conf;
			if (FlashApi.conf.siteDom == "") {
				var lc : LocalConnection = new LocalConnection();
				FlashApi.conf.elcDom = FlashApi.conf.siteDom = (lc.domain == 'localhost' ? '' : lc.domain);
			}
			
			DojoExternalInterface.initialize(FlashApi.lInfo);
			DojoExternalInterface.addCallback("flashCall", FlashApi.flashCall);
			DojoExternalInterface.done();
		}

		/*
		 * Method that allows an outside class to be informed when some method
		 * is called upon FlashApi
		 */
		public static function addCallback(func : String, callbackfunc : Function) {
			FlashApi.callbackObjects.push({method:func, callbackfunc:callbackfunc})
		}

		/**
		 * This is our flash method dispatcher.  Any as methods that are exposed to
		 * the page js will be made available via flashCall.
		 * To call an as method from the page:
		 * 
		 * 		var resp = generic.flash.Api.flashCall(method, args);
		 * 		if (resp.success) {
		 * 			var data = resp.results;
		 * 		}
		 */
		public static function flashCall(method : String, ... args) : Object {
			FlashApi.console("debug", "flashCall method: "+method+" args: "+args);
			// There can be any number of args passed through here.  We use
			// the ... (rest) argument for passthrough.
			var results : Object;
			try {
				results = FlashApi[method].apply(FlashApi, args);
			} catch (e : Error) {
				// method doesn't exist so we've failed, no success:
				results = {success: 0, results: []};
			}
			
			/* Do the callbacks which were added with addCallback. 
			*  If no callbacks were added then nothing happens here
			*/
			for (var prop in FlashApi.callbackObjects) {
				try {
					if (FlashApi.callbackObjects[prop].method == method) {
						FlashApi.callbackObjects[prop].callbackfunc(args)
						results = {success: 1, results: []};
					} 
				} catch (e : Error) {
					// do nothing
				}
			}
			
			return results;
		}

		public static function getFlashConf(... args) : Object {
			return {success: 1, results: FlashApi.conf };
		}

		/**
		 * This is our js method dispatcher.  The methods exposed here can be found in the
		 * generic.flash.ApiMethods js class.  To call a js method from flash:
		 * 
		 * 		var resp:Object = FlashApi.jsCall(method, args);
		 * 		var data:* = resp.results;
		 * 		FlashApi.console("log", resp.success); //(true|false)
		 */
		public static function jsCall(method : String, ... args) : Object {
			// Once again, we dont know how many arguments are coming through, so
			// we just use a passthrough to keep things moving.
			try {
				var resp : Object = DojoExternalInterface.call("generic.flash.Api.jsCall", method, args);
			} catch (err : Error) {
				FlashApi.console("dir", err.message);
			} catch (err : SecurityError) {
				FlashApi.console("dir", err.message);
			}

			return resp;
		}
		
		

		/**
		 * Use in place of actionscripts built in trace() function.
		 * FlashApi.trace("tracing this call");  //("FLASH: tracing this call")
		 */
		public static function trace(txt : String) : void {
			DojoExternalInterface.trace(txt);
		}

		/**
		 * Use this to help debug your actionscript using the browser console.
		 * Accepts log, debug, and dir as console methods along with the message to output.
		 * 
		 * 		FlashApi.console("log", "Log this message");
		 * 		FlashApi.console("debug", "Message for debugging");
		 * 		FlashApi.console("dir", { foo:"bar", biz:"baz", message:"this is a message" });
		 * 
		 * Note: You can pass console.dir an actionscript object and it will traversed in the console.
		 */
		public static function console(cmeth : String, mess : *) : void {
			var method : String = "console." + cmeth;
			DojoExternalInterface.call(method, mess);
		}

		public function resourceurl(url : String) : String {
			if (url.indexOf('/') == 0) {
				return conf.elcDom + url;
			} else {
				return conf.elcDom + conf.moviePath + '/' + url;
			}
		}

		public function pageurl(url : String) : String {
			if (url.indexOf('/') == 0) {
				return conf.siteDom + url;
			}
			else {
				return conf.siteDom + conf.moviePath + '/' + url;
			}
		}
	}
}