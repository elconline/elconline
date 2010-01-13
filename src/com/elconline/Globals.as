package com.coresite {
	import flash.net.LocalConnection;

	/**
	 * @author nmouzann
	 */
	public class Globals 
	{
		
		public static var vars : Object = [];
		/**
		 * Determines the domain from which this SWF is executing to figure out root-relative vs FQDN JSON RPC URI.
		 */
		private static var _executing_domain:String;
		
		
		public function Globals() {
		}
		
		static public function get executing_domain() : String {
			_executing_domain = new LocalConnection( ).domain;
			if (_executing_domain == 'localhost'){_executing_domain = 'http://dev2.coresite.com';}
			else{
				_executing_domain = '';
			}	
			return _executing_domain;
		}
	}
}