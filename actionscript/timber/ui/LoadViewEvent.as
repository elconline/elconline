/**
	Constructs a 

	@author Matthew Richmond
	@version 2007-04-30
	@copyright (c) 2007 The Chopping Block, Inc.. All rights reserved.

	@usage

	- Activate with:
	<code>

	</code>

*/
package timber.ui{
	import flash.events.Event;

	public class LoadViewEvent extends Event {

		/**
         * The name of the new LoadViewEvent type.
         */
        public static const LOAD:String = "LoadViewLoadEvent";
		public static const IO_ERROR:String = "LoadViewIoErrorEvent";
		public static const SECURITY_ERROR:String = "LoadViewSecurityErrorEvent";
        
        /**
         * A text message that can be passed to an event handler
         * with this event object.
         */
        public var message:String;
        
        /**
         *  Constructor.
         *  @param message The text to display when the alarm goes off.
         */
        public function LoadViewEvent(message:String = "load view event")
        {
            super(message);
            this.message = message;
        }

		/**
	     * Creates and returns a copy of the current instance.
	     * @return A copy of the current instance.
	     */
	    public override function clone():Event
	    {
	        return new LoadViewEvent(message);
	    }

	    /**
	     * Returns a String containing all the properties of the current
	     * instance.
	     * @return A string representation of the current instance.
	     */
	    public override function toString():String
	    {
	        return formatToString("LoadViewEvent", "type", "bubbles", "cancelable", "eventPhase", "message");
	    }
	}
}