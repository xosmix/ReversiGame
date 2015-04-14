/**
 * Created by SergeyMalenko on 14.04.2015.
 */
package reversi.popup
{
	import reversi.core.Game;
	import reversi.error.GameError;

	public class PopupManager
	{
		private static var _instance:PopupManager = null;
		private var _startPopup:StartGamePopup;
		private var _gameOverPopup:GameOverPopup;
		private var _errorPopup:Popup;
		private var _game:Game;

		public function PopupManager(game:Game):void
		{
			_game = game;

			if(instance != null)
			throw new GameError(GameError.SINGLETON);
			_instance = this;
		}

		public static function get instance():PopupManager
		{
			return _instance;
		}

		public function showStartPopup(data:Object = null):void
		{
			if(_startPopup == null)
			{
				_startPopup = new StartGamePopup();
			}
			_startPopup.prepare(data);

			show(_startPopup);
		}

		public function showGameOverPopup(data:Object = null):void
		{
			if(_gameOverPopup == null)
			{
				_gameOverPopup = new GameOverPopup();
			}
			_gameOverPopup.prepare(data);

			show(_gameOverPopup);
		}

		public function showErrorPopup(data:Object = null):void
		{
			if(_errorPopup == null)
			{
				_errorPopup = new GameOverPopup();
			}
			_errorPopup.prepare(data);

			show(_errorPopup);
		}

		private function show(popup:Popup):void
		{
			_game.addChild(popup);
		}
	}
}
