/**
	ProgressIndicator class for showing a tasks progress. Most comonly used in conjunction with the
	{@link LoadView} object to show the loading of LoadView


	@author Chandler McWilliams
	@version 1.0
	@version 2005-06-06

*/
package timber.ui
{ 	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class ProgressIndicator extends MovieClip
	{
		
		protected var _total:Number;
		protected var _loaded:Number;
		
		public function ProgressIndicator() {
			hide();
		}
		
		/**
			Starts progress display in response to Event.OPEN events

			@param  e Event
			@return (void) 
		*/
		public function startHandler(e:Event) {
				value = 0;
				startAnimation();
		}


		/**
			Stops progress display in response to Event.COMPLETE events

			@param  e Event
			@return (void) 
		*/
		public function completeHandler(event:Event):void {
			stopAnimation();
		}


		/**
			Updates progress display in response to ProgressEvent.PROGRESS events

			@param  e Event
			@return (void) 
		*/
		public function progressHandler(event:ProgressEvent):void {
			total	= event.bytesTotal;
			value	= event.bytesLoaded;
			update();
		}

		
	/**
		Starts the animation of an indeterminate progress indicator.
		Does nothing for determinate indicators.
		
		@return (void)
	*/
		public function startAnimation():void {
			show();
			if (isIndeterminate) gotoAndPlay(1);
		}
	
	
	
	/**
		Stops the animation of an indeterminate progress indicator.
		Does nothing for determinate indicators.

		@return (void)
	*/
		public function stopAnimation():void {
			hide();
			gotoAndStop(1);
		}
	
	
	/**
		Called when new data is loaded.

		@return (void)
	*/
		public function update():void {
			// if determinate, 
			// update by going to the right frame in the animation
			// treats the animation as a scale from 0 to 100%
			if (!isIndeterminate) {
				gotoAndStop(Math.round(totalFrames * value/total));
			}
		}
	
	/**
		Move one step forward

		@return (void)
	*/
		public function step():void {
			value += 1;
			update();
		}

	/**
		Displays the progress bar. Normally used for determinate indicators, indeterminate indicators
		show/hide themselves automatically.

		@return (void)
	*/
		public function show():void {
			visible = true;
		}
	
	/**
		hides the progress bar. Normally used for determinate indicators, indeterminate indicators
		show/hide themselves automatically.

		@return (void)
	*/
		public function hide():void {
			visible = false;
		}
		
			
	// ===========================================================
	// - ACCESSORS
	// ===========================================================
	/**

		Returns a boolean value if the preloader is determinate.
	
		Determinate preloaders display the amount of content loaded. Indeterminate
		preloaders are just animations that play while the content loads.

		@return (Bool) If the preloader is determinate or not.
	*/
		public function get isIndeterminate():Boolean {
			return true;
		}
	

	/**
		Sets the total value for the indicator.
		Ignored by indeterminate indicators.
		
		@param newtotal Total value of indicator.
	*/
		public function set total(val:Number):void {
			_total = val;
		}
	
	/**
		Gets the total value for the indicator.
		
		@return (Number) Total value of indicator.
	*/
		public function get total():Number {
			return _total;
		}
	
	
	/**
		Sets the current value for the indicator.
		Ignored by indeterminate indicators.
		
		@param newvalue Current value of indicator.
	*/
		public function set value(val:Number):void {
			_loaded = val;
		}
	
	/**
		Gets the current value for the indicator.
		
		@return (Number) Current value of indicator.
	*/
		public function get value():Number {
			return _loaded;
		}
	
	/**
		Gets the percent complete for the indicator.
		
		@return (Number) percent complete of indicator.
	*/
		public function get percent():Number {
			return 100*value/total;
		}

	/**
		Gets the percent complete for the indicator as a float.
		
		@return (Number) percent complete of indicator as a float.
	*/
		public function get percentAsFloat():Number {
			return value/total;
		}

	}
}