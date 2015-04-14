/**
 * Created by SergeyMalenko on 14.04.2015.
 */
package reversi.popup
{
	import reversi.common.TextureHelper;
	import reversi.core.AssetsManager;

	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.textures.Texture;

	public class Popup extends Sprite implements IPopup
	{
		private var _caption:TextField;
		private var _closeButton:Button;

		public function Popup()
		{
			initBackground();
			initCloseButton();
		}

		private function initBackground():void
		{
			var image:Image = new Image(AssetsManager.getTextureByName(TextureHelper.POPUP_BACKGROUND));
			addChild(image);
			_caption = new TextField(width, height, "", "LilyUPC", 70, 0xFFFFFF);
			_caption.autoSize = TextFieldAutoSize.VERTICAL;
			addChild(_caption);
		}

		private function initCloseButton():void
		{
			var closeState:Texture = AssetsManager.getTextureByName(TextureHelper.CLOSE_BUTTON);
			_closeButton = new Button(closeState);
			_closeButton.x = width - _closeButton.width - 5;
			_closeButton.y = 5;
			addChild(_closeButton)
		}

		public function activate():void
		{
			_closeButton.addEventListener(TouchEvent.TOUCH, onCloseHandler)
		}

		public function deactivate():void
		{
			_closeButton.addEventListener(TouchEvent.TOUCH, onCloseHandler)
		}

		public function show(popup:String):void
		{
		}

		public function prepare(data:Object):void
		{
			caption.text = data.caption;
		}

		public function onCloseHandler(e:TouchEvent):void
		{
			var touchHover:Touch = e.getTouch(e.target as DisplayObject);
			if(touchHover != null && touchHover.phase == TouchPhase.BEGAN)
			{
				deactivate();
				this.parent.removeChild(this);
			}
		}

		protected function get closeButton():Button
		{
			return _closeButton;
		}

		public function get caption():TextField
		{
			return _caption;
		}
	}
}
