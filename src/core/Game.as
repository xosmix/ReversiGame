/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package core
{
	import controllers.HumanController;
	import controllers.IHumanController;

	import core.GraphicsManager;

	import models.BoardModel;

	import models.IBoardModel;
	import models.ICellModel;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.events.Event;
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
			new GraphicsManager(startGame);
		}

		private function startGame():void
		{
			_boardModel = new BoardModel();
			_controller = new HumanController(_boardModel);
			_view = new BoardView(_boardModel, _controller);
			addChild(_view);
			initBoard();
		}

		private function initBoard():void
		{
			var background:Image = new Image(_boardModel.texture);
			background.x = stage.stageWidth - background.width >> 1;
			background.y = stage.stageHeight - background.height >> 1;
			trace(stage.stageWidth + "|" + background.width + "|" + background.x);
			_view.addChild(background);
			initCells(background);
		}

		private function initCells(background:Image):void
		{
			for each(var row:Array in _boardModel.gameField)
			{
				for each(var cellModel:ICellModel in row)
				{
					var cell:Cell = new Cell(cellModel.texture);
					cell.x = background.x + 2.5 + cellModel.position.x * 55;
					cell.y = background.y + 2.5 + cellModel.position.y * 55;
					_view.add(cell);
				}
			}
		}
	}
}
