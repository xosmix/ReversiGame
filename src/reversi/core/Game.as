/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package reversi.core
{
	import reversi.common.TextureHelper;
	import reversi.controller.HumanController;
	import reversi.controller.IHumanController;
	import reversi.model.BoardModel;
	import reversi.model.IBoardModel;
	import reversi.popup.PopupManager;
	import reversi.view.BoardView;
	import reversi.view.RefreshButton;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;

	public class Game extends Sprite
	{
		private var _model:IBoardModel;
		private var _controller:IHumanController;
		private var _view:BoardView;
		public function Game()
		{
			if(stage == null)
			{
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}
			else
			{
				onAddedToStage();
			}
		}

		private function onAddedToStage(e:Event = null):void
		{
			new PopupManager(this);
			new AssetsManager(startGame);
		}

		private function startGame():void
		{
			var background:Image = new Image(AssetsManager.getTextureByName(TextureHelper.MAIN_BACKGROUND));
			addChild(background);

			_model = new BoardModel();

			_controller = new HumanController(_model);

			_view = new BoardView(_model, _controller);
			_view.x = background.width - _view.width >> 1;
			_view.y = background.height - _view.height >> 1;
			addChild(_view);

			var refreshButton:RefreshButton = new RefreshButton();
			refreshButton.x = width - refreshButton.width;
			refreshButton.addEventListener(TouchEvent.TOUCH, refreshButton.onClick);
			addChild(refreshButton);

			PopupManager.instance.showStartPopup({action: _view.setConfigs});
		}
	}
}
