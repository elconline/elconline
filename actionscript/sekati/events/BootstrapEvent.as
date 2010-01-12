/** * sekati.events.BootstrapEvent * @version 1.0.5 * @author jason m horwitz | sekati.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.events {	import flash.events.Event;	/**	 * Application BootstrapEvent's fired during the bootstrapping process of Sekati API.	 * @see sekati.core.Bootstrap	 */	public class BootstrapEvent extends Event {				/**		 * @eventType onAppReady		 * Indicates the application has loaded successfully.		 */		public static const APP_LOAD : String = "onAppLoad";		/**		 * @eventType onLoadAppConfiguration 		 * Indicates the application configuration file has loaded successfully.		 */		public static const APP_CONFIG : String = "onLoadAppConfiguration";				/**		 * @eventType onLoadAppData 		 * Indicates the application data has loaded successfully.		 */		public static const APP_DATA : String = "onLoadAppData";				/**		 * @eventType onLoadAppStyles		 * Indicates the application stylesheet has loaded successfully.		 */		public static const APP_STYLE : String = "onLoadAppStyles";				/**		 * @eventType onAppInit		 * Indicates the application has successfully initialized.		 */				public static const APP_INIT : String = "onAppInit";				/**		 * @eventType onAppFailure		 * Indicates the application has <i>failed</i> to initialize.		 */		public static const APP_FAIL : String = "onAppFailure";		/**		 * BootstrapEvent Constructor		 */		public function BootstrapEvent(type : String, bubbles : Boolean = true, cancelable : Boolean = false) {			super( type, bubbles, cancelable );		}		/**		 * @inheritDoc		 */		public override function clone() : Event {				return new BootstrapEvent( type, bubbles, cancelable );			}	}}