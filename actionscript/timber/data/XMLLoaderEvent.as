package timber.data{

	/**
	Constructs a 

	@author Sarah Plowright
	@version 2007-03-07

	@usage
	Activate with:
		<code>

		</code>

	*/
	
	import flash.events.Event;
    
    /**
     * This custom Event class adds a message property to a basic Event.
     */
    public class XMLLoaderEvent extends Event 
    {
        /**
         * The name of the new XMLLoaderEvent type.
         */
        public static const COMPLETE:String = "XMLLoaderCompleteEvent";
		public static const ERROR:String = "XMLLoaderErrorEvent";
        
        /**
         * A text message that can be passed to an event handler
         * with this event object.
         */
        public var message:String;
        
        /**
         *  Constructor.
         *  @param message The text to display when the alarm goes off.
         */
        public function XMLLoaderEvent(message:String = "XML loader event.")
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
	        return new XMLLoaderEvent(message);
	    }

	    /**
	     * Returns a String containing all the properties of the current
	     * instance.
	     * @return A string representation of the current instance.
	     */
	    public override function toString():String
	    {
	        return formatToString("XMLLoaderEvent", "type", "bubbles", "cancelable", "eventPhase", "message");
	    }

    }
}