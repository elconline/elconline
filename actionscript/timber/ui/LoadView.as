﻿/**	LoadView loads swf or jpeg (or png, and gif in flash 8) with progress indicators.		Also provides some handy things like size and scale adjustments.	Broadcasts an onLoad message when the asset is loaded.	@author Chandler McWilliams	@version 2006-02-16	@version 2007-04-26		@usage	<code>	</code>*/package timber.ui{	import flash.display.*;	import flash.net.URLRequest;	import flash.events.*;	import flash.errors.*;	import timber.util.SpriteUtil;	public class LoadView extends Sprite {		protected var _loader:Loader;		public var _img:MovieClip;		public var _progress:MovieClip;		protected var _theurl:String;		protected var _type:String;		protected var _resizeMax = false;		protected var _resizeCrop = false;		protected var _autoCenter:Boolean = false;				protected var _errors:Boolean = true;		private var _autoAdd:Boolean = true;		// ------------------------------------		// CONSTRUCROR		// ------------------------------------		public function LoadView () {			//trace("LoadView");						this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);						_loader = new Loader();			_loader.contentLoaderInfo.addEventListener(Event.OPEN, startHandler);			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);			_loader.contentLoaderInfo.addEventListener(Event.INIT, initHandler);			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);			_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityHandler);		};				// ------------------------------------		// ACCESSORS		// ------------------------------------				/**			Returns the _loader object, handy if you wish to yank out the bitmap data				@return String		*/		public function get loader():Loader { return _loader; };				/**			Returns the url of the content loaded by this clip				@return String		*/		public function get contentURL():String {			return _theurl;		};		/**			Returns true if the assets is wider than it is tall				@return Boolean		*/		public function isLandscape() {			return (contentWidth > contentHeight);		}		/**		Sets the width of the content		@param  val new width		@return void		*/		public function set contentWidth(value:Number):void {			if (_img) _img.width = value;		};		/**			Gets the width of the content				@return Number		*/		public function get contentWidth():Number {			if (_img) { return _img.width; } else { return 0; };			//(_img)?(return _img.width;):(return 0;); // odd that this does not work!		};		/**		Sets the height of the content		@param  val new height		@return void		*/		public function set contentHeight(value:Number):void {			if (_img) _img.height = value;		};		/**			Gets the height of the content				@return Number		*/		public function get contentHeight():Number {			if (_img) { return _img.height; } else { return 0; };			//(_img)?(return _img.height):(return 0); // odd that this does not work!		};		/**			Returns true if the asset is a swf.				@return Boolean		*/		public function isSWF():Boolean	{ return (_type.toLowerCase() == 'swf');	}			/**			Returns true if the asset is a jpg.				@return Boolean		*/		public function isJPG():Boolean	{ return (_type.toLowerCase() == 'jpg');	}		public function isJPEG():Boolean	{ return isJPG();	}			/**			Returns true if the asset is a gif.				@return Boolean		*/		public function isGIF():Boolean	{ return (_type.toLowerCase() == 'gif');	}			/**			Returns true if the asset is a png.				@return Boolean		*/		public function isPNG():Boolean	{ return (_type.toLowerCase() == 'png');	}				/**			Sets the progressClip setting.		*/		public function set progressClip(value:MovieClip):void {			_progress = value;		};		/**			Gets the progressClip setting.						@return MovieClip		*/		public function get progressClip():MovieClip {			return _progress;		};				/**			Sets the autoCenter setting.		*/		public function set autoCenter(value:Boolean):void {			_autoCenter = value;		};				/**			Gets the autoCenter setting.		*/		public function get autoCenter():Boolean {			return _autoCenter;		};				/**			Get the content clip						@return MovieClip		*/		public function get content():MovieClip {			return _img;		};				/**			Sets the trace alert settings.		*/		public function set errors(value:Boolean):void {			_errors = value;		};		/**			Gets the trace alert settings.						@return Boolean		*/		public function get errors():Boolean {			return _errors;		};				/**			Sets the value of the _autoAdd variable, really handy if you dont want img_mc to automatically load the image. Useful if you want to pull the bitmap data out of the loader.						@return Boolean		*/		public function set autoAdd (value:Boolean):void{			_autoAdd = value;		};				// ------------------------------------		// IMAGE MANIPULATION		// ------------------------------------				/**			Proportionally scales a movieclip to a max width and height.			Fits whichever is smaller.				@param  width Maximum width.			@param  height Maximum height.		*/		public function setMaxSize(width:Number, height:Number = NaN, scale_up:Boolean = false) {			//trace("LoadView: setMaxSize");						if (height <= 0) height = width;				var nw:Number, nh:Number, r:Number;			_resizeMax = [width, height, scale_up];			r = contentWidth/contentHeight;			nw = width;			nh = nw/r;			if (nh > height) {				nh = height;				nw = nh * r;			}			if (!scale_up) {				if (nw > contentWidth) return;				if (nh > contentHeight) return;			}				contentWidth=nw;			contentHeight=nh;		}		public function clearMaxSize() { _resizeMax = false; }				/**			Proportionally scales a movieclip to a max width and height.			Allows the overflow to stick out to be cropped.				@param  width Minimum width.			@param  height Minimum height.		*/		public function cropTo(width:Number, height:Number = NaN, scale_up:Boolean = false) {			trace("LoadView: cropTo");						if (height <= 0) height = width;				var nw:Number, nh:Number, r:Number;			_resizeCrop = [width, height, scale_up];						r = contentWidth/contentHeight;			nw = width;			nh = nw/r;			if (nh < height) {				nh = height;				nw = nh * r;			}			if (!scale_up) {				if (nw > contentWidth) return;				if (nh > contentHeight) return;			}			contentWidth=nw;			contentHeight=nh;		}		public function clearCrop() { _resizeCrop = false; }				/**			Sets the x and y scale.				@param  val new scale		*/		public function scaleTo(val:Number) {			trace("LoadView: scaleTo to "+val);						// if there is no reference to img_mc, create one			if ( (_autoAdd) && ((_img = SpriteUtil.exists(this, "img_mc")) == null) ) {				_img = new MovieClip();				addChild(_img);				_img.name = "img_mc"			};						_img.scaleX = val;			_img.scaleY = val;									/*if ( _img = SpriteUtil.exists(this, "img_mc") ) {							trace("img_mc exists");							_img.scaleX = val;							_img.scaleY = val;						} else {							trace("img_mc exists NOT!!!!!!");							contentWidth = val;							contentHeight = val;						};*/		}				/**			Centers the img_mc.			*/		public function centerContent (){			//trace("LoadView: centerContent");			if ( _img == SpriteUtil.exists(this, "img_mc") ) {				_img.x = 0 - (_img.width * .5)				_img.y = 0 - (_img.height * .5)			};		};				// ------------------------------------		// LOADING		// ------------------------------------		/**			Loads an asset into the clip.				@param  newurl URL of the asset		*/		public function load (newurl:String):void{			//trace("LoadView: load " + newurl);						// if there is no reference to img_mc, create one			if ( (_autoAdd) && ((_img = SpriteUtil.exists(this, "img_mc")) == null) ) {				_img = new MovieClip();				addChild(_img);				_img.name = "img_mc"			};						// clear old			unload();						// save new			_theurl = newurl;						// grab the extension			_type = newurl.substr(newurl.lastIndexOf('.')+1);						// center the progress if need be			if (_autoCenter) {				//centerContent();				// i am going to hide this for now, in as3 we dont really have the need to keep the				// progress clip within the same DisplayObject				/*if (progressClip) {					progressClip.x = 0;					progressClip.y = 0;				};*/			}						// load new			var request:URLRequest = new URLRequest(_theurl);			_loader.load(request);			if (_autoAdd) _img.addChild(_loader);					};				/**			Unloads existing assets from the clip		*/		public function unload ():void{			//trace("LoadView: unload");			_loader.unload();					};				// ------------------------------------		// EVENTS		// ------------------------------------				public function addedHandler (event:Event):void{			//trace("LoadView: addedHandler");						// if a progressClip has not been assigned, and we have a internal "progress_mc" clip, store it			if (!progressClip) {				_progress = SpriteUtil.exists(this, "progress_mc")			}								};				// ------------------------------------		// LOADER EVENTS		// ------------------------------------				protected function startHandler (event:Event):void{			//trace("LoadView: startHandler");						// reset and start progress animation			if (progressClip) {				progressClip.value = 0;				progressClip.startAnimation();			};		};				protected function completeHandler (event:Event):void{			trace("LoadView: completeHandler");						// stop progress animation			if (progressClip) progressClip.stopAnimation();		};				protected function initHandler (event:Event):void{			//trace("LoadView: initHandler");						// crop/resize as needed			if (_resizeCrop) {				cropTo(_resizeCrop[0], _resizeCrop[1], _resizeCrop[2]);			} else if (_resizeMax) {				setMaxSize(_resizeMax[0], _resizeMax[1], _resizeMax[2]);			}						// if need be call the method to center			if (autoCenter) centerContent();						// tell the world			var e:LoadViewEvent = new LoadViewEvent(LoadViewEvent.LOAD);			this.dispatchEvent(e);		};				protected function progressHandler (event:ProgressEvent):void{			//trace("LoadView: progressHandler");						// progress animation			if (progressClip) {				progressClip.total = event.bytesTotal;				progressClip.value = event.bytesLoaded;				progressClip.update();			};		};				protected function errorHandler (event:IOErrorEvent):void{			if (errors) trace("LoadView: errorHandler: !ERROR loading "+_theurl);			// tell the world			var e:LoadViewEvent = new LoadViewEvent(LoadViewEvent.IO_ERROR);			this.dispatchEvent(e);		};				protected function securityHandler (event:SecurityErrorEvent):void{			if (errors) trace("LoadView: securityHandler: !SECURITY  ERROR loading "+_theurl);						// tell the world			var e:LoadViewEvent = new LoadViewEvent(LoadViewEvent.SECURITY_ERROR);			this.dispatchEvent(e);		};	}}