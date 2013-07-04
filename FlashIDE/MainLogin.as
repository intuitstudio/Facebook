package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.SimpleButton;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import com.adobe.serialization.json.JSONCore;
	import com.facebook.graph.Facebook;

	public class MainLogin extends Sprite
	{

		public var msg_txt:TextField;
		public var login_btn:SimpleButton;
		public var logout_btn:SimpleButton;
		public var publish_btn:SimpleButton;
		public var like_btn:SimpleButton;

		protected static const APP_ID:String = "480376102038843";//FB app id  
		protected var isLoggedIn:Boolean = false;
		protected var permissions_opts:Object = {perms:"publish_actions,publish_stream"};
		private var _permissions:Object = {scope:"應用程式權限"};
		private var _userData:Object;
/*
		// 參考Permissions Reference: 
        // https://developers.facebook.com/docs/authentication/permissions/
        // perms:"publish_actions,publish_stream" 針對朋友發文
	   
	    參考 https://developers.facebook.com/docs/reference/api/
	    ex . post的到自己塗鴉強，寫法是這樣的
          /me/feed
		 輸入JSON格式的資料 : {"message":"hello world"};
	  */

		private var user_id:String;

		public function MainLogin ()
		{
			// constructor code

			configUIs ();
			Facebook.init (APP_ID, onInit);
		}

		protected function configUIs ():void
		{
			log ('Test FB Login');

			setBtnLabel(login_btn, '登入');
			setBtnLabel(logout_btn, '登出');
			setBtnLabel(publish_btn, '發文');
			setBtnLabel(like_btn, '按讚');
			login_btn.visible = logout_btn.visible = publish_btn.visible = like_btn.visible = false;
		}
		
		private function setBtnLabel(btn:SimpleButton,lb:String):void
		{
			setLabel(btn.upState as DisplayObjectContainer,lb);
			setLabel(btn.overState as DisplayObjectContainer,lb);
			setLabel(btn.downState as DisplayObjectContainer,lb);
			
			function setLabel(btnState:DisplayObjectContainer,lb:String):void
			{
				 var tf:TextField = btnState.getChildAt(btnState.numChildren-1) as TextField;
			     tf.text = lb;
			}
		}

		private function enableButton (btn:SimpleButton,valid:Boolean = true):void
		{
			if (valid)
			{
				btn.addEventListener (MouseEvent.CLICK,buttonHandler);
				btn.visible = true;
			}
			else
			{
				btn.addEventListener (MouseEvent.CLICK,buttonHandler);
				btn.visible = false;
			}
		}

		protected function buttonHandler (e:MouseEvent):void
		{
			var btn:SimpleButton = e.target as SimpleButton;
			switch (btn)
			{
				case login_btn :
					doLogin ();
					break;
				case logout_btn :
					doLogout ();
					break;
				case publish_btn :
					doPublish ();
					break;
				case like_btn :
					doFanCheck ('fql');
					break;
			}

			enableButton (btn,false);

		}

		private function doLogin ():void
		{
			//var opts:Object = {scope:"publish_stream, user_photos"};
			//Facebook.login (onLogin, opts);
/*
				*  scope : 
				*
				*/
			if (permissions_opts)
			{
				Facebook.login (onLogin, permissions_opts);
			}
			else
			{
				//just login Facebook platform
				Facebook.login (onLogin);
			}
		}

		private function doLogout ():void
		{
			log ('call FB logout');
			Facebook.logout (onLogout);
		}

		private function doPublish ():void
		{
			log ('publish article');
			if (isLoggedIn)
			{
				var params:Object = null;
				try
				{
					params = {"message":"hello world 2"};
				}
				catch (e:Error)
				{
					log ("\n\nERROR DECODING JSON: " + e.message);
				}
				Facebook.api ('/me/feed', handleAPICall, params, "POST");
			}
		}

		private function doFanCheck (type:String='graph'):void
		{
			if(type === 'graph'){
			   Facebook.api ("/me/likes/{1620070992}", isFanResult);
			}
			if(type === 'fql'){
			    Facebook.fqlQuery("SELECT uid FROM page_fan WHERE uid=" + user_id + " AND page_id={1620070992}", isFanResult);
			}
		}

		private function isFanResult (result:Object, fail:Object):void
		{			 
			var obj:Object;
			if (result)
			{
				if (result.length == 0)
				{
					log ("不是粉絲");
				}
				else
				{
					log ("是粉絲");
				}
			}
		}

		protected function handleAPICall (result:Object, fail:Object):void
		{
			if (result)
			{
				var desp:String = "\n\nRESULT:\n" + JSONCore.encode(result).toString();
			}
			else
			{
				desp = "\n\nFAIL:\n" + JSONCore.encode(fail).toString();
			}
			log (desp);
		}

		//check FB connection status
		private function onInit (result:Object, fail:Object):void
		{
			if (result)
			{
				isLoggedIn = true;
				var descript:String = 'onInit -> ' + result.toString() + '\n';
				enableButton (logout_btn);
				enableButton (publish_btn);
				enableButton (like_btn);
			}
			else
			{
				descript = "onInit, Not Logged In\n";
				enableButton (login_btn);
			}
			log (descript);
		}

/**
		*  登入成功將會回傳user_id物件資料
		*
		*/
		private function onLogin (result:Object, fail:Object):void
		{
			if (result)
			{//successfully logged in

				user_id = result.uid;
				log ('Logged In : ' + user_id);
				enableButton (logout_btn);
				enableButton (publish_btn);
				enableButton (like_btn);
			}
			else
			{
				log ('Login Failed\n');
				enableButton (login_btn);
			}
		}

		private function onLogout (success:Boolean):void
		{
			log ('Logged Out');
			if (contains(publish_btn))
			{
				enableButton (publish_btn,false);
			}
			if (contains(like_btn))
			{
				enableButton (like_btn,false);
			}
			if (contains(login_btn))
			{
				enableButton (login_btn,false);
			}

		}

		public function log (msg:String):void
		{
			msg_txt.text = '';
			msg_txt.appendText (msg);
		}

	}

}