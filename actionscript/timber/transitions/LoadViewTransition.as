package timber.transitions{

	/**
	Constructs a 

	@author Matthew Richmond
	@version 2007-05-17
	@copyright (c) 2007 The Chopping Block, Inc.. All rights reserved.

	@usage
	Activate with:
		<code>

		</code>

	*/

	import flash.display.*;
	import flash.events.*;
	import timber.ui.*;

	public class LoadViewTransition extends Sprite {

		private var _view:LoadView; //most recent image
		private var _nextPath:String //next path;
		protected var _count:Number = 0;
		private var _showCount:int = 2;
		private var _viewArray:Array;
		
		private var _currentView:Sprite;
		private var _prevView:Sprite;
		
		protected var _progress:MovieClip;
		protected var _autoCenter:Boolean = false;
		
		private var _locked:Boolean = false;
		private var _queue:String;
		
		private var _autoAdd:Boolean = true;

		// ------------------------------------
		// CONSTRUCTOR
		// ------------------------------------

		public function LoadViewTransition () {
			//trace("LoadViewTransition");
			
			_viewArray = new Array();
		};
		
		// ------------------------------------
		// ACCESSORS
		// ------------------------------------
		
		public function set view(value:LoadView):void { _view = value; };
		public function get view():LoadView { return _view; };
		
		public function set currentView(value:Sprite):void { _currentView = value; };
		public function get currentView():Sprite { return _currentView; };
		
		public function set prevView(value:Sprite):void { _prevView = value; };
		public function get prevView():Sprite { return _prevView; };
		
		/**
			Set and get the showCount value.
		*/
		public function set showCount(value:int):void { _showCount = value; };
		public function get showCount():int { return _showCount; };
		
		/**
			Sets the progressClip setting.
		*/
		public function set progressClip(value:MovieClip):void {
			_progress = value;
		};

		/**
			Sets the autoCenter setting.
		*/
		public function set autoCenter(value:Boolean):void {
			_autoCenter = value;
		};
		
		/**
			Sets the value of the _autoAdd variable, really handy if you dont want img_mc to automatically load the image. Useful if you want to pull the bitmap data out of the loader.
			
			@return Boolean
		*/
		public function set autoAdd (value:Boolean):void{
			_autoAdd = value;
		};
		
		private function set locked(value:Boolean):void { _locked = value; };
		private function get locked():Boolean { return _locked; };
		
		// ------------------------------------
		// CLASS METHODS
		// ------------------------------------
		
		/**
		Creates a new instance of the LoadView class, passes in all the local classes, pushes it into an array and loads the requested image

		@param value	path to image
		*/
		public function load (value:String, scale:Number = NaN, offsetY:Number = 0):void{
			//trace("LoadViewTransition: load for "+value);
			
			if (locked) {
				_queue = value;

			} else {
				locked = true;
			
				// create our new LoadView
				view = new LoadView();
				view.progressClip = _progress;
				view.autoCenter = _autoCenter;
				view.name = "view"+_count+"_mc";
				view.autoAdd = _autoAdd;
				
				// optional attribute scale
				if (scale) {
					view.scaleTo(scale);
				}
				
				// optional param offsetY
				view.y = offsetY;
			
				view.addEventListener(LoadViewEvent.LOAD, loadHandler);
				view.addEventListener(LoadViewEvent.IO_ERROR, errorHandler);
				view.addEventListener(LoadViewEvent.SECURITY_ERROR, securityHandler);
			
				// [PRE TRANSITION IN] TRANSITION_IN -> LOAD -> TRANSITION_OUT -> VIEW
				
				// update path and array
				_nextPath = value;
				_viewArray.push( {loadview:view} );
				
				// User might want to fire a transition before they start the in Animation
				if (currentView) {
					preTransitionIn ();
				} else {
					preTransitionInComplete();
				}
				
			};
		};
		
		final protected function preTransitionInComplete ():void{
			//trace("LoadViewTransition: preTransitionInComplete");
			
			dispatchInStart ();
			transitionInStart();
		};
		
		final protected function transitionInComplete ():void{
			//trace("LoadViewTransition: transitionInComplete");
			
			// call our transition in end dispatch
			//trace("---> IN END");
			dispatchInEnd();
			
			view.load(_nextPath); // this goes before createCurrentView on the off chance you want to check to see what type of media is loading
		
			var s:Sprite = createCurrentView (view);
			updateViewArray(s);
			//addChild(s) // dont add it here, we add it within the method that gets extended
		
			_count++;
		};
		
		private function updateViewArray (s:Sprite):void{
			//trace("LoadViewTransition: updateViewArray");
			
			// append the sprite to the last object in the array
			var n:int = _viewArray.length;
			_viewArray[(n -1)].sprite = s;
			
			// store a reference to the current sprite
			currentView = s;
			
			// if we have enough, store a reference to the previous sprite
			if (_viewArray.length > 1) {
				prevView = _viewArray[ _viewArray.length - 2].sprite;
			}
		};
		
		final private function reveal ():void{
			//trace("LoadViewTransition: reveal");
			
			var mc:Sprite = _viewArray[_viewArray.length - 1].sprite;
			//trace("---> OUT IN");
			dispatchOutStart();
			revealCurrentView(mc);
		};
		
		final protected function revealComplete ():void{
			//trace("LoadViewTransition: revealComplete");
			
			purge ();
		};
		
		
		/**
		Removes the instances of LoadView that we no longer need
		*/
		final private function purge (){
			//trace("LoadViewTransition: purge");
		
			//trace("_viewArray is: "+_viewArray);
		
			var overflow:Number = _viewArray.length - showCount;
		
			if (overflow > 0) {
			
				// remove any (and all) overflow
				for ( var i=0; i<overflow; i++ ) {
					var mc:Sprite = _viewArray[i].sprite;

					_viewArray[i].loadview.unload();
					//trace("typeof mc is: "+typeof mc);
					removeChild(mc);
				};
			
				// update array
				var a:Array = _viewArray.splice( showCount * -1 );
				_viewArray = a;
			}
			
			// then we are done
			loadComplete ();
		};
		
		private function loadComplete ():void{
			//trace("LoadViewTransition: loadComplete");

			locked = false; // we can unlock the load now
			//trace("---> OUT END");
			dispatchOutEnd(); // broadcast that the image is visible

			checkQueue ();
		};
		
		/**
		If requests are outstanding we will load the latest
		*/
		private function checkQueue ():void{
			//trace("LoadViewTransition: checkQueue");
			
			if (_queue ) {
				load(_queue);
				_queue = null;
			};
		};
		
		// ------------------------------------
		// TRANSITION CLASS METHODS
		// ------------------------------------
		
		/**
		Extend this method if you want a transition or animation BEFORE the in  transition, just call preTransitionInComplete when ready.
		
		*/
		public function preTransitionIn ():void{
			//trace("LoadViewTransition: preTransitionIn");
			
			preTransitionInComplete();
		};
				
		/**
		Extend this method to add a transition for the In, just call transitionInComplete when ready.

		@param	mc Sprite of new clip
		*/
		public function transitionInStart ():void{
			//trace("LoadViewTransition: transitionInStart");
			
			transitionInComplete();
		};
		
		/**
		Extend this method to set the initial properties of the newly created clip

		@param	mc Sprite of new clip
		*/
		public function createCurrentView (mc:LoadView):Sprite{
			//trace("LoadViewTransition: createCurrentView");
			
			mc.alpha = 0;
			addChild(mc);
			
			return mc;
		};
		
		/**
		Extend this method to set the reveal properties of the newly created clip

		@param	mc Sprite of new clip
		*/
		public function revealCurrentView (mc:Sprite):void{
			//trace("LoadViewTransition: revealCurrentView");
			
			mc.alpha = 1;
			revealComplete();
		};
		
		// ------------------------------------
		// DISPATCH METHODS
		// ------------------------------------

		final private function dispatchInStart ():void{
			//trace("LoadViewTransition: dispatchInStart");
			
			// tell the world
			var e:LoadViewTransitionEvent = new LoadViewTransitionEvent(LoadViewTransitionEvent.IN_START);
			dispatchEvent(e);
		};
		
		final private function dispatchInEnd ():void{
			//trace("LoadViewTransition: dispatchInEnd");
			
			// tell the world
			var e:LoadViewTransitionEvent = new LoadViewTransitionEvent(LoadViewTransitionEvent.IN_END);
			this.dispatchEvent(e);
		};
	
		final private function dispatchOutStart ():void{
			//trace("LoadViewTransition: dispatchOutStart");
			
			// tell the world
			var e:LoadViewTransitionEvent = new LoadViewTransitionEvent(LoadViewTransitionEvent.OUT_START);
			this.dispatchEvent(e);

		};
		
		final private function dispatchOutEnd ():void{
			//trace("LoadViewTransition: dispatchOutEnd");
			
			// tell the world
			var e:LoadViewTransitionEvent = new LoadViewTransitionEvent(LoadViewTransitionEvent.OUT_END);
			this.dispatchEvent(e);
		};


		// ------------------------------------
		// LOADER EVENTS
		// ------------------------------------

		final private function loadHandler (event:Event):void{
			//trace("LoadViewTransition: loadHandler");
			
			reveal ();
			
			// tell the world
			var e:LoadViewTransitionEvent = new LoadViewTransitionEvent(LoadViewTransitionEvent.LOAD);
			this.dispatchEvent(e);
		};

		final private function errorHandler (event:Event):void{
			//trace("LoadViewTransition: errorHandler");
			
			locked = false; // we can unlock the load now
			checkQueue ();
			
			// tell the world
			var e:LoadViewTransitionEvent = new LoadViewTransitionEvent(LoadViewTransitionEvent.IO_ERROR);
			this.dispatchEvent(e);
		};

		final private function securityHandler (event:Event):void{
			//trace("LoadViewTransition: errorHandler");
			
			locked = false; // we can unlock the load now
			checkQueue ();
			
			// tell the world
			var e:LoadViewTransitionEvent = new LoadViewTransitionEvent(LoadViewTransitionEvent.SECURITY_ERROR);
			this.dispatchEvent(e);
		};
	}
}