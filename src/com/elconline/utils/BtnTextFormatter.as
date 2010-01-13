package com.elconline.utils {
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.AntiAliasType;
	
	
	public class BtnTextFormatter {
		
		function BtnTextFormatter($src:TextField,$str:String,$color:uint,$size:Number,$font:String="Arial",$align:String='left',$alias:Boolean =true,$ls:Number=0) {
		
			var format:TextFormat	=	new TextFormat;			
			format.color			=	$color;
			format.size				=	$size;
			format.font				=	$font;
			format.letterSpacing  	= $ls;
			if($align=='center'){
			format.align 			= 	TextFormatAlign.CENTER;
			}else if($align=='right'){
			format.align 			= 	TextFormatAlign.RIGHT;
			}else {
				$src.autoSize			=	TextFieldAutoSize.LEFT;
			}
			$src.background			=	false;
			$src.border				=	false;
			$src.embedFonts			=	true;
			$src.selectable			=	false;
			if($alias==false){
				$src.antiAliasType		=	AntiAliasType.NORMAL;
			}else {
				$src.antiAliasType		=	AntiAliasType.ADVANCED;
			}
			$src.defaultTextFormat	=	format;				
			$src.text = $str;
		}
	}
}