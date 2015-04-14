/**
 * Created by SergeyMalenko on 13.04.2015.
 */
package reversi.popup
{
	import reversi.core.AssetsManager;

	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.textures.Texture;

	public class GameOverPopup extends Popup
	{
		private var _resultTF:TextField;
		private var _reloadButton:Button;
		private var _action:Function;

		public function GameOverPopup()
		{
			caption.text = "GAME OVER";
			initTextField();
			initButtons();
		}

		private function initTextField():void
		{
			_resultTF = new TextField(width, 20, "", "LilyUPC", 40, 0xFFFFFF);
			_resultTF.autoSize = TextFieldAutoSize.VERTICAL;
			_resultTF.y = height >> 1;
			addChild(_resultTF);
		}

		private function initButtons():void
		{
			closeButton.visible = false;
			var upState:Texture = AssetsManager.getTextureByName("button");
			_reloadButton = new Button(upState, "New Game");
			_reloadButton.x = width - _reloadButton.width >> 1;
			_reloadButton.y = height - _reloadButton.height - 20;
			addChild(_reloadButton);
		}

		override public function prepare(data:Object):void
		{
			activate();
			_action = data.action;
			_resultTF.text = data.text;
		}

		override public function activate():void
		{
			_reloadButton.addEventListener(TouchEvent.TOUCH, onTouchHandler)
		}

		override public function deactivate():void
		{
			_reloadButton.removeEventListener(TouchEvent.TOUCH, onTouchHandler)
		}

		private function onTouchHandler(e:TouchEvent):void
		{
			var touchHover:Touch = e.getTouch(e.target as DisplayObject);
			if(touchHover != null && touchHover.phase == TouchPhase.BEGAN)
			{
				_action.call();
				deactivate();
				onCloseHandler(e);
			}
		}


	}
}
