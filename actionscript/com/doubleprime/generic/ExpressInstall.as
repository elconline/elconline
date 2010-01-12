/**
 * File: com.doubleprime.generic.ExpressInstall  v0.0.2
 * Auth: Anthony Decena
 * Desc: This is an AS3 port of the ExpressInstall class also packaged with
 * 		 the dojo 1.1.0 release.  Use this to invoke Express Install functionality
 * 		 for Flash Media Player.
 * 
 * 		*** Express Install requires that your flash movie be at least 214 x 137
 */
package com.doubleprime.generic {
	
	/**
	* Usage:
	* 			var ExpressInstall = new ExpressInstall();
	* 
	* 			// test to see if install is needed:
	* 			if (ExpressInstall.needsUpdate) { // returns true if update is needed
	* 				ExpressInstall.init(); // starts the update
	* 			}
	 */
	import flash.events.Event;	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.system.Security;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
//	import mx.core.Application;
	
	
	public class ExpressInstall extends Sprite {
		public var needsUpdate:Boolean;
		public var lInfo:Object;
		private var updater:MovieClip;
		private var hold:MovieClip;
		
		public function ExpressInstall(loadinfo:Object) {
			lInfo = loadinfo;
			this.needsUpdate = (lInfo.parameters.MMplayerType == undefined) ? false : true;
		}
		
		public function init():void {
			this.loadUpdater();
		}

		public function loadUpdater():void {
			Security.allowDomain("fpdownload.macromedia.com");

			// hope that nothing is at a depth of 10000000, you can change this depth if needed, but you want
			// it to be on top of your content if you have any stuff on the first frame
			var updater:MovieClip = new MovieClip();
			stage.addChild(updater);
			this.updater = updater;

			// register the callback so we know if they cancel or there is an error
			var _self:ExpressInstall = this;
			this.updater.installStatus = onInstallStatus("Message Test");
			var hold:MovieClip = new MovieClip();
			updater.addChild(hold);
			this.hold = hold;

			// can't use movieClipLoader because it has to work in 6.0.65
			this.updater.addEventListener(Event.ENTER_FRAME, onEnterFrameUpdate);
			

			var cacheBuster:Number = Math.random();

			var l:Loader = new Loader();
			this.hold.addChild(l);
			l.load(new URLRequest("http://fpdownload.macromedia.com/pub/flashplayer/"
													+"update/current/swf/autoUpdater.swf?"+ cacheBuster));
		}
		
		private function onEnterFrameUpdate(event : Event) : void {
				if (typeof this.hold.startUpdate == 'function') {
					var _self:ExpressInstall = this;
					_self.initUpdater();
					this.updater.removeEventListener(Event.ENTER_FRAME, onEnterFrameUpdate);
				}
			}
		

		
		
		private function initUpdater():void {
// nabil commented out -
//			this.hold.redirectURL = Application.application.parameters.MMredirectURL;
//			this.hold.MMplayerType = Application.application.parameters.MMplayerType;
///			this.hold.MMdoctitle = Application.application.parameters.MMdoctitle;
//			this.hold.startUpdate();
		}

		public function onInstallStatus(msg:String):void {
			var req:URLRequest = new URLRequest("javascript:dojox.flash.install._onInstallStatus('"+msg+"')");
			navigateToURL(req);
		}
		
		
		
		
	}
	
}