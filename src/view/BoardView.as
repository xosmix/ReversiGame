/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package view
{
	import controller.IHumanController;

	import core.AssetsManager;

	import event.BoardEvent;

	import flash.geom.Point;

	import model.BoardModel;

	import model.IBoardModel;
	import model.ICellModel;
	import model.PlayerFactory;

	import starling.display.DisplayObjectContainer;

	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.textures.Texture;

	public class BoardView extends DisplayObjectContainer
	{
		private var _children:Array;
		private var _model:BoardModel;
		private var _controller:IHumanController;
		private var _scoreView:ScoreGameView;
		public function BoardView(model:IBoardModel, controller:IHumanController)
		{
			_children = [];
			_model = model as BoardModel;
			_model.addEventListener(BoardEvent.CELL_CHANGED, update);
			_model.addEventListener(BoardEvent.SCORE_CHANGED, updateScore);
			_controller = controller;
			initComponents();
		}

		private function initComponents():void
		{
			var boardTexture:Texture = AssetsManager.getTextureByName("board");
			var background:Image = new Image(boardTexture);

			_scoreView = new ScoreGameView();
			_scoreView.x = background.width - _scoreView.width >> 1;
			background.y = _scoreView.height + 5;
			addChild(background);
			addChild(_scoreView);

			initCells(background);
		}

		private function initCells(background:Image):void
		{
			for each(var row:Array in _model.board)
			{
				var tempArray:Array = [];
				for each(var cellModel:ICellModel in row)
				{
					var cell:CellView = new CellView(cellModel, getCellTextureByOwner(cellModel.owner));
					var cellFace:Number = background.width / row.length;
					var margin:Number = cellFace - cell.width >> 1;
					cell.x = background.x + margin + cellModel.position.x * cellFace;
					cell.y = background.y + margin + cellModel.position.y * cellFace;
					cell.addEventListener(TouchEvent.TOUCH, _controller.onActivityCell);
					addChild(cell);
					tempArray.push(cell);
				}
				_children.push(tempArray);
			}

			_controller.initStartPosition();
		}



		private static function getCellTextureByOwner(owner:uint):Texture
		{
			var nameTexture:String = PlayerFactory.getNameTextureByPlayer(owner);
			return AssetsManager.getTextureByName(nameTexture);
		}

		public function update(e:BoardEvent = null):void
		{
			var position:Point = e.data.position;
			var texture:Texture = getCellTextureByOwner(_model.getCellOwner(position));
			(_children[position.x][position.y] as CellView).updateTexture(texture)
		}

		public function updateScore(e:BoardEvent = null):void
		{
			_scoreView.setScore(e.data.score, e.data.color, _model.currentPlayer);
		}
	}
}
