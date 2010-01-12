package timber.collection{

	/**
	Provides simple non-repeating random iteration for arrays, XMLLists, objects, and anything implementing the IterableInterface.
	
	@author Chandler McWilliams
	@author Matthew Richmond
	@version 2.0b3
	@history 2005-11-11 Created - Chandler.
	@history 2007-05-04 Update for AS3 - Added XMLList compatability, accessors, cycle functionality -Matthew.
	@see IterableInterface
	
	@usage
		A while loop will return one full iteration through the collection
		<code>
		
		var looper:RandomIterator = new RandomIterator(myData);
		var item:Object
		while ( (item = looper.next() ) !== null ) {
			trace(looper.key() + " = " + item);
		};
		
		</code>
		<hr />
		Set cycle to true and you can use a for loop to endlessly iterate through the collection
		<code>
		
		var looper:RandomIterator = new RandomIterator(myData);
		looper.cycle = true;
		for ( var i=0; i<15; i++ ) {
			trace(looper.nextKey()+" = "+looper.next());
		};

		</code>

	*/

	public class RandomIterator extends Iterator {

		private var _rnditems:Array;

		public function RandomIterator (value:*) {
			super(value);
			//trace("RandomIterator");
		};
				
		// ------------------------------------
		// INDEX METHODS
		// ------------------------------------
		
		override public function reset ():void{
			super.reset();
			randomize ();
		};
		
		public function randomize ():void{
			//trace("RandomIterator: randomize");
			
			// if we need to cycle lets make sure we dont start the same one we ended with
			if (_rnditems) {
				var endnum:Number = _rnditems[(length-1)]
				//trace("endnum is: "+endnum);
			}
			// clean out our shuffled array of numbers 
			_rnditems = new Array;
			// build a new array of numbers
			var a:Array = new Array;
			for (var i=0; i<length; i++) {
				a[i] = i;
			}
			// randomly pick from our new array and push to shuffled array
			for (var i=0; i<length; i++) {
				var n:Number;
				
				// if we are going to cycle, 
				if ( (length > 1) && ( endnum > -1 ) && (i==0)) {
					do { 
						n = Math.floor(Math.random() * a.length)
					} while ( Number(n) === Number(endnum) );
				} else {
					n = Math.floor(Math.random() * a.length);
				};
				
				var c:Number = a[n];
				a.splice(n, 1);
				_rnditems.push(c);
			};
		};
	
		override public function nextIndex ():int{
			//trace("RandomIterator: nextIndex");

			var n:Number;
				
			if (cycle) {
				n = (index+1) % length;
				if (n == 0) randomize ();
			} else {
				n = (index+1);
			}

			return n			
		};
		
		override public function previousIndex ():int{
			//trace("RandomIterator: previousIndex");
			return nextIndex ();	
		};
		// ------------------------------------
		// KEY ACCESS
		// ------------------------------------
		
		override public function keyAt (value:int):Number{
			//trace("Iterator: keyAt");
			return _rnditems[value];
		};
		
		// ------------------------------------
		// ITEM ACCESS
		// ------------------------------------
		
		override public function itemAt (value:int):Object{
			//trace("RandomIterator: itemAt");
			
			switch ( type ) {
				case "iterable":
					return collection.itemAt( _rnditems[value] );
					break;
				default:
					return collection[ _rnditems[value] ];
					break;
			};
		};
	}
}