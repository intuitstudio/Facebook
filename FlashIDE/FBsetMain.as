package 
{

	import flash.display.MovieClip;
	import com.facebook.graph.Facebook;

	public class FBsetMain extends MovieClip
	{

		private var _appId:String = '480376102038843';

		public function FBsetMain ()
		{
			// constructor code
			Facebook.init (_appId,initHandler);
		}

		private function initHandler (result:Object, fail:Object):void
		{
			trace('init call ');
			if (result)
			{
				trace ("result.uid = " + result.uid);
				//若曾經登入過，這邊就可以取得session，可以執行自動登入的動作
			}
			else
			{
                   trace('fail to ');
			}
		}





	}

}