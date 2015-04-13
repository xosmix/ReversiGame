/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package core
{
	import controllers.HumanController;
	import controllers.IHumanController;

	import core.AssetsManager;

	import models.BoardModel;

	import models.IBoardModel;
	import models.ICellModel;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	import views.BoardView;
	import views.Cell;

	public class Game extends Sprite
	{
		private var _boardModel:IBoardModel;
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
			new AssetsManager(startGame);
		}

		private function startGame():void
		{
			_boardModel = new BoardModel();
			_controller = new HumanController(_boardModel);
			_view = new BoardView(_boardModel, _controller);
			_view.x = stage.stageWidth - _view.width >> 1;
			_view.y = stage.stageHeight - _view.height >> 1;
			addChild(_view);
		}
	}
}
