/**
 * Created by SergeyMalenko on 14.04.2015.
 */
package reversi.view
{
	import reversi.common.TextureHelper;
	import reversi.core.AssetsManager;
	import reversi.popup.PopupManager;

	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class RefreshButton extends Button
	{
		public function RefreshButton()
		{
			var texture:Texture = AssetsManager.getTextureByName(TextureHelper.REFRESH_BUTTON);
			super(texture);
		}

		public function onClick(e:TouchEvent):void
		{
			var touchHover:Touch = e.getTouch(e.target as DisplayObject);
			if(touchHover != null && touchHover.phase == TouchPhase.BEGAN)
			{
				PopupManager.instance.showStartPopup({isClose:true, caption:"Refresh Game"});
			}
		}
	}
}
