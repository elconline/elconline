package com.coresite.events {
	import flash.events.Event;
	
	public class SectionEvent extends Event {
		
		public static const PREVIOUS_SECTION:String  		= "previewsection";
		public static const SECTION_CHANGE:String  		= "sectionchange";
		private var _id:int;
		
		public function SectionEvent (type:String) {
			super(type);
		}
		
		public function get id ():int {
			return _id;
		}
		
		public function set id (id:int):void {
		 _id = id;
		}
	}
}