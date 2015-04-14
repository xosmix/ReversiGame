/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package reversi.view
{
	import flash.geom.Point;

	import reversi.common.GameOverHelper;
	import reversi.common.PlayerHelper;
	import reversi.common.TextureHelper;
	import reversi.controller.IHumanController;
	import reversi.core.AssetsManager;
	import reversi.event.BoardEvent;
	import reversi.model.BoardModel;
	import reversi.model.IBoardModel;
	import reversi.model.ICellModel;
	import reversi.popup.PopupManager;

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
			_model.addEventListener(BoardEvent.CELL_CHANGED, updateCell);
			_model.addEventListener(BoardEvent.CELL_SELECTED, selectedCell);
			_model.addEventListener(BoardEvent.SCORE_CHANGED, updateScore);
			_model.addEventListener(BoardEvent.GAME_OVER, onGameOver);
			_controller = controller;
			initComponents();
		}

		private function initComponents():void
		{
			var boardTexture:Texture = AssetsManager.getTextureByName(TextureHelper.BOARD_BACKGROUND);
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
					var texture:Texture = AssetsManager.getTextureByName(PlayerHelper.getNameTextureByPlayer(cellModel.owner));
					var cell:CellView = new CellView(cellModel, texture);
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

		private function getGameOverMessage(gameOverType:uint):String
		{
			var message:String;
			switch(gameOverType)
			{
				case GameOverHelper.IS_WINNER:
				case GameOverHelper.FORFEITED:
					message = "Winner is " + getWinner();
					break;
				case GameOverHelper.DEAD_HIT:
					message = "Dead hit!!! " + getWinner();
					break;
			}
			message += "\nBLACK: " + _model.blackPlayer.score + " WHITE: " + _model.whitePlayer.score;

			return message;
		}

		private function getWinner():String
		{
			return _model.blackPlayer.score > _model.whitePlayer.score ? "BLACK" : "WHITE";
		}

		public function setConfigs(data:Object):void
		{
			_controller.reset();
			_controller.setConfigs(data);
		}

		private static function getCellTextureByOwner(owner:uint):Texture
		{
			var nameTexture:String = PlayerHelper.getNameTextureByPlayer(owner);
			return AssetsManager.getTextureByName(nameTexture);
		}

		public function updateCell(e:BoardEvent = null):void
		{
			var position:Point = e.data.position;
			var owner:uint = _model.getCellOwner(position);
			var texture:Texture = getCellTextureByOwner(owner);
			if(owner != PlayerHelper.EMPTY)
			{
				(_children[position.x][position.y] as CellView).updateTexture(texture);
			}
			else
			{
				(_children[position.x][position.y] as CellView).reset(texture);
			}
		}

		public function selectedCell(e:BoardEvent = null):void
		{
			var position:Point = e.data.position;
			var status:Boolean = e.data.status;
			(_children[position.x][position.y] as CellView).updateState(status);
		}

		public function updateScore(e:BoardEvent = null):void
		{
			_scoreView.setScore(e.data.score, e.data.color, _model.currentColor);
		}

		public function onGameOver(e:BoardEvent = null):void
		{
			PopupManager.instance.showGameOverPopup({action:showStartGamePopup, text:getGameOverMessage(e.data.type)});
		}

		private function showStartGamePopup():void
		{
			PopupManager.instance.showStartPopup();
		}
	}
}
