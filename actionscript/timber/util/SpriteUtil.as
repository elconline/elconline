/**
	Constructs a 

	@author Matthew Richmond
	@version 2007-04-26


*/
package timber.util
{
	import flash.display.*;

	public class SpriteUtil
	{

		/**
		Checks to see if an named object exists within a specified location and if so returns that object.

		@param	obj	DisplayObjectContainer where you wish to look
		@param	value String name of object you are looking for
		@return	* If found, returns the object
		*/
		public static function exists(obj:DisplayObjectContainer, value:String):* {
			return (obj.getChildByName(value))?(obj.getChildByName(value)):(null);
		};
	}
}