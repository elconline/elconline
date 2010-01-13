//============================================================================================
// 									DisplayObjectUtil CLASS
//============================================================================================/*
// 							Stephan Tanguay | Start Date FEB 21 2008
/*
	- Generic display tasks that get reused from package to package
*/

package com.coresite.utils {
	import flash.display.DisplayObjectContainer;

	
	
	public class DisplayObjectUtilities  {
		
		public static function removeAllChildren(container:DisplayObjectContainer):void 
		{
			var count:int = container.numChildren;
			for (var i:int = 0; i < count; i++)
			{
				container.removeChildAt(0);
			}
		}
	}
	
}