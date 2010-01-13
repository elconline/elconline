package com.elconline.utils {
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	public class TextFormatter {
		function TextFormatter(src:TextField, fcolor:uint, fsize:Number, str:String, ffont:String = "Helvetica", fleading:Number = 0, fletterSpacing:Number = 0, fthickness:Number = 0, html:Boolean= true, funderline:Boolean = false, fbold:Boolean = false, falign:String='left')
		{
			src.autoSize			=	TextFieldAutoSize.LEFT;
			src.background			=	false;
			src.border				=	false;
			src.embedFonts			=	true;
			src.selectable			=	false;
			src.thickness			=	fthickness;
			src.antiAliasType		=	AntiAliasType.ADVANCED;

			var format:TextFormat	=	new TextFormat;
			format.font				=	ffont;
			format.color			=	fcolor;
			format.size				=	fsize;
			format.leading			=	fleading;
			format.letterSpacing	=	fletterSpacing;
			format.indent			=	0;
			format.underline 		= 	funderline;
			format.bold 			=	fbold;
			format.align 			=	falign; 			
			src.defaultTextFormat	=	format;
			if (str != 'null'){ //Nabil added 
				if (html) { src.htmlText = str;} else { src.text = str; };
			}	
		}

	}
}