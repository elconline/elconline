package timber.data{

	/**
	Provides simple class for basic XML loading, with standard errors and simplified events.

	@author Sarah Plowright
	@author Matthew Richmond
	@version 1.0b2
	@history 2007-03-07 Created by Sarah.
	@history 2007-05-19 Moved into Timber by Matthew, changed to be more in line with the as3 event model, cache feature added.

	@usage
		Essentially this class is a simplified way to use URLLoader.
		<code>
		
		import timber.data.*;
		import flash.events.*;
		
		public function XMLLoaderDemo ():void {
			trace("XMLLoaderDemo");
			
			var myData:XMLLoader = new XMLLoader();
			myData.addEventListener(XMLLoaderEvent.COMPLETE, completeHandler);
			myData.addEventListener(XMLLoaderEvent.ERROR, errorHandler);
			//myData.cache = false; //optional
			myData.load("_xml/myFile.xml");
		};
		
		public function completeHandler (event:Event):void{
			trace("completeHandler");

			trace(event.target.data);
		};
		
		public function errorHandler (event:Event):void{
			trace("XerrorHandler");
			
			trace(event.target.message);
		};
		
		</code>

	*/
	
	import flash.net.*;
	import flash.events.*;
	import flash.errors.*;
	
	public class XMLLoader extends EventDispatcher{

		private var _loader:URLLoader;
		private var _url:String;
		private var _data:XML;
		private var _message:String;
		
		private var _cache:Boolean = true;

		// ------------------------------------
		// CONSTRUCTOR
		// ------------------------------------

		public function XMLLoader (){
			//trace("XMLLoader");
			
			_loader = new URLLoader();
			_loader.dataFormat = URLLoaderDataFormat.TEXT;
			_loader.addEventListener(Event.COMPLETE, completeHandler);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);			
		};
		
		// ------------------------------------
		// ACCESSORS
		// ------------------------------------
		
		public function set data(value:XML):void { _data = value; };
		public function get data():XML { return _data; };
		
		public function set message(value:String):void { _message = value; };
		public function get message():String { return _message; };
		
		public function set cache(value:Boolean):void { _cache = value; };
		public function get cache():Boolean { return _cache; };
		
		// ------------------------------------
		// LOAD
		// ------------------------------------
		
		public function load (url:String):void{
			//trace("XMLLoader: load");
			
			_url = url;
			var u:String = url;
			
			// TODO: Test this a lot
			if (cache != true) {
				u = appendDateQuery(url);
			};
			
			var request:URLRequest = new URLRequest(u);
			_loader.load(request);
		};
		
		// ------------------------------------
		// UTILITY METHODS
		// ------------------------------------
		
		function appendDateQuery (value:String):String{
			trace("appendDateQuery");
					
			return value+"?"+new Date().getTime();
		};
		
		// ------------------------------------
		// EVENT METHODS
		// ------------------------------------
		
		private function completeHandler(event:Event):void{
			//trace("XMLLoader: completeHandler");
			
			try {
				// Convert downloaded text into XML instance
				data = new XML( event.target.data );
				
			} catch ( event:TypeError ) {
				// Downloaded text could not be converted to XML instance
				trace("!!! XMLLoader: "+ event.message);
				return;
			}
			
			var e:XMLLoaderEvent = new XMLLoaderEvent(XMLLoaderEvent.COMPLETE);
			this.dispatchEvent(e);
		}
		
		private function ioErrorHandler(event:Event):void{
			//trace("XMLLoader: ioErrorHandler");
			
			message = "!!! XMLLoader: IO ERROR loading "+ _url;
			
			var e:XMLLoaderEvent = new XMLLoaderEvent(XMLLoaderEvent.ERROR);
			this.dispatchEvent(e);
		}
		
		private function securityErrorHandler(event:Event):void{
			//trace("XMLLoader: securityErrorHandler");
			
			message = "!!! XMLLoader: SECURITY ERROR loading "+ _url;
			
			var e:XMLLoaderEvent = new XMLLoaderEvent(XMLLoaderEvent.ERROR);
			this.dispatchEvent(e);
		}

		// Disabled this handler, wasnt sure how useful it was for most needs
		/*	
		private function httpStatusHandler(event:HTTPStatusEvent):void{
			trace("XMLLoader: httpStatusHandler: status: " + event.status);
		}
		*/

	}
}