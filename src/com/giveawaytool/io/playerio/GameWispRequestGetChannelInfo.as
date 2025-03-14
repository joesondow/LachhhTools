package com.giveawaytool.io.playerio {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.DataManager;

	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class GameWispRequestGetChannelInfo {
		public var isSuccess:Boolean = false;
		public var metaChannelInfo : MetaGameWispChannelInfo ;
		public var callbackOnSuccess : Callback;
		public var callbackOnError : Callback;
		private var accessToken:String;

		public function GameWispRequestGetChannelInfo(pAccessToken : String) {
			accessToken = pAccessToken;
		}

		public function loadRequest() : void {			
			var url:String = buildGetChannelInfoRequestURL();
			var request:URLRequest = new URLRequest(url);

			var loader : URLLoader = new URLLoader() ;
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIoError, false, 0, true);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
			loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onHttpResponseStatus, false, 0, true);
			loader.load(request);
		}

		private function onComplete(event : Event) : void {
			metaChannelInfo = new MetaGameWispChannelInfo();
			isSuccess = false;
			try {
				var rawData:String = event.target.data;
				var d:Dictionary = DataManager.stringToDictionnary(rawData);
				if(isDataValid(d)) {
					metaChannelInfo = MetaGameWispChannelInfo.createFromRawData(d);
					isSuccess = true;
				}
			} catch(e:Error) {
				
			}
			
			if(callbackOnSuccess) callbackOnSuccess.call();
		}
		
		private function isDataValid(rawData:Dictionary):Boolean {
			 if(rawData == null) return false;
			 if(rawData["result"] == null) return false;
			 if(rawData["data"] == null) return false;
			 if(rawData["data"]["display_name"] == null) return false;
			 
			 return true;	 
		}
		

		private function onIoError(event : IOErrorEvent) : void {
			if(callbackOnError) callbackOnError.call();
		}

		private function httpStatusHandler(event : HTTPStatusEvent) : void {
		}

		private function securityErrorHandler(event : SecurityErrorEvent) : void {
		}

		private function onHttpResponseStatus(event : HTTPStatusEvent) : void {
		}
		
		public function buildGetChannelInfoRequestURL():String {
			return "https://api.gamewisp.com/pub/v1/channel/information?access_token=" + accessToken +"&include=tiers";
		}
	}
}
