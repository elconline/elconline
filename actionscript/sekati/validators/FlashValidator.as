/** * sekati.validators.FlashValidator * @version 1.1.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.validators {	import flash.system.System;		import flash.system.Capabilities;	/**	 * FlashValidator provides introspective validation of playback type, version & mode.	 */	public class FlashValidator {		/**		 * Retrieve the FlashPlayer Version the application is running under.		 */		public static const FLASHPLAYER_VERSION : String = Capabilities.version;		/**		 * Retrieve the ActionScript Virtual Machine Version the application is running under.		 */		public static const AVM_VERSION : String = System.vmVersion;		/**		 * Retrieve the FlashPlayers Localized Language Code.		 * 		 * <p>e.g. <code>cs,da,nl,en,fi,fr,de,hu,it,ja,ko,no,xu,pl,pt,ru,zh-CN,es,sv,zh-TW,tr</code></p>.		 */		public static const LANGUAGE : String = Capabilities.language;		/**		 * Returns <code>true</code> if client flashplayer is >= the min version.		 */		public static function isMinVersion(minVersion : Number) : Boolean {			if (Number( Capabilities.version.split( " " )[1].split( "," )[0] ) >= minVersion) {				return true;			}			return false;		}		/**		 * Returns <code>true</code> if the client flashplayer supports fullscreen mode (>=9.0.28).		 */		public static function get hasFullscreenMode() : Boolean {			var v : Array = Capabilities.version.split( " " )[1].split( "," );			var major : Number = Number( v[0] );			var minor : Number = Number( v[1] );			var sub : Number = Number( v[2] );			if (major > 9) { 				return true;			} else if (major < 9) {				return false;				}			if ((minor == 0 && sub >= 28) || minor > 0) {				return true;				} else {				return false;			}		}		/**		 * Returns a player and environment info string.		 */		public static function get playerInfo() : String {			var debugger : String = (Capabilities.isDebugger) ? ' / Debugger' : '';			var info : String = String( "Flash Platform: " + FLASHPLAYER_VERSION + " / " + Capabilities.playerType + debugger + " / " + Capabilities.os + " / " + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY );			return info;		}			/**		 * Returns <code>true</code> is the swf is being previewed by the external debug player.		 */		public static function get isPreview() : Boolean {			return (Capabilities.playerType == "External") && Capabilities.isDebugger;		}					/**		 * Returns <code>true</code> is the swf is being viewed by the external player or in test mode.		 */		public static function get isExternal() : Boolean {			return (Capabilities.playerType == "External");		}			/**		 * Returns <code>true</code> is the swf is being viewed in the debug player.		 */		public static function get isDebugger() : Boolean {			return Capabilities.isDebugger;		}		/**		 * Returns <code>true</code> is the swf is being viewed in the standalone player.		 */		public static function get isStandAlone() : Boolean {			return (Capabilities.playerType == "StandAlone");		}		/**		 * Returns <code>true</code> is the swf is being viewed in a browser.		 */		public static function get isBrowser() : Boolean {			return (Capabilities.playerType == "PlugIn" || Capabilities.playerType == "ActiveX");		}				/**		 * FlashValidator Static Constructor		 */		public function FlashValidator() {			throw new Error( "FlashValidator is a static class and cannot be instantiated." );		}	}}