package timber.collection{

	/**
	Provides simple iteration for arrays, XMLLists, objects, and anything implementing the IterableInterface.

	@author Chandler McWilliams
	@author Matthew Richmond
	@version 2.0b3
	@history 2005-11-11 Created - Chandler.
	@history 2007-05-04 Update for AS3 - Added XMLList compatability, accessors, cycle functionality -Matthew.
	@see IterableInterface
	
	@usage
		A while loop will return one full iteration through the collection
		<code>
		
		var looper:Iterator = new Iterator(myData);
		var item:Object
		while ( (item = looper.next() ) !== null ) {
			trace(looper.key() + " = " + item);
		};
		
		</code>
		<hr />
		Set cycle to true and you can use a for loop to endlessly iterate through the collection
		<code>
		
		var looper:Iterator = new Iterator(myData);
		looper.cycle = true;
		for ( var i=0; i<15; i++ ) {
			trace(looper.nextKey()+" = "+looper.next());
		};

		</code>

	*/
	
	public class Iterator {

		private var _collection:Object;
		protected var _index:int = 0;
		private var _type:String;
		private var _length:int;
		protected var _cycle:Boolean = false;
		
		// ------------------------------------
		// CONSTRUCTOR
		// ------------------------------------
		
		public function Iterator (value:*) {
			//trace("Iterator");
			
			collection = value;
			
			// check for type
			switch ( true ) {
				case (value is Array):
					type = "array";
					length = collection.length;
					break;
				case (value is XMLList):
					type = "xml";
					length = collection.length();
					break;
				case (value.isIterable && value.isIterable()):
					type = "iterable";
					length = collection.length;
					break;
				default:
					type = 'object';
					length = 10;
					break;
			}
			
			// reset index (will reference type)
			reset ();
			
			
		};
		
		// ------------------------------------
		// ACCESORS
		// ------------------------------------
		
		public function set collection(value:Object):void { _collection = value; };
		public function get collection():Object { return _collection; };
		
		public function set index(value:int):void { _index = value; };
		public function get index():int { return _index; };
		
		public function set type(value:String):void { _type = value; };
		public function get type():String { return _type; };
		
		public function set length(value:int):void { _length = value; };
		public function get length():int { return _length; };
		
		public function set cycle(value:Boolean):void {_cycle = value;};
		public function get cycle():Boolean { return _cycle; };
		
		// ------------------------------------
		// ITERATION METHODS
		// ------------------------------------
		
		public function next ():Object{
			//trace("Iterator: next");
			var n:Number = nextIndex ();
			if ( n < length) {
				index = n;
				return itemAt(n);
			} else {
				return null;
			}
		};
		
		public function current ():Object{
			//trace("Iterator: current");
			return itemAt(index);
		};
		
		public function previous ():Object{
			//trace("Iterator: previous");
			var n:Number = previousIndex ();
			if ( n >= 0) {
				index = n;
				return itemAt(n);
			} else {
				return null;
			}
		};
		
		/**
		Alias for previous
		*/
		public function prev ():Object{
			return previous ();
		};
		
		// ------------------------------------
		// INDEX METHODS
		// ------------------------------------
		
		public function rewind ():void{ reset (); };
		public function reset ():void{
			//trace("Iterator: reset");
			index = -1;
		};
				
		public function nextIndex ():int{
			//trace("Iterator: nextIndex");
			return (cycle)?((index+1) % length):(index+1);
		};
		
		public function previousIndex ():int{
			//trace("Iterator: previousIndex");
			if (cycle) {
				return ((index-1) < 0)?(length-1):(index-1);
			} else {
				return (index-1)
			};
		};
		
		// ------------------------------------
		// KEY METHODS
		// ------------------------------------
		
		public function key ():int{ return currentKey (); };
		public function currentKey ():int{
			//trace("Iterator: currentKey");
			return keyAt ( index );
		};
		
		public function nextKey ():int{
			//trace("Iterator: currentKey");
			return keyAt ( nextIndex () );
		};
		
		public function prevKey ():int{ return previousKey (); };
		public function previousKey ():int{
			//trace("Iterator: currentKey");
			return keyAt ( previousIndex () );
		};
		
		// ------------------------------------
		// KEY ACCESS
		// ------------------------------------
		
		public function keyAt (value:int):Number{
			//trace("Iterator: keyAt");
			return value;
		};
			
		// ------------------------------------
		// ITEM ACCESS
		// ------------------------------------
		
		public function itemAt (value:int):Object{
			//trace("Iterator: itemAt "+ value);
			switch ( type ) {
				case "iterable":
					return collection.itemAt(value);
					break;
				default:
					return collection[value];
					break;
			};
		};
		
		// ------------------------------------
		// TYPE METHODS
		// ------------------------------------
		
		// not sure if we need these anymore, the class is not using them internally
		
		public function isIterable() {
			return (type == 'iterable');
		};
	
		public function isObject() {
			return (type == 'object');
		};
	
		public function isArray() {
			return (type == 'array');
		};
	
		public function isXML() {
			return (type == 'xml');
		};
	}
}