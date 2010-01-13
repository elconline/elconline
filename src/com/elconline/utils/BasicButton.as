package com.elconline.utils {  
	import flash.display.*;  
	import flash.events.*;  

	//this class is abstract and should not be instantiated 
	public class BasicButton extends MovieClip  {  
	
		public function BasicButton (data:XML, controller:* )  {
			this.buttonMode = true;
			this.mouseEnabled = true;//default is true
			this.tabEnabled = true;
			this.mouseChildren = false;  

			this.addEventListener(MouseEvent.ROLL_OVER, onOver);
			this.addEventListener(MouseEvent.ROLL_OUT, onOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onDown,false,0,true);
			this.addEventListener(MouseEvent.MOUSE_UP, onUp);
			}  
		
		protected function onClick(e:Event):void  { 
			
		} 
		protected function onOver(e:Event):void  { 
			//gotoAndStop("_over"); 
		}
		
		protected function onOut(e:Event):void  { 
			//gotoAndStop("_up"); 
		}
			
		protected function onDown(e:Event):void  { 
		  //gotoAndStop("_down"); 
		}
			
		protected function onUp(e:Event):void  { 
			//gotoAndStop("_up"); 
		} 
	}  
}