/**
 * Created by SergeyMalenko on 13.04.2015.
 */
package reversi.popup
{
	import reversi.common.PlayerHelper;
	import reversi.common.TextureHelper;
	import reversi.core.AssetsManager;

	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class StartGamePopup extends Popup
	{
		private static const BLACK:String = TextureHelper.BUTTON_BLACK_STONE;
		private static const WHITE:String = TextureHelper.BUTTON_WHITE_STONE;
		private static const ROBOT:String = TextureHelper.BUTTON_ROBOT;
		private static const HUMAN:String = TextureHelper.BUTTON_HUMAN;
		private var _startButton:Button;
		private var _colorButton:Button;
		private var _rivalButton:Button;
		private var _action:Function;
		private var _selectColor:String = BLACK;
		private var _selectRival:String = ROBOT;
		public function StartGamePopup()
		{
			caption.text = "REVERSI";
			initButtons();
		}

		private function initButtons():void
		{
			var upState:Texture = AssetsManager.getTextureByName(TextureHelper.START_BUTTON);
			_startButton = new Button(upState, "Start Game");
			_startButton.x = width - _startButton.width >> 1;
			_startButton.y = height - _startButton.height - 20;
			addChild(_startButton);

			upState = AssetsManager.getTextureByName(_selectColor);
			_colorButton = new Button(upState, "SELECT COLOR");
			_colorButton.x = width / 3 - _colorButton.width;
			_colorButton.y = height / 3;
			_colorButton.fontColor = 0xFFFFFF;
			addChild(_colorButton);


			upState = AssetsManager.getTextureByName(_selectRival);
			_rivalButton = new Button(upState, "SELECT RIVAL");
			_rivalButton.x = 2 * width / 3;
			_rivalButton.y = height / 3;
			_rivalButton.fontColor = 0xFFFFFF;
			addChild(_rivalButton);
		}

		override public function activate():void
		{
			super.activate();
			_colorButton.addEventListener(TouchEvent.TOUCH, onColorHandler);
			_rivalButton.addEventListener(TouchEvent.TOUCH, onColorHandler);
			_startButton.addEventListener(TouchEvent.TOUCH, onColorHandler);
		}

		override public function deactivate():void
		{
			super.deactivate();
			_colorButton.removeEventListener(TouchEvent.TOUCH, onColorHandler);
			_rivalButton.removeEventListener(TouchEvent.TOUCH, onColorHandler);
			_startButton.removeEventListener(TouchEvent.TOUCH, onColorHandler);
		}

		override public function prepare(data:Object):void
		{
			if(data != null)
			{
				if(data.action != null)
				{
					_action = data.action;
				}
				closeButton.visible = data.isClose;

				_startButton.text = data.caption != null ? data.caption : _startButton.text;
			}
			activate();
		}

		private function updateColorButton():void
		{
			_selectColor = _selectColor == BLACK ? WHITE : BLACK;
			var upState:Texture = AssetsManager.getTextureByName(_selectColor);
			_colorButton.upState = upState;
			_colorButton.fontColor = _colorButton.fontColor == 0x000000 ? 0xFFFFFF : 0x000000;
		}

		private function updateRivalButton():void
		{
			_selectRival = _selectRival == ROBOT ? HUMAN : ROBOT;
			var upState:Texture = AssetsManager.getTextureByName(_selectRival);
			_rivalButton.upState = upState;
		}

		private function onColorHandler(e:TouchEvent):void
		{
			var touchHover:Touch = e.getTouch(e.target as DisplayObject);
			if(touchHover != null && touchHover.phase == TouchPhase.BEGAN)
			{
				if(e.currentTarget == _colorButton)
				{
					updateColorButton();
				}
				else if(e.currentTarget == _rivalButton)
				{
					updateRivalButton();
				}
				else if(e.currentTarget == _startButton)
				{
					var color:uint = _selectColor == BLACK ? PlayerHelper.BLACK : PlayerHelper.WHITE;
					var rival:Boolean = _selectRival == HUMAN ? PlayerHelper.HUMAN : PlayerHelper.ROBOT;
					_action.call(null, {color:color, rival:rival});
					onCloseHandler(e);
				}
			}
		}
	}
}
