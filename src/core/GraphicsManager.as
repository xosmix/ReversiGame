/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package core
{
	import flash.filesystem.File;

	import starling.utils.AssetManager;

	public class GraphicsManager
	{
		private static var _assets:AssetManager;
		private var _completeFunc:Function;
		public function GraphicsManager(completeFunc:Function):void
		{
			_assets = new AssetManager();
			_completeFunc = completeFunc;
			var appDir:File = File.applicationDirectory;
			_assets.verbose = true;
			_assets.enqueue(appDir.resolvePath("graphics"));
			_assets.loadQueue(onComplete);
		}

		private function onComplete(ratio:Number):void
		{
			if (ratio == 1.0)
			{
				_completeFunc.call()
			}
		}

		public static function get assets():AssetManager
		{
			return _assets;
		}
	}
}
