package com.coresite.utils {
	import com.coresite.externalinterface.FlashApi;

	/**	 * @author nmouzannar
	 * 		
	 * COREMETRICS	 */
		public class CoremetricsManager {
		public static function callCoremetrics(method:String,param1:String,param2:String , ... rest):void{
			switch(method)
			{
				case 'cmCreateProductviewTag':
					 trace ('cmCreateProductviewTag !!!'+method+' : '+param1+ ': '+param2+ ' : '+ rest[0]);
					FlashApi.cmCreateProductviewTag(param1, param2, rest[0] );//	productID:String, productName:String, categoryID:String
					break;
				case 'cmCreatePageviewTag':
					FlashApi.cmCreatePageviewTag(param1, null, param2, 0);
					break;
				case 'cmCreatePageElementTag':
					 trace ('cmCreatePageElementTag !!!'+method+' : '+param2+ ': '+param1);
					 FlashApi.cmCreatePageElementTag(param2, param1); //switched per Deana
					break;
				default:
					trace("callCoremetrics Out of range");
					break;
			}
		}
	}}