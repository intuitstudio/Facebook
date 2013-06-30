package 
{
	import flash.display.Sprite;
	import flash.display.SimpleButton;
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

		protected static const APP_ID:String = "480376102038843";//FB app id  
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
			login_btn.visible = logout_btn.visible = false;
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
			if (e.target == login_btn)
			{
				//var opts:Object = {scope:"publish_stream, user_photos"};
				//Facebook.login (onLogin, opts);
				/*
				*  scope : 
				*
				*/
				//just login Facebook platform
				Facebook.login (onLogin);
			}

			if (e.target == logout_btn)
			{
				log ('call FB logout');
				Facebook.logout (onLogout);
			}

			enableButton (e.target as SimpleButton,false);

		}

		//check FB connection status
		private function onInit (result:Object, fail:Object):void
		{
			if (result)
			{
				var descript:String = "onInit, Logged In\n";
				enableButton (logout_btn);
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
			enableButton (login_btn);
		}

		public function log (msg:String):void
		{
			msg_txt.text = msg;

		}

	}

}