package com.coresite.utils {
		private var _rollOverColor: int;
		private var _pageUrl: String;
			_color = color;
			_rollOverColor = rollOverColor;
		public function addLine(posX:Number,posY:Number, lineWidth:Number) : void {	
			var hyperLinkLine:Sprite = Draw.createHorizontalLine(2,_color,1,lineWidth);
			hyperLinkLine.x = posX;
			hyperLinkLine.y = posY;
			addChild(hyperLinkLine);
		}