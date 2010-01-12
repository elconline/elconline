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
package timber.transitions{
	import flash.events.Event;

	public class LoadViewTransitionEvent extends Event {

		/**
         * The name of the new LoadViewTransitionEvent type.
         */
		public static const LOAD:String = "LoadViewTransitionLoadEvent";
		public static const IN_START:String = "LoadViewTransitionInStartEvent";
		public static const IN_END:String = "LoadViewTransitionInEndEvent";
		public static const OUT_START:String = "LoadViewTransitionOutStartEvent";
		public static const OUT_END:String = "LoadViewTransitionOutEndEvent";
		//public static const REVEAL:String = "LoadViewTransitionOutEndEvent"; // redundant, just for backwards compatibility
		public static const IO_ERROR:String = "LoadViewTransitionIoErrorEvent";
		public static const SECURITY_ERROR:String = "LoadViewTransitionSecurityErrorEvent";
        
        /**
         * A text message that can be passed to an event handler
         * with this event object.
         */
        public var message:String;
        
        /**
         *  Constructor.
         *  @param message The text to display when the alarm goes off.
         */
        public function LoadViewTransitionEvent(message:String = "load view transition event")
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
	        return new LoadViewTransitionEvent(message);
	    }

	    /**
	     * Returns a String containing all the properties of the current
	     * instance.
	     * @return A string representation of the current instance.
	     */
	    public override function toString():String
	    {
	        return formatToString("LoadViewTransitionEvent", "type", "bubbles", "cancelable", "eventPhase", "message");
	    }
	}
}