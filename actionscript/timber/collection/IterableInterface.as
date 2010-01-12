package timber.collection{
	
	/**
	Basic class interface that is iterable using timber.collection.Iterator

	@author Chandler McWilliams
	@version 2007-05-02

	@usage

	- Activate with:
	<code>

	</code>
	
	*/

	public interface IterableInterface {
		
		// get the length
		function get length():uint;
		
		// return the current item
		function itemAt (value:uint):Object;
	
		// tell it you are iterable
		function isIterable():Boolean;
		
	}
}