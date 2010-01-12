package timber.collection{
	
	/**
	Provides simple reverse iteration for arrays, XMLLists, objects, and anything implementing the IterableInterface.

	@author Chandler McWilliams
	@author Matthew Richmond
	@version 2.0b3
	@history 2005-11-11 Created - Chandler.
	@history 2007-05-04 Update for AS3 - Added XMLList compatability, accessors, cycle functionality -Matthew.
	@see IterableInterface
	
	@usage
		A while loop will return one full iteration through the collection
		<code>
		
		var looper:ReverseIterator = new ReverseIterator(myData);
		var item:Object
		while ( (item = looper.next() ) !== null ) {
			trace(looper.key() + " = " + item);
		};
		
		</code>
		<hr />
		Set cycle to true and you can use a for loop to endlessly iterate through the collection
		<code>
		
		var looper:ReverseIterator = new ReverseIterator(myData);
		looper.cycle = true;
		for ( var i=0; i<15; i++ ) {
			trace(looper.nextKey()+" = "+looper.next());
		};

		</code>

	*/

	public class ReverseIterator extends Iterator {

		public function ReverseIterator (value:*) {
			super(value);
			//trace("ReverseIterator");
		};
		
		// ------------------------------------
		// ITERATION METHODS
		// ------------------------------------
		
		override public function next ():Object{
			//trace("ReverseIterator: next");
			
			var n:Number = nextIndex ();
			if (n >= 0) {
				index = n;
				return itemAt(n);
			} else {
				return null;
			};
			
		};
		
		override public function previous ():Object{
			//trace("ReverseIterator: next");
			
			var n:Number = previousIndex ();
			if ( n < length) {
				index = n;
				return itemAt(n);
			} else {
				return null;
			};
		};
		
		// ------------------------------------
		// INDEX METHODS
		// ------------------------------------
		
		override public function reset ():void{
			//trace("ReverseIterator: reset");
			index = length;
		};
		
		override public function nextIndex ():int{
			//trace("ReverseIterator: nextIndex");
			
			if (cycle) {
				return ((index-1) < 0)?(length-1):(index-1);
			} else {
				return (index-1)
			};
			
		};
		
		override public function previousIndex ():int{
			//trace("ReverseIterator: previousIndex");
			return (cycle)?((index+1) % length):(index+1);
		};
		
	}
}