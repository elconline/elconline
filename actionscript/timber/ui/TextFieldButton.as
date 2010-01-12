package timber.ui{ 
	/**
		Constructs a TextField and invis MovieClip based button inside a new clip in a specified location
	
		@author Matthew Richmond
		@version 2006-05-21
	
		@usage
	
		- Activate with:
		<code>
		
			// make a set of buttons
			var links = new Array();
			links = ["Huzzah", "Pico", "Taco", "Burrito", "Photo"]
	
			var xpos = 50;
	
			for ( var i=0; i<links.length; i++ ) {
		
				var foo:TextFieldButton = new TextFieldButton(this);
				foo.setFontSymbol("Interstate_fnt");
				foo.setFontSize (14)
				foo.setBaseColor (0xFF6600)
				foo.setHoverColor (0x00000)
				foo.create(links[i]);
		
				foo.setX(xpos);
				foo.setY(150);
				foo.id = i;
		
				xpos += (foo.getWidth() + 20);
		
				var ears = {onRelease: function(id) { trace("Done Biznitch! for thing "+id);}}
				foo.addListener(ears)
			};
	
			// make just one button
			var bar:TextFieldButton = new TextFieldButton(this);
			bar.setFontSymbol("Interstate_fnt");
			bar.create("Lonely Button", 100, 100);
	
			var ears = {onRelease: this.test1}
			bar.addListener(ears)
	
			function test1 (id, obj){
				//trace("test1 from id:"+id+", obj:"+obj);
				trace("Sending a 'select' back into your instance of TextFieldButton");
				obj.select();
			};
			
		</code>
	
	*/
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	public class TextFieldButton extends Sprite{
	
		// passed
		public var _id:Number;
		private var _data:*;
		private var _field:TextField;
		
		// format
		private var _baseFormat:TextFormat = new TextFormat();
		private var _hoverFormat:TextFormat = new TextFormat();
		private var _selectFormat:TextFormat = new TextFormat();
		
		// options
		private var _embedFonts:Boolean = false;
		private var _antiAliasType:String = AntiAliasType.ADVANCED;
		private var _hover:Boolean = true;
		private var _wrap:Boolean = false;
		private var _wrapWidth:Number;
		private var _center:Boolean = false;
		private var _persistent:Boolean = false;
		
		//protected var isPersistent:Boolean = false; // if the dusabled button still links
	
		// ------------------------------------
		// CONSTRUCTOR
		// ------------------------------------
	
		public function TextFieldButton () {
			//trace("TextFieldButton");
			
			buttonMode = true;
			mouseChildren = false;
			
			setDefaults ();
		};
	
		// ------------------------------------
		// ACCESSORS
		// ------------------------------------
	
		public function set field(value:TextField):void { _field = value; };
		public function get field():TextField { return _field; };
	
		public function set id(value:int):void { _id = value; };
		public function get id():int { return _id; };
	
		public function get data():* { return _data; };
		public function set data(value:*):void { _data = value; };
	
		public function set baseFormat(value:TextFormat):void { _baseFormat = value; };
		public function get baseFormat():TextFormat { return _baseFormat; };
	
		public function set hoverFormat(value:TextFormat):void { _hoverFormat = value; };
		public function get hoverFormat():TextFormat { return _hoverFormat; };
	
		public function set selectFormat(value:TextFormat):void { _selectFormat = value; };
		public function get selectFormat():TextFormat { return _selectFormat; };
	
		public function set embedFonts(value:Boolean):void { _embedFonts = value; };
		public function get embedFonts():Boolean { return _embedFonts; };
	
		public function set antiAliasType(value:String):void { _antiAliasType = value; };
		public function get antiAliasType():String { return _antiAliasType; };
	
		public function set hover(value:Boolean):void { _hover = value; buttonMode = value };
		public function get hover():Boolean { return _hover; };
	
		public function set wrap(value:Number):void {
			_wrap = true;
			_wrapWidth = value;
		};
		public function get wrap():Number { return Number(_wrap); };
		public function get wrapWidth():Number { return _wrapWidth; };
	
		public function set center(value:Boolean):void { _center = value; };
		public function get center():Boolean { return _center; };
	
		public function get persistent():Boolean { return _persistent; };
		public function set persistent(value:Boolean):void { _persistent = value; };
	
		override public function get width():Number {
			return (field) ? field.textWidth : NaN;
		};
		
		override public function get height():Number {
			return (field) ? field.textHeight : NaN;
		};

		// ------------------------------------
		// DEFAULTS
		// ------------------------------------
	
		private function setDefaults ():void{
			//trace("TextFieldButton: setDefaults");
		
			// Create default TextFormat object.
			baseFormat.font = "Trebuchet MS";
			baseFormat.color = 0x000000; // hex value for black 
			baseFormat.size = 10;
		
			hoverFormat.color = 0x0000FF; // hex value for red 
	
			selectFormat.color = 0xCCCCCC; // hex value for red 
	
		};
		
		// ------------------------------------
		// CREATE/DESTROY
		// ------------------------------------
		
		public function create (value:String):void{
			//trace("TextFieldButton: create");
			
			field = createField ();
			field.text = value;
			
			if (hover) addEventListener(MouseEvent.MOUSE_OVER, overHandler);
			if (hover) addEventListener(MouseEvent.MOUSE_OUT, outHandler);
			
			if (center) {
				field.x = Math.round( -(width * .5) );
				field.y = Math.round( -(height * .5) );
			}
			
			addChild(field);
		};
		
		public function destroy ():void{
			//trace("TextFieldButton: destroy");
			if (field) removeChild(field);
		};
		
		private function createField ():TextField{
			//trace("TextFieldButton: createField");
			
			var f:TextField = new TextField()
			f.embedFonts = embedFonts;
			
			if (wrap) {
				f.width = wrapWidth;
				f.multiline = true;
				f.wordWrap = true;
			}
			
			f.autoSize = TextFieldAutoSize.LEFT;
			//f.border = true; // handy for testing
			f.antiAliasType = antiAliasType;
			f.selectable = false;
			f.defaultTextFormat = baseFormat;

			return f;
			
		};
		
		// ------------------------------------
		// EVENT METHODS
		// ------------------------------------
		
		public function overHandler (event:Event):void{
			//trace("TextFieldButton: overHandler for "+event.target);
			field.setTextFormat(hoverFormat);
		};
		
		public function outHandler (event:Event):void{
			//trace("TextFieldButton: outHandler for "+event.target);
			field.setTextFormat(baseFormat);
		};
		
		// ------------------------------------
		// ENABLE / DISABLE
		// ------------------------------------
		
		// ------------------------------------
		// SELECT / DESELECT
		// ------------------------------------
		
		public function select ():void{
			//trace("TextFieldButton: select");
			
			if (!persistent) {
				mouseEnabled = false;
				removeEventListener(MouseEvent.MOUSE_OUT, outHandler);
				field.setTextFormat(selectFormat);
			};
		};
		
		public function deselect ():void{
			//trace("TextFieldButton: deselect");
			
			field.setTextFormat(baseFormat);
			addEventListener(MouseEvent.MOUSE_OUT, outHandler);
			mouseEnabled = true;
		};
	}
}