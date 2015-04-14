/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package core
{

	import error.GameError;

	import popup.PopupManager;

	import starling.textures.Texture;

	import starling.utils.AssetManager;

	public class AssetsManager
	{
		private static var _manager:AssetManager;
		private var _completeFunc:Function;
		public function AssetsManager(completeFunc:Function):void
		{
			_manager = new AssetManager();
			_completeFunc = completeFunc;

			_manager.verbose = true;
			_manager.enqueue("graphics/graphics.png");
			_manager.enqueue("graphics/graphics.xml");
			_manager.loadQueue(onComplete);
		}

		private function onComplete(ratio:Number):void
		{
			if (ratio == 1.0)
			{
				_completeFunc.call();
			}
		}

		public static function getTextureByName(name:String):Texture
		{
			var texture:Texture = _manager.getTexture(name);
			if(texture != null)
			{
				return texture;
			}
			else
			{
				throw new GameError(GameError.TEXTURE_IS_NULL);
			}
		}
	}
}
